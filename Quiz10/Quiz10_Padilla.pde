Walker[] walkers = new Walker[100];
Liquid liquid;

void setup() {
  size(800, 600);

  liquid = new Liquid(0, height/2, width, height/2, 0.1);

  float gap = width / (walkers.length + 1);

  for (int i = 0; i < walkers.length; i++) {
    float x = gap * (i + 1);
    float y = -50; 
    
    float mass = random(1, 10);
    walkers[i] = new Walker(x, y, mass);
  }
}

void draw() {
  background(0);

  liquid.display();

  for (int i = 0; i < walkers.length; i++) {

    PVector wind = new PVector(0.1, 0);
    walkers[i].applyForce(wind);

    PVector gravity = new PVector(0, 0.15 * walkers[i].mass);
    walkers[i].applyForce(gravity);

    if (liquid.contains(walkers[i])) {
      PVector drag = liquid.calculateDrag(walkers[i]);
      walkers[i].applyForce(drag);
    }

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

  Walker(float x, float y, float m) {
    position = new PVector(x, y);
    velocity = new PVector(0, 0);
    acceleration = new PVector(0, 0);

    mass = m;
    scale = mass * 10;

    col = color(random(255), random(255), random(255));
  }

  void applyForce(PVector force) {
    // a = F / m
    PVector f = PVector.div(force, mass);
    acceleration.add(f);
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
  }
}

class Liquid {
  float x, y, w, h;
  float c;

  Liquid(float x_, float y_, float w_, float h_, float c_) {
    x = x_;
    y = y_;
    w = w_;
    h = h_;
    c = c_;
  }

  void display() {
    noStroke();
    fill(0, 0, 255, 100);
    rect(x, y, w, h);
  }

  boolean contains(Walker w) {
  return (w.position.x > x &&
          w.position.x < x + this.w &&
          w.position.y > y &&
          w.position.y < y + this.h);
  }

  PVector calculateDrag(Walker w) {
    float speed = w.velocity.mag();
    float dragMagnitude = c * speed * speed;

    PVector drag = w.velocity.copy();
    drag.normalize();
    drag.mult(-1);
    drag.mult(dragMagnitude);

    return drag;
  }
}
