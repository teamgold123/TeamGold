import java.awt.*;
import java.awt.event.*;

import javax.swing.*;

/*
 * Diese Klasse wird f�r verschiedene Programmfunktionen verwendet ( Unterscheidbar durch die �bergebene Quelle ),
 * entsprechend der Funktion wird das Fenster anders dargestellt.
 * 
 * Sie dient dazu, um eine Vorstellung auszuw�hlen und dessen Vorstellungs_ID aus der DB zu bekommen.
 * Dabei wird zun�chst der Film, welcher in der Vorstellung gezeigt werden soll, ausgew�hlt und anschlie�end werden 
 * alle Vorstellungen die f�r diesen Film vorhanden sind angezeigt. Davon kann eine ausgew�hlt werden.
 */

public class VorstellungsAuswahl extends Kino implements ActionListener {
	Container 			ContainerVorAus;
	JLabel				FilmeLabel, Vorstell_Label;
	JComboBox<String>	Filme;
	JButton 			back;
	JPanel				jp1, jp2, jp3;
	String 				quelle;
	
	public VorstellungsAuswahl( Container con, String quelle ) {
		this.quelle = quelle;
		
		ContainerVorAus = con;
		ContainerVorAus.setLayout( new BorderLayout() );
		
		jp1 = new JPanel( new GridLayout( 0, 1 ) );
		jp2 = new JPanel( new FlowLayout( FlowLayout.CENTER, 75, 5 ) );
		jp3 = new JPanel( new FlowLayout( FlowLayout.LEFT, 20, 20 ) );
	
		FilmeLabel = new JLabel("Bitte einen Film ausw�hlen:");
		FilmeLabel.setFont( schrift );
		
		String[] filme = db.StringArray("Name", "filme order by Name");		// Alle Filme aus der DB auslesen
		
        Filme = new JComboBox<String>( filme );				// Alle Filme in eine ComboBox schreiben
        Filme.setFont( schrift );
        Filme.setSelectedItem( null );						// Standardm�ssig nichts ausw�hlen
        
		jp1.add( FilmeLabel );
        jp1.add( Filme );
        jp1.add( new JLabel() );
                
        // Nur beim Reservieren und Reservierung l�schen einen Button Zur�ck einf�gen
        if( quelle.equals("reservieren") || quelle.equals("res_loe") ) {
			back = new JButton( "Zur�ck" );		
	        back.setFont( schrift );
	        jp3.add( back );
	        back.addActionListener( this );
        }
        
        ContainerVorAus.add(BorderLayout.NORTH, jp1);
		ContainerVorAus.add( BorderLayout.CENTER, jp2 );
        ContainerVorAus.add( BorderLayout.SOUTH, jp3 );
        
        ContainerVorAus.repaint();
		ContainerVorAus.validate();
		
        Filme.addActionListener( this );		// ActionListener f�r die Combobox
	}
	
	

	public void actionPerformed( ActionEvent e ) {
		// falls auf Zur�ck gedr�ckt wurde, vorheriges Fenster anzeigen
		if ( e.getSource() == back ) {
			ContainerVorAus.removeAll();

			if ( quelle.equals("reservieren") ) {
				new Kunden_Auswahl( ContainerVorAus, quelle );
				fenster.setTitle("Reservierung");	
			}

			if ( quelle.equals("res_loe") ) {
				new auswahl_fenster( ContainerVorAus, quelle );
				fenster.setTitle("Reservierung l�schen");
			}	
		}
		
		// falls Action von der Combobox ausgel�st
		if ( e.getSource() == Filme ) {
			String film = (String) Filme.getSelectedItem();		// Name des ausgew�hlten Films aus der Combobox
			
			jp2.removeAll();									// Alte Ergenisse l�schen ( falls vorher ein anderer Film ausgew�hlt war )
			
			// Die Daten der Vorstellungen des ausgew�hlten Films aus der Datenbank ziehen ( String abfrage als Hilfe um Tipparbeit zu sparen )
			String abfrage = "vorstellung, filme where filme.Filme_ID = vorstellung.Filme_ID AND filme.Name = \"" + film + "\"" + " order by Datum ASC, Beginn ASC";
			String VorID[] = db.StringArray("Vorstellung_ID", abfrage);
			String datum[] = db.StringArray("Datum", abfrage);
			String zeiten[] = db.StringArray("Beginn", abfrage);
			int[] SID = db.intArray("Saal_ID", abfrage);
			
			int filmid = db.IntAuslesen("filme_id", "filme where name = \"" + film + "\"");
			
			int anz = db.sonder( "count(*) from vorstellung where Filme_ID = " + filmid );	// Vorstellungen zu dem ausgew�hlten Film in der DB z�hlen und Anzahl in anz speichern
			JButton[] Vorstellung = new JButton[anz];			// ButtonArray in dem die Kn�pfe sind, die zur Auswahl der einzelnen Vorstellungen genutzt werden. (Gr��e ist die oben ausgelesene Anzahl)
			
			ButtonListener bL = new ButtonListener();
			
			/*
			 * In der Schleife wird f�r jede Vorstellung ein Label mit den Vorstellungsdaten
			 * und ein Button mit der entsprechenden Aufschrift erstellt. (Reservieren / l�schen / anzeigen)
			 */
			int z = 0;
			for (int i = 0; i < anz; i++) {
				jp2.add( Vorstell_Label = new JLabel( datum[i] + " - " + zeiten[i] + " Uhr - " + "Saal " + SID[i]) );
				Vorstell_Label.setFont( schrift );
	
				if ( quelle.equals("reservieren") ) {
					jp2.add( Vorstellung[i] = new JButton( "Reservieren" ) );
				}
				if ( quelle.equals("vorstellungen")) {
					jp2.add( Vorstellung[i] = new JButton( "anzeigen" ) );
				}
				if ( quelle.equals("res_loe") ) {
					jp2.add( Vorstellung[i] = new JButton( "l�schen" ) );
					
					// z�hlt die Reservierungen einer Vorstellung
					int anzahl = db.sonder( "count(*) from reservierung, vorstellung where reservierung.Vorstellung_ID = Vorstellung.Vorstellung_ID AND vorstellung.Vorstellung_ID = " + VorID[i]);
					// falls keine  Reservierungen vorliegen, ist der Button nicht mehr klickbar, da es nichts zu l�schen gibt
					if (anzahl == 0){
						Vorstellung[i].setEnabled( false );
					}
				}
				
				// Buttoneigenschaften
				Vorstellung[i].setFont( schrift );
				Vorstellung[i].setActionCommand( VorID[i] ); 	// �bergebe die Vorstellungs_ID der ausgew�hlten Vorstellung
				Vorstellung[i].addActionListener( bL );
				
				z++;
			}
			
			// falls es keine Vorstellungen zu einem Film gibt, gebe im Fenster eine Meldung aus
			if (z == 0) {
				JLabel keine_Vor = new JLabel("F�r diesem Film gibt es keine Vorstellungen!");
				jp2.add( keine_Vor );
				keine_Vor.setFont( schrift );
				keine_Vor.setForeground( Color.RED );
			}
					
			ContainerVorAus.repaint();
			ContainerVorAus.validate();
		}
	}
	
	class ButtonListener implements ActionListener {
		public void actionPerformed(ActionEvent e) {
			
			String VorstellungsID = e.getActionCommand();	// Die erhaltene vorstellungs_id speichern
			ContainerVorAus.removeAll();
			
			if ( quelle.equals("reservieren") ) {
			    new Saal( ContainerVorAus, VorstellungsID, quelle );		// Neuen Saal zum reservieren
			}
			if ( quelle.equals("vorstellungen") ) {
			    new Saal( ContainerVorAus, VorstellungsID, quelle );		// Neuen Saal zum anzeigen der Vorstellung
			}
			
			// Mithilfe der Vorstellungs_ID eine Vorstellung l�schen, Meldung ausgeben und wieder zur Vorstellungsauswahl um Reservierungen zu l�schen
			if ( quelle.equals("res_loe") ) {					
				db.delete("reservierung where Vorstellung_ID = " + VorstellungsID + ";");
				
				JOptionPane.showMessageDialog(null, "Die Reservierungen wurde erfolgreich gel�scht!");
						
				new VorstellungsAuswahl( ContainerVorAus, quelle );
			}
		}
	}
}
