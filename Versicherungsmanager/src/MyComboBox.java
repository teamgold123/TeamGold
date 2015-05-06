import java.awt.*;
import java.awt.event.*;

import javax.swing.*;
import javax.swing.border.TitledBorder;

public class MyComboBox extends JComboBox{
	public MyComboBox(String[] items){
	for(int i = 0; i < items.length; i++){
	addItem(items[i]);
	}
	addItemListener(new BoxListener());
	setBackground(Color.WHITE);
	}
	

}

