import java.awt.Font;

import javax.swing.*;

public class MyTextField extends JTextField {
	public MyTextField (int laenge) {
		super(laenge);
		this.setFont(konst.myFont2);
	}
	
	public MyTextField(int x, int y, int breite, int hoehe) {
		super();
		this.setBounds(x, y, breite, hoehe);
	}

}
