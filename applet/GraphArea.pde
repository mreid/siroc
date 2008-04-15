class GraphArea {

  OpCurve[] curves = new OpCurve[10];
  int curveCount = 0;
  
  int pixWidth, pixHeight;
  int vxStart, vyStart;
  int vxEnd, vyEnd;
  float xStart, xEnd;
  float yStart, yEnd;
  
  GraphArea() {
    vxStart = 0; vyStart = 0;
    vxEnd = 100; vyEnd = 100;
    
    xStart = 0.0; yStart = 0.0;
    xEnd   = 1.0; yEnd   = 1.0;    
  }
  
  void add(OpCurve curve) {
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
     noFill();
     stroke(0);
//     rect(vxStart,vyStart,viewWidth(),viewHeight());
     
     pushMatrix();
     translate(-xStart, -yStart);
     scale(viewWidth()/xRange(),-viewHeight()/yRange());
     translate(0,-yEnd);
     strokeWeight(xRange()/viewWidth());

     // Axes
     line(xStart, yStart, xRange(), yRange());

     for(int i = 0 ; i < curveCount ; i++) {
      curves[i].draw(g);       
     }
     popMatrix();
   }
}
