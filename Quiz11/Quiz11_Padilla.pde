Walker[] walkers = new Walker[10];

void setup() {
  size(800, 600);

  for (int i = 0; i < walkers.length; i++) {
    float x = random(width);
    float y = random(height);
    float mass = random(2, 10);

    walkers[i] = new Walker(x, y, mass);
  }
}

void draw() {
  background(0);

  for (int i = 0; i < walkers.length; i++) {
    for (int j = 0; j < walkers.length; j++) {

      if (i != j) {
        PVector force = walkers[j].calculateAttraction(walkers[i]);
        walkers[i].applyForce(force);
      }
    }
  }

  for (int i = 0; i < walkers.length; i++) {
    walkers[i].update();
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

  float G = 1; 

  Walker(float x, float y, float m) {
    position = new PVector(x, y);
    velocity = new PVector(0, 0);
    acceleration = new PVector(0, 0);

    mass = m;
    scale = mass * 5;

    col = color(random(255), random(255), random(255));
  }

  void applyForce(PVector force) {
    // a = F / m
    PVector f = PVector.div(force, mass);
    acceleration.add(f);
  }

  PVector calculateAttraction(Walker other) {

    PVector force = PVector.sub(position, other.position);

    float distance = force.mag();

    distance = constrain(distance, 5, 50);

    force.normalize();

    float strength = (G * mass * other.mass) / (distance * distance);

    force.mult(strength);

    return force;
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
