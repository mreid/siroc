/**
 * Visualisation of the relationship between Statistical Information
 * and ROC curves.
 */
import geomerative.*;
import name.reid.mark.geovex.*;

PlotView rocView = new PlotView(0.0, 0.0, 1.0, 1.0);
PlotView siView  = new PlotView(0.0, 0.0, 1.0, 0.25);

Converter convert = new Converter();

void setup(){
  size(700,400,P3D);
  frameRate(20);
  background(255);
  fill(0);
  //noFill();
  stroke(255,0,0);

  siView.setView(10, 10, 300, 300);
  rocView.setView(310, 10, 610, 300);

  GVCurve siTent = new GVCurve();
  siTent.add(0.0, 0.0);
  siTent.add(0.5, 0.25);
  siTent.add(1.0, 0.0);

  GVCurve si = new GVCurve();
  si.add(0.0, 0.0);
  si.add(0.25, 0.125);
  si.add(0.5, 0.15);
  si.add(0.75, 0.125);
  si.add(1.0, 0.0);

  siView.add(siTent);
  siView.add(si);

  rocView.add(convert.toROCCurve(siTent));
  rocView.add(convert.toROCCurve(si));

}


void draw(){
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
