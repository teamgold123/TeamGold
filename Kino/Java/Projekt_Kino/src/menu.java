import java.awt.*;
import java.awt.event.*;

import javax.swing.*;

/*
* Dies Klasse fügt dem Fensetr die Menüleiste hinzu.
* Mit den Menupunkten können verschiedene Aktionen gestartet werden.
*/

public class menu extends Kino {
	Container  	ContainerMenu;
	JMenuItem 	start, reservieren, kunde_verwalten, vorstellungen, res_loeschen, logout, beenden; 	// Menue-Einträge	
	
	public menu() {
		ContainerMenu = getContentPane();
		
	    // Erzeuge die Menueleiste.
		JMenuBar menuBar = new JMenuBar();
	
	    // Erzeuge ein Menue
		JMenu	menu = new JMenu("Menu");
	    // Fuege das Menue der Menueleiste hinzu
	    menuBar.add(menu);
	
	    // Erzeuge die Menue-Eintraege und fuege sie dem Menue hinzu
	    start = new JMenuItem("Startseite");
	    menu.add(start);
	    start.setFont( schrift );
	    
	    reservieren = new JMenuItem("Reservieren");
	    menu.add(reservieren);
	    reservieren.setFont( schrift );
	    
	    kunde_verwalten = new JMenuItem("Kunden verwalten");
	    kunde_verwalten.setFont( schrift );
	    menu.add( kunde_verwalten );	  
	    
	    vorstellungen = new JMenuItem("Vorstellung anzeigen");
	    menu.add( vorstellungen );
	    vorstellungen.setFont( schrift );
	    
	    res_loeschen = new JMenuItem("Reservierung löschen");
	    menu.add( res_loeschen );
	    res_loeschen.setFont( schrift );
	    
	    menu.addSeparator();			// Eine Trennlinie einfügen
	    
	    logout = new JMenuItem("Logout");
	    logout.setFont( schrift );
	    menu.add(logout);
	    
	    beenden = new JMenuItem("Beenden");
	    beenden.setFont( schrift );
	    menu.add(beenden);
	    
	    // Fuegt das Menue dem Frame hinzu
	    setJMenuBar(menuBar);
	     
	    // Listener für die Menüeinträge
		ButtonListener bL = new ButtonListener();
		start.addActionListener( bL );
		reservieren.addActionListener( bL ); 
		kunde_verwalten.addActionListener( bL );
		vorstellungen.addActionListener( bL );
		res_loeschen.addActionListener( bL );
		logout.addActionListener( bL );
		beenden.addActionListener( bL );
		
	    // Startseite erzeugen (Container wird übergeben, dass der Inhalt in das aktuelle Fenster eingefügt werden kann)
	    new Startseite( ContainerMenu );
	}
    
    // Für die jeweiligen Menüeinträge die entsprechenden Aktionen ausführen
	class ButtonListener implements ActionListener {
		public void actionPerformed( ActionEvent e ) {
			
			if ( e.getSource() == start ) {
				ContainerMenu.removeAll();								// alten Fensterinhalt löschen
			    new Startseite( ContainerMenu );
				fenster.setTitle("Kinoprogramm - TEAM GOLD");			// In die Titelzeile schreiben weleche Aktion aktiv ist
			}
			
			if (e.getSource() == reservieren) {
				ContainerMenu.removeAll();								
				new Kunden_Auswahl( ContainerMenu, "reservieren" );	
				fenster.setTitle("Reservierung");	
			}
			
			if ( e.getSource() == kunde_verwalten ) {
				ContainerMenu.removeAll();
				new auswahl_fenster(ContainerMenu, "kunde");
				fenster.setTitle("Kunden verwalten");
			}
			
			if ( e.getSource() == vorstellungen ) {
				ContainerMenu.removeAll();
				new VorstellungsAuswahl( ContainerMenu, "vorstellungen" );
				fenster.setTitle("Vorstellung anzeigen");
			}
			
			if (e.getSource() == res_loeschen ) {
				ContainerMenu.removeAll();
				new auswahl_fenster( ContainerMenu, "res_loe" );
				fenster.setTitle("Reservierung löschen");
			}
			
			if ( e.getSource() == logout ) {
				ContainerMenu.removeAll();
			    new Startseite( ContainerMenu );	// zurück zur Startseite
				new Anmeldung();					// neues Anmeldungsfenster	
				fenster.setTitle("Kinoprogramm - TEAM GOLD");
			}
			
			if ( e.getSource() == beenden ) {
				System.exit(0);					// Programm beenden
				db.beenden();					// DB Verbindung schließen
			}
		}
	}
}
