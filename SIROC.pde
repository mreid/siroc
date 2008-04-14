import geomerative.*;

RPolygon p;
RShape s;

void setup(){
  size(400,400);
  frameRate(34);
  background(255);
  fill(0);
  //noFill();
  stroke(255,0,0);
  
  s = new RShape();
  
  s.addMoveTo(-30,250);
  s.addLineTo(30,150);
  s.addLineTo(50,75);
  s.addBezierTo(130,90,75,100,90,150);
  s.addLineTo(130,250);
  s.addBezierTo(80,200,70,200,-30,250);
  
  s.addMoveTo(60,120);
  s.addBezierTo(75,110,85,130,75,140);
  s.addBezierTo(70,150,65,140,60,120);
  
  p = s.toPolygon();
}

void draw(){
//  scale(0.25);
  translate(200,50);
  background(255);
  
//  p.draw(g);
  smooth();
  
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
}
