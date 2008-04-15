import java.util.ArrayList;

class OpCurve {
  ArrayList points = new ArrayList();
  RContour curve = new RContour();
  
  OpCurve() {
    curve.addPoint(0.0, 0.0);
    curve.addPoint(1.0, 1.0);
  }
  
  // Add a new ROC point to this curve
  void add(float newfpr, float newtpr) {
    curve.addPoint(newfpr, newtpr);
  }

  void draw(PGraphics g) {
    curve.draw(g);
  }  
}

/**
 * Represents a line aX + bY = c
 */
class Line {
  float a, b, c; 
  
  Line(float a, float b, float c) {
   this.a = a;
   this.b = b;
   this.c = c; 
  }
  
  float slope() { 
   if(b == 0) return Float.POSITIVE_INFINITY;

   return -a/b;
  }
  
  boolean isVertical() { return (b == 0); }
  
  float atX(float x) { return (c - a*x)/b; }
  float atY(float y) { return (c - b*y)/a; }
  
  String toString() { 
    String result = "Line: " + a + "X + " + b + "Y = " + c;
    return result; 
  }
}

/**
 * Represents a point (X,Y)
 */
class Point {
  float x, y;
  
  Point(float x, float y) {
   this.x = x;
   this.y = y; 
  }
  
  String toString() { return "(" + x + "," + y + ")"; }
}
