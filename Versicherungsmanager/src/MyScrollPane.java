import java.awt.*;
import javax.swing.*;


public class MyScrollPane extends JScrollPane {
	public MyScrollPane (JTable tab) {
		super(tab);
		//this.setPreferredSize(new Dimension(770, 460));
		this.setBounds(5, 5, 760, 460);
	}
}
