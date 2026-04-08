Walker walkerNormal;
Walker walkerBiased;

void setup() {
  size(600, 600);
  background(0);

  walkerNormal = new Walker(width/2, height/2);
  walkerBiased = new Walker(width/2, height/2);
}

void draw() {
  walkerNormal.randomWalk();
  walkerNormal.display();

  walkerBiased.randomWalkBiased();
  walkerBiased.display();
}

class Walker {
  int x, y;

  Walker(int startX, int startY) {
    x = startX;
    y = startY;
  }

  void randomWalk() {
    int stepX = int(random(-1, 2)); // -1, 0, or 1
    int stepY = int(random(-1, 2)); // -1, 0, or 1

    x += stepX;
    y += stepY;

    constrainToScreen();
  }

  void randomWalkBiased() {
    float r = random(1);

    int stepX = 0;
    int stepY = 0;

    if (r < 0.4) {          
      stepX = 1;
    } else if (r < 0.6) {   
      stepX = -1;
    } else if (r < 0.8) {  
      stepY = -1;
    } else {      
      stepY = 1;
    }

    if (random(1) < 0.3) {
      stepY = int(random(-1, 2));
    }

    x += stepX;
    y += stepY;

    constrainToScreen();
  }

  void display() {
    float r = random(255);
    float g = random(255);
    float b = random(255);
    float a = random(50, 100);

    fill(r, g, b, a);
    noStroke();
    rect(x, y, 4, 4);
  }

  void constrainToScreen() {
    x = constrain(x, 0, width - 1);
    y = constrain(y, 0, height - 1);
  }
}
