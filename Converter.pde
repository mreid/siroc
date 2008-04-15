/**
 * Implements conversions between ROC points to SI lines, etc.
 */
class Converter {
  
  float pi = 0.5;
    
  Point toSIPoint(Line rocLine) {
    float m = rocLine.slope();
    float cost = (rocLine.isVertical() ? 1.0 : pi*m/(pi*m + (1-pi)));
    float fn0  = (rocLine.isVertical() ? 0.0 : 1 - rocLine.atX(0.0));
    float loss = pi*(1-cost)*fn0;
    
    return new Point(cost, loss);
  }
  
  Line toSILine(Point rocPoint) {
    float fn = 1 - rocPoint.y;
    float fp = rocPoint.x;
    
    return new Line(1, -1*((1-pi)*fp - pi*fn), pi*fn);
  }
  
  Point toROCPoint(Line siLine) {
    float l0 = siLine.atX(0.0);
    float m  = siLine.slope();
    float fn = l0/pi;
    float fp = (m + l0)/(1 - pi);
    
    return new Point(fp, 1-fn);
  }
  
  Line toROCLine(Point siPoint) {
    float c = siPoint.x;
    float l = siPoint.y;
    
    return new Line(-c*(1-pi), pi*(1-c), pi*(1-c) - l);
  }
}

void testConverter() {
  Converter conv = new Converter();
  Point rocZero = new Point(0.0, 0.0);
  Point rocMid  = new Point(0.5, 0.5);
  Point rocOne  = new Point(1.0, 1.0);
  
  println("ROC " + rocZero + " -> SI " + conv.toSILine(rocZero));
  println("ROC " + rocMid  + " -> SI " + conv.toSILine(rocMid));
  println("ROC " + rocOne + " -> SI " + conv.toSILine(rocOne));
  
  Line rocDiag = new Line(1, -1, 0);
  Line rocVert = new Line(1, 0, 0);
  Line rocHor  = new Line(0, 1, 1);
  
  println("ROC " + rocDiag + " -> SI " + conv.toSIPoint(rocDiag));
  println("ROC " + rocVert + " -> SI " + conv.toSIPoint(rocVert));
  println("ROC " + rocHor + " -> SI " + conv.toSIPoint(rocHor));

  // Test SI Points to ROC Lines conversions
  Point[] siPoints = { 
    new Point(0.0, 0.0), new Point(1.0, 0.0), 
    new Point(0.5, 0.0), new Point(0.25, 0.0), new Point(0.75, 0.0), 
    new Point(0.5, 0.25), new Point(0.25, 0.0625)
  };
  for(int i = 0 ; i < siPoints.length ; i++) {
    Point p = siPoints[i];
    println("SI " + p + " -> ROC " + conv.toROCLine(p));  
  }

  // Test SI Line to ROC Point conversions
  Line[] siLines = {
    new Line(0.0, 1.0, 0.0), new Line(0.5, -1.0, 0.0), new Line(-0.5, -1.0, -0.5),
    new Line(0.25, -1.0, 0.0)
  };
  for(int i = 0 ; i < siLines.length ; i++) {
    Line l = siLines[i];
    println("SI " + l + " -> ROC " + conv.toROCPoint(l)); 
  }
}

