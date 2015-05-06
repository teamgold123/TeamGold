import java.awt.*;
import java.awt.event.*;
import javax.swing.*;

/*
 * Diese Klasse wird für verschiedene Programmfunktionen verwendet ( Unterscheidung durch die übergebene Quelle ),
 * entsprechend der Funktion wird das Fenster anders dargestellt.
 * 
 * Diese Klasse stellt ein Layout zur Verfügung, in dem 2 Knöpfe in der Mitte des Fenster angezeigt werden.
 */

public class auswahl_fenster extends Kino implements ActionListener {
	Container 	ContainerResLoe;
	JButton 	auswahl1, auswahl2;
	String		quelle;
	
	public auswahl_fenster( Container con, String quelle ) {
		ContainerResLoe = con;
		ContainerResLoe.setLayout( new FlowLayout( FlowLayout.CENTER, 100, 20 ) );
		
		this.quelle = quelle;
		
		if ( quelle.equals( "res_loe" ) ) {		// Falls beim Reservierung löschen
			auswahl1 = new JButton( "Reservierung eines Kunden löschen" );
			auswahl2 = new JButton( "Alle Reservierungen einer Vorstellung löschen" );
		}
		if ( quelle.equals( "kunde" ) ) {		// Falls beim Kunden verwalten
			auswahl1 = new JButton( "Einen neuen Kunden anlegen" );
			auswahl2 = new JButton( "Einen Kunden löschen" );
		}
		
		auswahl1.setFont( schrift );
		auswahl1.setPreferredSize( new Dimension( 500, 30 ) );
		auswahl2.setFont( schrift );
		auswahl2.setPreferredSize( new Dimension( 500, 30 ) );
		
		JLabel leer = new JLabel();
		leer.setPreferredSize( new Dimension( 500, 200 ) );		// 'leer' dient als Platzhalter und 'schiebt' die Knöpfe in die Mitte des Frames
		ContainerResLoe.add( leer );
		ContainerResLoe.add( auswahl1 );
		ContainerResLoe.add( auswahl2 );
		
		auswahl1.addActionListener(this);
		auswahl2.addActionListener(this);
		
		ContainerResLoe.repaint();
		ContainerResLoe.validate();
   }

	public void actionPerformed(ActionEvent e) {

		ContainerResLoe.removeAll();			// Inhalt des Containers löschen
		
		if (e.getSource() == auswahl1) {			
			if ( quelle.equals( "res_loe" ) ) {
				new Kunden_Auswahl( ContainerResLoe, quelle );
				fenster.setTitle( "Reservierung eines Kunden löschen" );
			}
			if ( quelle.equals( "kunde" ) ) {
				new Neuer_Kunde( ContainerResLoe, quelle );
				fenster.setTitle( "Neuen Kunden anlegen" );
			}
		}
		if (e.getSource() == auswahl2) {
			if ( quelle.equals( "res_loe" ) ) {
				new VorstellungsAuswahl( ContainerResLoe, quelle );
				fenster.setTitle( "Reservierungen einer Vorstellung löschen" );
			}
			if ( quelle.equals( "kunde" ) ) {
				new Kunden_Auswahl( ContainerResLoe, quelle );
				fenster.setTitle( "Kunde löschen" );
			}
		}
	}
}