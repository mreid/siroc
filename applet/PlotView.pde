import java.util.Vector;

class PlotView {

  Vector curves = new Vector();
  Vector points = new Vector();
  Vector lines  = new Vector();
  
  int vxStart, vyStart;
  int vxEnd, vyEnd;
  float xStart, xEnd;
  float yStart, yEnd;
  
  GBounds bounds;
  
  PlotView(
    int vx0, int vy0, int vx1, int vy1,
    float x0, float y0, float x1, float y1
  ) {
    vxStart = vx0; vyStart = vy0; vxEnd = vx1; vyEnd = vy1;
    xStart = x0; yStart = y0; xEnd = x1; yEnd = y1;
    bounds = new GBounds(xStart, yStart, xEnd, yEnd);
  }

  PlotView(float x0, float y0, float x1, float y1) {
   this(0, 0, 100, 100, x0, y0, x1, y1); 
  }
  
  PlotView() {
    this(0.0, 0.0, 1.0, 1.0);
  }
  
  void add(GCurve curve) {
    curves.add(curve); 
  }

  void add(GPoint point) {
    points.add(point);  
  }
  
  void add(GLine line) {
     lines.add(line); 
  }
  
  void setViewStart(int vx, int vy) { vxStart = vx; vyStart = vy; }
  void setViewEnd(int vx, int vy) { vxEnd = vx; vyEnd = vy; }
  void setView(int vx0, int vy0, int vx1, int vy1) { 
    setViewStart(vx0, vy0); 
    setViewEnd(vx1, vy1); 
  }
  
  int viewWidth() { return vxEnd - vxStart; }
  int viewHeight() { return vyEnd - vyStart; }
  
  float xRange() { return xEnd - xStart; }
  float yRange() { return yEnd - yStart; }
  
  float viewToModelX(float vx) { return xStart + xRange() * (vx - vxStart) / viewWidth(); }
  float viewToModelY(float vy) { return yStart - yRange() * (vy - vyEnd) / viewHeight(); }
  
   boolean active() {
     return (mouseX > vxStart && mouseX < vxEnd && mouseY > vyStart && mouseY < vyEnd);
   }
  
   void showCursor() {
    /*
     RShape c = new RShape();
     c.addMoveTo(viewToModelX(mouseX), 0.0);
     c.addLineTo(viewToModelX(mouseX), 1.0);
     display(c, g);
    */
   }
  
   void draw(PGraphics g) {
     
     pushMatrix();
     
     // Set up viewing transformations
     translate(vxStart, vyStart);
     translate(-xStart, -yStart);
     scale(viewWidth()/xRange(),-viewHeight()/yRange());
     translate(0,-yEnd);

     // Outline
     noFill();
     stroke(200);
     rect(xStart,yStart,xRange(),yRange());

     // Curves
     for(int i = 0 ; i < curves.size() ; i++) {
       stroke(0);
       viewCurve((GCurve) curves.get(i)).draw(g);
     }
     
     // Points
     for(int i = 0 ; i < points.size() ; i++) {
       stroke(200,0,0);
       viewPoint((GPoint) points.get(i));
     }
     
     // Lines
     for(int i = 0 ; i < lines.size() ; i++) {
       stroke(200,0,0);
       viewLine((GLine) lines.get(i)).draw(g);
     }
     
     popMatrix();
   }
   
   RContour viewCurve(GCurve curve) {
     RContour c = new RContour();
     for(int i = 0 ; i < curve.size() ; i++) {
       GPoint p = curve.getPoint(i);
       c.addPoint(p.getX(), p.getY()); 
     }
     
     return c;
   }
   
   void viewPoint(GPoint point) {
     point(point.getX(), point.getY());
   }
   
   RContour viewLine(GLine line) {
     GSegment s = bounds.clip(line);
     RContour l = new RContour();
     l.addPoint(s.start.getX(), s.start.getY());
     l.addPoint(s.end.getX(), s.end.getY());
//     l.addPoint(0.0, line.atX(0.0));
//     l.addPoint(1.0, line.atX(1.0));
     return l;
   }
}
