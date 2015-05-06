import javax.swing.*;
import javax.swing.event.*;


public class MyTable extends JTable {
	public String type;
	
	public MyTable (Object[][] data, String [] head, String type) {
		super(data, head);
		this.type = type;
		this.setRowHeight(20);
		this.getTableHeader().setReorderingAllowed(false);
		this.setAutoResizeMode(JTable.AUTO_RESIZE_OFF);
		
		if (type == "halter") {
			//Spaltenbreite anpassen für Halterabfrage
			this.getColumnModel().getColumn(0).setPreferredWidth(40);
			this.getColumnModel().getColumn(1).setPreferredWidth(175);
			this.getColumnModel().getColumn(2).setPreferredWidth(175);
			this.getColumnModel().getColumn(3).setPreferredWidth(175);
			this.getColumnModel().getColumn(4).setPreferredWidth(175);
		} else if (type == "auto") {
			//Spaltenbreite anpassen für Autoabfrage
			this.getColumnModel().getColumn(0).setPreferredWidth(60);
			this.getColumnModel().getColumn(1).setPreferredWidth(180);
			this.getColumnModel().getColumn(2).setPreferredWidth(120);
			this.getColumnModel().getColumn(3).setPreferredWidth(80);
			this.getColumnModel().getColumn(4).setPreferredWidth(80);
			this.getColumnModel().getColumn(5).setPreferredWidth(110);
			this.getColumnModel().getColumn(6).setPreferredWidth(110);
		}
		
		
		
		
		this.getSelectionModel().addListSelectionListener(new ListSelectionListener(){
			public void valueChanged(ListSelectionEvent e){
		         maklersicht.edit.setEnabled(true); 
			}
		});
	}
}
