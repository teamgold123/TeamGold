import java.awt.*;

import javax.swing.*;
import javax.swing.border.TitledBorder;

public class MyRadioButton extends JPanel{
	
	 JRadioButton rb[];
	
	public MyRadioButton(String[] item){
		super(new FlowLayout(FlowLayout.LEFT));
		rb = new JRadioButton[item.length];
		ButtonGroup bg = new ButtonGroup();
		setBackground(Color.WHITE);
		setCursor(Cursor.getPredefinedCursor(Cursor.HAND_CURSOR));

		
		for (int i=0; i<item.length; i++){
			rb[i] = new JRadioButton(item[i]);
			bg.add(rb[i]);
			this.add(rb[i]);
			rb[i].setBackground(Color.WHITE);
			rb[i].setFont(konst.myFont2);
		}
	}
	
	public String getSelected () {
		if (rb[0].isSelected()) 
			return "Fahrzeugwechsel";
		else if (rb[1].isSelected())
			return "Zweitwagen";
		else if (rb[2].isSelected())
			return "Erstvertrag";
		else if (rb[3].isSelected())
			return "Versicherungswechsel";
		return null;
	}
}


