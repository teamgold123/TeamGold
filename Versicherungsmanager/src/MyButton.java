import java.awt.Color;
import java.awt.Cursor;
import java.awt.Dimension;
import java.awt.Toolkit;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

import javax.swing.ImageIcon;
import javax.swing.JButton;

public class MyButton extends JButton {
	public MyButton(String text) {
		setText(text);
		setBackground(konst.myColororange);
		setForeground(Color.BLACK);
		setFont(konst.myFont4);
		setCursor(Cursor.getPredefinedCursor(Cursor.HAND_CURSOR));
		addActionListener(new ButtonListener());
	}	
	
}
