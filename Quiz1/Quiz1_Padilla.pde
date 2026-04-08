
float amplitude = 50;
float frequency = 0.05;
float phase = 0;

void setup() {
  size(800, 600);
}

void draw() {
  background(0);

  // Move origin to center
  translate(width/2, height/2);

  scale(1, -1);

  drawAxes();

  stroke(255, 255, 0);
  noFill();
  beginShape();
  for (float x = -20; x <= 20; x += 0.1) {
    float y = x*x - 15*x - 3;
    vertex(x * 10, y * 2); 
  }
  endShape();

  stroke(200, 0, 255);
  beginShape();
  for (float x = -40; x <= 40; x += 0.1) {
    float y = -5*x + 30;
    vertex(x * 10, y * 2);
  }
  endShape();

  stroke(0, 255, 255);
  beginShape();
  for (float x = -width/2; x < width/2; x++) {
    float y = sin(x * frequency + phase) * amplitude;
    vertex(x, y);
  }
  endShape();

  phase += 0.05;
}

void drawAxes() {
  stroke(150);

  line(-width/2, 0, width/2, 0);

  line(0, -height/2, 0, height/2);
}

void keyPressed() {
  if (key == 'w') amplitude += 5;
  if (key == 's') amplitude -= 5;
  if (key == 'd') frequency += 0.01;
  if (key == 'a') frequency -= 0.01;
}
