
<?php

// Verbindung zu localhost auf port 3307
$link = mysql_connect('localhost', 'root', '');
if (!$link) {
    die('Verbindung schlug fehl: ' . mysql_error());
}
echo 'Erfolgreich verbunden';
mysql_close($link);



$datenbank = mysql_select_db('kurse')
or die ("Datenbank existiert nicht!");
?>



	
		/*
		$verbindung = mysql_connect("localhost", "root")
		or die("Keine Verbindung m&ouml;glich!");
		
		//
		$datenbank = mysql_select_db("kino_db")
		or die ("Datenbank existiert nicht!");
		
		$abfrage = "SELECT Uhrzeit, Datum FROM Vorstellungen";
		$ergebnis = mysql_query($abfrage)
		or die ("Lesen des Datensatzes fehlgeschlagen!");
		
		echo "In der Datenbank enthalten: <br><br>\n";
		echo "<table border bgcolor='#EEEEEE'>\n";
		echo "
		<tr>
		<th>Uhrzeit</th>
		<th>Datum</th>
		</tr>\n";
		 
		while (list($Uhrzeit, $Datum) = mysql_fetch_row($ergebnis))
		{
			echo"
			<tr>
			<td>$Uhrzeit</td>
			<td>$Datum</td>
			</tr>";			
		}
		
		echo"</table><br>Ende der Abfrage.\n";
		mysql_close($verbindung);
		?>*/


		
