import processing.core.*; import geomerative.*; import name.reid.mark.geovex.*; import java.applet.*; import java.awt.*; import java.awt.image.*; import java.awt.event.*; import java.io.*; import java.net.*; import java.text.*; import java.util.*; import java.util.zip.*; import javax.sound.midi.*; import javax.sound.midi.spi.*; import javax.sound.sampled.*; import javax.sound.sampled.spi.*; import java.util.regex.*; import javax.xml.parsers.*; import javax.xml.transform.*; import javax.xml.transform.dom.*; import javax.xml.transform.sax.*; import javax.xml.transform.stream.*; import org.xml.sax.*; import org.xml.sax.ext.*; import org.xml.sax.helpers.*; public class siroc extends PApplet {/**
 * Visualisation of the relationship between Statistical Information
 * and ROC curves.
 */



PlotView rocView = new PlotView(0.0f, 0.0f, 1.0f, 1.0f);
PlotView siView  = new PlotView(0.0f, 0.0f, 1.0f, 0.25f);

Converter convert = new Converter();

public void setup(){
  size(700,400,P3D);
  frameRate(20);
  background(255);
  fill(0);
  //noFill();
  stroke(255,0,0);

  siView.setView(10, 10, 300, 300);
  rocView.setView(310, 10, 610, 300);

  GVCurve siTent = new GVCurve();
  siTent.add(0.0f, 0.0f);
  siTent.add(0.5f, 0.25f);
  siTent.add(1.0f, 0.0f);

  GVCurve si = new GVCurve();
  si.add(0.0f, 0.0f);
  si.add(0.25f, 0.125f);
  si.add(0.5f, 0.15f);
  si.add(0.75f, 0.125f);
  si.add(1.0f, 0.0f);

  siView.add(siTent);
  siView.add(si);

  rocView.add(convert.toROCCurve(siTent));
  rocView.add(convert.toROCCurve(si));

}


public void draw(){
//  scale(200.0);
//  strokeWeight(1/200.0);
//  translate(200,50);
  background(255);
  
//  smooth();

  siView.draw(g);
  rocView.draw(g);
  
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

class PlotView {

  GVCurve[] curves = new GVCurve[10];
  Converter convert = new Converter();
  int curveCount = 0;
  
  int vxStart, vyStart;
  int vxEnd, vyEnd;
  float xStart, xEnd;
  float yStart, yEnd;
  
  PlotView(
    int vx0, int vy0, int vx1, int vy1,
    float x0, float y0, float x1, float y1
  ) {
    vxStart = vx0; vyStart = vy0; vxEnd = vx1; vyEnd = vy1;
    xStart = x0; yStart = y0; xEnd = x1; yEnd = y1;
  }

  PlotView(float x0, float y0, float x1, float y1) {
   this(0, 0, 100, 100, x0, y0, x1, y1); 
  }
  
  PlotView() {
    this(0.0f, 0.0f, 1.0f, 1.0f);
  }
  
  public void add(GVCurve curve) {
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
     
     pushMatrix();
     
     // Set up viewing transformations
     translate(vxStart, vyStart);
     translate(-xStart, -yStart);
     scale(viewWidth()/xRange(),-viewHeight()/yRange());
     translate(0,-yEnd);

//    strokeWeight(0.5*min(xRange()/viewWidth(), yRange()/viewHeight()));

     // Outline
     noFill();
     stroke(200);
     rect(xStart,yStart,xRange(),yRange());


     for(int i = 0 ; i < curveCount ; i++) {
       stroke(0);
       view(curves[i]).draw(g);
     }
     popMatrix();
   }
   
   public RContour view(GVCurve curve) {
     RContour c = new RContour();
//     c.addPoint(0.0, 0.0);
     for(int i = 0 ; i < curve.size() ; i++) {
       GVPoint p = curve.getPoint(i);
       c.addPoint(p.x, p.y); 
     }
//     c.addPoint(1.0, 0.0);
     
     return c;
   }
}

  static public void main(String args[]) {     PApplet.main(new String[] { "siroc" });  }}