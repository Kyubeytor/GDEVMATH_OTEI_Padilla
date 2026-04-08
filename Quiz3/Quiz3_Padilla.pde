void setup() {
  size(600, 600);
  background(255);
  noStroke();
}

void draw() {

  float meanX = width / 2;
  float stdDevX = width / 8;
  float x = (float)(randomGaussian() * stdDevX + meanX);

  float y = random(0, height);

  float meanSize = 20;
  float stdDevSize = 8;
  float size = abs((float)(randomGaussian() * stdDevSize + meanSize));

  size = constrain(size, 2, 60);

  float r = random(255);
  float g = random(255);
  float b = random(255);
  float a = random(10, 100);

  fill(r, g, b, a);
  ellipse(x, y, size, size);

  if (frameCount % 300 == 0) {
    background(255);
  }
}
