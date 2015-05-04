#!/usr/bin/perl
#Script um Daten von IMDB zu sammeln, zu kontrollieren und abschließend in eine Datenbank zu sichern.
#Autor: Florian Drummer

use strict;
#use warnings;
use IMDB::Film;
use DBI;
use feature 'say';

#Globale Variablen
my $database = "kino_db";
my $hostname = "localhost";
my $dsn = "DBI:mysql:database=$database;host=$hostname";
my $user = "root";
my $pass = "";

sub time_check {
	#Variablendeklaration
	my $time = shift(@_);
	my $date = shift(@_);
	my $show_room_id = shift(@_);
	my @row;
	
	#Konstruktor und Verbindung - alle Fehler führen zum Abbruch
	my $dbh = DBI->connect( $dsn, $user, $pass,
	{RaiseError => 1, PrintError => 0, ShowErrorStatement => 1});
	
	my $sql = qq(SELECT Beginn, Ende FROM vorstellung WHERE Datum = ? AND Saal_ID = ?);
	my $sth = $dbh->prepare($sql);
	$sth->execute($date, $show_room_id);
	while(@row = $sth->fetchrow_array()) {
		if($time > $row[0] and $time < $row[1]) {
			return 1;
		}
	}
	$sth->finish;
	return 0;
}

sub get_duration {
	#Variablendeklaration
	my @zu_runden;
	my @gerundet;
	my @keys;
	my @sammlung;
	my %gerundet;
	my @row;
	
	#Konstruktor und Verbindung - alle Fehler führen zum Abbruch
	my $dbh = DBI->connect( $dsn, $user, $pass,
	{RaiseError => 1, PrintError => 0, ShowErrorStatement => 1});
	
	my $sql = qq(SELECT Filme_ID, Spiellaenge FROM filme);
	my $sth = $dbh->prepare($sql);
	$sth->execute;
	while(@row = $sth->fetchrow_array()) {
		#Filme ID's und Spiellänge in Array packen		
		push(@_, $row[0]);
		push(@_, $row[1]);
	}
	$sth->finish;	
	
	
	#Alle Spielzeiten in floating point Zahlen wandeln
	while(@_) {
		push(@keys, shift(@_));
		push(@zu_runden, (shift(@_) / 60));
	}
	
	#Prüfen ob gerundet werden muss
	while(@zu_runden) {
		$_  = shift(@zu_runden);		
		if($_ > ($_ % 10)) {
			if(("" . $_-($_ % 10)) gt "0.80") {
				push(@gerundet, (($_ % 10) + 1.5));
			} else {
				push(@gerundet, (($_ % 10) + 1));
			}
		} else {
			push(@gerundet, $_);
		}
	}
	while(@keys) {
		push(@sammlung, shift(@keys));
		push(@sammlung, shift(@gerundet));
	}
	%gerundet = @sammlung;
	return %gerundet;
}

sub is_valid_date {
	my $input = shift;
	if ($input =~ m!^(0[1-9]|[12][0-9]|3[01])[.](0[1-9]|1[012])[.](20\d\d)$!) {
		#$1 beinhaltet den Tag, $2 den Monat und $3 das Jahr
		if ($1 == 31 and ($2 == 4 or $2 == 6 or $2 == 9 or $2 == 11)) {
			print "Dieser Monat hat keine 31 Tage!\n";
			return 0; # 31. eines Monats mit 30 Tagen
		} elsif ($1 >= 30 and $2 == 2) {
			print "Der Monat Februar kann niemals die Tage 30 oder 31 besitzen!\n";
			return 0; # Februar 30. oder 31.
		} elsif ($2 == 2 and $1 == 29 and not ($3 % 4 == 0 and ($3 % 100 != 0 or $3 % 400 == 0))) {
			print "Dieses Jahr ist kein Schaltjahr somit hat der Monat Februar nicht 29 Tage!\n";
			return 0; # February 29. außerhalb eines Schaltjahres
		} else {
			return 1; # Zulässiges Datum
		}
	} else {
		return 0; # Kein Datum
	}
}

sub get_valid_film_ids {
	#Variablendeklaration
	my @valid_film_ids;
	my @row;
	
	#Konstruktor und Verbindung - alle Fehler führen zum Abbruch
	my $dbh = DBI->connect( $dsn, $user, $pass,
	{RaiseError => 1, PrintError => 0, ShowErrorStatement => 1});
	
	my $sql = qq(SELECT Filme_ID FROM filme);
	my $sth = $dbh->prepare($sql);
	$sth->execute;
	while(@row = $sth->fetchrow_array()) {
		#Filme ID's in Array packen
		push(@valid_film_ids, $row[0]);
	}
	$sth->finish;
	return @valid_film_ids;
}

sub calculate_end_time_clean {
	#Variablendeklaration
	my $time = pop(@_);
	my $film_id = pop(@_);
	my %spielzeiten = @_;
	my $duration = $spielzeiten{$film_id};	
	my $hour;
	my $minute;
	my $end;
	my $decimal_end;
	my %decimal_minutes = ('0'  => '0',
						   '15' => '25',
						   '30' => '50',
						   '45' => '75');
	my %normal_minutes = ('75' => '45',
						  '5' => '30',
						  '25' => '15',
						  '0'  => '00');
	
	#Zerlege Zeitstring
	$time =~ /(\d)(\d):(\d)(\d)/;

	#Filtere Stunden
	if($1 == 0) {
		$hour = $2;
	} else {
		$hour = $1.$2;
	}
	
	#Filtere Minuten
	if($3 == 0) {
		$minute = $4;
	} else {
		$minute = $3.$4;
	}
	
	#Führe Stunden und Minuten zusammen
	$decimal_end = $hour . "." . $decimal_minutes{$minute};
	
	#Summiere die Vorstellungsdauer auf
	$decimal_end += $duration;
	if($decimal_end > '24.00') {
		return "0";
	} else {
		if($decimal_end =~ /\A(\d)\z/) {
			$end = '0'.$1.':00';
		} elsif($decimal_end =~ /\A(\d)(\d)\z/) {
			$end = $1.$2.':00';
		} elsif($decimal_end =~ /\A(\d)\.(\d)\z/) {
			$end = '0'.$1.':'.$normal_minutes{$2};
		} elsif($decimal_end =~ /\A(\d)(\d)\.(\d)\z/) {
			$end = $1.$2.':'.$normal_minutes{$3};
		} elsif($decimal_end =~ /\A(\d)\.(\d)(\d)\z/) {
			$end = '0'.$1.':'.$normal_minutes{$2.$3};
		} else {
			$decimal_end =~ /\A(\d)(\d)\.(\d)(\d)\z/;
			$end = $1.$2.':'.$normal_minutes{($3.$4)};
		}
	}
	return $end;
}

sub get_valid_show_room_ids {
	#Variablendeklaration
	my @valid_show_room_ids;
	my @row;
	
	#Konstruktor und Verbindung - alle Fehler führen zum Abbruch
	my $dbh = DBI->connect( $dsn, $user, $pass,
	{RaiseError => 1, PrintError => 0, ShowErrorStatement => 1});
	
	my $sql = qq(SELECT Saal_ID FROM saal);
	my $sth = $dbh->prepare($sql);
	$sth->execute;
	while(@row = $sth->fetchrow_array()) {
		#Saal ID's in Array packen
		push(@valid_show_room_ids, $row[0]);
	}
	$sth->finish;
	return @valid_show_room_ids;
}

sub get_valid_event_ids {
	#Variablendeklaration
	my @valid_event_ids;
	my @row;
	
	#Konstruktor und Verbindung - alle Fehler führen zum Abbruch
	my $dbh = DBI->connect( $dsn, $user, $pass,
	{RaiseError => 1, PrintError => 0, ShowErrorStatement => 1});
	
	my $sql = qq(SELECT Vorstellung_ID FROM vorstellung);
	my $sth = $dbh->prepare($sql);
	$sth->execute;
	while(@row = $sth->fetchrow_array()) {
		#Saal ID's in Array packen
		push(@valid_event_ids, $row[0]);
	}
	$sth->finish;
	return @valid_event_ids;	
}

sub film_exist {
	#Konstruktor und Verbindung - alle Fehler führen zum Abbruch
	my $dbh = DBI->connect( $dsn, $user, $pass,
	{RaiseError => 1, PrintError => 0, ShowErrorStatement => 1});
	
	
	#Anzahl der Einträge auslesen
	my $sql = qq(SELECT COUNT(Filme_ID) FROM filme);
	my $sth = $dbh->prepare($sql);
	$sth->execute;
	my @row = $sth->fetchrow_array();
	$sth->finish;
	return $row[0];	
}

sub event_exist {
	#Konstruktor und Verbindung - alle Fehler führen zum Abbruch
	my $dbh = DBI->connect( $dsn, $user, $pass,
	{RaiseError => 1, PrintError => 0, ShowErrorStatement => 1});
	
	
	#Anzahl der Einträge auslesen
	my $sql = qq(SELECT COUNT(Vorstellung_ID) FROM vorstellung);
	my $sth = $dbh->prepare($sql);
	$sth->execute;
	my @row = $sth->fetchrow_array();
	$sth->finish;
	return $row[0];	
}

sub show_room_exist {
	#Konstruktor und Verbindung - alle Fehler führen zum Abbruch
	my $dbh = DBI->connect( $dsn, $user, $pass,
	{RaiseError => 1, PrintError => 0, ShowErrorStatement => 1});
	
	
	#Anzahl der Einträge auslesen
	my $sql = qq(SELECT COUNT(Saal_ID) FROM saal);
	my $sth = $dbh->prepare($sql);
	$sth->execute;
	my @row = $sth->fetchrow_array();
	$sth->finish;
	return $row[0];	
}

sub delete_film {
	#Variablendeklaration
	my $hold;
	my $choice;
	my $amount;
	my $not_ready_yet = 1;
	my @valid_film_ids;
	my @row;
	
	#Konstruktor und Verbindung - alle Fehler führen zum Abbruch
	my $dbh = DBI->connect( $dsn, $user, $pass,
	{RaiseError => 1, PrintError => 0, ShowErrorStatement => 1});
		
	if(($amount = &film_exist()) eq '0') {
		#Abbruch, da nichts gelöscht werden kann
		say "Es sind keine Filme zum löschen vorhanden! ( PRESS ENTER )";
		$hold = <STDIN>;
		return "";
	} else {
		#Welche ID's sind überhaupt vorhanden?
		@valid_film_ids = &get_valid_film_ids();
		
		#Solange die Schleife abarbeiten bis bis eine vorhandene ID eingegeben wurde!
		NEED_VALID_ID: while($not_ready_yet) {
			system("cls");
			&print_film_database();
			print "\nBitte wählen Sie die zu löschende Filme_ID aus: ";
			chomp($choice = <STDIN>);
			if($choice =~ /[1-9]\d{0,}/) {
				if(!&is_valid_film_id($choice, @valid_film_ids)) {
					redo NEED_VALID_ID;
				} else {
					#Sind Elemente in der Tabelle Reservierung welche mit der zu löschenden Filme_ID verknüpft sind?
					my $sql = qq(SELECT COUNT(*) AS Eintraege FROM (SELECT Reservierung_ID FROM reservierung r JOIN vorstellung v ON v.Vorstellung_ID = r.Vorstellung_ID WHERE v.Filme_ID = ?) AS Auswertung);
					my $sth = $dbh->prepare($sql);
					$sth->execute($choice);
					@row = $sth->fetchrow_array();
					$amount = $row[0];
					$sth->finish;
					
					if(!($amount eq '0')) {
						#Warten bis Enter
						say "Der Film kann nicht gelöscht werden, da noch Reservierungen, welche sich auf diesen Film beziehen vorhanden sind! ( PRESS ENTER )";
						$hold = <STDIN>;
					} else {
						$sql = qq(DELETE FROM filme WHERE Filme_ID = ?);
						$sth = $dbh->prepare($sql);
						$sth->execute($choice);
						$sth->finish;
						
						#Warten bis Enter
						print "Der Eintrag wurde aus der Datenbank gelöscht! ( PRESS ENTER )";
						$hold = <STDIN>;
						return "";
					}					
				}
			} else {
				#Keine Zahl eingegeben!
				print "Bitte nur Zahlen angeben! ( PRESS ENTER )";
				$hold = <STDIN>;
				redo NEED_VALID_ID;
			}
		}
	}	
}

sub delete_event {
	#Variablendeklaration
	my $hold;
	my $choice;
	my $amount;
	my $not_ready_yet = 1;
	my @valid_event_ids;
	my @row;
	
	#Konstruktor und Verbindung - alle Fehler führen zum Abbruch
	my $dbh = DBI->connect( $dsn, $user, $pass,
	{RaiseError => 1, PrintError => 0, ShowErrorStatement => 1});
		
	if(($amount = &event_exist()) eq '0') {
		#Abbruch, da nichts gelöscht werden kann
		say "Es sind keine Vorstellungen zum löschen vorhanden! ( PRESS ENTER )";
		$hold = <STDIN>;
		return "";
	} else {
		#Welche ID's sind überhaupt vorhanden?
		@valid_event_ids = &get_valid_event_ids();
		
		#Solange die Schleife abarbeiten bis bis eine vorhandene ID eingegeben wurde!
		NEED_VALID_EVENT_ID: while($not_ready_yet) {
			system("cls");
			&print_events();
			print "\nBitte wählen Sie die zu löschende Vorstellung_ID aus: ";
			chomp($choice = <STDIN>);
			if($choice =~ /[1-9]\d{0,}/) {
				if(!&is_valid_event_id($choice, @valid_event_ids)) {
					redo NEED_VALID_EVENT_ID;
				} else {
					#Sind Elemente in der Tabelle Reservierung welche mit der zu löschenden Vorstellung_ID verknüpft sind?
					my $sql = qq(SELECT COUNT(*) AS Eintraege FROM reservierung WHERE Vorstellung_ID = ?);
					my $sth = $dbh->prepare($sql);
					$sth->execute($choice);
					@row = $sth->fetchrow_array();
					$amount = $row[0];
					$sth->finish;
					
					if(!($amount eq '0')) {
						#Warten bis Enter
						say "Die Vorstellung kann nicht gelöscht werden, da noch Reservierungen, welche sich auf die Vorstellung beziehen vorhanden sind! ( PRESS ENTER )";
						$hold = <STDIN>;
					} else {
						$sql = qq(DELETE FROM vorstellung WHERE Vorstellung_ID = ?);
						$sth = $dbh->prepare($sql);
						$sth->execute($choice);
						$sth->finish;
						
						#Warten bis Enter
						print "Der Eintrag wurde aus der Datenbank gelöscht! ( PRESS ENTER )";
						$hold = <STDIN>;
						return "";
					}					
				}
			} else {
				#Keine Zahl eingegeben!
				print "Bitte nur Zahlen angeben! ( PRESS ENTER )";
				$hold = <STDIN>;
				redo NEED_VALID_ID;
			}
		}
	}	
}

sub is_valid_film_id {
	my $hold;
	my $choice = shift(@_);
	my @valid_film_ids = @_;
	while(@valid_film_ids) {
		if($choice == shift(@valid_film_ids)) {
			return 1;
		} else {
			print "";
		}
	}
	#Warten bis Enter
	print "Die Filme_ID: $choice ist nicht vorhanden! ( PRESS ENTER )";
	$hold = <STDIN>;
	return 0;
}

sub is_valid_show_room_id {
	my $hold;
	my $choice = shift(@_);
	my @valid_show_room_ids = @_;
	while(@valid_show_room_ids) {
		if($choice == shift(@valid_show_room_ids)) {
			return 1;
		} else {
			print "";
		}
	}
	#Warten bis Enter
	print "Die Saal_ID: $choice ist nicht vorhanden! ( PRESS ENTER )";
	$hold = <STDIN>;
	return 0;
}

sub is_valid_event_id {
	my $hold;
	my $choice = shift(@_);
	my @valid_event_ids = @_;
	while(@valid_event_ids) {
		if($choice == shift(@valid_event_ids)) {
			return 1;
		} else {
			print "";
		}
	}
	#Warten bis Enter
	print "Die Vorstellung_ID: $choice ist nicht vorhanden! ( PRESS ENTER )";
	$hold = <STDIN>;
	return 0;	
}

sub duration_to_int {
	#Dauer des Filmes in eine Zahl wandeln
	if( $_[0] =~/\d+/ ) {
		return $&+0;
	} else {
		print "Kein Match!\n";
	}
}

sub check_film {
	#Variablendeklaration
	my $n = 1;
	my $amount;
	my $film = $_[0];
	my $title = $film->title();
	my $duration = &duration_to_int($film->duration());
	my $genre = &print_array(@{ $film->genres() });
	my $storyline = $film->storyline();
	my $cover = $film->cover();
	my @row;
	
	#Konstruktor und Verbindung - alle Fehler führen zum Abbruch
	my $dbh = DBI->connect( $dsn, $user, $pass,
	{RaiseError => 1, PrintError => 0, ShowErrorStatement => 1});
	
	#Anzahl der Filme beschaffen
	$amount = &film_exist();

	#Datenbank Kommando einlesen und auführen
	my $sql = qq(SELECT Name FROM filme);
	my $sth = $dbh->prepare($sql);
	$sth->execute;
	
	#Daten abgleichen
	STOP: while(@row = $sth->fetchrow_array() || 1) {
		#Ist der Titel in der DB schon vorhanden, dann schreibe nicht
		if($row[0] eq $title) {
			print "Film konnte nicht geschrieben werden, weil er schon vorhanden ist!\n";
			$sth->finish;
			$dbh->disconnect;
			last STOP;
		#Zähle $n hoch um alle DB Elemente auszulesen
		} elsif($n < $amount) {
			$n++;
		#Film noch nicht vorhanden, also schreibe
		} else {
			print "Film ist noch nicht in der Datenbank vorhanden!\n";
			print "Film wird zur Datenbank übermittelt!\n";
			&film_to_database($title, $duration, $genre, $storyline, $cover);
	
			#Verbindung beenden
			$sth->finish;
			$dbh->disconnect;
			last STOP;
		}		
	}
}

sub film_to_database {
	#Variablendeklaration
	my $hold;
	
	#Konstruktor und Verbindung - alle Fehler führen zum Abbruch
	my $dbh = DBI->connect( $dsn, $user, $pass,
	{RaiseError => 1, PrintError => 0, ShowErrorStatement => 1});
	
	#Datenbank Kommando einlesen und auführen
	my $sth = $dbh->prepare('INSERT INTO filme VALUES(?, ?, ?, ?, ?, ?)');
	$sth->execute(undef, $_[0],$_[1], $_[2], $_[3], $_[4]);
	$sth->finish;
	$dbh->disconnect;
	print "Film wurde erfolgreich geschrieben!\n";
	
	#Anzeige bis Enter bestehen lassen
	print "Anzeige beenden ( PRESS ENTER )?";
	$hold = <STDIN>;
}

sub print_film_database {
	#Variablendeklaration
	my $hold;
	my $format = "" . ("%-10s") . ("%-40s") . ("%-20s") . ("%-40s");
	my @headline= ("Filme_ID", "Name", "Spiellänge", "Genre");
	
	#Konstruktor und Verbindung - alle Fehler führen zum Abbruch
	my $dbh = DBI->connect( $dsn, $user, $pass,
	{RaiseError => 1, PrintError => 0, ShowErrorStatement => 1});
	
	#Überschrift
	printf $format, @headline;
	say "\n";
	
	#Datenbank Kommando einlesen und auführen
	my $sql = qq(SELECT Filme_ID, Name, Spiellaenge, Genre FROM filme);
	my $sth = $dbh->prepare($sql);
	$sth->execute;
	
	#Daten ausgeben
	while(my @row = $sth->fetchrow_array()) {
		printf $format, @row;
		print "\n";
	}
	
	#Verbindung beenden
	$sth->finish;
	$dbh->disconnect;
}

sub print_events_error {
	#Variablendeklaration
	my $show_room_id = shift(@_);
	my $date = shift(@_);
	my $hold;
	my $format = "" . ("%-20s") . ("%-10s") . ("%-10s") . ("%-15s") . ("%-10s") . ("%-10s");
	my @headline= ("Vorstellung_ID", "Beginn", "Ende", "Datum", "Filme_ID", "Saal_ID");
	
	#Konstruktor und Verbindung - alle Fehler führen zum Abbruch
	my $dbh = DBI->connect( $dsn, $user, $pass,
	{RaiseError => 1, PrintError => 0, ShowErrorStatement => 1});
	
	#Überschrift
	printf $format, @headline;
	say "\n";
	
	#Datenbank Kommando einlesen und auführen
	my $sql = qq(SELECT Vorstellung_ID, Beginn, Ende, Datum, Filme_ID, Saal_ID FROM vorstellung WHERE Datum = ? AND Saal_ID = ?);
	my $sth = $dbh->prepare($sql);
	$sth->execute($date, $show_room_id);
	
	#Daten ausgeben
	while(my @row = $sth->fetchrow_array()) {
		printf $format, @row;
		print "\n";
	}
	
	#Verbindung beenden
	$sth->finish;
	$dbh->disconnect;
	say "";
}

sub print_events {
	#Variablendeklaration
	
	my $hold;
	my $format = "" . ("%-20s") . ("%-10s") . ("%-10s") . ("%-15s") . ("%-10s") . ("%-10s");
	my @headline= ("Vorstellung_ID", "Beginn", "Ende", "Datum", "Filme_ID", "Saal_ID");
	
	#Konstruktor und Verbindung - alle Fehler führen zum Abbruch
	my $dbh = DBI->connect( $dsn, $user, $pass,
	{RaiseError => 1, PrintError => 0, ShowErrorStatement => 1});
	
	#Überschrift
	printf $format, @headline;
	say "\n";
	
	#Datenbank Kommando einlesen und auführen
	my $sql = qq(SELECT Vorstellung_ID, Beginn, Ende, Datum, Filme_ID, Saal_ID FROM vorstellung);
	my $sth = $dbh->prepare($sql);
	$sth->execute;
	
	#Daten ausgeben
	while(my @row = $sth->fetchrow_array()) {
		printf $format, @row;
		print "\n";
	}
	
	#Verbindung beenden
	$sth->finish;
	$dbh->disconnect;
	say "";
}

sub print_show_room_database {
	#Variablendeklaration
	my $hold;
	my $format = "" . ("%-10s") . ("%-25s") . ("%-20s") . ("%-20s");
	my @headline= ("Saal_ID", "Anzahl der Sitzplätze", "Projektor", "Soundanlage");
	
	#Konstruktor und Verbindung - alle Fehler führen zum Abbruch
	my $dbh = DBI->connect( $dsn, $user, $pass,
	{RaiseError => 1, PrintError => 0, ShowErrorStatement => 1});
	
	#Überschrift
	printf $format, @headline;
	say "\n";
	
	#Datenbank Kommando einlesen und auführen
	my $sql = qq(SELECT Saal_ID, (Anzahl_Sitze_pro_Reihe*Anzahl_Reihen) AS Anzahl_der_Sitzplaetze, Projektor, Soundanlage FROM saal);
	my $sth = $dbh->prepare($sql);
	$sth->execute;
	
	#Daten ausgeben
	while(my @row = $sth->fetchrow_array()) {
		printf $format, @row;
		print "\n";
	}
	
	#Verbindung beenden
	$sth->finish;
	$dbh->disconnect;
}

sub generate_event {
	#Variablendeklaration
	my $choice;
	my @valid_film_ids;
	my @valid_show_room_ids;
	my $not_ready_yet = 1;
	my $amount;
	my $hold;
	my %spielzeiten;
	my $film_id;
	my $show_room_id;
	my $date;
	my $time;
	my $end;
	my @ungerundet;
	my $min;
	my $max;
	
	#Konstruktor und Verbindung - alle Fehler führen zum Abbruch
	my $dbh = DBI->connect( $dsn, $user, $pass,
	{RaiseError => 1, PrintError => 0, ShowErrorStatement => 1});
	
	if(($amount = &film_exist()) eq '0') {
		#Abbruch, da ohne Filme keine Vorstellung erstellt werden kann
		say "Es sind keine Filme in der Datenbank vorhanden! ( PRESS ENTER )";
		$hold = <STDIN>;
		return "";
	} else {
		#Welche ID's sind überhaupt vorhanden?
		@valid_film_ids = &get_valid_film_ids();
		
		#Solange die Schleife abarbeiten bis bis eine vorhandene ID eingegeben wurde!
		NEED_VALID_FILM_ID: while($not_ready_yet) {
			system("cls");
			&print_film_database();
			print "\nBitte wählen Sie die Filme_ID für die Vorstellung aus: ";
			chomp($choice = <STDIN>);
			if($choice =~ /[1-9]\d{0,}/) {
				if(!&is_valid_film_id($choice, @valid_film_ids)) {
					redo NEED_VALID_FILM_ID;
				} else {
					system("cls");
					$film_id = $choice;
					%spielzeiten = &get_duration();
					if(($amount = &show_room_exist()) eq '0'){
						say "Es sind bisher noch keine Sääle angelegt worden! ( PRESS ENTER )";
						$hold = <STDIN>;
						return "";
					} else {
						#Welche ID's sind überhaupt vorhanden?
						@valid_show_room_ids = &get_valid_show_room_ids();
		
						#Solange die Schleife abarbeiten bis bis eine vorhandene ID eingegeben wurde!
						NEED_VALID_SHOW_ROOM_ID: while($not_ready_yet) {
							system("cls");
							&print_show_room_database();
							print "\nBitte wählen Sie die Saal_ID für die Vorstellung aus: ";
							chomp($choice = <STDIN>);
							if($choice =~ /[1-9]\d{0,}/) {
								if(!&is_valid_show_room_id($choice, @valid_show_room_ids)) {
									redo NEED_VALID_SHOW_ROOM_ID;
								} else {
									$show_room_id = $choice;

									#Solange die Schleife abarbeiten bis bis eine gültiges Datum dd.mm.yyyy es werden keine vergangen daten abgefangen
									NEED_VALID_DATE: while($not_ready_yet) {
										system("cls");
										print "Bitte geben Sie ein gültiges Datum im dd.mm.yyyy Format an: ";
										chomp($choice = <STDIN>);
										if(is_valid_date($choice)) {
											$date = $choice;
											
											#Sind Einträge in der Vorstellungstabelle mit wo Saal_ID + Datum mit den vorherigen Eingaben übereinstimmen?
											#Anzahl der Einträge auslesen
											my $sql = qq(SELECT COUNT(Vorstellung_ID) FROM vorstellung WHERE Saal_ID = ? AND Datum = ?);
											my $sth = $dbh->prepare($sql);
											$sth->execute($show_room_id, $date);
											my @row = $sth->fetchrow_array();
											$sth->finish;
											if(($amount = $row[0]) eq '0') {
												NEED_VALID_TIME: while($not_ready_yet) {
													system("cls");
													print "Bitte geben Sie den Beginn an (Öffnungszeiten: 09:00 - 24:00 Uhr)\n";
													print "Bedenken Sie, das Vorstellungen nur im Virtelstundentakt generiert werden können z.B. '19:30' o. '19:45': ";
													chomp($choice = <STDIN>);
													if($choice =~ /\A(?:(?:2[0-4])|(?:1[0-9])|(?:0?[9])):(?:(?:00)|(?:15)|(?:30)|(?:45))\z/) {
														$time = $choice;
														
														#Bestimme Endzeit
														$end = &calculate_end_time_clean(%spielzeiten, $film_id, $time);
														
														#Wenn die Endzeit 24:00 Uhr überschreitet
														if($end == 0) {
															print "\nDie Endzeit des Filmes überschreitet 24:00 Uhr. Bitte korrigieren Sie Ihre Eingabe!";
															print "\nGeplanter Start: $time";
															print "\nSpieldauer:      $spielzeiten{$film_id} Stunden";															
															print "\nAnzeige beenden ( PRESS ENTER )?";
															$hold = <STDIN>;
															redo NEED_VALID_TIME;																														
														}
														
														#Datenbank Kommando einlesen und auführen
														$sth = $dbh->prepare('INSERT INTO vorstellung VALUES(?, ?, ?, ?, ?, ?)');
														$sth->execute(undef, $time, $end, $date, $film_id, $show_room_id);
														$sth->finish;
														$dbh->disconnect;
														print "Vorstellung wurde erfolgreich erstellt!\n";
														
														#Anzeige bis Enter bestehen lassen
														print "Anzeige beenden ( PRESS ENTER )?";
														$hold = <STDIN>;
														return "";
													} else {
														print "Bitte halten Sie sich an die Vorgabe hh:mm! ( PRESS ENTER )";
														$hold = <STDIN>;
														redo NEED_VALID_TIME;
													}
												}
											} else {
												NEED_VALID_TIME2: while($not_ready_yet) {
													system("cls");
													print "Bitte geben Sie den Beginn an (Öffnungszeiten: 09:00 - 24:00 Uhr)\n";
													print "Bedenken Sie, das Vorstellungen nur im Virtelstundentakt generiert werden können z.B. '19:30' o. '19:45': ";
													chomp($choice = <STDIN>);
													if($choice =~ /\A(?:(?:2[0-4])|(?:1[0-9])|(?:0?[9])):(?:(?:00)|(?:15)|(?:30)|(?:45))\z/) {
														$time = $choice;
														
														#Datenbank Kommando einlesen und auführen
														$sth = $dbh->prepare('SELECT MAX(DISTINCT Ende) FROM vorstellung WHERE Ende <= ? AND Datum = ? AND Saal_ID = ?');
														$sth->execute($time, $date, $show_room_id);
														@row = $sth->fetchrow_array();
														$sth->finish;
															
														#Nächste kleinere oder gleiche Endzeit des vorherigen Filmes 
														$min = $row[0];
														if(&time_check($time, $date, $show_room_id)) {
															&print_events_error($show_room_id, $date);
															print "\nDie Startzeit des Filmes überschneidet sich mit bereits vorhandenen Vorstellungen!";
															print "\nGeplanter Start: $time";
															print "\nSpieldauer:      $spielzeiten{$film_id} Stunden";
															$end = $end = &calculate_end_time_clean(%spielzeiten, $film_id, $time);
															print "\nGeplantes Ende:  $end";
															print "\nAnzeige beenden ( PRESS ENTER )?";
															$hold = <STDIN>;
															redo NEED_VALID_TIME2;	
														}
															
														#Datenbank Kommando einlesen und auführen
														$sth = $dbh->prepare('SELECT MIN(DISTINCT Beginn) FROM vorstellung WHERE Beginn >= ? AND Datum = ? AND Saal_ID = ?');
														$sth->execute($time, $date, $show_room_id);
														@row = $sth->fetchrow_array();
														$sth->finish;
															
														#Nächste größere oder gleiche Anfangszeit der darauf folgenden vorstellung
														$end = $end = &calculate_end_time_clean(%spielzeiten, $film_id, $time);
														$max = $row[0];
														if(&time_check($end, $date, $show_room_id)) {
															&print_events_error($show_room_id, $date);
															print "\nDie Endzeit des Filmes überschneidet sich mit bereits vorhandenen Vorstellungen!";
															print "\nGeplanter Start: $time";
															print "\nSpieldauer:      $spielzeiten{$film_id} Stunden";
															print "\nGeplantes Ende:  $end";
															print "\nAnzeige beenden ( PRESS ENTER )?";
															$hold = <STDIN>;
															redo NEED_VALID_TIME2;	
														}													
														
														#Start muss größer als letztes bekanntes Ende sein und kleiner als nächster bekannter Start
														if(($time gt $min and $max gt $time) or ($time gt $min and (!(defined $max))) or ((!(defined $min)) and $max gt $time)) {
															#Bestimme Endzeit
															$end = &calculate_end_time_clean(%spielzeiten, $film_id, $time);
															if($end == 0) {
																&print_events_error($show_room_id, $date);
																print "\nDie Endzeit des Filmes überschreitet 24:00 Uhr. Bitte korrigieren Sie Ihre Eingabe!";
																print "\nGeplanter Start: $time";
																print "\nSpieldauer:      $spielzeiten{$film_id} Stunden";
																print "\nAnzeige beenden ( PRESS ENTER )?";
																$hold = <STDIN>;
																redo NEED_VALID_TIME2;																														
															}
															if(($max gt $end) or (!(defined $max))) {
																#Datenbank Kommando einlesen und auführen
																$sth = $dbh->prepare('INSERT INTO vorstellung VALUES(?, ?, ?, ?, ?, ?)');
																$sth->execute(undef, $time, $end, $date, $film_id, $show_room_id);
																$sth->finish;
																$dbh->disconnect;
																print "Vorstellung wurde erfolgreich erstellt!\n";
																
																#Anzeige bis Enter bestehen lassen
																print "Anzeige beenden ( PRESS ENTER )?";
																$hold = <STDIN>;
																return "";	
															} else {
																&print_events_error($show_room_id, $date);
																print "Endzeitpunkt überschneidet sich mit bereits vorhandenen Vorstellungen! ( PRESS ENTER )";
																print "\nGeplanter Start: $time";
																print "\nSpieldauer:      $spielzeiten{$film_id} Stunden";
																$end = $end = &calculate_end_time_clean(%spielzeiten, $film_id, $time);
																print "\nGeplantes Ende:  $end";
																$hold = <STDIN>;
																redo NEED_VALID_TIME2;
															}
														} else {
															&print_events_error($show_room_id, $date);
															print "Startzeitpunkt überschneidet sich mit bereits vorhandenen Vorstellungen! ( PRESS ENTER )";
															print "\nGeplanter Start: $time";
															print "\nSpieldauer:      $spielzeiten{$film_id} Stunden";
															$end = $end = &calculate_end_time_clean(%spielzeiten, $film_id, $time);
															print "\nGeplantes Ende:  $end";
															$hold = <STDIN>;
															redo NEED_VALID_TIME2;
														}												
													} else {
														print "Bitte halten Sie sich an die Vorgabe hh:mm! ( PRESS ENTER )";
														$hold = <STDIN>;
														redo NEED_VALID_TIME2;
													}
												}												
											}										
										} else {
											#Keine Zahl eingegeben!
											print "Bitte halten Sie sich an die Vorgabe dd.mm.yyyy! ( PRESS ENTER )";
											$hold = <STDIN>;
											redo NEED_VALID_DATE;
										}
									}
								}
							}
							else {
								#Keine Zahl eingegeben!
								print "Bitte nur Zahlen angeben! ( PRESS ENTER )";
								$hold = <STDIN>;
								redo NEED_VALID_SHOW_ROOM_ID;
							}
						}
					}									
				}								
			} else {
				#Keine Zahl eingegeben!
				print "Bitte nur Zahlen angeben! ( PRESS ENTER )";
				$hold = <STDIN>;
				redo NEED_VALID_FILM_ID;
			}
		}
	}
}

sub print_storyline {
	#Output des Inhaltes auf 20 Wörter pro Zeile beschränken
	my @storyline = split (/ /, $_[0]);
	my $counter = 0;
	
	#Wort für Wort ausgeben
	do{
		#Solange $counter != 20 ist einfach Wort für Wort printen
		if($counter != 20) {
			$counter++;
			print shift(@storyline) . " ";
		#Sobald $counter auf 20 steht führe einen Zeilenumbruch aus
		} else  {
			$counter = 0;
			print "\n        ";
		}
	#Führe die Schleif solange aus bis @storyline undefined ist
	}while(@storyline);
	return "";
}

sub print_array {
	my $genre_string;
	my $n = 1;
	my $amount = @_;
	foreach(@_) {
		#Filter um Leerzeichen zu entfernen
		$_ =~ s/ //g;
		if($n != $amount) {
			$n++;
			$genre_string .= "$_, ";
		} else {
			$genre_string .= $_;
		}				
	}
	return $genre_string;
}

sub print_array2 {
	my $n = 1;
	my $amount = @_;
	foreach(@_) {
		if($n != $amount) {
			$n++;
			print "$_,";
		} else {
			print;
		}				
	}
}

sub yes_or_no {
	#Diese Subroutine soll den Anwender eine Ja- / Nein-Abfrage unterbreiten
	my $choice;
	FEHLER: until($choice) {
		print "\nBitte Wahl treffen ( j/ja | n/nein ): ";
		chomp($choice = <STDIN>);
		if($choice =~ /\Aj\z|\Aja\z/i) {
			return 1;
		} elsif($choice =~ /\An\z|\Anein\z/i) {
			return 0;
		} else {
			print "Unzulässige Eingabe!\n";
			$choice = 0;
			redo FEHLER;
		}
	}
}

sub search {
	my @imdb_objects;
	my $title;
	my $year;
	my $n = 0;
	
	REDO: until($n) {
		#Eingabe des gesuchten Films
		print "Bitte geben Sie einen Filmtitel und Erscheinungsjahr ein (z. B. Harry Potter,2001): ";
		chomp($_ = <STDIN>);
		($title, $year) = split(/,/, $_);
		$imdb_objects[$n] = new IMDB::Film(	crit => $title,									#Titel
											year => $year,									#Jahr
											search => "find?ref_=nv_sr_fn&q=" );			#Suchstring
		if($imdb_objects[$n]->status) {
			system("cls");
			say "Folgendes wurde gefunden:";
			print "\nTitel:  " . $imdb_objects[$n]->title() . "\n";
			print "Jahr:   " . $imdb_objects[$n]->year() . "\n";
			print "Dauer:  " . $imdb_objects[$n]->duration() . "\n";
			print "Genre:  ";
			print &print_array(@{ $imdb_objects[$n]->genres() }) . "\n";
			print "Cover:  " . $imdb_objects[$n]->cover() . "\n";
			print "Inhalt: ";
			print &print_storyline($imdb_objects[$n]->storyline()) . "\n";
			
			#Wurde der richtige Film gefunden?
			print "\nWurde der richtige Film gefunden?";
			if(&yes_or_no()) {
				system("cls");
				print "Wunderbar!\n\n";
				&check_film($imdb_objects[$n]);
				print "Wollen Sie einen weiteren Film suchen?";
				if(&yes_or_no()) {
					system("cls");
					$n++;
					redo REDO;
				} else  {
					system("cls");
					last;
				}
			} else {
				system("cls");
				say "Neuer Versuch!";
				redo REDO;
			}	
		} else {
			system("cls");
			print "Fehler: " . $imdb_objects[$n]->error . "\n";
			print "Wollen Sie es erneut versuchen?";
			if(&yes_or_no()) {
				system("cls");
				say "Neuer Versuch!";
				redo;
			} else {
				system("cls");
				delete $imdb_objects[$n]; 
				last;
			}
		}			
	}
	return @imdb_objects;	
}


system("chcp 1252");								#Zeichensatz anpassen

#Variablendeklaration
my @imdb_container_temp;
my @imdb_container;
my $choice = 1;

#Programmbeginn
while($choice) {
	system("cls");
	say "###################";
	say "#  IMDB2Database  #";
	say "###################\n";
	say "#######################################";
	say "#  Was wollen Sie tun?                #";
	say "#-------------------------------------#";
	say "#  1. Film/e suchen/schreiben         #";
	say "#  2. Film/e auslesen/löschen         #";
	say "#  3. Vorstellung erstellen           #";
	say "#  4. Vorstellung auslesen/löschen    #";
	say "#  5. Beenden                         #";
	say "#######################################";
	
	print "\nBitte treffen Sie Ihre Auswahl: ";
	chomp($choice = <STDIN>);
	if($choice =~ /[^1234]/) {						#Programm beenden
		say "Das Programm wird beendet!";
		last;
	} elsif($choice eq '1') {						#Film/e suchen und schreiben
		system("cls");
		push(@imdb_container_temp, &search());
		redo;
	} elsif($choice eq '2') {						#Datenbank auslesen oder Film löschen
		system("cls");
		&print_film_database();
		print "\nSoll ein Film gelöscht werden?";
		if(&yes_or_no()){
			system("cls");
			&delete_film();
			redo;			
		} else {
			redo;	
		}
	} elsif($choice eq '3') {						#Vorstellung erstsellen
		system("cls");
		&generate_event();
		redo;
	} else {										#Vorstellung löschen
		system("cls");
		&print_events();
		print "\nSoll eine Vorstellung gelöscht werden?";
		if(&yes_or_no()){
			system("cls");
			&delete_event();
			redo;			
		} else {
			redo;	
		}
	}
}

