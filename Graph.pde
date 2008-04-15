class Graph {
  Segment[] segments = new Segment[16];
  int lastIndex = 0;

  void add(float x, float y) {
    Segment last;
    if(lastIndex == 0) {
      last = new Segment(x,y,x,y);
    } else {
      last = segments[lastIndex-1];
    }
    println(last);
    segments[lastIndex] = new Segment(last.x1, last.y1, x, y);  
    lastIndex++;
  }

  void display(PGraphics pg) {
   for(int i = 0 ; i < lastIndex ; i++) {
    segments[i].display(pg);
    println("Displaying segment " + i);
   }
  }  
}

class Segment {
 float x0, x1, y0, y1;

 Segment(float xStart, float yStart, float xEnd, float yEnd) {
  x0 = xStart; y0 = yStart;
  x1 = xEnd; y1 = yEnd;
 }

 void display(PGraphics pg) {
  pg.line(x0, y0, x1, y1);
 } 
}
