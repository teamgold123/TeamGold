import java.awt.*;
import javax.swing.*;

/*
* Diese Klasse stellt die Startseite des Programms dar
* ( Setzt nur ein Bild als Hintergrund )
*/

public class Startseite extends Kino {	
	public Startseite( Container con )  {
		// Referenz auf das Fenster setzen
		Container ContainerStart = con;
		// Die Startseite braucht ihr eigenes Layout, sonst ist beim wechsel von z.B. auswahl_fenster zur Startseite oben ein weißer Balken
		ContainerStart.setLayout( new GridLayout() );	
		
		// Bild Hinzufügen
		Icon bild = new ImageIcon("./Bilder/TeamGold_g.png");
		JLabel BildGold = new JLabel( bild );
		ContainerStart.add( BildGold );
		
		// Fensterinhalt 'neu zeichnen'
	    ContainerStart.repaint();
	    ContainerStart.validate();	
	}
}