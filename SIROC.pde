/**
 * <p>
 * Visualisation of the relationship between Statistical Information
 * and ROC curves.
 * </p><p>
 * The left graph shows two curves on a Statistical Information Graph.
 * The right graph shows the same curves converted to an ROC representation
 * with ¹ = 0.5.
 * </p><p>
 * Move your mouse over the S.I. graph to see the corresponding line in the
 * ROC graph.
 * </p>
 */
import geomerative.*;
import name.reid.mark.geovex.*;

PlotView rocView = new PlotView(0.0, 0.0, 1.0, 1.0);
PlotView siView  = new PlotView(0.0, 0.0, 1.0, 0.25);

Converter sirocConvert = new SIROCConverter();
Converter rocsiConvert = new ROCSIConverter();

SpecPoint siCursor = new SpecPoint(0.0, 0.0);
SpecPoint rocCursor = new SpecPoint(0.0, 0.0);

void setup(){
  size(700,400,P3D);
  frameRate(20);
  background(255);
  fill(0);
  //noFill();
  stroke(255,0,0);

  siView.setView(10, 10, 300, 300);
  rocView.setView(310, 10, 610, 300);

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

  siView.add(siTent);
  siView.add(si);

  rocView.add(sirocConvert.toCurve(siTent));
  rocView.add(sirocConvert.toCurve(si));

  siView.add(siCursor);
  rocView.add(new DualLine(siCursor, sirocConvert));
  
  rocView.add(rocCursor);
  siView.add(new DualLine(rocCursor, rocsiConvert));
}


void draw(){
  background(255);
  
  siView.draw(g);
  rocView.draw(g);

  if(siView.active()) {
    siCursor.setX(siView.viewToModelX(mouseX));
    siCursor.setY(siView.viewToModelY(mouseY));
  }
  
  if(rocView.active()) {
    rocCursor.setX(rocView.viewToModelX(mouseX));
    rocCursor.setY(rocView.viewToModelY(mouseY)); 
  }
}
