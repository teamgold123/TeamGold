import java.awt.event.ItemEvent;
import java.awt.event.ItemListener;

	class BoxListener implements ItemListener {
		public void itemStateChanged(ItemEvent e){
			
			if	(e.getSource() == GUI.auswahl){
			Aktualisieren.anzeigeAktualisieren();
			}
		}
	}