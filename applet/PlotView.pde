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
    this(0.0, 0.0, 1.0, 1.0);
  }
  
  void add(GVCurve curve) {
    curves[curveCount++] = curve; 
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
  
  float viewToModelX(float vx) { return xRange() * (vx - vxStart) / viewWidth(); }
  float viewToModelY(float vy) { return yRange() * (vy - vyStart) / viewHeight(); }
  
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
   
   RContour view(GVCurve curve) {
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
