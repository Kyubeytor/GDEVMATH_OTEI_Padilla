Walker[] walkers = new Walker[100];

void setup() {
  size(600, 600);
  background(0);

  for (int i = 0; i < walkers.length; i++) {
    float x = random(width);
    float y = random(height);
    float s = random(5, 20);

    walkers[i] = new Walker(x, y, s);
  }
}

void draw() {
  background(0);

  for (int i = 0; i < walkers.length; i++) {
    walkers[i].update();
    walkers[i].display();
  }
}

class Walker {
  PVector position;
  PVector velocity;
  PVector acceleration;
  float scale;

  Walker(float x, float y, float s) {
    position = new PVector(x, y);
    velocity = new PVector(0, 0);
    acceleration = new PVector(0, 0);
    scale = s;
  }

  void update() {

    PVector mouse = new PVector(mouseX, mouseY);
    PVector direction = PVector.sub(mouse, position);

    direction.normalize();

    acceleration = direction;

    acceleration.mult(0.2);

    velocity.add(acceleration);
    position.add(velocity);

    velocity.limit(5);
  }

  void display() {
    fill(255);
    noStroke();
    ellipse(position.x, position.y, scale, scale);
  }
}
