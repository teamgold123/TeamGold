/*
 * Diese Exception wird ausgelöst, wenn beim Reservieren
 * kein Sitzplaz ausgewählt wurde.
 * 
 * Sie empfängt einen String, der die Nachricht 
 * enthält und gibt sie an die KinoException weiter.
 */

class Kein_Sitz_Exception extends KinoException {
	public Kein_Sitz_Exception(String msg) {
	    super(msg);
	}
}