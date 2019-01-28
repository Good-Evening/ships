Ship[] ships = new Ship[200];
boolean pointTowardsMouse = false;
class Ship {
  float x, y, vx, vy, ax, ay, dampen = 0.983;
  color c = color(random(0, 255), random(0, 255), random(0, 255));
  public void move() {
    ax = (mouseX - x)/100 + random(-.01, .01);
    ay = (mouseY - y)/100 + random(-.01, .01);
    x=x+vx;              
    y=y+vy;
    vx=(vx+ax)*dampen;   
    vy=(vy+ay)*dampen;
    x = Math.max(Math.min(x, width), 0);
    y = Math.max(Math.min(y, height), 0);
  }
  public void display() {
    pushMatrix();
    translate(x, y);
    rotate(pointTowardsMouse?atan2(mouseY-y, mouseX-x)-PI/2:atan2(vy, vx)-PI/2);
    triangle(-3, -3, 3, -3, 0, 13);
    popMatrix();
  }
}
void setup() {
  size(800, 800);
  noStroke();
  for (int i=0; i<ships.length; i++) ships[i] = new Ship();
}
void draw() {
  background(0);
  for (Ship s : ships) {
    fill(s.c);    
    for (Ship o : ships) {
      if (s==o) continue; 
      float dx = s.x-o.x; 
      float dy = s.y-o.y;
      if (sqrt( dx*dx + dy*dy) < 10) {
        s.vx += .4*cos(atan2(dy, dx));
        s.vy += .4*sin(atan2(dy, dx));
        if (sqrt( dx*dx + dy*dy) < 5) { 
          fill(50);  
          break;
        }
      }
    }
    s.move(); 
    s.display();
  }
}
void keyPressed() {
  pointTowardsMouse = !pointTowardsMouse;
}
