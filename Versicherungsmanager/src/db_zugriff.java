import java.sql.*;

import javax.swing.JOptionPane;

public class db_zugriff {
	//Komponenten der DB-Klasse
	public static Connection con;
	
	
	//Methode zum Einloggen
	//Username und Passwort müssen übergeben werden
	public static void db_login (String username, String pwd) throws Exception {
		con = DriverManager.getConnection("jdbc:mysql://Niki_NB:3306/versicherungscheck", username, pwd);
		//JOptionPane.showMessageDialog(null, "Verbindung erfolgreich", "OK", JOptionPane.INFORMATION_MESSAGE);
	}
	
	
	//Methode zum Ausloggen
	public static void db_logout () {
		try {
			con.close();
			//JOptionPane.showMessageDialog(null, "Verbindung getrennt", "OK", JOptionPane.INFORMATION_MESSAGE);
		} catch (Exception ex) {
			JOptionPane.showMessageDialog(null, ex.toString(), "Fehler beim Trennen", JOptionPane.ERROR_MESSAGE);
		}
	}
	
	
	//Methode für Einfügen/Löschen/...
	//SQL-String muss übergeben werden
	public static void db_update (String sql) {
		try {
			Statement stm = con.createStatement();
			stm.executeUpdate(sql);
			stm.close();
		} catch (Exception ex) {
			//ex.printStackTrace();
			JOptionPane.showMessageDialog(null, ex.toString(), "Fehler bei Update", JOptionPane.ERROR_MESSAGE);
		}
	}
	
	
	//Methode für Abfragen
	//SQL-String muss übergeben werden/ResultSet wird zurückgegeben
	public static ResultSet db_select (String sql) {
		ResultSet rs = null;
		try {
			Statement stm = con.createStatement();
			rs = stm.executeQuery(sql);
			//stm.close();
		} catch (Exception ex) {
			JOptionPane.showMessageDialog(null, ex.toString(), "Fehler bei Select", JOptionPane.ERROR_MESSAGE);
		}
		return rs;
	}
}
