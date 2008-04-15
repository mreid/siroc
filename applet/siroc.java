import processing.core.*; import geomerative.*; import java.util.ArrayList; import java.applet.*; import java.awt.*; import java.awt.image.*; import java.awt.event.*; import java.io.*; import java.net.*; import java.text.*; import java.util.*; import java.util.zip.*; import javax.sound.midi.*; import javax.sound.midi.spi.*; import javax.sound.sampled.*; import javax.sound.sampled.spi.*; import java.util.regex.*; import javax.xml.parsers.*; import javax.xml.transform.*; import javax.xml.transform.dom.*; import javax.xml.transform.sax.*; import javax.xml.transform.stream.*; import org.xml.sax.*; import org.xml.sax.ext.*; import org.xml.sax.helpers.*; public class siroc extends PApplet {/**
 * Visualisation of the relationship between Statistical Information
 * and ROC curves.
 */


RShape s;
GraphArea area = new GraphArea();

public void setup(){
  size(400,400);
  frameRate(20);
  background(255);
  fill(0);
  //noFill();
  stroke(255,0,0);

  OpCurve roc = new OpCurve();
  roc.add(0.6f, 0.8f);

  area.setView(10,10,300,300);
  area.add(roc);
}

public void draw(){
//  scale(200.0);
//  strokeWeight(1/200.0);
//  translate(200,50);
  background(255);
  
  smooth();

  area.draw(g);
  
  if(area.active()) {
    area.showCursor();
  }

/*  
  for(int si=0 ; si < s.countSubshapes() ; si++) {
    RSubshape ss = s.subshapes[si];
    for(int i=0 ; i < 100; i++) {
     float t = i/100.0;
     RPoint v = ss.getCurvePoint(t);
     RPoint tgnt = ss.getCurveTangent(t);
     tgnt.normalize();
     tgnt.scale(20);
     stroke(0);
     point(v.x, v.y);
     stroke(255,0,0);
     line(v.x, v.y, v.x + tgnt.y, v.y - tgnt.x);
    }
  }
*/
}

class GraphArea {

  OpCurve[] curves = new OpCurve[10];
  int curveCount = 0;
  
  int pixWidth, pixHeight;
  int vxStart, vyStart;
  int vxEnd, vyEnd;
  float xStart, xEnd;
  float yStart, yEnd;
  
  GraphArea() {
    vxStart = 0; vyStart = 0;
    vxEnd = 100; vyEnd = 100;
    
    xStart = 0.0f; yStart = 0.0f;
    xEnd   = 1.0f; yEnd   = 1.0f;    
  }
  
  public void add(OpCurve curve) {
    curves[curveCount++] = curve; 
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
  
  public float viewToModelX(float vx) { return xRange() * (vx - vxStart) / viewWidth(); }
  public float viewToModelY(float vy) { return yRange() * (vy - vyStart) / viewHeight(); }
  
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
     noFill();
     stroke(0);
//     rect(vxStart,vyStart,viewWidth(),viewHeight());
     
     pushMatrix();
     translate(-xStart, -yStart);
     scale(viewWidth()/xRange(),-viewHeight()/yRange());
     translate(0,-yEnd);
     strokeWeight(xRange()/viewWidth());

     // Axes
     line(xStart, yStart, xRange(), yRange());

     for(int i = 0 ; i < curveCount ; i++) {
      curves[i].draw(g);       
     }
     popMatrix();
   }
}



class OpCurve {
  ArrayList points = new ArrayList();
  RContour curve = new RContour();
  
  OpCurve() {
    curve.addPoint(0.0f, 0.0f);
    curve.addPoint(1.0f, 1.0f);
  }
  
  // Add a new ROC point to this curve
  public void add(float newfpr, float newtpr) {
    curve.addPoint(newfpr, newtpr);
  }

  public void draw(PGraphics g) {
    curve.draw(g);
  }  
}


  static public void main(String args[]) {     PApplet.main(new String[] { "siroc" });  }}