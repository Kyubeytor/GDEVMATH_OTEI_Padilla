Walker[] walkers = new Walker[10];

// Forces
PVector gravity = new PVector(0, -0.4);
PVector wind = new PVector(0.15, 0);

void setup() {
  size(800, 600);
  background(0);

  for (int i = 0; i < walkers.length; i++) {
    float mass = i + 1; // 1 to 10
    walkers[i] = new Walker(mass);
  }
}

void draw() {
  background(0);

  for (int i = 0; i < walkers.length; i++) {

    walkers[i].applyForce(gravity);
    walkers[i].applyForce(wind);

    walkers[i].update();
    walkers[i].checkEdges();
    walkers[i].display();
  }
}

class Walker {
  PVector position;
  PVector velocity;
  PVector acceleration;

  float mass;
  float scale;
  color col;

  Walker(float m) {
    mass = m;
    scale = mass * 15;

    position = new PVector(-500, 200);

    velocity = new PVector(0, 0);
    acceleration = new PVector(0, 0);

    col = color(random(255), random(255), random(255));
  }

  void applyForce(PVector force) {
    PVector f = PVector.div(force, mass);
    acceleration.add(f);
  }

  void update() {
    velocity.add(acceleration);
    position.add(velocity);

    acceleration.mult(0);
  }

  void checkEdges() {

    if (position.x > width) {
      position.x = width;
      velocity.x *= -1;
    }

    if (position.x < 0) {
      position.x = 0;
      velocity.x *= -1;
    }

    if (position.y > height) {
      position.y = height;
      velocity.y *= -1;
    }

    if (position.y < 0) {
      position.y = 0;
      velocity.y *= -1;
    }
  }

  void display() {
    fill(col);
    noStroke();
    ellipse(position.x, position.y, scale, scale);
  }
}
