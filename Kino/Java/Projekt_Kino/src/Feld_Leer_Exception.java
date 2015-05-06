/*
 * Diese Exception wird ausgelöst, wenn ein Feld beim 
 * anlegen eines Kunden leer bleibt.
 * 
 * Sie empfängt eine String, der den Namen des leere Feld enthält und
 * erstellt damit eine Nachricht die an die KinoException weiter gegeben wird.
 */

class Feld_Leer_Exception extends KinoException {
	public Feld_Leer_Exception( String str ) {
		super("Bitte " + str + " angeben!");
	}
}