import processing.core.*; import geomerative.*; import name.reid.mark.geovex.*; import java.util.Vector; import java.applet.*; import java.awt.*; import java.awt.image.*; import java.awt.event.*; import java.io.*; import java.net.*; import java.text.*; import java.util.*; import java.util.zip.*; import javax.sound.midi.*; import javax.sound.midi.spi.*; import javax.sound.sampled.*; import javax.sound.sampled.spi.*; import java.util.regex.*; import javax.xml.parsers.*; import javax.xml.transform.*; import javax.xml.transform.dom.*; import javax.xml.transform.sax.*; import javax.xml.transform.stream.*; import org.xml.sax.*; import org.xml.sax.ext.*; import org.xml.sax.helpers.*; public class siroc extends PApplet {/**
 * Visualisation of the relationship between Statistical Information
 * and ROC curves.
 */



PlotView rocView = new PlotView(0.0f, 0.0f, 1.0f, 1.0f);
PlotView siView  = new PlotView(0.0f, 0.0f, 1.0f, 0.25f);

Converter sirocConvert = new SIROCConverter();
Converter rocsiConvert = new ROCSIConverter();

SpecPoint siCursor = new SpecPoint(0.0f, 0.0f);

public void setup(){
  size(700,400,P3D);
  frameRate(20);
  background(255);
  fill(0);
  //noFill();
  stroke(255,0,0);

  siView.setView(10, 10, 300, 300);
  rocView.setView(310, 10, 610, 300);

  SpecCurve siTent = new SpecCurve();
  siTent.add(0.0f, 0.0f);
  siTent.add(0.5f, 0.25f);
  siTent.add(1.0f, 0.0f);

  SpecCurve si = new SpecCurve();
  si.add(0.0f, 0.0f);
  si.add(0.25f, 0.125f);
  si.add(0.5f, 0.15f);
  si.add(0.75f, 0.125f);
  si.add(1.0f, 0.0f);

  siView.add(siTent);
  siView.add(si);

  rocView.add(sirocConvert.toCurve(siTent));
  rocView.add(sirocConvert.toCurve(si));

  siView.add(siCursor);
  rocView.add(new DualLine(siCursor, sirocConvert));
}


public void draw(){
  background(255);
  
  siView.draw(g);
  rocView.draw(g);

  if(siView.active()) {
    siCursor.setX(siView.viewToModelX(mouseX));
    siCursor.setY(siView.viewToModelY(mouseY));
  }
}



class PlotView {

  Vector curves = new Vector();
  Vector points = new Vector();
  Vector lines  = new Vector();
  
  int vxStart, vyStart;
  int vxEnd, vyEnd;
  float xStart, xEnd;
  float yStart, yEnd;
  
  GBounds bounds;
  
  PlotView(
    int vx0, int vy0, int vx1, int vy1,
    float x0, float y0, float x1, float y1
  ) {
    vxStart = vx0; vyStart = vy0; vxEnd = vx1; vyEnd = vy1;
    xStart = x0; yStart = y0; xEnd = x1; yEnd = y1;
    bounds = new GBounds(xStart, yStart, xEnd, yEnd);
  }

  PlotView(float x0, float y0, float x1, float y1) {
   this(0, 0, 100, 100, x0, y0, x1, y1); 
  }
  
  PlotView() {
    this(0.0f, 0.0f, 1.0f, 1.0f);
  }
  
  public void add(GCurve curve) {
    curves.add(curve); 
  }

  public void add(GPoint point) {
    points.add(point);  
  }
  
  public void add(GLine line) {
     lines.add(line); 
  }
  
  public void setViewStart(int vx, int vy) { vxStart = vx; vyStart = vy; }
  public void setViewEnd(int vx, int vy) { vxEnd = vx; vyEnd = vy; }
  public void setView(int vx0, int vy0, int vx1, int vy1) { 
    setViewStart(vx0, vy0); 
    setViewEnd(vx1, vy1); 
  }
  
  public int viewWidth() { return vxEnd - vxStart; }
  public int viewHeight() { return vyEnd - vyStart; }
  
  public float xRange() { return xEnd - xStart; }
  public float yRange() { return yEnd - yStart; }
  
  public float viewToModelX(float vx) { return xStart + xRange() * (vx - vxStart) / viewWidth(); }
  public float viewToModelY(float vy) { return yStart - yRange() * (vy - vyEnd) / viewHeight(); }
  
   public boolean active() {
     return (mouseX > vxStart && mouseX < vxEnd && mouseY > vyStart && mouseY < vyEnd);
   }
  
   public void showCursor() {
    /*
     RShape c = new RShape();
     c.addMoveTo(viewToModelX(mouseX), 0.0);
     c.addLineTo(viewToModelX(mouseX), 1.0);
     display(c, g);
    */
   }
  
   public void draw(PGraphics g) {
     
     pushMatrix();
     
     // Set up viewing transformations
     translate(vxStart, vyStart);
     translate(-xStart, -yStart);
     scale(viewWidth()/xRange(),-viewHeight()/yRange());
     translate(0,-yEnd);

     // Outline
     noFill();
     stroke(200);
     rect(xStart,yStart,xRange(),yRange());

     // Curves
     for(int i = 0 ; i < curves.size() ; i++) {
       stroke(0);
       viewCurve((GCurve) curves.get(i)).draw(g);
     }
     
     // Points
     for(int i = 0 ; i < points.size() ; i++) {
       stroke(200,0,0);
       viewPoint((GPoint) points.get(i));
     }
     
     // Lines
     for(int i = 0 ; i < lines.size() ; i++) {
       stroke(200,0,0);
       viewLine((GLine) lines.get(i)).draw(g);
     }
     
     popMatrix();
   }
   
   public RContour viewCurve(GCurve curve) {
     RContour c = new RContour();
     for(int i = 0 ; i < curve.size() ; i++) {
       GPoint p = curve.getPoint(i);
       c.addPoint(p.getX(), p.getY()); 
     }
     
     return c;
   }
   
   public void viewPoint(GPoint point) {
     point(point.getX(), point.getY());
   }
   
   public RContour viewLine(GLine line) {
     GSegment s = bounds.clip(line);
     RContour l = new RContour();
     l.addPoint(s.start.getX(), s.start.getY());
     l.addPoint(s.end.getX(), s.end.getY());
//     l.addPoint(0.0, line.atX(0.0));
//     l.addPoint(1.0, line.atX(1.0));
     return l;
   }
}

  static public void main(String args[]) {     PApplet.main(new String[] { "siroc" });  }}