import controlP5.*;
import geomerative.*;
import name.reid.mark.geovex.*;

/**
 * <p>
 * Visualisation of the relationship between Statistical Information
 * and ROC curves.
 * </p><p>
 * The left graph shows curves on a Statistical Information plot.
 * The right graph shows the same curves converted to an ROC representation
 * with ¹ = 0.5.
 * </p><p>
 * Move your mouse over the S.I. window to see the corresponding line in the
 * ROC graph and <i>vice versa</i>.
 * </p>
 * <p>
 * The duality relationships are computed using the 
 * <a href="http://gihub.com/mreid/geovex">geovex</a> Java library while the visualisation
 * is done with the standard Processing library and the 
 * <a href="http://www.ricardmarxer.com/processing/geomerative/documentation/">geomerative</a> 
 * library.
 * </p>
 */
PlotView rocView = new PlotView(0.0, 0.0, 1.0, 1.0);
PlotView siView  = new PlotView(0.0, 0.0, 1.0, 0.5);

SIROCConverter sirocConvert = new SIROCConverter();
ROCSIConverter rocsiConvert = new ROCSIConverter();

SpecPoint siCursor = new SpecPoint(0.0, 0.0);
SpecPoint rocCursor = new SpecPoint(0.0, 0.0);
GLine rocDualCursor = new DualLine(siCursor, sirocConvert);
GLine siDualCursor = new DualLine(rocCursor, rocsiConvert); 

PFont titleFont = createFont("Arial", 16);
PFont tickFont  = createFont("Arial", 12);

float prior = 0.5;

void setup(){
  size(700,400,JAVA2D);
  frameRate(20);
  background(255);

  siView.setView(30, 30, 300, 300);
  siView.setTitle("Stat. Info. (¹ = 0.5)");
  
  rocView.setView(360, 30, 300, 300);
  rocView.setTitle("ROC");

  SpecCurve siTent = new SpecCurve();
  siTent.add(0.0, 0.0);
  siTent.add(0.5, 0.25);
  siTent.add(1.0, 0.0);

  SpecCurve si = new SpecCurve();
  si.add(0.0, 0.0);
  si.add(0.25, 0.125);
  si.add(0.5, 0.15);
  si.add(0.75, 0.125);
  si.add(1.0, 0.0);

  color grey = color(160,160,160);
  color black = color(0,0,0);

  siView.add(siTent, grey);
  siView.add(si, black);

  rocView.add(sirocConvert.toCurve(siTent), grey);
  rocView.add(sirocConvert.toCurve(si), black);  

  // Controls for prior value
//  ControlP5 priorControl = new ControlP5(this);
//  Slider s = priorControl.addSlider("priorSlider", 0.0, 1.0, 0.5, 250, 350, 200, 20);

  smooth();
}

/*
void priorSlider(float value) {
  prior = value;
  sirocConvert.setPrior(prior);
  rocsiConvert.setPrior(prior);
}
*/

void draw(){
  // Clear the screen
  background(255);
  
  siView.draw(g);
  rocView.draw(g);

  if(siView.active()) {
    siCursor.setX(siView.viewToModelX(mouseX));
    siCursor.setY(siView.viewToModelY(mouseY));
    
    stroke(200,0,0);
    siView.drawPoint(siCursor);
    rocView.drawLine(rocDualCursor);
  }
  
  if(rocView.active()) {
    rocCursor.setX(rocView.viewToModelX(mouseX));
    rocCursor.setY(rocView.viewToModelY(mouseY)); 

    stroke(0,0,200);    
    rocView.drawPoint(rocCursor);
    siView.drawLine(siDualCursor);
  }
}
