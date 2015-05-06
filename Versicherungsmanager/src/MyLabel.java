import java.awt.Font;

import javax.swing.*;

public class MyLabel extends JLabel {
	public MyLabel (String text) {
		super(text);
		this.setFont(konst.myFont2);
	}
	
	public MyLabel (String text, int x, int y, int breite, int hoehe) {
		super(text);
		this.setBounds(x, y, breite, hoehe);
	}

}
