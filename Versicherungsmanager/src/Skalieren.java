import java.awt.Image;
import java.awt.image.BufferedImage;
import java.awt.image.BufferedImageOp;
import java.awt.image.LookupOp;
import java.awt.image.ShortLookupTable;
import java.io.File;
import java.io.IOException;
 






import javax.imageio.ImageIO;
import javax.swing.ImageIcon;
import javax.swing.JOptionPane;
 
public class Skalieren {
	
	//Skalieren und zurückgeben
    public static String skalieren (String kfzschein, int breite, int hoehe) throws Exception {
   
    	BufferedImage img = ImageIO.read(new File(kfzschein));
        Image scaledImage = img.getScaledInstance(breite, hoehe,BufferedImage.SCALE_FAST);
        BufferedImage scaledBufferedImage = new BufferedImage(breite, hoehe, BufferedImage.TYPE_INT_RGB);
        scaledBufferedImage.getGraphics().drawImage(scaledImage, 0, 0, null);
            
    
        ImageIO.write(scaledBufferedImage, "png", new File("skaliert.png"));
 
		return kfzschein;
    }
    
    	 //Skalieren und in schwarz/weiß umwandeln, anschließend speichern
        public static void schneiden(String skalbild, String bildname, int xrichtung, int yrichtung, int breite, int hohe) {
            try {
                BufferedImage img = ImageIO.read(new File(skalbild));
     
                BufferedImage partImg = img.getSubimage(xrichtung, yrichtung, breite, hohe);
                
                BufferedImage scaledBufferedImage = new BufferedImage(breite, hohe, BufferedImage.TYPE_BYTE_BINARY);
                scaledBufferedImage.getGraphics().drawImage(partImg, 0, 0, null);
     
                ImageIO.write(scaledBufferedImage, "jpg", new File(bildname));
                
     
            } catch (IOException e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            }
        }
    }
