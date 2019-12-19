int floor = 350;
//ball b1 = new ball();
float walls = 1000;
boolean greedy = true;
float tdiv = 1;
int tms = 1;
/*class agentmanager{
int team;
Point start;
Point goal;
agent attack;
agent home;
boolean active = false;
boolean dead = false;
Point defense;
Point offense;
agentmanager(Point s, Point g, int t){
team = t;
start = s;
goal = g;
home = new agentb(s,g,5,t);
attack = new agent(s,g,0,t);
        if(team == 0){
        //   ogoal = enemyflag;
        //   ostart = allyflag;
           defense = allyflag;  
           offense = enemyflag;
        }else{
         //  ogoal = allyflag;
        //   ostart = enemyflag;
        defense = enemyflag;
        offense = allyflag;
        }
}

void update(){
if(!dead){
boolean shift = false;
if(!active){
home.update();
if(team == 0 && (attack.location.y < scensize/2)){
boolean test = true;
for(agent a: agentlist){
if(a.team == 1 && (a.location.y < scensize/2)){
test = false;}}
if(test == true){
shift = true;
}}

if(team == 1 && (attack.location.y > scensize/2)){
boolean test = true;
for(agent a: agentlist){
if(a.team == 0 && (a.location.y > scensize/2)){
test = false;}}
if(test == true){
shift = true;
}}

if(shift){
active = true;
attack.location = home.location;
shift = false;
}
}
else{

attack.update();

if(team == 0 && (attack.location.y < scensize/2)){
for(agent a: agentlist){
if(a.team == 1 &&(a.location.y < scensize/2)){
shift = true;}}}

if(team == 1 && (attack.location.y > scensize/2)){
for(agent a: agentlist){
if(a.team == 0 &&(a.location.y > scensize/2)){
shift = true;}}}

if(shift){
active = false;
home.location = attack.location;
shift = false;
}

}
}}


}

*/











class agent{
//boolean done = false;
int idx = 0;
int lastidx;
int type = 0;
int team = 0;
boolean hasFlag = false;
Point goal;
Point start;
Point ogoal;
Point ostart;
Point defense;
Point offense;
Point origin;
ArrayList<Line> lines;
PVector velocity;
PVector velocitytemp;
PVector acceleration;
//PVector dist;
PVector location;
PVector lastloc;
int poscounter = 0;
int timer = 0;
int alg;
float radius = agentsize*2;
ArrayList<Point> path;
agent(){}
agent(Point s, Point g, int t, int tea, int a){
  lines = new ArrayList<Line>();
  type = t;
  team = tea;
  goal = g;
  start = s;
  velocitytemp = new PVector(0,0,0);
  velocity = new PVector(0,0,0);
  path = new ArrayList<Point>();
        alg = a;
        //if(!greedy){
        //dijkstra = new DijkstraAlgorithm(pointlist, lineg);
        //dijkstra.execute(s);
        //ArrayList<Point> pathlist = new ArrayList<Point>();
        //path = dijkstra.getPath(g);
       // Point close = closest(start);
        //path = theta_star(start, goal, this);
        if(alg == 0){
        path = tconASTAR(start, goal, this,tms,tdiv);
        }
        else if(alg == 1){
        path = theta_star(start, goal, this);
        }
        else if (alg == 2){
        path = A_Star(start, goal, this);
        }
        /*}
        else{
          path = search(s, g);
          }*/
        origin = new Point(start.location.copy());
        addnode(origin);
        if(path == null){
        // path = new ArrayList<Point>();
        // path.add(start);
         //path.add(goal);
        //System.out.println(lineg.size());
        location = start.location.copy(); 
        }
        else{
     
        
         for(int i = 0; i < path.size()-1; i++){
         lines.add(new Line(path.get(i),path.get(i+1)));
        }
       location = start.location.copy(); 
        lastloc = location.copy();
        }
        if(team == 0){
           ogoal = enemyflag;
           ostart = allyflag;
           defense = allyflag;  
           offense = enemyflag;
        }else{
           ogoal = allyflag;
           ostart = enemyflag;
        defense = enemyflag;
        offense = allyflag;
        }
}

PVector getloc(){
return location;
}

float getrad(){
return radius;
}


void computePhysics(float dt){
  if(type == 0 && path != null){
  if(idx < path.size()-1){
  velocity = velocitytemp;
  velocity.limit(1);
  if(!nocor){
  if(lastloc.dist(location)<1.09 && lastidx==idx){
    poscounter++;
  }
  else{poscounter = 0;}
  if(lastidx==idx){
    timer++;
  }
  else{timer = 0;}
  
  if(poscounter >= 0 || timer >= 100){
        ArrayList<Point> pathlist = new ArrayList<Point>();
       // else{
        if(timer >= 500){
          //pathlist = theta_star(closest(path.get(idx)), goal, this);
          //pathlist = A_Star(closest(path.get(idx)), goal, this);
          //pathlist = tconASTAR(closest(path.get(idx)), goal, this,1,2);
          if(alg == 0){
          pathlist = tconASTAR(closest(path.get(idx)), goal, this,tms,tdiv);
          }
          else if(alg == 1){
          pathlist = theta_star(closest(path.get(idx)), goal, this);
          }
          else if (alg == 2){
          pathlist = A_Star(closest(path.get(idx)), goal, this);
          }
          timer = 0;
        }
        else{
        //pathlist = theta_star(path.get(idx), goal, this);
        //pathlist = A_Star(path.get(idx), goal, this);
        if(alg == 0){
        pathlist = tconASTAR(path.get(idx), goal, this,tms,tdiv);
        }
        else if(alg == 1){
        pathlist = theta_star(path.get(idx), goal, this);
        }
        else if (alg == 2){
        pathlist = A_Star(path.get(idx), goal, this);
        }
        }
       // }
        if(pathlist!=null){
          idx = 0;
        path = pathlist;
         lines.clear();
      for(int i = 0; i < path.size()-1; i++){
          lines.add(new Line(path.get(i),path.get(i+1)));
       }
   // }
    }
    else{
   // System.out.println("Helpme!");
    }
  }
  if(offense.taken && !hasFlag){

        if(alg == 0){
        path = tconASTAR(closest2(location), origin, this,tms,tdiv);
        }
        else if(alg == 1){
        path = theta_star(closest2(location), origin, this);
        }
        else if (alg == 2){
        path = A_Star(closest2(location), origin, this);
        }
   idx = 0;
  }
  lastloc = location.copy();
  lastidx = idx;
  }
  }
  if(idx < path.size()-1){

  velocity.add((path.get(idx+1).location.copy().sub(location).copy().normalize()).mult(dt));
  //location.x += dist.x*dt;
  //location.y += dist.y*dt;
  if(location.dist(path.get(idx+1).location) < agentsize/2 && idx < path.size()-2){
 
  location = path.get(idx+1).location.copy();
  idx++;
  
  }
  else if(location.dist(path.get(idx+1).location) < agentsize*2 && idx < path.size()-1){
  idx++;
  poscounter = 0;
  timer = 0;

  }
  else if(location.dist(path.get(idx+1).location) < agentsize && idx < path.size()-1){
   //velocity.mult(0);
  
   velocity.add(new PVector(random(-0.1,0.1),random(-0.1,0.1)));
   //idx++;
   //velocity.add(path.get(idx+1).location.copy().sub(velocity).normalize().mult(5));
  }
  }
  else if(location.dist(offense.location) < agentsize*1.5 || location.dist(defense.location)<agentsize*1.5){
      poscounter = 0;
      if(hasFlag){
      if(team == 1){
      EScore++;
      }
      else{
      AScore++;
      }
      hasFlag = false;
      offense.taken = false;
      }else if(!offense.taken && location.dist(offense.location)<agentsize*2){
      hasFlag = true;
      offense.taken = true;
      }
  timer = 0;
  idx = 0;
  //done = false;
  //for(agent a: agentlist){
  if(((!offense.taken) || hasFlag)){
    goal = ostart;
  start = ogoal;
  Point temp = ogoal;
  ogoal= ostart;
  ostart = temp;
  //path = A_Star(closest(path.get(idx)), goal, this);
  //path = theta_star(closest(path.get(idx)), goal, this);
  //path = tconASTAR(closest2(location), goal, this,1,2);
          if(alg == 0){
          path = tconASTAR(closest2(location), goal, this,tms,tdiv);
          }
          else if(alg == 1){
          path = theta_star(closest2(location), goal, this);
          }
          else if (alg == 2){
          path = A_Star(closest2(location), goal, this);
          }
 // }
  }
  }
  else{//velocity.mult(0);
  velocity.mult(0.995);
 // path = theta_star(closest(path.get(idx)), goal, this);
  //path = tconASTAR(closest(closest2(location)), goal, this,1,2);
            if(alg == 0){
          path = tconASTAR(closest2(location), goal, this,tms,tdiv);
          }
          else if(alg == 1){
          path = theta_star(closest2(location), goal, this);
          }
          else if (alg == 2){
          path = A_Star(closest2(location), goal, this);
          }
 // done = true;
   //location = path.get(path.size()-1).location.copy();
  }
  location.add(velocity);
  }
  if(type == 1){
  
    velocity = velocitytemp;
    velocity.limit(1);
    location.add(velocity);
  }
  if(goal == start){
   
  }
}


void update(){
pushMatrix();
computePhysics(.1);
if(team == 0){
fill(200,100,100);
noStroke(); 
//lights();
translate(location.x,location.y,location.z);
circle(0,0,radius);
if(hasFlag){
      fill(0,150,255);
  stroke(0,0,255);
  line(0,0,0,-10);
  rect(0,-18,15,8);
  }
  popMatrix();
  stroke(200,100,100);
}
else{
fill(100,100,200);
noStroke(); 
//lights();
translate(location.x,location.y,location.z);
circle(0,0,radius);
  if(hasFlag){
    fill(255,160,0);
  stroke(255,0,0);
  line(0,0,0,-10);
  rect(0,-18,15,8);
  }
  popMatrix();
  stroke(100,100,200);
}
for (Line ps: lines) {
     ps.run();
    }

for (int a = agentlist.size()-1; a >= 0; a--) {
  if(agentlist.get(a).location.dist(location) < 20 && agentlist.get(a).type == 5 && agentlist.get(a).team != team ){
      if(hasFlag){
      offense.taken = false;}
      if(team == 0){
      allies--;
      }
      else{
      enemies--;
      }
      agentlist.remove(this);
      return;
    }
  }
}







  void separate () {
    if(false){
    for (agent other : agentlist) {
      float look = location.dist(other.location);
      if(look < agentsize*2 && other.type != 5){
        velocitytemp.add((location.copy().sub(other.location.copy()).normalize()).mult((agentsize*2-look)*(agentsize*2-look)));
    }
  }
      for (Shape s: shapelist){
      if(!s.check(location,2)){
        PVector temp = new PVector();
        //temp.limit(1);
        temp = s.side(location, 1);
       velocitytemp.x += temp.x*0.01;
       velocitytemp.y += temp.y*0.01;
      }
    }
    if(!game){
    if(location.x < 0 + agentsize){
      float x = abs(location.x - agentsize);
        velocitytemp.x+=(((x*((agentsize-abs(x))*(agentsize-abs(x))))));
    }
    if(location.x > scensize - agentsize){
      float x = abs(location.x - (scensize - agentsize));
      x*=-1;
      velocitytemp.x+=(((x*((agentsize-abs(x))*(agentsize-abs(x))))));
    }
    if(location.y < 0 + agentsize){
       float y = abs(location.y - agentsize);
        velocitytemp.y+=(((y*((agentsize-abs(y))*(agentsize-abs(y))))));
    }
    if(location.y > scensize - agentsize){
      float y = abs(location.y - (scensize - agentsize));
      y*=-1;
      velocitytemp.y+=(((y*((agentsize-abs(y))*(agentsize-abs(y))))));
    }
    }
    }
  }
  
  
   /* void align () {
      float neighbordist = 0;
      if(type == 1){
       neighbordist = 100;
      }
      else{
       neighbordist = 60;
      }
    for (agent other : agentlist) {
      if(!other.done){
      float d = PVector.dist(location, other.location);
      if ((d > 0) && (d < neighbordist)) {
        velocitytemp.add(other.velocity.copy().mult(0.05));
      }
      }
    }
  }
*/

/*  void cohesion () {
    float neighbordist = 0;
    if(type == 1){
        neighbordist = 100;
      }
      else{
        neighbordist = 60;
      }
    for (agent other : agentlist) {
      if(!other.done){
      float d = PVector.dist(location, other.location);
      if ((d > 0) && (d < neighbordist)) {
        velocitytemp.add((other.location.copy().sub(location.copy()).normalize()).mult(0.01));
      }
      }
    }
}*/






}
Point closest(Point start){
    Double closest = inf;
    Point closp = null;
    for(Point p: pointlist){
      Double temp = new Double (p.location.dist(start.location));
      if(temp <closest && p != start){
        closp = p;
        closest = temp;
      }
    }
    return closp;
}


void environment(){
noStroke();
tint(255,255);
beginShape();
//texture(nick);
fill(120,120,120);
int X = 468;
int Y = 550;
vertex(walls,floor+1,walls,0,0);
vertex(-walls,floor+1,walls,X,0);
vertex(-walls,floor+1,-walls,X,Y);
vertex(walls,floor+1,-walls,0,Y);
endShape();
}
