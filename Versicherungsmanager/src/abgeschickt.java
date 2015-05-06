import java.awt.Color;
import java.awt.GridLayout;



import javax.swing.BorderFactory;
import javax.swing.JPanel;
import javax.swing.JTextArea;
import javax.swing.border.TitledBorder;





public class abgeschickt extends JPanel{

	JTextArea fertig;

	
	public abgeschickt(){
		
	super(null);
	
	
	fertig = new JTextArea("Vielen Dank! \n\nIhre Daten werden bearbeitet und Sie erhalten schnellst \nmöglich eine Email "
			+ "mit den Vertragsdaten \nund einem Kostenvoranschlag");
	fertig.setBounds(20, 200, 700, 400);
	fertig.setFont(konst.myFont);
	this.add(fertig);
	
	this.setBackground(Color.WHITE);
	
	}
}