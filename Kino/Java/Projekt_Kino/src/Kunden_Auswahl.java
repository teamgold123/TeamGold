import java.awt.*;
import java.awt.event.*;
import javax.swing.*;

/*
 * Diese Klasse wird für verschiedene Programmfunktionen verwendet ( Unterscheidbar durch die übergebene Quelle ),
 * entsprechend der Funktion wird das Fenster anders dargestellt.
 * 
 * Sie dient dazu, um einen Kunden auszuwählen und seine Kunden_ID aus der Datenbank zu bekommen.
 */

public class Kunden_Auswahl extends Kino  implements ActionListener {
	Container 	ContainerKunde;
	JTextField	Suche_TFeld;
	JButton		Neuer_Kunde, back;
	JPanel		jp1, jp2, jp3;
	String 		quelle;
	JButton[]	Kunden_Button;
	String[] 	Kunden_ID, Nachname_DB, Vorname_DB, Strasse_DB, Ort_DB;
	
	public Kunden_Auswahl ( Container con, String quelle ) {
		this.quelle = quelle;				// Ist notwendig, dass die quelle ( wozu wird der Kunde gesucht ) auch in den Listener sichtbar ist
		
		ContainerKunde = con;				// Containerreferenz auf das Haupfenster setzen
						
		ContainerKunde.setLayout( new BorderLayout() );
		jp1 = new JPanel( new GridLayout( 0, 1, 20, 20 ) );
		jp2 = new JPanel( new FlowLayout( FlowLayout.CENTER, 1, 5) );

		JLabel Suche_Label = new JLabel("Bitte Vor- und Nachnamen des Kunden eingeben:");
		Suche_Label.setFont( schrift );
		
		Suche_TFeld = new JTextField();
		Suche_TFeld.setFont( schrift );

		// Die Knöpfe in die 'SOUTH'-Box entsprechend der momentanen Aufgabe setzen
		if ( quelle.equals("res_loe") || quelle.equals("kunde")) {		// Falls Reservierung löschen oder Kunde verwalten nur einen Zurück-Knopf
			jp3 = new JPanel( new FlowLayout( FlowLayout.LEFT, 20, 20 ) );
	        back = new JButton( "Zurück" );
	        back.setFont( schrift );
	        jp3.add( back );
	        back.addActionListener( this );
		}
		if ( quelle.equals("reservieren") ) {				// Falls beim Reservierungsprozess, nur einen 'Neuen Kunden anlegen'-Knopf
			jp3 = new JPanel( new FlowLayout( FlowLayout.RIGHT, 20, 20 ) );
	        Neuer_Kunde = new JButton( "Neuen Kunden anlegen" );
	        Neuer_Kunde.setFont( schrift );
	        jp3.add( Neuer_Kunde );
	        Neuer_Kunde.addActionListener( this );
		}
				
		jp1.add( Suche_Label );
        jp1.add( Suche_TFeld );
        jp1.add( new JLabel() );
        
        ContainerKunde.add( BorderLayout.NORTH, jp1 );
		ContainerKunde.add( BorderLayout.CENTER, jp2 );
        ContainerKunde.add( BorderLayout.SOUTH, jp3 );
                
        // Den aktuellen Fensterinhalt zeichnen
        ContainerKunde.repaint();
        ContainerKunde.validate();
        
		Suche_TFeld.grabFocus();		// Beim erstellen der Klasse den Zeiger in das Suchefeld setzen
			
		// Daten aus der Datenbank in Arrays schreiben
		Kunden_ID = db.StringArray("Kunde_ID", "kunde order by Name, Vorname");
		Nachname_DB = db.StringArray("Name", "kunde order by Name, Vorname");
		Vorname_DB = db.StringArray("Vorname", "kunde order by Name, Vorname");
		Strasse_DB = db.StringArray("Strasse", "kunde order by Name, Vorname");
		Ort_DB = db.StringArray("Ort", "kunde order by Name, Vorname");
		
		// Buttonarray in der Größe der oben ausgelesenen Kunden erstellen
		Kunden_Button = new JButton[ Kunden_ID.length ];
		
		
        KeyListener kL = new KeyListener() {			// neuen 'Knopf`-Listener
			public void keyReleased(KeyEvent arg0) {	// auf Aktionen beim loslassen einer Taste lauschen
			
				jp2.removeAll();						// momentane Ergebnisse löschen ( erst ab dem 2. loslassen wichtig )

					String Suche = Suche_TFeld.getText();
					
					// Abfragen ob das Suchfenster leer ist, sonst werden beim löschen mit Backspace alle Kunden angezeigt
					if ( !Suche.equals("") ) {
						
						
						/* In der Schleife wird für jeden Kunden geprüft, ob er auf die Suche passt.
						 * 
						 * Man kann nach 'Vorname Nachname' oder 'Nachname Vorname' suchen. Groß- und Kleinschreibung sind irrelevant.
						 *  - es wird jeweils geprüft ob ein Teil enthalten ist (z.B. würde 'lric' den Kunden 'Johannes Ullrich' anzeigen) -
						 * 
						 * Falls ein passender Kunde gefunden wurde, wird ein Knopf mit seinen Daten erstellt,
						 * falls kein passender Kunde gefunden wurde, wird eine Meldung im Fenster angezeigt.
						 */
						int z = 0;
						for (int i = 0; i < Kunden_ID.length; i++) {
							if ( (Nachname_DB[i].toLowerCase() + " " + Vorname_DB[i].toLowerCase() ).contains(Suche.toLowerCase() ) ||	
								 (Vorname_DB[i].toLowerCase() + " " + Nachname_DB[i].toLowerCase() ).contains(Suche.toLowerCase() ) ) { 
								
								ButtonListener bL = new ButtonListener();
								
								String Kundendaten = ( Nachname_DB[i] + " " + Vorname_DB[i] + ", " + Strasse_DB[i] + ", " + Ort_DB[i] +  ", ID: " + Kunden_ID[i] );
								
								Kunden_Button[i] = new JButton( Kundendaten );
								Kunden_Button[i].setToolTipText( Kundendaten );		// Falls die Daten eines Kunden zu lang für den Button sind, kann man den vollständigen Datensatz per MouseOver ansehen
								jp2.add( Kunden_Button[i] );
								Kunden_Button[i].setPreferredSize( new Dimension( 700, 30) );
								Kunden_Button[i].setFont( schrift );
								Kunden_Button[i].setActionCommand( Kunden_ID[i] ); 	// Die Kunden_ID des Kunden per ActionCommand an den Listener übergeben
								Kunden_Button[i].addActionListener( bL );
								z ++;
							}
						}
						if (z == 0) {
							JLabel kein_Kunde = new JLabel("Es wurde kein Kunde gefunden!");
							jp2.add( kein_Kunde );
							kein_Kunde.setFont( schrift );
							kein_Kunde.setForeground( Color.RED );
						}
					}
					
					// Ergenisse anzeigen					
			        ContainerKunde.repaint();
			        ContainerKunde.validate();
			}
			
			// Methoden gehören zur Klasse KeyListener und müssen vorhanden sein
			public void keyTyped(KeyEvent arg0) {
			}
			public void keyPressed(KeyEvent arg0) {
			}
		};
		
        Suche_TFeld.addKeyListener( kL );		// Key-Listener dem Textfeld zuweisen
	}
	
	// Listener für die SOUTH-Box
	public void actionPerformed( ActionEvent e ) {
		
		ContainerKunde.removeAll();
		
		if ( e.getSource() == Neuer_Kunde ) {					// Falls man im Reservierungsprozess ist kann man einen neuen Kunden anlegen
			new Neuer_Kunde( ContainerKunde, quelle );	
			fenster.setTitle( "Neuen Kunden anlegen" );
		}
		
		if ( e.getSource() == back ) {							// Falls man sich beim Kunden oder Reservierung löschen befindet kann man zum jeweils vorherigen Fenster zurückgehen
			if ( quelle.equals("res_loe") ) {
				new auswahl_fenster( ContainerKunde, quelle );
				fenster.setTitle("Reservierung löschen");
			}
			if ( quelle.equals("kunde") ) {
				new auswahl_fenster( ContainerKunde, quelle );
				fenster.setTitle("Kunden verwalten");
			}
		}
	}
	
	// Listener für die Knöpfe mit den Kundendaten
	class ButtonListener implements ActionListener {
		public void actionPerformed(ActionEvent e) {

			Kunde_ID = e.getActionCommand();		// setzen der Kunden_ID des ausgewählten Kunden
			ContainerKunde.removeAll();

			// Namen des Kunden aus der DB bekommen
			String Vorname = db.StringAuslesen("Vorname", "kunde where Kunde_ID = " + Kunde_ID);
			String Nachname = db.StringAuslesen("Name", "kunde where Kunde_ID = " + Kunde_ID);
			
			// entsprechend der aktuellen Aufgabe einen neuen Inahlt erstellen
			if ( quelle.equals("reservieren") ) {
				new VorstellungsAuswahl( ContainerKunde, quelle );
				fenster.setTitle("Reservierung - " + Vorname + " " + Nachname);	
			}
			
			if ( quelle.equals("res_loe") ) {
				new Kunden_Res_loeschen( ContainerKunde );
			}
			
			// Hier wird mit der Kunden_ID ein Kunde gelöscht, eine Bestätigung ausgegeben und das Fenster zum löschen eines Kunden neu dargestellt
			if ( quelle.equals("kunde") ) {
				db.delete("kunde where Kunde_ID = " + Kunde_ID + ";");
				
				JOptionPane.showMessageDialog(null, "Der Kunde \"" +  Vorname + " " + Nachname + "\" wurde erfolgreich gelöscht!");
						
				new Kunden_Auswahl( ContainerKunde, quelle );
			}
		}
	}
}
	
