int WIDTH=800;
int HEIGHT=400;

GraphArea graph = new GraphArea(150,150,1.0,1.0);

void setup() {
  size(WIDTH,HEIGHT);
}

void draw() { 
  background(255);
  noFill();
  stroke(0);
  graph.display(10,10);
  graph.display(200,100);
}
