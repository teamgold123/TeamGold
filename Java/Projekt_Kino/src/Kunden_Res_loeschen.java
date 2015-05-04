import java.awt.*;
import java.awt.event.*;

import javax.swing.*;

/*
 * Diese Klasse dient dazu um Reservierungen eines Kunden zu löschen.
 * 
 * Sie zeigt alle Reservierungen eines Kunden an und der Benutzer
 * kann dann mithilfe eines Buttons einzelne Reservierungen löschen.
 */

public class Kunden_Res_loeschen extends Kino implements ActionListener{
	Container 	ContainerKundeRes;
	JPanel		jp1, jp2, jp3;
	JButton 	back;
	JButton[] 	delete;

	String[] 	RID;
	int[] 		Sitz, Reihe, VorID;
	
	public Kunden_Res_loeschen(Container con) {

		ContainerKundeRes = con;
		
		ContainerKundeRes.removeAll();
		ContainerKundeRes.setLayout( new BorderLayout() );
		
		jp1 = new JPanel( new GridLayout( 0, 1 ) );
		jp2 = new JPanel( new FlowLayout(FlowLayout.CENTER, 75, 5) );
		
		String Vorname = db.StringAuslesen("Vorname", "kunde where Kunde_ID = " + Kunde_ID);
		String Nachname = db.StringAuslesen("Name", "kunde where Kunde_ID = " + Kunde_ID);
		JLabel Header = new JLabel("<HTML><u>Reservierungen für " + Vorname + " " + Nachname + " (Kunden-ID: " + Kunde_ID + "):</u></HTML>");
		
		jp1.add( Header );
		Header.setFont( schrift );
		jp1.add( new JLabel() );
	
		jp3 = new JPanel( new FlowLayout( FlowLayout.LEFT, 20, 20 ) );
		back = new JButton( "Zurück" );
        back.setFont( schrift );
        jp3.add( back );
        back.addActionListener( this );
	
        // String für die DB Abfrage
		String abfrage = "reservierung, vorstellung, filme where reservierung.Vorstellung_ID = Vorstellung.Vorstellung_ID AND vorstellung.Filme_ID = filme.Filme_ID AND reservierung.Kunde_ID = " + Kunde_ID + " order by Reservierung_ID, reservierung.Vorstellung_ID, Reihe, Sitzplatz ASC";
	
		// Daten aus der DB auslesen und in Arrays speichern
		String Filmname[] = db.StringArray("Name", abfrage);
		String Datum[] = db.StringArray("Datum", abfrage);
		String Beginn[] = db.StringArray("Beginn", abfrage);
		int SID[] = db.intArray("Saal_ID", abfrage);
		
		RID = db.StringArray("Reservierung_ID", abfrage);
		Sitz = db.intArray("Sitzplatz", abfrage);
		Reihe = db.intArray("Reihe", abfrage);
		VorID = db.intArray("Vorstellung_ID", abfrage);
		
		int anz = db.sonder( "count(*) from " + abfrage );	// Ergebnisse zählen und Anzahl in anz speichern
		delete = new JButton[anz];							// ButtonArray in dem die Knöpfe sind, die zum Löschen der einzelnen Reservierungen genutzt werden. (Größe ist die oben ausgelesene Anzahl)

		int z = 0;
		for (int i = 0; i < anz; i++) {
			jp2.add( new JLabel(RID[i] + " - " + Filmname[i] + " - " + Datum[i] + " " + Beginn[i] + " - Saal " + SID[i] + " - Sitz: " + Sitz[i] + " Reihe: " + Reihe[i]) );	// Label mit den Reservierungsdaten
			jp2.add( delete[i] = new JButton( "löschen" ) );
			
			String index = String.valueOf(i);		// Index des Knopfes in einen String umwwandeln
			delete[i].setActionCommand( index );	// Den Index an den Listener übergeben
			delete[i].addActionListener( this );
			z++;
		}
		
		// Falls keine Reservierungen vorliegen, eine Meldung im Fenster anzeigen
		if (z == 0) {
			JLabel keine_Res = new JLabel("Für diesen Kunden liegen keine Reservierungen vor!");
			jp2.add( keine_Res );
			keine_Res.setFont( schrift );
			keine_Res.setForeground( Color.RED );
		}
		
		ContainerKundeRes.add( BorderLayout.NORTH, jp1 );
		ContainerKundeRes.add( BorderLayout.CENTER, jp2 );
		ContainerKundeRes.add( BorderLayout.SOUTH, jp3 );
	
		ContainerKundeRes.repaint();
		ContainerKundeRes.validate();
	}
	
	
	public void actionPerformed(ActionEvent e) {	
		// Falls auf zurück gedrückt wurde, zur Kundenauswahl zurückgehen
		if ( e.getSource() == back ) {
			ContainerKundeRes.removeAll();
			new Kunden_Auswahl( ContainerKundeRes, "res_loe" );
		}
	
		// Wenn auf löschen gedruckt wurde:
		// den vom ActionCommand empfangenen Index in int umwandeln, die Reservierung löschen, eine Bestätigung ausgeben und alle noch bestehenden Reservierungen des Kunden anzeigen
		else {
			int index = Integer.parseInt( e.getActionCommand() );
			
			db.delete("reservierung where Reservierung_ID = " +  RID[index] + " AND Reihe = " + Reihe[index] + " AND Sitzplatz = " + Sitz[index] + " AND Vorstellung_ID = " + VorID[index] + ";");
		
			JOptionPane.showMessageDialog(null, "Die Reservierung wurde erfolgreich gelöscht!");
					
			new Kunden_Res_loeschen( ContainerKundeRes );
		}
	}
}
