import java.awt.Color;
import java.awt.Dimension;
import java.awt.Graphics;
import java.awt.Image;
import java.awt.Point;
import java.awt.Rectangle;
import java.awt.event.MouseEvent;
import java.awt.event.MouseListener;
import java.awt.event.MouseMotionListener;
import java.awt.image.BufferedImage;
import java.awt.image.CropImageFilter;
import java.awt.image.FilteredImageSource;
import java.awt.image.ImageFilter;
import java.awt.image.RenderedImage;
import java.io.File;
import java.io.IOException;

import javax.imageio.ImageIO;
import javax.swing.ImageIcon;
import javax.swing.JPanel;

public class DragPanel extends JPanel {
    private static final long serialVersionUID = 1L;
    private Rectangle rect;
    private Image image;
    private int image_left=0;
    private int image_top=0;
    
    public DragPanel() {
        super(null);
        MouseHandler handler = new MouseHandler();
        addMouseListener(handler);
        addMouseMotionListener(handler);
        setOpaque(false);
    }
    
    public void setImage( String path ) {
        image = new ImageIcon(path).getImage();
        
        repaint();
    }

    public void setImage( Image image ) {
        this.image=image;
        	
        repaint();
    }

    public void paintComponent(Graphics g) {
        super.paintComponent(g);
        g.setColor( Color.white );
        Dimension d = getSize();
        g.fillRect( 0, 0, d.width, d.height );
        if ( image != null ) {
            image_left = (d.width-image.getWidth(null))/2;
            image_top = (d.height-image.getHeight(null))/2;
            g.drawImage(image,image_left,image_top,null);
        }
        if ((rect!=null) && (rect.width>1) && (rect.height>1)) {
            g.setColor(new Color(0xA0000052));
            g.drawRect(rect.x,rect.y,rect.width,rect.height);
        }
    }
    
    private class MouseHandler implements MouseListener, MouseMotionListener {
        private boolean dragRectangle = false;
        private Point lastPoint;
        
        public void mousePressed(MouseEvent e) {
            // there is already a rectangle
            if(rect != null) {
                // we want to drag this one
                if(rect.contains(e.getPoint())) {
                    dragRectangle = true;
                    return;
                // we're not going to drag it
                } else {
                    dragRectangle = false;
                    rect = null;
                }
            }
            // by now there won't be a rectangle
            lastPoint = e.getPoint();
            rect = new Rectangle(lastPoint.x, lastPoint.y, 1, 1);
            repaint();
        }
        
        public void mouseDragged(MouseEvent e) {
            Point currentPoint = e.getPoint();
            // dragging?
            if(dragRectangle) {
                rect.x += currentPoint.x - lastPoint.x;
                rect.y += currentPoint.y - lastPoint.y;
            } else {
                // Ok, we're changing its size
                rect.width = currentPoint.x - rect.x;
                rect.height = currentPoint.y - rect.y;
                
                // the above code might introduce troubles
                if(rect.width < 0) {
                    rect.x = rect.x + rect.width;
                    rect.width = -rect.width;
                }
                if(rect.height < 0) {
                    rect.y = rect.y + rect.height;
                    rect.height = -rect.height;
                }
            }
            // store point
            lastPoint = currentPoint;
            repaint();
        }

        public void mouseClicked(MouseEvent arg0) {}
        public void mouseReleased(MouseEvent arg0) {}
        public void mouseEntered(MouseEvent arg0) {}
        public void mouseExited(MouseEvent arg0) {}
        public void mouseMoved(MouseEvent arg0) {}
    }

    public void chop() throws IOException {
        // Wenn der Rahmen auserhalb des Bildes beginnt abschneiden
        if (rect.x<image_left) { rect.width-=image_left-rect.x; rect.x=image_left; }
        if (rect.y<image_top) { rect.height-=image_top-rect.y; rect.y=image_top; }
        if (rect.width+rect.x>image_left+image.getWidth(null)) rect.width-=rect.width+rect.x-(image_left+image.getWidth(null));
        if (rect.height+rect.y>image_top+image.getHeight(null)) rect.height-=rect.height+rect.y-(image_top+image.getHeight(null));
        
        // Kopie des ausgewählten Bereichs erzeugen und als Image festlegen
        ImageFilter cropFilter = new CropImageFilter( rect.x-image_left, rect.y-image_top, rect.width, rect.height );
        setImage(createImage( new FilteredImageSource(image.getSource(),cropFilter)));
	

      
        
    }
}