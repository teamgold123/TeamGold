#!/usr/bin/perl

# Modell-Merkmale werden in ARGV[0] - [5] übergeben.
# Datensatz wird angelegt.

use strict;
use DBI;


# Deklaration der noetigen Variablen fuer die Verbindung

my $db_host = 'Niki_NB';
my $db_port = 3306;
my $db_user = 'chef';
my $db_name = 'versicherungscheck';
my $db_pass = 'passwd';


# Verbindung zur DB herstellen

my $dbh = DBI->connect("DBI:mysql:database=$db_name;host=$db_host;port=$db_port", "$db_user", "$db_pass");


# SQL-Anweisung, um die Daten einzufügen

my $create_query = $dbh->prepare("INSERT INTO versicherungscheck.modell (hsn, tsn, model, leistung, hubraum, kraftstoff) VALUES ('".$ARGV[0]."', '".$ARGV[1]."', '".$ARGV[2]."', '".$ARGV[3]."', '".$ARGV[4]."', '".$ARGV[5]."');");
$create_query->execute();


# Datenbankverbindung schließen
 
$dbh->disconnect();