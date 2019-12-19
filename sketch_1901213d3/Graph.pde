class Team {
    int teamsize;
    int team;
    Team(int s, int t){
    
    
    }

}


class Point {
  int state = 0;
  PVector location;
  PVector locationtemp;
  PVector velocity;
  PVector velocitytemp;
  PVector acceleration;
  Boolean isFixed;
  ArrayList<Point> neighbors;
  boolean taken = false;

  Point(PVector l) {
    location = l.copy();
    locationtemp = location.copy();
    isFixed = false;
    neighbors = new ArrayList<Point>();
  }
  Point() {
    location = new PVector();
    locationtemp = location.copy();
    isFixed = true;
    neighbors = new ArrayList<Point>();
  }

  void run() {
    //update();
    display();
  }


  void display() {
//computePhysics(.15);
stroke(255,0,13);
//noStroke(); 
//fill(255);
pushMatrix();
translate(location.x,location.y,location.z);
if(isFixed){
  location = me.location;
}
if(this == allyflag){
  if(!taken){
    fill(255,160,0);
  stroke(255,0,0);
  line(0,0,0,-10);
  //triangle(0,-10,0,-30,20,-25);
  rect(0,-18,15,8);
  }
  //circle(0,0,30);
}
else if(this == enemyflag){
  if(!taken){
    fill(0,150,255);
  stroke(0,0,255);
  line(0,0,0,-10);
  rect(0,-18,15,8);
  }
}
else{
  circle(0,0,4);
}
popMatrix();
}
  
  
}

class Line {
  Point p1;
  Point p2;
  float dist;
  Line(Point one, Point two) {
   p1 = one;
   p2 = two;
   dist = p1.location.dist(p2.location);
  }


  void run() {
    //update();
    display();
  }

  void display() {
   //stroke(17,160,130);
   line(p1.location.x,p1.location.y,p1.location.z,p2.location.x,p2.location.y,p2.location.z);
  }}
