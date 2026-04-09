BlackHole bh;
Matter[] matters = new Matter[120];

int resetFrame = 600;

void setup() {
  size(800, 600);
  initScene();
}

void draw() {
  background(0);

  bh.update();

  bh.display();

  for (int i = 0; i < matters.length; i++) {
    matters[i].attract(bh);
    matters[i].update();
    matters[i].display();
  }

  if (frameCount % resetFrame == 0) {
    initScene();
  }
}

void initScene() {
  float x = random(width);
  float y = random(height);

  bh = new BlackHole(x, y);

  for (int i = 0; i < matters.length; i++) {
    float gx = (float)(randomGaussian() * width/6 + width/2);
    float gy = (float)(randomGaussian() * height/6 + height/2);

    matters[i] = new Matter(gx, gy);
  }
}

class BlackHole {
  PVector position;
  float scale = 50;

  BlackHole(float x, float y) {
    position = new PVector(x, y);
  }

  void update() {               
    position.x = mouseX;
    position.y = mouseY;
  }

  void display() {
    fill(255);
    noStroke();
    ellipse(position.x, position.y, scale, scale);
  }
}

class Matter {
  PVector position;
  PVector velocity;
  PVector acceleration;

  float scale;
  color col;

  float t;

  Matter(float x, float y) {
    position = new PVector(x, y);
    velocity = new PVector(0, 0);
    acceleration = new PVector(0, 0);

    scale = random(3, 12);
    col = color(random(255), random(255), random(255));

    t = random(1000);
  }

  void attract(BlackHole bh) {
    
    PVector direction = PVector.sub(bh.position, position);

    float distance = direction.mag();

    distance = constrain(distance, 5, 100);

    direction.normalize();

    float strength = 5 / (distance * 0.1);

    direction.mult(strength);

    float noiseOffset = map(noise(t), 0, 1, -0.5, 0.5);
    direction.add(new PVector(noiseOffset, noiseOffset));

    t += 0.01;

    acceleration.add(direction);
  }

  void update() {
    velocity.add(acceleration);
    position.add(velocity);

    velocity.limit(5);

    acceleration.mult(0);
  }

  void display() {
    fill(col);
    noStroke();
    ellipse(position.x, position.y, scale, scale);
  }
}
