Walker walker;

void setup() {
  size(600, 600);
  background(0);
  noStroke();

  walker = new Walker();
}

void draw() {
  walker.perlinWalk();
  walker.display();
}

class Walker {
  float x, y;

  float tx, ty; 
  float ts;         
  float tr, tg, tb;

  Walker() {
    x = width / 2;
    y = height / 2;

    tx = random(1000);
    ty = random(2000);

    ts = random(3000);

    tr = random(4000);
    tg = random(5000);
    tb = random(6000);
  }

  void perlinWalk() {

    x = map(noise(tx), 0, 1, 0, width);
    y = map(noise(ty), 0, 1, 0, height);

    tx += 0.01;
    ty += 0.01;
  }

  void display() {
    
    float size = map(noise(ts), 0, 1, 5, 150);
    ts += 0.01;

    float r = map(noise(tr), 0, 1, 0, 255);
    float g = map(noise(tg), 0, 1, 0, 255);
    float b = map(noise(tb), 0, 1, 0, 255);

    tr += 0.01;
    tg += 0.01;
    tb += 0.01;

    if (r == 0 && g == 0 && b == 0) {
      r = g = b = 255;
    }

    fill(r, g, b);
    ellipse(x, y, size, size);
  }
}
