#!/usr/bin/perl

# HSN und TSN müssen in ARGV[0] und ARGV[1] übergeben werden. 
# Modell-Merkmale werden online abgegriffen und es wird überprüft,
# ob ein entspr. Eintrag bereits existiert.

 
use strict;
use LWP 5.64;
use DBI;


# Seiteninhalt mittels LWP abrufen

my $browser = LWP::UserAgent->new();
my $seite = $browser->get('http://www.hsn-tsn.de/'.$ARGV[0].'-'.$ARGV[1].'.html');
die "Die Seite existiert nicht" unless $seite->is_success;


# Seiteninhalt filtern

my $seite_code = $seite->decoded_content();
$seite_code =~ m/<a href="\/hsn-tsn\.php\?/;
$' =~ m/<\/table>/;
$seite_code = $`;


# Ergebnisse im Array @table speichern

my @table = split (m/<\/?t?d?r?a?>/, $seite_code);
$table[0] =~ m/>/;
$table[0] = $';


# Prüfen, ob der Eintrag bereits vorhanden ist

my $anzahl = &Daten_pruefen($ARGV[0], $ARGV[1]);


# Bei Nicht-Vorhandensein muss ein neuer Eintrag erzeugt werden, 
# dazu wird das Script DB_eintragen.pl aufgerufen und alle Modell-Merkmale übergeben.

if ($anzahl == 0) {
	system("perl", "F:\\Technikerschule\\ITV34\\Projekt\\Versicherungscheck\\src\\DB_eintragen.pl", $ARGV[0], $ARGV[1], $table[0], $table[3], $table[5], $table[7]);
}

exit;



sub Daten_pruefen {
	
	# Deklaration der noetigen Variablen fuer die Verbindung

	my $db_host = 'Niki_NB';
	my $db_port = 3306;
	my $db_user = 'chef';
	my $db_name = 'versicherungscheck';
	my $db_pass = 'passwd';


	# Verbindung zur DB herstellen

	my $dbh = DBI->connect("DBI:mysql:database=$db_name;host=$db_host;port=$db_port", "$db_user", "$db_pass");


	# SQL-Anweisung zum Prüfen, ob ein Eintrag bereits vorhanden ist.

	my $count_query = $dbh->prepare("SELECT COUNT(*) FROM versicherungscheck.modell WHERE hsn = '".$ARGV[0]."' AND tsn = '".$ARGV[1]."';");
	$count_query->execute();


	# Ergebnis der Select-Query in lok. Variable speichern
	
	my $counter = $count_query->fetchrow();
	$count_query->finish();
	

	# Datenbankverbindung schließen
 
	$dbh->disconnect();


	#Rückgabe des Counters

	return $counter;
}

