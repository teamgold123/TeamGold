import java.sql.*;
import javax.swing.JOptionPane;

/*
 * In dieser Klasse wird eine Verbindung zur Datenbank hergestellt,
 * diese wird im kompletten Programm genutzt.
 * 
 * Mit Hilfe verschiedener Methoden, kann man die gewünschten Werte aus der Datenbank
 * auselesen oder Datensätze in die Datenbank schreiben.
 * Falls beim Datenbankzugriff ein Fehler auftritt wird eine Fehlermeldung ausgegeben und das Programm wird beendet.
 */

public class DB_Zugriff {

	Connection 	con;
	Statement 	stmt;
	ResultSet 	rs;
	
	final String DATENBANK 	= "kino_db";
	final String BENUTZER 	= "root";
	final String PASSWORT 	= "";
	
	// Hier wird eine Verbindung mit der Datenbank hergestellt
	public DB_Zugriff() { 
		try {
			Class.forName("com.mysql.jdbc.Driver");
			con = DriverManager.getConnection("jdbc:mysql://localhost:3306/" + DATENBANK, BENUTZER, PASSWORT);
			stmt = con.createStatement();
		}
		catch (Exception e) {
			e.printStackTrace();
			JOptionPane.showMessageDialog(null, "<html>Fehler beim Verbindungsaufbau mit der Datenbank!<br><br>Programm wird beendet!</html>", "Achtung!", JOptionPane.ERROR_MESSAGE);
			System.exit(1);
		}
	}
	
	// Methode empfängt eine Spalte und einen Abfragestring, und gibt den abgefragten int-Wert  aus der DB zurück
	int IntAuslesen (String spalte, String abfrage) {
		
		int Wert = 0;
	
		try {
			rs = stmt.executeQuery("select * from " + abfrage );

			while( rs.next() ) {
				Wert = rs.getInt( spalte );
			}
		}
		// Falls ein Fehler auftritt, wird eine Meldung ausgegeben und das Programm beendet
		catch (Exception e) {
			JOptionPane.showMessageDialog(null, "<html>Folgende Abfrage war nicht erfolgreich:<br>'" + spalte + "'<br><br>Programm wird beendet!</html>", "Fehler beim Datenbankzugriff!", JOptionPane.ERROR_MESSAGE);
			System.exit(1);
		}
		
		return Wert;
	}

	// Methode empfängt eine Spalte und einen Abfragestring, und gibt den abgefragten String aus der DB zurück
	String StringAuslesen (String spalte, String abfrage) {
		
		String Wert = null;
	
		try {
			rs = stmt.executeQuery("select * from " + abfrage);
			
			while( rs.next() ) {
				Wert = rs.getString( spalte );
			}			
		}
		catch (Exception e) {
			JOptionPane.showMessageDialog(null, "<html>Folgende Abfrage war nicht erfolgreich:<br>'" + spalte + "'<br><br>Programm wird beendet!</html>", "Fehler beim Datenbankzugriff", JOptionPane.ERROR_MESSAGE);
			System.exit(1);
		}
		
		return Wert;
	}

	// Methode empfängt eine Spalte und einen Abfragestring, und gibt ein String-Array mit den Ergebnissen aus der DB zurück
	String[] StringArray (String spalte, String abfrage) {
		
		try {			
			int anz = sonder( "count(*) from " + abfrage);		// Mithilfe der sonder-Methode wird die Anzahl der Ergebnisse ermittelt

			String[] liste = new String[anz];					// String Array in der Größe der Ergebnisse anlegen
			
			rs = stmt.executeQuery("select * from " + abfrage);	// Abfrage durchführen und Ergebnisse in rs speichern

			int i = 0;
			while( rs.next() ) {								// Für jedes Ergebnis,
				liste[i] = rs.getString( spalte );				// aktuelles Ergebnis in das return-Array schreiben
				i++;											// Index des return-Arrays incrementieren
			}	
			
			return liste;										// Array zurückgeben
		}
		catch (Exception e) {
			JOptionPane.showMessageDialog(null, "<html>Folgende Abfrage war nicht erfolgreich:<br>'" + spalte + "'<br><br>Programm wird beendet!</html>", "Fehler beim Datenbankzugriff", JOptionPane.ERROR_MESSAGE);
			System.exit(1);
		}
		return null;
	}

	// Methode empfängt eine Spalte und einen Abfragestring, und gibt eine int-Array mit dem Ergebnissen aus der DB zurück
	int[] intArray (String spalte, String abfrage) {

		try {
			int anz = sonder( "count(*) from " + abfrage );			// MIt der sonder-Methode wird die Anzahl der Ergebnisse ermittelt

			int[] liste = new int[anz];								// String Array in der Größe der Ergebnisse anlegen	
			
			rs = stmt.executeQuery( "select * from " + abfrage);	// Abfrage durchführen und Ergebnisse in rs speichern

			int i = 0;
			while( rs.next() ) {									// Für jedes Ergebnis,
				liste[i] = rs.getInt( spalte );						// aktuelles Ergebnis in das return-Array schreiben
				i++;												// Index des return-Arrays incrementieren
			}		
			
			return liste;											// Array zurückgeben
		}
		catch (Exception e) {
			JOptionPane.showMessageDialog(null, "<html>Folgende Abfrage war nicht erfolgreich:<br>'" + spalte + "'<br><br>Programm wird beendet!</html>", "Fehler beim Datenbankzugriff", JOptionPane.ERROR_MESSAGE);
			System.exit(1);
		}
		return null;
	}
	
	// Diese Methode wird verwendet um spezielle Abfragen zu tätigen ( count(), max() ), gibt eine Zahl zurück
	int sonder (String abfrage) {

		try {
			rs = stmt.executeQuery("select " + abfrage);	// Abfrage an die Datenbank senden

			int anz = 0;
					
			while ( rs.next() ) {
				anz = ( rs.getInt(1) );						// Ergebnis in anz schreiben
			}
			
			return anz;
		}
		catch (Exception e) {
			JOptionPane.showMessageDialog(null, "<html>Folgende Abfrage war nicht erfolgreich:<br>'" + abfrage + "'<br><br>Programm wird beendet!</html>", "Fehler beim Datenbankzugriff", JOptionPane.ERROR_MESSAGE);
			System.exit(1);
		}
		return 0;
	}

	// Diese Methode wird verwendet um die Reservierungen in die Datenbank zu schreiben, dabei wird eine 'Stored Procedure' verwendet.
	void reservieren (int RID, int Reihe, int Sitzplatz, String Vorstellung_ID, String Kunden_ID, String User_ID) {
		
		try {	
			stmt.execute("call reservieren_insert ("+ RID + ", " + Reihe + ", " + Sitzplatz + "," + Vorstellung_ID + ", " + Kunden_ID + ", " + User_ID +");");	// Stored Procedure mit übergebenen Daten aufrufen
		}
		catch (Exception e) {
			JOptionPane.showMessageDialog(null, "<html>Die Reservierung war nicht erfolgreich!<br>Es ist ein Fehler beim schreiben in die Datenbank aufgetreten!<br><br>Programm wird beendet!</html>", "Achtung!", JOptionPane.ERROR_MESSAGE);
			System.exit(1);
		}
	}
	
	// Diese Methode legt einen Datensatz für einen neuen Benutzer in der Datenbank ab
	void kunde_anlegen (String Name, String Vorname, String Strasse, String Ort, String Email, String Tele_Nr ) {
		
		try {			
			stmt.executeUpdate( "INSERT INTO kunde (Name, Vorname, Strasse, Ort, Email, Tele_Nr)"
					+ "VALUES (\""+ Name + "\", \"" + Vorname + "\", \"" + Strasse + "\", \"" + Ort + "\", \"" + Email + "\", \"" + Tele_Nr + "\")" );	
		}
		catch (Exception e) {
			JOptionPane.showMessageDialog(null, "<html>Kunde konnte nicht angelegt werden!<br>Es ist ein Fehler beim schreiben in die Datenbank aufgetreten!<br><br>Programm wird beendet!</html>", "Achtung!", JOptionPane.ERROR_MESSAGE);
			System.exit(1);
		}
	}
	
	// Mit dieser Methoden werden Datensätze aus der Datenbank gelöscht
	void delete (String befehl) {
		
		try {			
			stmt.executeUpdate( "delete from " + befehl );	
		}
		catch (Exception e) {
			JOptionPane.showMessageDialog(null, "<html>Fehler beim löschen aus der Datenbank!<br><br>Programm wird beendet!</html>", "Achtung!", JOptionPane.ERROR_MESSAGE);
			System.exit(1);
		}
	}
	
	// Mit dieser Methoden wird die Verbindung mit der Datenbank geschlossen
	void beenden () {
		try {
			con.close();
		} catch (SQLException e) {
			JOptionPane.showMessageDialog(null, "<html>Fehler beim trennen der Verbindung zur Datenbank!<br><br>Programm wird beendet!</html>", "Achtung!", JOptionPane.ERROR_MESSAGE);
			System.exit(1);
		}
	}
}