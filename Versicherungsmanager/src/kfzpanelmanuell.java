import java.awt.Color;
import java.awt.GridLayout;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.io.IOException;
import java.sql.ResultSet;
import java.util.Locale;

import javax.swing.BorderFactory;
import javax.swing.JOptionPane;
import javax.swing.JPanel;
import javax.swing.border.TitledBorder;

import org.freixas.jcalendar.JCalendarCombo;



public class kfzpanelmanuell extends JPanel{
	String[] item;
	String[] item2;
	String[] zahl = new String[116];
	MyComboBox monat;
	MyComboBox jahr;
	MyComboBox monat1;
	MyComboBox jahr1;
	MyComboBox finanz;
	MyComboBox kennz;
	static MyTextField t1;
	static MyTextField t2;
	static MyButton weiter;
	MyTextField t3, t4, t5, t6;
	JCalendarCombo calender;
	MyRadioButton kfzradio;

	
	public kfzpanelmanuell(){
		
	super(null);
	
	
	
	//Buttongroup für KFZ positionieren und hinzufügen
	kfzradio = new MyRadioButton(item2 = new String[]{"Fahrzeugwechsel","Zweitwagen", "Erstvertrag", "Versicherungswechsel"});
	
	//Comboboxen für Monat und Jahr Erstzulassung
	monat = new MyComboBox(item = new String[]{"Januar", "Februar", "März", "April", "Mai", "Juni", "Juli", "August", "September", "Oktober", "November", "Dezember"});
	
	for(int i=0; i<116; i++){
		zahl[i] = ""+(i+1900);
	}
	jahr = new MyComboBox(zahl);
	jahr.setFont(konst.myFont2);
	monat.setFont(konst.myFont2);
	
	//Comboboxen für Monat und Jahr Zulassung auf Halter
	monat1 = new MyComboBox(item = new String[]{"Januar", "Februar", "März", "April", "Mai", "Juni", "Juli", "August", "September", "Oktober", "November", "Dezember"});
	
	for(int i=0; i<116; i++){
		zahl[i] = ""+(i+1900);
	}
	jahr1 = new MyComboBox(zahl);
	jahr1.setFont(konst.myFont2);
	monat1.setFont(konst.myFont2);
	
	//Combobox für Fahrzeugfinanziereung
	finanz = new MyComboBox(item = new String[]{"geleast", "über Kreditinstitut finanziert", "eigenfinanziert"});
	finanz.setFont(konst.myFont2);
	
	//Combobox für Kennzeichenart
	kennz = new MyComboBox(item = new String[]{"Normales Kennzeichen", "Saisonkennzeichen", "Wechselkennzeichen"});
	kennz.setFont(konst.myFont2);
	
	//Kalender zur Auswahl des genauen Tages erstellen
	calender = new JCalendarCombo(); 
	calender.setFont(konst.myFont2);
	
	
	
	//Formular definieren und Objekte dem Panel hinzufügen
	MyLabel l1 = new MyLabel("Situation");
	MyLabel l2 = new MyLabel("Fahrzeugdaten");
	MyLabel l3 = new MyLabel("Herstellerschlüssel-Nr.");
	t1 = new MyTextField(40);
	MyLabel l4 = new MyLabel("Typschlüssel-Nr.");
	t2 = new MyTextField(40);
	MyLabel l5 = new MyLabel("Erstzulassung");
	MyLabel l6 = new MyLabel("Derzeitige Fahrzeugfinanzierung");
	MyLabel l7 = new MyLabel("Kennzeichenart");
	MyLabel l8 = new MyLabel("Fahrzeughalter");
	t3 = new MyTextField(40);
	t4 = new MyTextField(40);
	MyLabel l9 = new MyLabel("Postleitzahl des Halters");
	t5 = new MyTextField(40);
	MyLabel l10 = new MyLabel("Zulassungstermin auf den Halter");
	MyLabel l11 = new MyLabel("Versicherungsbeginn");
	MyLabel l12 = new MyLabel("E-Mail");
	t6 = new MyTextField(40);
	weiter = new MyButton("Weiter");
	

	this.add(l1);
	l1.setFont(konst.myFont);
	l1.setBounds(0, 0 , 150, 30);
	this.add(kfzradio);
	kfzradio.setBounds (300, 0, 200, 140);
	this.add(l2);
	l2.setFont(konst.myFont);
	l2.setBounds (0, 160, 250, 30);
	this.add(l3);
	l3.setBounds (0, 210, 250, 30);
	this.add(t1);
	t1.setBounds (300, 210, 250, 30);
	this.add(l4);
	l4.setBounds (0, 245, 250, 30);
	this.add(t2);
	t2.setBounds (300, 245, 250, 30);
	this.add(l5);
	l5.setBounds (0, 280, 250, 30);
	this.add(monat);
	monat.setBounds (300, 280, 120, 30);
	this.add(jahr);
	jahr.setBounds (430, 280, 120, 30);
	this.add(l6);
	l6.setBounds(0, 315, 250, 30);
	this.add(finanz);
	finanz.setBounds (300, 315, 250, 30);
	this.add(l7);
	l7.setBounds(0, 350, 250, 30);
	this.add(kennz);
	kennz.setBounds(300, 350, 250,30);
	this.add(l8);
	l8.setBounds(0,392,250,30);
	this.add(t3);
	t3.setBounds(300,385,120,40);
	t3.setBorder(BorderFactory.createTitledBorder(null, "Vorname", TitledBorder.LEFT, TitledBorder.TOP, konst.myFont5));
	this.add(t4);
	t4.setBorder(BorderFactory.createTitledBorder(null, "Nachname", TitledBorder.LEFT, TitledBorder.TOP, konst.myFont5));
	t4.setBounds(430,385,120,40);
	this.add(l9);
	l9.setBounds(0,435,250,30);
	this.add(t5);
	t5.setBounds(300,435,250,30);
	this.add(l10);
	l10.setBounds(0,470,250,30);
	this.add(monat1);
	monat1.setBounds(300,470,120,30);
	this.add(jahr1);
	jahr1.setBounds(430,470,120,30);
	this.add(l11);
	l11.setBounds(0,505,250,30);
	this.add(calender);
	calender.setBounds(300,505,250,30);
	this.add(l12);
	l12.setBounds(0,540,250,30);
	this.add(t6);
	t6.setBounds(300,540,250,30);
	
	
	
	weiter.setBounds(400, 600, 200, 30);
	weiter.addActionListener(new AddButtonListener());
	this.add(weiter);
	this.setBackground(Color.WHITE);

	}
	
	public class AddButtonListener implements ActionListener {
		public void actionPerformed(ActionEvent arg0) {
			int id_halter = 0, id_modell = 0;
			
			// ________________________________________ Perl Skript aufrufen; HSN/TSN synchronisieren ________________________________________
			
			try {
				Process p = Runtime.getRuntime().exec("cmd /c perl F:\\Technikerschule\\ITV34\\Projekt\\Versicherungscheck\\src\\Daten_holen.pl " + t1.getText() + " " + t2.getText());
				// wartet bis Perl Skript fertig ist
				p.waitFor();
			
			// ________________________________________ Halter Datensatz anlegen ________________________________________
				
				db_zugriff.db_login("chef", "passwd");
				
				ResultSet res = db_zugriff.db_select("CALL user_exist ('" + t6.getText() + "');");
				while (res.next()) {
					if (res.getInt(1) == 0) {
						db_zugriff.db_update("INSERT INTO versicherungscheck.halter (name, vorname, plz, mail) VALUES"
								+ "('" + t4.getText().toString() + "', "
								+ "'" + t3.getText().toString() + "', "
								+ "'" + t5.getText().toString() + "', "
								+ "'" + t6.getText().toString() + "');");
					}
				}
					
				res = db_zugriff.db_select("SELECT id FROM versicherungscheck.halter WHERE mail = '" + t6.getText() + "';");
				while (res.next())
					id_halter = res.getInt(1);
				
				res = db_zugriff.db_select("SELECT id FROM versicherungscheck.modell WHERE hsn = '" + t1.getText() + "' AND tsn = '" + t2.getText() + "';");
				while (res.next())
					id_modell = res.getInt(1);
				
			// ________________________________________ Auto Datensatz anlegen ________________________________________
			
				db_zugriff.db_update("INSERT INTO versicherungscheck.auto (modell_id, halter_id, situation, erstzul, finanzierung, kennz_art, zul_halter, vers_beg) VALUES ("
						+ id_modell + ", '"
						+ id_halter + "', '"
						+ kfzradio.getSelected() + "', '"
						+ monat.getSelectedItem().toString() + " " + jahr.getSelectedItem().toString() + "', '"
						+ finanz.getSelectedItem().toString() + "', '"
						+ kennz.getSelectedItem().toString() + "', '"
						+ monat1.getSelectedItem().toString() + " " + jahr1.getSelectedItem().toString() + "', '"
						+ calender.getSelectedItem().toString() + "');");
				db_zugriff.db_logout();
				
			// ________________________________________ Fehlerfall ________________________________________
					
			} catch (Exception e) {
				JOptionPane.showMessageDialog(null, "Leider ist ein Fehler aufgetreten. Bitte versuchen Sie es erneut.", "Fehler", JOptionPane.ERROR_MESSAGE);
			}
			
			// ________________________________________ Felder wieder leeren, für erneute Eingabe ________________________________________
			
			t1.setText("");
			t2.setText("");
			t3.setText("");
			t4.setText("");
			t5.setText("");
			t6.setText("");
		}
		
	}
	
	
}
