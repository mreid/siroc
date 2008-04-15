/**
 * Visualisation of the relationship between Statistical Information
 * and ROC curves.
 */
import geomerative.*;

RShape s;
PlotView area = new PlotView();

void setup(){
  size(400,400);
  frameRate(20);
  background(255);
  fill(0);
  //noFill();
  stroke(255,0,0);

  OpCurve roc = new OpCurve();
  roc.add(0.6, 0.8);

  area.setView(10,10,300,300);
  area.add(roc);
}

void draw(){
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
