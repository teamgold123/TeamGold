import java.awt.*;
import java.awt.event.*;
import java.sql.*;
import javax.swing.*;


public class Login extends JFrame implements Runnable {
	//Komponenten des Login-Fensters
	MyButton ok, cancel;
	MyTextField user;
	JPasswordField pw;
	
	
	//Konstruktor
	public Login () {
		super("Login");
		//Komponenten des Login-Fensters
		JLabel benutzername = new JLabel("Benutzername: ");
		benutzername.setFont(konst.myFont);
		benutzername.setBounds(30, 20, 150, 30);
		
		JLabel passwort = new JLabel("Passwort: ");
		passwort.setFont(konst.myFont);
		passwort.setBounds(30, 65, 150, 30);
		
		user = new MyTextField(15);
		user.setBounds(185, 20, 140, 30);
		
		pw = new JPasswordField(15);
		pw.setActionCommand("enter_pressed");
		pw.addActionListener(new LoginButtonListener());
		pw.setBounds(185, 65, 140, 30);
		
		ok = new MyButton("OK");
		ok.addActionListener(new LoginButtonListener());
		ok.setBounds(30, 110, 120, 40);
		
		cancel = new MyButton("Abbrechen");
		cancel.addActionListener(new LoginButtonListener());
		cancel.setBounds(210, 110, 120, 40);
		
		//Layout des Login-Fensters
		Container c = getContentPane();
		c.setLayout(null);
		c.add(benutzername);
		c.add(user);
		c.add(passwort);
		c.add(pw);
		c.add(ok);
		c.add(cancel);
	}
	
	public class LoginButtonListener implements ActionListener {
		public void actionPerformed(ActionEvent e) {
			// TODO Auto-generated method stub
			if (e.getSource() == ok || e.getActionCommand() == "enter_pressed") {
				try {
					db_zugriff.db_login(user.getText(), pw.getText());
					Thread makler = new Thread(new maklersicht());
					makler.start();
					dispose();
				}
				catch (Exception ex) {
					JOptionPane.showMessageDialog(null, "Benutzername und/oder Passwort falsch!", "Fehler", JOptionPane.ERROR_MESSAGE);
					pw.setText("");
				}
			} else if (e.getSource() == cancel) {
				dispose();
			}
		}
	}

	
	public void run() {
		// TODO Auto-generated method stub
		Login log = new Login();
		log.setSize(365, 215);
		log.setResizable(false);
		log.setLocationRelativeTo(null);
		log.setVisible(true);
		log.setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);
	}
}
