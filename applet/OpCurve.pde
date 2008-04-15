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

