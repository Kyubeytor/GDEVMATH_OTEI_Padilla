PVector center;
PVector dir; 

void setup() {
  size(600, 600);
  background(0);

  center = new PVector(width/2, height/2);

  dir = new PVector(200, 0);
}

void draw() {
  background(0);

  drawDoubleSaber();

  println("Magnitude of one blade: " + dir.mag());
}

void drawDoubleSaber() {

  PVector d = dir.copy();
  d.normalize();
  d.mult(200); 

  PVector dOpp = d.copy().mult(-1);

  PVector end1 = PVector.add(center, d);
  PVector end2 = PVector.add(center, dOpp);

  stroke(300, 0, 0, 150);
  strokeWeight(40);
  line(center.x, center.y, end1.x, end1.y);
  line(center.x, center.y, end2.x, end2.y);

  stroke(255);
  strokeWeight(10);
  line(center.x, center.y, end1.x, end1.y);
  line(center.x, center.y, end2.x, end2.y);

  stroke(0);
  strokeWeight(12);

  float handleSize = 40;

  PVector h1 = d.copy().normalize().mult(handleSize/2);
  PVector h2 = h1.copy().mult(-1);

  PVector handleStart = PVector.add(center, h2);
  PVector handleEnd   = PVector.add(center, h1);

  line(handleStart.x, handleStart.y, handleEnd.x, handleEnd.y);
}
