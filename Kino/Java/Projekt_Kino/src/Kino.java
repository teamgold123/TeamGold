import java.awt.*;
import javax.swing.*;

/*
 * Kinoprogramm zum durchführen einer Reservierung
 * Author: Johannes Ullrich
 * 
 * Es ist möglich eine Reservierung durchzuführen, dabei muss zunächst der Kunde ausgewählt werden, danach muss ein Film und
 * eine Vorstellung gewählt werden.
 * Bei dem anschließend angezeigten Saal können dann Sitzplätze ausgewählt und die Reservierung durchgeführt werden.
 * 
 * Außerdem ist es möglich Kunden zu löschen/anzulegen, Reservierungen für einen Kunden zu löschen, 
 * Reservierungen für eine Vorstellung zu löschen, eine Vorstellung anzuzeigen um die Reservierungen zu sehen.
 * Über eine Menüleiste können die entsprechende Aktion ausgewählt werden.
 * 
 * Beim Programmstart werden Benutzername und Password abgefragt.
*/

public class Kino extends JFrame{

	static		String		Kunde_ID,		// Kunde_ID und User_ID sind zur einfacheren Handhabung als Strings initalisiert, 
							User_ID;		// da an die Datenbank ohnehin ein String übergeben wird gibt es hiermit keine Probleme.
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
