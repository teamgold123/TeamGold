import java.awt.*;

import javax.swing.*;
import javax.swing.border.TitledBorder;

public class MyCheckBox extends JCheckBox{
	public MyCheckBox(JCheckBox name[], String[] item2){
	for(int i = 0; i < item2.length; i++){
	name[i] = new JCheckBox(item2[i]);
	}
	}
}
