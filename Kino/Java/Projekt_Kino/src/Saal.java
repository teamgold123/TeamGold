import java.awt.*;

import javax.swing.*;

import java.awt.event.*;

/*
 * Diese Klasse wird f�r verschiedene Programmfunktionen verwendet ( Unterscheidbar durch die �bergebene Quelle ),
 * entsprechend der Funktion wird das Fenster anders dargestellt.
 * 
 * Sie dient dazu, um einen Saal mit Hilfe von �bergebenen Variablen darzustellen und 
 * 		1. eine �bersicht �ber den aktuellen Stand der Reservierungen einer Vorstellung zu geben.
 * 		2. Sitzpl�tze f�r eine Reservierung auszuw�hlen und diese f�r einen Kunden durchzuf�hren.
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
		
		// Feld mit den Gr��e der Sitze und Reihen des Saals, in dem Feld sind die St�hle als JToggleButton
		feld = new JToggleButton[Sitze][Reihe];
		
		// In dieser Schleife werden die 'St�hle' als ToggleButton erstellt, angepasst und dem Fenster hinzugef�gt
		// Jeder Stuhl bekommt ein Bild von einem Stuhl in unterschiedlichen Farben je nach Reservierungsstand
		for (int r = 0; r < Reihe; r++) {
			jp3.add( new JLabel(" Reihe " + (r+1) + "  "));			// links die Reihe anzeigen
			jp4.add( new JLabel("  Reihe " + (r+1) + " "));			// rechts die Reihe anzeigen
			for (int i = 0; i < Sitze; i++) {
				feld[i][r] = new JToggleButton();
				feld[i][r].setBackground( Color.WHITE );									// f�r die Optik
				feld[i][r].setIcon( new ImageIcon("./Bilder/stuhl_red.png") );				// leere St�hle sind Rot
				feld[i][r].setSelectedIcon( new ImageIcon("./Bilder/stuhl_green.png") );	// Vom Bentzer f�r die Reservierung ausgew�hlt St�hle sind gr�n
				feld[i][r].setToolTipText( "Reihe: " + (r+1) + " - Sitzplatz: " + (i+1) );	// Bei MouseOver wird die Reihe und Platznummer des Stuhls angezeigt
				jp2.add(feld[i][r]);
				
				// falls Saal nur zur �bersicht gezeigt wird
				if ( quelle.equals("vorstellungen") ) { 
					feld[i][r].setEnabled( false );											// alle St�hle nicht mehr anw�hlbar
					feld[i][r].setDisabledIcon( new ImageIcon("./Bilder/stuhl_red.png") );	// alle St�hle, obwohl nicht w�hlbar(also eigl reserviert), als rote St�hle anzeigen 
				}
			}
		}
		
		// Reservierungen aus der DB auslesen
		int ResReihe[] = db.intArray("Reihe", "reservierung where Vorstellung_ID = " + Vorstell_ID );
		int ResSitz[] = db.intArray("Sitzplatz", "reservierung where Vorstellung_ID = " + Vorstell_ID );
		
		// f�r jeden reservierten Sitzplatz die Ausw�hlbarkeit und die Farbe �ndern ( Stuhlfarbe + Hintergrund )
		for (int j = 0; j < ResSitz.length; j++) {
			feld[ ResSitz[j] -1 ][ ResReihe[j] -1 ].setEnabled( false );
			feld[ ResSitz[j] -1 ][ ResReihe[j] -1 ].setDisabledIcon( new ImageIcon("./Bilder/stuhl_lightred.png") );	// Reservierte St�hle sind 'leichtrot'
			feld[ ResSitz[j] -1 ][ ResReihe[j] -1 ].setBackground( Color.PINK );										// Reservierte St�hle bekommen einen pinken Hintergrund
		}
		
		// Falls Saal nur zur �bersicht gezeigt wird nur einen Zur�ckknopf
		back = new JButton( "Zur�ck zur Vorstellungsauswahl" );
		back.setFont( schrift );
		jp5.add( back );	
        back.addActionListener( this );
        
        // falls Saal zur Reservierung gezeigt wird, einen Knopf f�r Reservieren und einen f�r Zur�ck
		if ( quelle.equals("reservieren") ) {
	        JLabel abstand = new JLabel();
	        abstand.setPreferredSize( new  Dimension(260 ,10) );			// Dient der Optik um den Abstand zwischen den Kn�pfen zu gew�hrleisten.
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
			int RID = db.sonder( "max(Reservierung_ID) FROM reservierung" );		// Muss per Hand gesetzt werden, sonst w�rde jeder Stuhl eine eigenen Rerservierungs_ID bekommen
			
			// Alle St�hle auf 'selected' pr�fen, bei Match eine Reservierung f�r diesen Stuhl in die DB schreiben
			for (int r = 0; r < Reihe; r++) {
				for (int i = 0; i < Sitze; i++) {
					if ( feld[i][r].isSelected() ) {
						db.reservieren( (RID+1), (r+1), (i+1), Vorstell_ID, Kunde_ID, User_ID);
						wahl_z ++;
					}
				}
			}
				
			// Falls kein Stuhl ausgew�hlt wurde, wirf eine Exception 'Kein_Sitz_Exception'
			if ( wahl_z == 0 ) {
				try {
					throw new Kein_Sitz_Exception("Bitte einen Sitzplatz ausw�hlen!");
				}
				catch (Kein_Sitz_Exception e1) {
				}
			}

			// sonst Best�tigung �ber die Reservierung ausgeben, welche einige Daten enth�lt.
			else {
				String Vorname = db.StringAuslesen("Vorname", "kunde where Kunde_ID = " + Kunde_ID);
				String Nachname = db.StringAuslesen("Name", "kunde where Kunde_ID = " + Kunde_ID);
				
				JOptionPane.showMessageDialog(null, 	"<HTML><u><H3>Gl�ckwunsch!</u><BR>"
													+ 	"Ihre Reservierung war erfolgreich.</H3><BR>"
													+ 	"Sie haben f�r den Film \"" + film + "\"<BR>"
													+ 	"am " + Datum + " um " + Uhrzeit + " Uhr<BR><BR>"
													+	" erfolgreich " + wahl_z + " Sitz/e  f�r \"" + Vorname + " " + Nachname + "\" reserviert!", "Best�tigung", JOptionPane.DEFAULT_OPTION);
				
				ContainerSaal.removeAll();
				
			    new Startseite( ContainerSaal );	// Nach erfolgreicher Reservierung, zur�ck zur Startseite
			    fenster.setTitle("Kinoprogramm - TEAM GOLD");
			}
		}
	}
}
