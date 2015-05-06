import java.awt.*;
import java.awt.event.*;

import javax.swing.*;

/*
 * Diese Klasse wird von 2 verschiedene Programmfunktionen verwendet ( Unterscheidbar durch die übergebene Quelle ),
 * der einzige Unterschied  besteht darin, wohin beim drücken auf Zurück/Kunde anlegen gegangen werden soll.
 * 
 * Die Klasse dient dazu, um die Daten eines neuen Kunden einzulesen und den Datensatz in der Datebank abzuspeichern
 */

public class Neuer_Kunde extends Kino implements ActionListener {

	Container 	ContainerKunde;
	JPanel 		jp1, jp2, jp3;
	JTextField 	Vorname_TField, Nachname_TField, Strasse_TField, Ort_TField, EMail_TField, Tele_TField;
	JButton 	Kunde_anlegen, back;
	String		quelle;
	
	public Neuer_Kunde (Container con, String quelle) {
		ContainerKunde = con ;
		this.quelle = quelle;					// Quelle auch in dem Listener sichtbar machen

		ContainerKunde.setLayout( new BorderLayout() );
		jp1 = new JPanel( new GridLayout( 0, 1, 20, 20 ) );
		jp2 = new JPanel( new FlowLayout( FlowLayout.RIGHT, 20, 20 ) );
		jp3 = new JPanel( new GridLayout(6, 2, 20, 20) );
		
		JLabel Eingabe_Label = new JLabel( "<html><h1><u>Bitte Kundendaten eingeben:</u></h1></html>" );
		Eingabe_Label.setFont( schrift );
		jp1.add( Eingabe_Label );
		
		jp3.add( new JLabel("<html><h2>Bitte Vornamen eingeben:</h2></html>") );
		Vorname_TField = new JTextField();
		Vorname_TField.setFont( schrift );
		Vorname_TField.setMargin( new Insets(10, 10, 10, 10));		// Sind die Abstände zwischen Schrift und Rand im Textfeld, ist für die Optik wichtig sonst steht die Eingabe direkt am Rand des Textfeldes
		jp3.add( Vorname_TField );
		
		jp3.add( new JLabel("<html><h2>Bitte Nachnamen eingeben:</h2></html>") );
		Nachname_TField = new JTextField();
		Nachname_TField.setFont( schrift );
		Nachname_TField.setMargin( new Insets(10, 10, 10, 10));
		jp3.add( Nachname_TField );
		
		jp3.add( new JLabel("<html><h2>Bitte Straße und Hausnummer eingeben:</h2></html>") );
		Strasse_TField = new JTextField("");
		Strasse_TField.setFont( schrift );
		Strasse_TField.setMargin( new Insets(10, 10, 10, 10));
		jp3.add( Strasse_TField );
		
		jp3.add( new JLabel("<html><h2>Bitte PLZ und Ort eingeben:</h2></html>") );
		Ort_TField = new JTextField("");
		Ort_TField.setFont( schrift );
		Ort_TField.setMargin( new Insets(10, 10, 10, 10));
		jp3.add( Ort_TField );
		
		jp3.add( new JLabel("<html><h2>Bitte E-Mail eingeben:</h2></html>") );
		EMail_TField = new JTextField();
		EMail_TField.setFont( schrift );
		EMail_TField.setMargin( new Insets(10, 10, 10, 10));
		jp3.add( EMail_TField );
		
		jp3.add( new JLabel("<html><h2>Bitte Telefonnummer eingeben:</h2></html>") );
		Tele_TField = new JTextField("");
		Tele_TField.setFont( schrift );
		Tele_TField.setMargin( new Insets(10, 10, 10, 10));
		jp3.add( Tele_TField );
		
		
		back = new JButton( "Zurück" );
		back.setFont( schrift );
		back.addActionListener( this );
        jp2.add( back );		
		
        // Dient der Optik um den Abstand zwischen den Knöpfen in der SOUTH-Box zu gewährleisten.
        JLabel abstand = new JLabel();
        abstand.setPreferredSize( new  Dimension(465 ,10) );
        jp2.add( abstand );
        
        Kunde_anlegen = new JButton( "Kunde anlegen" );
        Kunde_anlegen.setFont( schrift );
        jp2.add( Kunde_anlegen );
		
		ContainerKunde.add( BorderLayout.NORTH, jp1 );
		ContainerKunde.add( BorderLayout.SOUTH, jp2);
		ContainerKunde.add( BorderLayout.CENTER, jp3 );
		
        ContainerKunde.repaint();
        ContainerKunde.validate();
        
        Vorname_TField.grabFocus();		// Beim erstellen der Klasse den Zeiger in das Vornamentextfeld setzen

        Kunde_anlegen.addActionListener( this );
	}

	public void actionPerformed(ActionEvent e) {
		
		if ( e.getSource() == back ) {

			ContainerKunde.removeAll();
			
			if ( quelle.equals("reservieren") ){	// Falls die Klasse beim Reservierungsprozess aufgerufen wurde, zurück zur Reservierung
				new Kunden_Auswahl( ContainerKunde, "reservieren" );
				fenster.setTitle("Reservierung");	
			}
			if ( quelle.equals("kunde") ){			// Falls der Kunde beim Kunden verwalten angelegt wurde, zurück zum Kunden verwalten
				new auswahl_fenster( ContainerKunde, "kunde" );	
				fenster.setTitle("Kunden verwalten");
			}
		}
		
		if ( e.getSource() == Kunde_anlegen ) {	
			// Die Eingaben aus den Textfeldern in Strings speichern
			String Vorname = Vorname_TField.getText();
			String Nachname = Nachname_TField.getText();
			String Strasse = Strasse_TField.getText();
			String Ort = Ort_TField.getText();
			String EMail = EMail_TField.getText();
			String Tele = Tele_TField.getText();
			
			// Falls ein Textfeld leer ist, eine 'Feld_Leer_Exception' werfen
			try {
				if ( Vorname.equals( "" ) ) {
					throw new Feld_Leer_Exception( "Vorname" );
				}
				else if ( Nachname.equals( "" ) ) {
					throw new Feld_Leer_Exception( "Nachname" );
				}
				else if ( Strasse.equals( "" ) ) {
					throw new Feld_Leer_Exception( "Straße" );
				}
				else if ( Ort.equals( "" ) ) {
					throw new Feld_Leer_Exception( "Ort" );
				}
				else if ( EMail.equals( "" ) ) {
					throw new Feld_Leer_Exception( "E-Mail" );
				}
				else if ( Tele.equals( "" ) ) {
					throw new Feld_Leer_Exception( "Telefonnummer" );
				}
				
				// Sonst wenn alle Felder gefüllt sind, einen neuen Kunden anlegen und eine Bestätigung ausgeben
				else {
					db.kunde_anlegen(Nachname, Vorname, Strasse, Ort, EMail, Tele);
					JOptionPane.showMessageDialog(null, "Neuer Kunde \"" + Vorname + " " + Nachname + "\" wurde erfolgreich angelegt!");

					ContainerKunde.removeAll();
					
					if ( quelle.equals("kunde") ) {	// Falls der Kunde beim Kunden verwalten angelegt wurde, Fensterinhalt zum erstellen eines weiteren Kunden setzen
						new Neuer_Kunde( ContainerKunde, quelle );
					}
					
					// Falls der Kunde beim Reservieren angelegt wurde, die Kunden_ID des erstellten Kunden aus der DB holen und in Kunde_ID für die Reservierung schreiben
					// Außerdem weiter zur Vorstellungsauswahl und den Titel mit dem Kundennamen setzen
					if ( quelle.equals("reservieren") ) {
						Kunde_ID = String.valueOf( db.sonder( "max(Kunde_ID) FROM kunde" ) );
						new VorstellungsAuswahl( ContainerKunde, quelle );
						fenster.setTitle("Reservierung - " + Vorname + " " + Nachname);	
					}
				}
			}
			catch (Feld_Leer_Exception e1) {
			}
		}
	}
}
