import javax.swing.JOptionPane;

/*
 * Diese Exception empfängt einen String von 'Kein_Sitz_Exception'
 * oder von 'Feld_Leer_Exception' und erstellt ein Meldungsfenster
 * mit der empfangenen Nachricht.
 */

public class KinoException extends Exception {
    public KinoException (String msg) {
		JOptionPane.showMessageDialog(null, msg, "Achtung!", JOptionPane.ERROR_MESSAGE);
	}
}