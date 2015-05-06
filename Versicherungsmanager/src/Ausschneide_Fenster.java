import java.awt.Image;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.io.IOException;

import javax.swing.JButton;
import javax.swing.JFrame;

import com.jgoodies.forms.layout.CellConstraints;
import com.jgoodies.forms.layout.FormLayout;

public class Ausschneide_Fenster extends JFrame {

    private static Ausschneide_Fenster mainFrame = null;
    private final DragPanel dp = new DragPanel(); 
    private static String ausschnitt_kfz;
    
    private Ausschneide_Fenster(String schein) {
        setTitle("KFZ-Schein zuschneiden");
        setDefaultCloseOperation(DISPOSE_ON_CLOSE);
        getContentPane().setLayout(new FormLayout("7px,f:m:g,7px","7px,f:m:g,7px,f:p,7px"));
        setExtendedState(MAXIMIZED_BOTH);
        CellConstraints cc = new CellConstraints();
        
        dp.setImage(schein);
        add(dp,cc.xy(2,2));
        JButton button = new JButton("Ausschneiden");
        button.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent arg0) {
                try {
					dp.chop();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
                dispose();
            }
        });
        add(button,cc.xy(2,4,"r,b"));
        add(button,cc.xy(2,4,"r,b"));
        setVisible(true);
    }
    
    public static String get(String schein) {
        mainFrame = new Ausschneide_Fenster(schein);
        return ausschnitt_kfz;
    }
}