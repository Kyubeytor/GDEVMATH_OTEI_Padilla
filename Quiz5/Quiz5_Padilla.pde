Walker walker;

void setup() {
  size(600, 600);
  background(0);

  walker = new Walker();
}

void draw() {
  background(0);

  walker.moveAndBounce();
  walker.display();
}

class Walker {
  PVector position;
  PVector velocity;

  Walker() {
    position = new PVector(width/2, height/2);

    velocity = new PVector(random(-10, 10), random(-10, 10));
  }

  void randomWalk() {
    PVector step = new PVector(random(-1, 1), random(-1, 1));
    position.add(step);
  }

  void moveAndBounce() {
    position.add(velocity);

    if (position.x <= 0 || position.x >= width) {
      velocity.x *= -1;
    }

    if (position.y <= 0 || position.y >= height) {
      velocity.y *= -1;
    }

    position.x = constrain(position.x, 0, width);
    position.y = constrain(position.y, 0, height);
  }

  void display() {
    fill(255);
    noStroke();
    ellipse(position.x, position.y, 20, 20);
  }
}
