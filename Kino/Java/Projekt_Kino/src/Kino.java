import java.awt.*;
import javax.swing.*;

/*
 * Kinoprogramm zum durchf�hren einer Reservierung
 * Author: Johannes Ullrich
 * 
 * Es ist m�glich eine Reservierung durchzuf�hren, dabei muss zun�chst der Kunde ausgew�hlt werden, danach muss ein Film und
 * eine Vorstellung gew�hlt werden.
 * Bei dem anschlie�end angezeigten Saal k�nnen dann Sitzpl�tze ausgew�hlt und die Reservierung durchgef�hrt werden.
 * 
 * Au�erdem ist es m�glich Kunden zu l�schen/anzulegen, Reservierungen f�r einen Kunden zu l�schen, 
 * Reservierungen f�r eine Vorstellung zu l�schen, eine Vorstellung anzuzeigen um die Reservierungen zu sehen.
 * �ber eine Men�leiste k�nnen die entsprechende Aktion ausgew�hlt werden.
 * 
 * Beim Programmstart werden Benutzername und Password abgefragt.
*/

public class Kino extends JFrame{

	static		String		Kunde_ID,		// Kunde_ID und User_ID sind zur einfacheren Handhabung als Strings initalisiert, 
							User_ID;		// da an die Datenbank ohnehin ein String �bergeben wird gibt es hiermit keine Probleme.
	static 		menu 		fenster;		// wird gebraucht, dass man bei der Anmeldung das Fenster auf disabled sezten kann und um die Titelleiste an die momentane Aufgabe anzupassen
	
	// Schrift und Datenbank Objekt, die im gesamten Programm genutzt werden
	static final Font 		schrift = 	new Font("Arial", Font.BOLD, 18);
	static final DB_Zugriff db 		= 	new DB_Zugriff();
	
	// In der Main wird das Hauptenster mit einer Menuzeile und ein neues Anmeldungsfenster erstellt
	public static void main(String[] args) {
		fenster = new menu();		
		fenster.setTitle("Kinoprogramm - TEAM GOLD");
	    fenster.setSize( 800, 700 );
	    fenster.setVisible( true );
	    fenster.setDefaultCloseOperation( JFrame.EXIT_ON_CLOSE );
	    fenster.setResizable( false );
			    
		new Anmeldung();		// neues Anmeldungsfenster
	}
}
