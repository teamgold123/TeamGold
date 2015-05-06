import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.io.File;

import javax.swing.ImageIcon;
import javax.swing.JFileChooser;
import javax.swing.JLabel;
import javax.swing.JOptionPane;
import javax.swing.JPanel;
import javax.swing.JTextArea;
import javax.swing.filechooser.FileFilter;
import javax.swing.filechooser.FileNameExtensionFilter;



public class kfzpanelschein extends JPanel{
	MyButton open;
	static MyButton lesen;
	MyTextField pfad;
	JLabel bild1;
	ImageIcon ico;
	JTextArea beschreibung;
	static int hsn;
	static int tsn;
	
	public kfzpanelschein(){
		super(null);
		this.setBackground(Color.WHITE);
		
		//Beschreibungstext
		JTextArea beschreibung = new JTextArea("Bitte klicken Sie auf den Button Auswahl und wählen den Pfad \nIhres Bildes mit dem Kfz-Schein aus");
		beschreibung.setBounds(50, 0, 500, 50);
		beschreibung.setFont(konst.myFont4);
		beschreibung.setBackground(konst.myColororange);
		this.add(beschreibung);
		
		//Textfeld in dem der Pfad des Bildes steht
		pfad = new MyTextField(40);
		pfad .setBounds (50, 100 , 500, 25);
		this.add(pfad);
		
		//Button der den Chooser öffnet
		open = new MyButton("Öffnen");
		open.setBounds (50, 140, 200, 30);
		this.add(open);
		
		//Button der das Bild zuschneiden lässt
		lesen = new MyButton("Daten auslesen");
		lesen.setBounds (350, 140, 200, 30);
		this.add(lesen);
		
		//Label definieren
		bild1 = new JLabel();
		bild1.setBounds(0,180,600,420);
		this.add(bild1);
		
		
		//Buttons mit ButtonListener verknüpfen
		open.addActionListener(new FileButtonListener());
		lesen.addActionListener(new FileButtonListener());;
		
	}
		public class FileButtonListener implements ActionListener {

			public void actionPerformed(ActionEvent e) {
				
				//Wenn der Button "öffnen" gedrückt wird soll der FileChooser erscheinen um die gewünschte Datei auszuwählen
				if (e.getSource() == open){
					FileFilter filter = new FileNameExtensionFilter("Bilder", "jpg", "gif" , "png");         
					JFileChooser chooser = new JFileChooser();
					chooser.setFileFilter(filter);
					chooser.showDialog(chooser, "Öffnen");
					pfad.setText(chooser.getSelectedFile().getAbsolutePath());
					
					try {
						//Skalieren für neues Fenster
						Skalieren.skalieren(pfad.getText(), 1900, 940);
						//Ausschneiden des Kfz-Scheins, damit kein Rand mehr ist
						Ausschneide_Fenster.get("skaliert.png");
						//Skalieren, damit der Schein immer gleich groß ist
						Skalieren.skalieren("test.png", 2500, 1540);
					} catch (Exception e1) {
						JOptionPane.showMessageDialog(null, "Vergewissern Sie sich, dass Sie Ihren KFZ-Schein ausgewählt haben.", "Fehler aufgetreten", JOptionPane.ERROR_MESSAGE);
					}

					ico = new ImageIcon("test.png");
					ico.setImage(ico.getImage().getScaledInstance(600,350,Image.SCALE_DEFAULT)); 
					bild1.setIcon(ico);
				
				// wenn der Button "lesen" gedrückt wird solln die 2 Bilder (hsn.png, tsn.png) erzeugt/ausgeschnitten werden
				} else if (e.getSource() == lesen){
					
					try {
						//Skalieren.schneiden("test.jpg", "hsn.png", 1122, 45, 160, 65);
						//Skalieren.schneiden("test.jpg", "tsn.png", 1316, 50, 220, 75);
						
						//Bilder Auswerten
						hsn = Auswertungkfz.auswerten("hsn.png");
						
						tsn = Auswertungkfz.auswerten("tsn.png");
						
					} catch (Exception e1) {
						JOptionPane.showMessageDialog(null, "Vergewissern Sie sich, dass Sie Ihren KFZ-Schein ausgewählt haben.", "Fehler aufgetreten", JOptionPane.ERROR_MESSAGE);
					}
				
				}
		
			}
		}
	
}