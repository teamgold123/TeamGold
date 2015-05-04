import java.awt.*;
import java.awt.event.*;
import java.math.BigInteger;
import java.security.MessageDigest;
import javax.swing.*;

/*
 * Diese Klasse wird beim Programmstart aufgerufen und erstellt ein kleines Passwortfenster.
 * 
 * Es wird nach Username und Passwort gefragt und die eigegebenen Daten werden mit den 
 * Userdaten in der Datenbank verglichen.
 */

public class Anmeldung extends Kino implements ActionListener {
	JPasswordField 	passwordField;
	JTextField 		userField;
	JFrame			Anmeldung;
	
	public Anmeldung() {
		fenster.setEnabled( false );			// Hauptfenster nicht mehr 'klickbar'
		
		passwordField = new JPasswordField(10);
	    passwordField.setEchoChar('*');			// * für jedes eigegbene Zeichen im Passwortfeld
	    userField = new JTextField();
	    
	    Anmeldung = new JFrame();
	    Anmeldung.setTitle( "Login" );
	    Anmeldung.setVisible( true );
	    Anmeldung.setDefaultCloseOperation( JFrame.EXIT_ON_CLOSE );
	    Anmeldung.setSize( 200, 100 );
	    Anmeldung.setLocationRelativeTo( fenster );		// zentriert vor das Hauptfenster
	    Anmeldung.setResizable( false );				// Größe nicht veränderbar
	    
	    Anmeldung.setLayout( new GridLayout(3, 0) );
	    
	    Anmeldung.add( new JLabel("Username:") );
	    Anmeldung.add( userField );
	    userField.grabFocus();							// "Cursor" in das Userfeld setzen
	    
	    Anmeldung.add( new JLabel("Passwort:") );
	    Anmeldung.add( passwordField );
	    
	    Anmeldung.add( new JLabel() );					// Platzhalter unten links
	    
	    JButton login = new JButton("Login");
	    Anmeldung.add( login );
	    
		login.addActionListener( this ); 
	}
	
	public void actionPerformed( ActionEvent e ) {
		String hashtext = null;
		
	    String keyStr = new String( passwordField.getPassword() );
	    
	    // Passwortumwandlung in MD5, MD5-Hash wird in den String 'hastext' geschrieben
		try {
			byte[] bytesOfMessage = keyStr.getBytes("UTF-8");
	        MessageDigest md = MessageDigest.getInstance("MD5");
	        byte[] thedigest = md.digest(bytesOfMessage);
	        BigInteger bigInt = new BigInteger(1,thedigest);
	        hashtext = bigInt.toString(16);
		} catch (Exception e1) {
			e1.printStackTrace();
		}
        
		String username = userField.getText();
    	
		// MD5 Hash des Passworts und alle Usernamen aus der DB holen
		String pass = db.StringAuslesen( "passwort", "user where username = \"" + username + "\"");
		String Usernamen[] = db.StringArray("username", "user");
		
		/* 
		 * Jeden Usernamen mit dem eingegebnen Benutzername vergeleiche
		 * -> Match: 
		 * 	  ->Passwort überprüfen
		 * 		-> richtiges Passwort 
		 * 			-> einloggen, User_ID setzen, Loginfenster vernichten, Hauptfenster auf enable und nach vorne holen
		 * 		-> falsche Passwort
		 * 			-> Meldung ausgeben, Passwort löschen und Zeiger in Passwortfeld
		 * -> Kein Match
		 * 		-> zähler erhöhen
		 */		
		int z = 0;
		for (int i = 0; i < Usernamen.length; i++) {
			if ( username.toLowerCase().equals( Usernamen[i].toLowerCase() ) )  {
			    if ( pass.contains( hashtext ) ) {
					String UserID = db.StringAuslesen("User_ID", "user where username = \"" + username + "\"");
			    	User_ID = UserID;
		        	Anmeldung.dispose();
		        	fenster.setEnabled( true );
		        	fenster.toFront();
		        }
		        else {
					JOptionPane.showMessageDialog(null, "Falsches Passwort!", "Achtung!", JOptionPane.ERROR_MESSAGE);
					passwordField.setText("");		// Eingabe aus dem Passwortfeld löschen
					passwordField.grabFocus();		// Cursor in das Passwortfeld
		        }
			    z++;
			}
		}
		
		// falls kein passender User gefunden wurde -> Meldung ausgeben, Textfelder zurücksetzen und Cursor in das Benutzertextfeld
		// kann nicht in der else-Anweisung  von der obrigen if-Abfrage geschehen, da sonst die Meldung für jeden geprüfen Benutzer ausgegeben wird.
		if (z == 0 ) {
			JOptionPane.showMessageDialog(null, "Username \"" + username + "\" nicht vorhanden!", "Achtung!", JOptionPane.ERROR_MESSAGE);
			userField.setText("");
			passwordField.setText("");
			userField.grabFocus();	
		}
	}
}