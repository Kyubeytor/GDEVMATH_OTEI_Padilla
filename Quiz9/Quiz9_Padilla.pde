Walker[] walkers = new Walker[8];
int num = 8;

void setup() {
  size(1000, 600);
  initWalkers();
}

void draw() {
  background(0);

  PVector accelForce = new PVector(0.2, 0);

  for (int i = 0; i < walkers.length; i++) {

    PVector f = PVector.mult(accelForce, walkers[i].mass);
    walkers[i].applyForce(f);

    walkers[i].applyFriction();

    walkers[i].update();
    walkers[i].display();
  }
}

void mousePressed() {
  initWalkers();
}

void initWalkers() {
  for (int i = 0; i < num; i++) {

    float mass = i + 1;
    float scale = mass * 10;

    float posY = (height / (float)num) * (i - (num / 2.0));

    posY += height / 2;

    float posX = -100;

    walkers[i] = new Walker(posX, posY, mass, scale);
  }
}

class Walker {
  PVector position;
  PVector velocity;
  PVector acceleration;

  float mass;
  float scale;
  color col;

  float mu = 0.01;

  Walker(float x, float y, float m, float s) {
    position = new PVector(x, y);
    velocity = new PVector(0, 0);
    acceleration = new PVector(0, 0);

    mass = m;
    scale = s;

    col = color(random(255), random(255), random(255));
  }

  void applyForce(PVector force) {
    PVector f = PVector.div(force, mass);
    acceleration.add(f);
  }

  void applyFriction() {

    if (position.x > width / 2) {
      mu = 0.4;
    }

    if (velocity.mag() > 0) {
      PVector friction = velocity.copy();
      friction.normalize();
      friction.mult(-1);

      friction.mult(mu * mass);

      applyForce(friction);
    }
  }

  void update() {
    velocity.add(acceleration);
    position.add(velocity);

    acceleration.mult(0);
  }

  void display() {
    fill(col);
    noStroke();
    ellipse(position.x, position.y, scale, scale);
  }
}
