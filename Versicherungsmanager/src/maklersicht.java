import java.awt.*;
import java.awt.event.*;
import java.sql.*;

import javax.swing.*;


public class maklersicht extends JFrame implements Runnable {
	Container c;
	MyButton nutzer, bye, auto, save_halter, zeige_halter, add_halter, del_halter, del_auto;
	static MyButton edit;
	JPanel tab;
	MyTable erg;
	MyLabel welcome, title, l0, l1, l2, l3, l4, l5, l6, l7, l8, l9, l10, l11, l12;
	MyTextField t0, t1, t2, t3, t4, t5, t6, t7, t8, t9, t10, t11, t12;
	String id_halter;
	

	public maklersicht () {
		super("Administration");
		
		//Komponenten: Labels
		
		welcome = new MyLabel("Willkommen auf der Administrationsseite", 100, 50, 500, 50);
		welcome.setFont(konst.myFont);
		title = new MyLabel("Details für ausgewählten Datensatz", 100, 50, 400, 50);
		title.setFont(konst.myFont);
		l0 = new MyLabel("", 100, 100, 80, 25);
		l1 = new MyLabel("", 100, 130, 80, 25);
		l2 = new MyLabel("", 100, 160, 80, 25);
		l3 = new MyLabel("", 100, 190, 80, 25);
		l4 = new MyLabel("", 100, 220, 80, 25);
		l5 = new MyLabel("", 100, 250, 80, 25);
		l6 = new MyLabel("", 100, 280, 90, 25);
		l7 = new MyLabel("", 420, 130, 80, 25);
		l8 = new MyLabel("", 420, 160, 100, 25);
		l9 = new MyLabel("", 420, 190, 100, 25);
		l10= new MyLabel("", 420, 220, 100, 25);
		l11= new MyLabel("", 420, 250, 80, 25);
		l12= new MyLabel("", 420, 280, 80, 25);
		
		//Komponenten: TextFelder
		
		t0 = new MyTextField(200, 100, 200, 25);
		t1 = new MyTextField(200, 130, 200, 25);
		t2 = new MyTextField(200, 160, 200, 25);
		t3 = new MyTextField(200, 190, 200, 25);
		t4 = new MyTextField(200, 220, 200, 25);
		t5 = new MyTextField(200, 250, 200, 25);
		t6 = new MyTextField(200, 280, 200, 25);
		t7 = new MyTextField(520, 130, 200, 25);
		t8 = new MyTextField(520, 160, 200, 25);
		t9 = new MyTextField(520, 190, 200, 25);
		t10= new MyTextField(520, 220, 200, 25);
		t11= new MyTextField(520, 250, 200, 25);
		t12= new MyTextField(520, 280, 200, 25);
		
		
		//Komponenten: Buttons
		
		nutzer = new MyButton("Halter anzeigen");
		nutzer.addActionListener(new MaklerButtonListener());
		nutzer.setBounds(780, 50, 200, 30);
		
		auto = new MyButton("Fahrzeuge anzeigen");
		auto.addActionListener(new MaklerButtonListener());
		auto.setBounds(780, 100, 200, 30);
		
		edit = new MyButton("Details / Bearbeiten");
		edit.addActionListener(new MaklerButtonListener());
		edit.setBounds(780, 150, 200, 30);
		edit.setEnabled(false);
		
		add_halter = new MyButton("Halter hinzufügen");
		add_halter.addActionListener(new MaklerButtonListener());
		add_halter.setBounds(780, 200, 200, 30);
		
		bye = new MyButton("Abmelden");	
		bye.addActionListener(new MaklerButtonListener());
		bye.setBounds(780, 250, 200, 30);;
		
		
		save_halter = new MyButton("Speichern");
		save_halter.addActionListener(new MaklerButtonListener());
		save_halter.setBounds(200, 280, 200, 30);
		
		del_halter = new MyButton("Löschen");
		del_halter.addActionListener(new MaklerButtonListener());
		del_halter.setBounds(200, 330, 200, 30);
		
		del_auto = new MyButton("Löschen");
		del_auto.addActionListener(new MaklerButtonListener());
		del_auto.setBounds(200, 350, 200, 30);
		
		zeige_halter = new MyButton("Halterdaten anzeigen");
		zeige_halter.addActionListener(new MaklerButtonListener());
		zeige_halter.setBounds(520, 350, 200, 30);
		
		tab = new JPanel(null);
		tab.setBounds(0, 0, 780, 500);
		tab.add(welcome);
		
		//Hinzufügen der Komponenten
		
		c = getContentPane();
		c.setLayout(null);
		c.add(nutzer);
		c.add(auto);
		c.add(edit);
		c.add(add_halter);
		c.add(bye);
		c.add(tab);
	}
	
	
	public class MaklerButtonListener implements ActionListener {
		public void actionPerformed(ActionEvent e) {
			int spaltenzahl = 0, zeilenzahl = 0;
			ResultSet rs;
			String[][] result = null;
				
			//JPane leeren
			edit.setEnabled(false);
			tab.removeAll();
			revalidate();
			repaint();
				
			
			if (e.getSource() == nutzer || e.getSource() == save_halter || e.getSource() == del_halter) {
				
				if (e.getSource() == save_halter) {
					if (t0.getText().equals("(systembedingt)")) {
						
						// ________________________________________ Halter hinzufügen ________________________________________
						
						db_zugriff.db_update("INSERT INTO versicherungscheck.halter (name, vorname, plz, mail) VALUES"
							+ "('" + t1.getText().toString() + "', "
							+ "'" + t2.getText().toString() + "', "
							+ "'" + t3.getText().toString() + "', "
							+ "'" + t4.getText().toString() + "');");
						JOptionPane.showMessageDialog(null, "Datensatz erfolgreich angelegt.", "Neuer Halter", JOptionPane.INFORMATION_MESSAGE);
					} else {
						
						// ________________________________________ Halter ändern ________________________________________
						
						db_zugriff.db_update("UPDATE versicherungscheck.halter "
							+ "SET name = '" + t1.getText().toString()
							+ "', vorname = '" + t2.getText().toString()
							+ "', plz = '" + t3.getText().toString()
							+ "', mail = '" + t4.getText().toString()
							+ "' WHERE id = '" + t0.getText() + "';");
						JOptionPane.showMessageDialog(null, "Datensatz erfolgreich gespeichert.", "Gespeichert", JOptionPane.INFORMATION_MESSAGE);
					}
					
				} else if (e.getSource() == del_halter) {
					
					// ________________________________________ Halter löschen ________________________________________
					
					db_zugriff.db_update("DELETE FROM versicherungscheck.halter WHERE id = '" + t0.getText() + "';");
					JOptionPane.showMessageDialog(null, "Datensatz erfolgreich gelöscht.", "Löschen", JOptionPane.INFORMATION_MESSAGE);
				}

				// ________________________________________ Halter anzeigen ________________________________________
				
				spaltenzahl = 5;
				try {
					//String-Array erstellen
					
					rs = db_zugriff.db_select("SELECT COUNT(*) FROM versicherungscheck.halter;");
					while (rs.next())
						zeilenzahl = rs.getInt(1);
					result = new String[zeilenzahl][spaltenzahl];
				
					//Array füllen
					
					rs = db_zugriff.db_select("SELECT * FROM versicherungscheck.halter;");
					int i = 0;
					while(rs.next()) {
						for (int j = 0; j < spaltenzahl; j ++) {
							result[i][j] = rs.getString(j+1);
						}
						i++;
					}	
				} catch (SQLException e1) {
					JOptionPane.showMessageDialog(null, "Fehler bei Abfrage", "Fehler", JOptionPane.ERROR_MESSAGE);
				}
				
				//Tabelle erstellen und anzeigen
				
				erg = new MyTable(result, new String[] {"ID", "Name", "Vorname", "PLZ", "Mail"}, "halter");
				tab.add(new MyScrollPane(erg));
				validate();
				
				
			} else if (e.getSource() == auto || e.getSource() == del_auto) {
				if (e.getSource() == del_auto) {
					
					// ________________________________________ Fahrzeug löschen ________________________________________
					
					db_zugriff.db_update("DELETE FROM versicherungscheck.auto WHERE kennzeichen = '" + t0.getText() + "';");
					JOptionPane.showMessageDialog(null, "Datensatz erfolgreich gelöscht.", "Löschen", JOptionPane.INFORMATION_MESSAGE);
				}

				// ________________________________________ Fahrzeuge anzeigen ________________________________________
				
				spaltenzahl = 7;
				
				try {
					//Array erstellen
					
					rs = db_zugriff.db_select("SELECT COUNT(*) FROM versicherungscheck.auto;");
					while (rs.next())
						zeilenzahl = rs.getInt(1);
					result = new String[zeilenzahl][spaltenzahl];
				
					//Array füllen
					
					rs = db_zugriff.db_select("CALL fahrzeug_abfrage();");
					int i = 0;
					while(rs.next()) {
						for (int j = 0; j < spaltenzahl; j ++) {
							result[i][j] = rs.getString(j+1);
						}
						i++;
					}	
				} catch (SQLException e1) {
					JOptionPane.showMessageDialog(null, "Fehler bei Abfrage", "Fehler", JOptionPane.ERROR_MESSAGE);
				}
					
				//Tabelle erstellen und anzeigen
				
				erg = new MyTable(result, new String[] {"ID", "Modell", "Leistung", "Hubraum", "Kraftstoff", "Name", "Vorname"}, "auto");
				tab.add(new MyScrollPane(erg));
				validate();
				
				
			} else if ((e.getSource() == edit && erg.type == "halter") || e.getSource() == zeige_halter) {
				
				// ________________________________________ Halter Datensatz anzeigen/bearbeiten ________________________________________
				
				String id;
				if (e.getSource() == zeige_halter) {
					id = id_halter;
				} else {
					id = (String)erg.getValueAt(erg.getSelectedRow(), 0);
				}
				
				rs = db_zugriff.db_select("SELECT * FROM versicherungscheck.halter WHERE id = " + id + ";");
				try {
					while(rs.next()) {
						t0.setText(rs.getString(1));
						t0.setEditable(false);
						t1.setText(rs.getString(2));
						t2.setText(rs.getString(3));
						t3.setText(rs.getString(4));
						t4.setText(rs.getString(5));
					}	
					
				} catch (SQLException e1) {
					JOptionPane.showMessageDialog(null, "Fehler beim Laden der Daten", "Fehler", JOptionPane.ERROR_MESSAGE);
				}
				title.setText("Details für ausgewählten Datensatz");
				l0.setText("ID");
				l1.setText("Name");
				l2.setText("Vorname");
				l3.setText("PLZ");
				l4.setText("eMail");
				
				tab.add(title);
				tab.add(l0);
				tab.add(l1);
				tab.add(l2);
				tab.add(l3);
				tab.add(l4);
				
				tab.add(t0);
				tab.add(t1);
				tab.add(t2);
				tab.add(t3);
				tab.add(t4);
				tab.add(save_halter);
				tab.add(del_halter);
				validate();
				
					
			} else if (e.getSource() == edit && erg.type == "auto") {
				
				// ________________________________________ Auto Datensatz anzeigen ________________________________________
				
				String kennz = (String)erg.getValueAt(erg.getSelectedRow(), 0);
				rs = db_zugriff.db_select("CALL fahrzeug_abfr_kennz('" + kennz + "');");
				try {
					while(rs.next()) {
						t0.setText(rs.getString(1));
						t0.setEditable(false);
						t1.setText(rs.getString(2));
						t2.setText(rs.getString(3));
						t3.setText(rs.getString(4));
						t4.setText(rs.getString(5));
						t5.setText(rs.getString(6));
						t6.setText(rs.getString(7));
						t7.setText(rs.getString(8));
						t8.setText(rs.getString(9));
						t9.setText(rs.getString(10));
						t10.setText(rs.getString(11));
						t11.setText(rs.getString(12));
						t12.setText(rs.getString(13));
						id_halter = rs.getString(14);
					}	
					
				} catch (SQLException e1) {
					JOptionPane.showMessageDialog(null, "Fehler beim Laden der Daten", "Fehler", JOptionPane.ERROR_MESSAGE);
				}
				title.setText("Details für ausgewählten Datensatz");
				l0.setText("ID");
				l1.setText("Modell");
				l2.setText("Leistung");
				l3.setText("Hubraum");
				l4.setText("Kraftstoff");
				l5.setText("Situation");
				l6.setText("Erstzulassung");
				l7.setText("Finanzierung");
				l8.setText("Kennzeichen Art");
				l9.setText("Zul. auf Halter");
				l10.setText("Vers.-beginn");
				l11.setText("Name");
				l12.setText("Vorname");
				
				tab.add(title);
				tab.add(l0);
				tab.add(l1);
				tab.add(l2);
				tab.add(l3);
				tab.add(l4);
				tab.add(l5);
				tab.add(l6);
				tab.add(l7);
				tab.add(l8);
				tab.add(l9);
				tab.add(l10);
				tab.add(l11);
				tab.add(l12);
				
				tab.add(t0);
				tab.add(t1);
				tab.add(t2);
				tab.add(t3);
				tab.add(t4);
				tab.add(t5);
				tab.add(t6);
				tab.add(t7);
				tab.add(t8);
				tab.add(t9);
				tab.add(t10);
				tab.add(t11);
				tab.add(t12);
				tab.add(zeige_halter);
				tab.add(del_auto);
				validate();
				
				
			} else if (e.getSource() == add_halter) {
				
				// ________________________________________ Halter hinzufügen ________________________________________
				
				title.setText("Bitte Daten eingeben");
				l0.setText("ID");
				l1.setText("Name");
				l2.setText("Vorname");
				l3.setText("PLZ");
				l4.setText("eMail");
				
				t0.setText("(systembedingt)");
				t0.setEditable(false);
				t1.setText("");
				t2.setText("");
				t3.setText("");
				t4.setText("");
				
				tab.add(title);
				tab.add(l0);
				tab.add(l1);
				tab.add(l2);
				tab.add(l3);
				tab.add(l4);
				
				tab.add(t0);
				tab.add(t1);
				tab.add(t2);
				tab.add(t3);
				tab.add(t4);
				tab.add(save_halter);
				validate();
			
				
			} else if (e.getSource() == bye) {
				
				// ________________________________________ Abmelden ________________________________________
				
				db_zugriff.db_logout();
				dispose();
			}
		}
	}
	
	
	public void run() {
		maklersicht mak = new maklersicht();
		mak.setSize(1000, 500);
		mak.setResizable(false);
		mak.setLocationRelativeTo(null);
		mak.setVisible(true);
		mak.setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);
	}
}
