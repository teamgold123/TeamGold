import java.awt.*;
import java.awt.event.*;

import javax.swing.*;

/*
* Dies Klasse f�gt dem Fensetr die Men�leiste hinzu.
* Mit den Menupunkten k�nnen verschiedene Aktionen gestartet werden.
*/

public class menu extends Kino {
	Container  	ContainerMenu;
	JMenuItem 	start, reservieren, kunde_verwalten, vorstellungen, res_loeschen, logout, beenden; 	// Menue-Eintr�ge	
	
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
	    
	    res_loeschen = new JMenuItem("Reservierung l�schen");
	    menu.add( res_loeschen );
	    res_loeschen.setFont( schrift );
	    
	    menu.addSeparator();			// Eine Trennlinie einf�gen
	    
	    logout = new JMenuItem("Logout");
	    logout.setFont( schrift );
	    menu.add(logout);
	    
	    beenden = new JMenuItem("Beenden");
	    beenden.setFont( schrift );
	    menu.add(beenden);
	    
	    // Fuegt das Menue dem Frame hinzu
	    setJMenuBar(menuBar);
	     
	    // Listener f�r die Men�eintr�ge
		ButtonListener bL = new ButtonListener();
		start.addActionListener( bL );
		reservieren.addActionListener( bL ); 
		kunde_verwalten.addActionListener( bL );
		vorstellungen.addActionListener( bL );
		res_loeschen.addActionListener( bL );
		logout.addActionListener( bL );
		beenden.addActionListener( bL );
		
	    // Startseite erzeugen (Container wird �bergeben, dass der Inhalt in das aktuelle Fenster eingef�gt werden kann)
	    new Startseite( ContainerMenu );
	}
    
    // F�r die jeweiligen Men�eintr�ge die entsprechenden Aktionen ausf�hren
	class ButtonListener implements ActionListener {
		public void actionPerformed( ActionEvent e ) {
			
			if ( e.getSource() == start ) {
				ContainerMenu.removeAll();								// alten Fensterinhalt l�schen
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
				fenster.setTitle("Reservierung l�schen");
			}
			
			if ( e.getSource() == logout ) {
				ContainerMenu.removeAll();
			    new Startseite( ContainerMenu );	// zur�ck zur Startseite
				new Anmeldung();					// neues Anmeldungsfenster	
				fenster.setTitle("Kinoprogramm - TEAM GOLD");
			}
			
			if ( e.getSource() == beenden ) {
				System.exit(0);					// Programm beenden
				db.beenden();					// DB Verbindung schlie�en
			}
		}
	}
}
