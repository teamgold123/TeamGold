/*
 * Diese Exception wird ausgel�st, wenn beim Reservieren
 * kein Sitzplaz ausgew�hlt wurde.
 * 
 * Sie empf�ngt einen String, der die Nachricht 
 * enth�lt und gibt sie an die KinoException weiter.
 */

class Kein_Sitz_Exception extends KinoException {
	public Kein_Sitz_Exception(String msg) {
	    super(msg);
	}
}