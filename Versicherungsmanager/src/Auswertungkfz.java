import java.awt.image.BufferedImage;
import java.awt.image.Raster;
import java.io.File;
import java.io.IOException;
import java.util.ArrayList;

import javax.imageio.ImageIO;

public class Auswertungkfz {

   // Schwelle ist unterschiedlich, kommt auf die Farbkodierung an
   private static int S_W_Schwelle = 100;

   private static int number =0;
   
 
   public static int auswerten(String bild) {
      try {
    	  
    	  number= 0;

         // 1. Nimm screenshot
         BufferedImage screenshot = ImageIO.read(new File(bild));

         
         
         // 2. Berechne segmente der zahlen
         ArrayList<Integer> list = calcSegments(screenshot);

         
         BufferedImage screenshot_sub = new BufferedImage(screenshot.getWidth(),screenshot.getHeight(),screenshot.getType());
         for (int listindex =0; listindex< list.size()-1; listindex++) {
	        
        	//System.out.println(" pos: "+list.get(listindex) );
        	 
        	 screenshot_sub = screenshot.getSubimage(list.get(listindex), 0, (list.get(listindex+1) - list.get(listindex)), screenshot.getHeight());
	
	         // 3. Zuschneiden auf die Grenten der Zahl
        	 screenshot_sub = cutToEdges(screenshot_sub);
	
	         // 4. Vergleichen und Prozent ausrechnen
	         for (int i = 1; i <= 4; i++) {
	            BufferedImage template = ImageIO.read(new File(
	                  "C:\\Users\\Johannes\\Desktop\\Techniker\\PRG\\eclipse\\eclipsprojekte\\Projekt\\Gui\\Zahlen\\" + i + ".png"));
	
	            
	            int percentage = compareWithPercentage(template, screenshot_sub);
	            //System.out.println("Prozent: " +percentage);
	            
	            if (percentage > 75) {
	              System.out.println("Found number. Number is " + i);
	               number = number + (int)( i*Math.pow(10,list.size()-1-listindex-1));
	              //System.out.println("--> "+number +" pow: "+(list.size()-1-listindex));
	               //break;
	            }
	         }
         }
         System.out.println("number in screenshot is: "+number);

      } catch (Exception e) {
         System.err.println("Fehler : " + e);
         e.printStackTrace();
      }
      return number;
   }

   private static BufferedImage cutToEdges(BufferedImage img) throws IOException {

      int bottom = 0;
      int top = img.getHeight();

      int right = 0;
      int left = img.getWidth();

      Raster raster = img.getRaster();

      // Grenzen ermitteln
      for (int y = 0; y < img.getHeight(); y++) {
         for (int x = 0; x < img.getWidth(); x++) {

            int[] rgb = new int[3];
            raster.getPixel(x, y, rgb);

            if (rgb[0] < S_W_Schwelle) {
               if (x < left) {
                  left = x;
               }
               if (x > right) {
                  right = x;
               }

               if (y < top) {
                  top = y;
               }

               if (y > bottom) {
                  bottom = y;
               }
            }
         }
      }

      // Unterbild extrahieren mit den neuen Grenzen
      img = img.getSubimage(left, top, right - left, bottom - top);
      //ImageIO.write(img, "png", new File("C:\\Users\\Johannes\\Desktop\\Techniker\\PRG\\eclipse\\eclipsprojekte\\Projekt\\Gui\\hallo.png"));

      return img;
   }

   private static int compareWithPercentage(BufferedImage template,
         BufferedImage screenshot) {

      int completepixel = template.getWidth() * template.getHeight();
      int matches = 0;
      Raster tempRaster = template.getRaster();
      Raster screenRaster = screenshot.getRaster();
      try {
         for (int y = 0; y < template.getHeight(); y++) {
            for (int x = 0; x < template.getWidth(); x++) {

               int[] temp_rgb = new int[3];
               int[] screen_rgb = new int[3];

               tempRaster.getPixel(x, y, temp_rgb);
               screenRaster.getPixel(x, y, screen_rgb);

               // Schwelle setzen
               if (temp_rgb[0] < S_W_Schwelle) {
                  temp_rgb[0] = 0;
               } else {
                  temp_rgb[0] = 15;
               }

               if (screen_rgb[0] < S_W_Schwelle) {
                  screen_rgb[0] = 0;
               } else {
                  screen_rgb[0] = 15;
               }

               // Hier stimmt was überein
               if (temp_rgb[0] == screen_rgb[0]) {
                  matches++;
               }
            }
         }
      } catch (Exception e) {
         // Wenn hier fehler auftreten ignoriere sie erstmal
         // die 2-5% differenz in unterschiedlichen
         // Bildmaßen machen hier keinen Unterschied
      }

      // gibt die prozentuale Übereinstimmung zurück
      return (100 * matches / completepixel);
   }
   
   
   public static ArrayList<Integer> calcSegments(BufferedImage image) {
	   
	   ArrayList<Integer> list = new ArrayList<Integer>();
	   Raster raster = image.getRaster();
	   boolean segmentline= true;
	   int count =0;
	   int temp =0;
	   for (int x = 0; x < image.getWidth(); x++) {
		   segmentline = true;
		  
		   for (int y = 0; y < image.getHeight(); y++) {
          
			   int[] rgb = new int[5];
        	   raster.getPixel(x, y, rgb);
        	   //System.out.println("rgb in screenshot is: "+rgb[0]);
        	   if (rgb[0] < S_W_Schwelle) {
        		   segmentline = false;
        	   }
        	   
        	   
           }

		   if (segmentline)  {
			  
			   if (count == 1) {
				   list.add(x);
			   }
			   count++;
		   } else {
			   count =0;
		   }
		   
	   }
	  
	  return list; 
   }
   

}