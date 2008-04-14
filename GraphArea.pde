class GraphArea {

  PGraphics pg;
  
  int pixWidth, pixHeight;
  float xStart, xEnd;
  float yStart, yEnd;
  
  GraphArea(int wide, int high, float xRange, float yRange) {
    pg = createGraphics(wide, high, P3D);
    
    xStart = 0.0;
    yStart = 0.0;
    xEnd = xStart + xRange;
    yEnd = yStart + yRange;    
  }
  
   void display(int x, int y) {
     pg.beginDraw();
     pg.rect(0,0,pg.width-1,pg.width-1);
     pg.pushMatrix();
     pg.translate(-xStart, -yStart);
     pg.scale(pg.width/(xEnd - xStart),pg.height/(yStart - yEnd));
     pg.translate(0,-yEnd);
     pg.stroke(0);
     pg.line(0.2, 0.2, 0.8, 0.8);
     pg.line(0.1,0.5,0.9,0.5);
     pg.popMatrix();
     pg.endDraw();
     image(pg,x,y);
   }
}
