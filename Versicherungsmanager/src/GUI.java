import java.awt.*;
import java.awt.event.*;
import java.awt.image.BufferedImage;
import java.io.File;

import javax.imageio.ImageIO;
import javax.swing.*;
import javax.swing.border.TitledBorder;



public class GUI extends JFrame {
	
	static Container c;
	static MyComboBox auswahl;
	static MyButton einlesen;
	static MyButton eingabe;
	String[] item;
	String[] item2;
	static MyRadioButton kfzradio;
	JLabel header;
	static kfzpanelmanuell kfz;
	static kfzpanelschein kfzschein;
	static abgeschickt abgeschickt;
	static JTextArea begruss;
	static JTextArea kfzmethode;

	
	public GUI () {
		c = getContentPane();
		c.setLayout(null);
		c.setBackground(Color.white);
		
		//header definieren
		header = new JLabel(new ImageIcon("headerv1.jpg"));
		header.setBounds(0,0,700,80);
		header.setVisible(true);
		c.add(header);
		
		//Begr�ssungstext
		begruss = new JTextArea("Herzlich Willkommen, \n\nbitte w�hlen Sie eine Versicherung aus \nund klicken sich durch das Men�. \n\nViel Spa�");
		begruss.setBounds(150, 400, 700, 400);
		begruss.setFont(konst.myFont);
		c.add(begruss);
		


		
		//Combobox positionieren und hinzuf�gen
		auswahl = new MyComboBox(item = new String[]{"Bitte w�hlen Sie aus", "Kfz", "Hausrat", "Lebensversicherung"});
		auswahl.setBorder(BorderFactory.createTitledBorder(null, "W�hlen Sie die gew�nschte Versicherung", TitledBorder.LEFT, TitledBorder.TOP, konst.myFont3));
		auswahl.setFont(konst.myFont2);
		auswahl.setBounds (50, 110, 400, 60);
		auswahl.setSelectedItem("Bitte w�hlen Sie aus");
		c.add(auswahl);
		
		//Text der erscheint wenn NUR eine Wahl in der Combobox statt gefunden hat
		kfzmethode = new JTextArea("Bitte klicken Sie jetzt entweder \"Kfz-Schein einlesen\" f�r \neine automatische "
				+ "Erfassung Ihrer Daten mit Hilfe eines Bildes\nIhres Kfz-Scheins oder klicken Sie auf \"Manuelle Eingabe\"\n"
				+ "um Ihre Daten manuell einzugeben");
		kfzmethode.setBounds(50, 400, 600, 110);
		kfzmethode.setFont(konst.myFont);
		kfzmethode.setBackground(konst.myColororange);
		c.add(kfzmethode);

		
		//Buttons positionieren und hinzuf�gen
		einlesen = new MyButton("Kfz-Schein einlesen");
		einlesen.setBounds (50, 850, 200, 30);
		eingabe = new MyButton("Manuelle Eingabe");
		eingabe.setBounds (450, 850, 200, 30);
		
		c.add(einlesen);
		c.add(eingabe);
		
		
		//kfzpanelmanuell  panel hinzuf�gen (Daten Manuell eingeben)
		kfz = new kfzpanelmanuell();
		kfz.setBounds(50,200,600,700);
		c.add(kfz);
		
		
		//kfzschein panel hinzuf�gen (Bild einlesen)
		kfzschein = new kfzpanelschein();
		kfzschein.setBounds(50,200,600,700);
		c.add(kfzschein);
		
		//fertig panel hinzuf�gen (Daten wurden abgeschickt)
		abgeschickt = new abgeschickt();
		abgeschickt.setBounds(50,200,600,700);
		c.add(abgeschickt);
		
		
		
		
		//Menu f�r login und beenden
		JMenuBar mb = new JMenuBar();
		JMenu menu = new JMenu("Menu");
		JMenuItem miLogin = new JMenuItem("Login");
		JMenuItem miBeenden = new JMenuItem("Beenden");
		miBeenden.addActionListener(new ButtonListener());
		miLogin.addActionListener(new ButtonListener());
		menu.add(miLogin);
		menu.add(miBeenden);
		mb.add(menu);
		setJMenuBar(mb);												
		setVisible(true);
		
		
		
		Aktualisieren.anzeigeAktualisieren();
		
	
	}
	
	
	public static void main(String[] args) {
		GUI fenster = new GUI();
		fenster.setSize(705,965);
		fenster.setResizable(false);
		fenster.setLocationRelativeTo(null);
		
		fenster.setVisible(true);
		fenster.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
	}
	
}
