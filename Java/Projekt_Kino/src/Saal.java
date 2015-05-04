import java.awt.*;

import javax.swing.*;

import java.awt.event.*;

/*
 * Diese Klasse wird für verschiedene Programmfunktionen verwendet ( Unterscheidbar durch die übergebene Quelle ),
 * entsprechend der Funktion wird das Fenster anders dargestellt.
 * 
 * Sie dient dazu, um einen Saal mit Hilfe von übergebenen Variablen darzustellen und 
 * 		1. eine Übersicht über den aktuellen Stand der Reservierungen einer Vorstellung zu geben.
 * 		2. Sitzplätze für eine Reservierung auszuwählen und diese für einen Kunden durchzuführen.
 */

public class Saal extends Kino implements ActionListener {

	Container 	ContainerSaal;
	JPanel 		jp1, jp2, jp3, jp4, jp5;

	int 		SID, Sitze, Reihe;
	String 		Vorstell_ID, Datum, Uhrzeit, film;
	
	JButton 	Reservierung, back;
	String		quelle;
	
	JToggleButton[][] feld;
	
	public Saal( Container con, String VorstellungsID, String quelle ){
		ContainerSaal = con;
		ContainerSaal.setLayout( new BorderLayout() );
		
		this.quelle = quelle;
		Vorstell_ID = VorstellungsID;
		
		// Daten der Vorstellung aus der DB auslesen
		Datum = db.StringAuslesen("Datum", "vorstellung where Vorstellung_ID = " + Vorstell_ID );
		Uhrzeit = db.StringAuslesen("Beginn", "vorstellung where Vorstellung_ID = " + Vorstell_ID );
		film = db.StringAuslesen("Name", "vorstellung, filme where filme.Filme_ID = vorstellung.Filme_ID AND Vorstellung_ID = " + Vorstell_ID);
		SID = db.IntAuslesen("Saal_ID", "vorstellung where Vorstellung_ID = " + Vorstell_ID );
		Sitze = db.IntAuslesen("Anzahl_Sitze_pro_Reihe", "saal where Saal_ID = " + SID );
		Reihe = db.IntAuslesen("Anzahl_Reihen", "saal where Saal_ID = " + SID );
	
		jp1 = new JPanel( ); 
		jp2 = new JPanel( new GridLayout(Reihe, Sitze, 5, 10) );
		jp3 = new JPanel( new GridLayout(Reihe, Sitze, 5, 10) );
		jp4 = new JPanel( new GridLayout(Reihe, Sitze, 5, 10) );
		jp5 = new JPanel( new FlowLayout( FlowLayout.LEFT, 20, 20 ) );	
		
		// Leinwand mit Beschreibung ( Vorstellungsdaten )
		Icon leinwand = new ImageIcon("./Bilder/leinwand800.jpg");
		JLabel lab = new JLabel("Saal " + SID + " - " + film + " - " + Datum + " um " + Uhrzeit + " Uhr", leinwand, JLabel.CENTER);
		lab.setFont( new Font("SansSerif", Font.BOLD ,20) );
		lab.setHorizontalTextPosition(JLabel.CENTER);
		lab.setVerticalTextPosition(JLabel.TOP);
		jp1.add(lab);
		
		// Feld mit den Größe der Sitze und Reihen des Saals, in dem Feld sind die Stühle als JToggleButton
		feld = new JToggleButton[Sitze][Reihe];
		
		// In dieser Schleife werden die 'Stühle' als ToggleButton erstellt, angepasst und dem Fenster hinzugefügt
		// Jeder Stuhl bekommt ein Bild von einem Stuhl in unterschiedlichen Farben je nach Reservierungsstand
		for (int r = 0; r < Reihe; r++) {
			jp3.add( new JLabel(" Reihe " + (r+1) + "  "));			// links die Reihe anzeigen
			jp4.add( new JLabel("  Reihe " + (r+1) + " "));			// rechts die Reihe anzeigen
			for (int i = 0; i < Sitze; i++) {
				feld[i][r] = new JToggleButton();
				feld[i][r].setBackground( Color.WHITE );									// für die Optik
				feld[i][r].setIcon( new ImageIcon("./Bilder/stuhl_red.png") );				// leere Stühle sind Rot
				feld[i][r].setSelectedIcon( new ImageIcon("./Bilder/stuhl_green.png") );	// Vom Bentzer für die Reservierung ausgewählt Stühle sind grün
				feld[i][r].setToolTipText( "Reihe: " + (r+1) + " - Sitzplatz: " + (i+1) );	// Bei MouseOver wird die Reihe und Platznummer des Stuhls angezeigt
				jp2.add(feld[i][r]);
				
				// falls Saal nur zur Übersicht gezeigt wird
				if ( quelle.equals("vorstellungen") ) { 
					feld[i][r].setEnabled( false );											// alle Stühle nicht mehr anwählbar
					feld[i][r].setDisabledIcon( new ImageIcon("./Bilder/stuhl_red.png") );	// alle Stühle, obwohl nicht wählbar(also eigl reserviert), als rote Stühle anzeigen 
				}
			}
		}
		
		// Reservierungen aus der DB auslesen
		int ResReihe[] = db.intArray("Reihe", "reservierung where Vorstellung_ID = " + Vorstell_ID );
		int ResSitz[] = db.intArray("Sitzplatz", "reservierung where Vorstellung_ID = " + Vorstell_ID );
		
		// für jeden reservierten Sitzplatz die Auswählbarkeit und die Farbe ändern ( Stuhlfarbe + Hintergrund )
		for (int j = 0; j < ResSitz.length; j++) {
			feld[ ResSitz[j] -1 ][ ResReihe[j] -1 ].setEnabled( false );
			feld[ ResSitz[j] -1 ][ ResReihe[j] -1 ].setDisabledIcon( new ImageIcon("./Bilder/stuhl_lightred.png") );	// Reservierte Stühle sind 'leichtrot'
			feld[ ResSitz[j] -1 ][ ResReihe[j] -1 ].setBackground( Color.PINK );										// Reservierte Stühle bekommen einen pinken Hintergrund
		}
		
		// Falls Saal nur zur Übersicht gezeigt wird nur einen Zurückknopf
		back = new JButton( "Zurück zur Vorstellungsauswahl" );
		back.setFont( schrift );
		jp5.add( back );	
        back.addActionListener( this );
        
        // falls Saal zur Reservierung gezeigt wird, einen Knopf für Reservieren und einen für Zurück
		if ( quelle.equals("reservieren") ) {
	        JLabel abstand = new JLabel();
	        abstand.setPreferredSize( new  Dimension(260 ,10) );			// Dient der Optik um den Abstand zwischen den Knöpfen zu gewährleisten.
	        jp5.add( abstand );	
	        
	        Reservierung = new JButton("Reservieren");
			Reservierung.setFont( schrift );
			jp5.add( Reservierung );
			Reservierung.addActionListener( this );
			
		}
				
		ContainerSaal.add(jp1, BorderLayout.NORTH);
		ContainerSaal.add(jp2, BorderLayout.CENTER);
		ContainerSaal.add(jp3, BorderLayout.WEST);
		ContainerSaal.add(jp4, BorderLayout.EAST);
		ContainerSaal.add(jp5, BorderLayout.SOUTH);

	    ContainerSaal.repaint();
	    ContainerSaal.validate();
	}
	
	public void actionPerformed( ActionEvent e ) {
		if ( e.getSource() == back ) {
			
			ContainerSaal.removeAll();
			
			if ( quelle.equals("reservieren") ) {
				new VorstellungsAuswahl( ContainerSaal, quelle );
			}
			if ( quelle.equals("vorstellungen") ) {
				new VorstellungsAuswahl( ContainerSaal, quelle );
			}
		}
		

		if ( e.getSource() == Reservierung ) {
			int wahl_z = 0;
			int RID = db.sonder( "max(Reservierung_ID) FROM reservierung" );		// Muss per Hand gesetzt werden, sonst würde jeder Stuhl eine eigenen Rerservierungs_ID bekommen
			
			// Alle Stühle auf 'selected' prüfen, bei Match eine Reservierung für diesen Stuhl in die DB schreiben
			for (int r = 0; r < Reihe; r++) {
				for (int i = 0; i < Sitze; i++) {
					if ( feld[i][r].isSelected() ) {
						db.reservieren( (RID+1), (r+1), (i+1), Vorstell_ID, Kunde_ID, User_ID);
						wahl_z ++;
					}
				}
			}
				
			// Falls kein Stuhl ausgewählt wurde, wirf eine Exception 'Kein_Sitz_Exception'
			if ( wahl_z == 0 ) {
				try {
					throw new Kein_Sitz_Exception("Bitte einen Sitzplatz auswählen!");
				}
				catch (Kein_Sitz_Exception e1) {
				}
			}

			// sonst Bestätigung über die Reservierung ausgeben, welche einige Daten enthält.
			else {
				String Vorname = db.StringAuslesen("Vorname", "kunde where Kunde_ID = " + Kunde_ID);
				String Nachname = db.StringAuslesen("Name", "kunde where Kunde_ID = " + Kunde_ID);
				
				JOptionPane.showMessageDialog(null, 	"<HTML><u><H3>Glückwunsch!</u><BR>"
													+ 	"Ihre Reservierung war erfolgreich.</H3><BR>"
													+ 	"Sie haben für den Film \"" + film + "\"<BR>"
													+ 	"am " + Datum + " um " + Uhrzeit + " Uhr<BR><BR>"
													+	" erfolgreich " + wahl_z + " Sitz/e  für \"" + Vorname + " " + Nachname + "\" reserviert!", "Bestätigung", JOptionPane.DEFAULT_OPTION);
				
				ContainerSaal.removeAll();
				
			    new Startseite( ContainerSaal );	// Nach erfolgreicher Reservierung, zurück zur Startseite
			    fenster.setTitle("Kinoprogramm - TEAM GOLD");
			}
		}
	}
}
