import java.awt.*;
import java.awt.event.*;

import javax.swing.*;
import javax.swing.border.TitledBorder;


public class Aktualisieren {
	
	
	//Anzeige Aktualisieren nach Comboboxauswahl
	public static void anzeigeAktualisieren(){
		if	(GUI.auswahl.getSelectedItem() == "Bitte wählen Sie aus"){
			GUI.einlesen.setVisible(false);
			GUI.eingabe.setVisible(false);
			GUI.kfz.setVisible(false);
			GUI.kfzschein.setVisible(false);
			GUI.begruss.setVisible(true);
			GUI.kfzmethode.setVisible(false);
			GUI.abgeschickt.setVisible(false);
		} else if (GUI.auswahl.getSelectedItem() == "Kfz") {
			GUI.einlesen.setVisible(true);
			GUI.eingabe.setVisible(true);
			GUI.kfz.setVisible(false);
			GUI.kfzschein.setVisible(false);
			GUI.begruss.setVisible(false);
			GUI.kfzmethode.setVisible(true);
			GUI.abgeschickt.setVisible(false);
		} else if (GUI.auswahl.getSelectedItem() == "Hausrat"){
			GUI.einlesen.setVisible(false);
			GUI.eingabe.setVisible(true);
			GUI.kfz.setVisible(false);
			GUI.kfzschein.setVisible(false);
			GUI.begruss.setVisible(false);
			GUI.kfzmethode.setVisible(false);
			GUI.abgeschickt.setVisible(false);
		}else if (GUI.auswahl.getSelectedItem() == "Lebensversicherung"){
			GUI.einlesen.setVisible(false);
			GUI.eingabe.setVisible(false);
			GUI.kfz.setVisible(false);
			GUI.kfzschein.setVisible(false);
			GUI.begruss.setVisible(false);
			GUI.kfzmethode.setVisible(false);
			GUI.abgeschickt.setVisible(false);
		}
	}
		
	//Anzeige Aktualisieren (Grundanzeige)
	public static void anzeigeAktualisierenButton(ActionEvent e){
		
		//Buttonklick und Comboboxauswahl
		if (GUI.auswahl.getSelectedItem() == "Kfz" && e.getSource() == GUI.einlesen) {
			GUI.kfzschein.setVisible(true);
			GUI.kfz.setVisible(false);
			GUI.kfzmethode.setVisible(false);
			GUI.abgeschickt.setVisible(false);
		} else if (GUI.auswahl.getSelectedItem() == "Kfz" && e.getSource() == GUI.eingabe) {
			GUI.kfz.setVisible(true);
			GUI.kfzschein.setVisible(false);
			GUI.kfzmethode.setVisible(false);
			GUI.abgeschickt.setVisible(false);
		} else if (GUI.auswahl.getSelectedItem() == "Kfz" && e.getSource() == kfzpanelmanuell.weiter) {
			GUI.kfz.setVisible(false);
			GUI.kfzschein.setVisible(false);
			GUI.kfzmethode.setVisible(false);
			GUI.abgeschickt.setVisible(true);
		} else if (GUI.auswahl.getSelectedItem() == "Kfz" && e.getSource() == kfzpanelschein.lesen){
			GUI.kfz.setVisible(true);
			kfzpanelmanuell.t1.setText("8253");//+ kfzpanelschein.hsn);
			kfzpanelmanuell.t2.setText("ADX00070");//+ kfzpanelschein.tsn);
			GUI.kfzschein.setVisible(false);
			GUI.kfzmethode.setVisible(false);
			GUI.abgeschickt.setVisible(false);
		}//Menubar abfragen	
		 else if(e.getActionCommand().equals("Beenden")){
			System.exit(0);	
		} else if(e.getActionCommand().equals("Login")){
			Login log = new Login();
			Thread log1 = new Thread(log);
			log1.start();
		}
	}
}

