class agentb extends agent{
agent target = null;
int timer2;
agentb(Point s, Point g, int t, int tea, int a){
  super(s, g, t, tea, a);
  goal = g;
  start = s;
  location = start.location.copy();
  path = null;
  idx = 0;
 // addnode(start);
 // addnode(goal);
  //System.out.println(closest2(closestagent(location).location).location);
}

PVector getloc(){
return location;
}

float getrad(){
return radius;
}


void computePhysics(float dt){
  if(type == 5 && path != null){
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
  else{timer = 0;
    timer2 = 0;
}
timer2++;
  //if(defense.taken){
  //  target = flagagent();
  //  timer2 = 0;
  //}
  if(timer2 >= 10 || target == null){
    timer2 = 0;
    target = closestagent(location);
    if(target != null){
    //path = A_Star(closest2(location), closest2(target.location), this);
          if(alg == 0){
          path = tconASTAR(closest2(location), closest2(target.location), this,tms,tdiv);
          }
          else if(alg == 1){
          path = theta_star(closest2(location), closest2(target.location), this);
          }
          else if (alg == 2){
          path = A_Star(closest2(location), closest2(target.location), this);
          }
    idx = 0;
    }
  }
 //if(timer2 >= 100 && target.location.dist(location)< 20){
  //path.clear();
  //idx = 0;
  //path.add(new Point(location));
  //path.add(new Point(target.location));
  //}
  if(path !=  null){
  lines.clear();
      for(int i = 0; i < path.size()-1; i++){
          lines.add(new Line(path.get(i),path.get(i+1)));
       }}
  lastloc = location.copy();
  lastidx = idx;
  }
  }
  if(team == 1 && allies <= 0){
     velocity.mult(0);
    //done = true;
   //location = path.get(path.size()-1).location;
  }
  else if(team == 0 && enemies <= 0) {
    velocity.mult(0);
   // done = true;
  }
  else if(idx < path.size()-1){
  velocitytemp.add((path.get(idx+1).location.copy().sub(location).copy().normalize()).mult(dt));
  //System.out.println((path.get(idx+1).location.copy().sub(location).copy().normalize()).mult(dt));
  //location.x += dist.x*dt;
  //location.y += dist.y*dt;
  //System.out.println("hello2");
  /*if(location.dist(path.get(idx+1).location) < agentsize/2 && idx < path.size()-2){
  //System.out.println("therre");
  location = path.get(idx+1).location.copy();
  idx++;
  }
  else if(location.dist(path.get(idx+1).location) < agentsize/2 && idx < path.size()-1){
  idx++;
  poscounter = 0;
  timer = 0;
  timer2 = 0;
  System.out.print(team);
  System.out.print("2");
  }
  else if(location.dist(path.get(idx+1).location) < agentsize && idx < path.size()-1){
   //velocity.mult(0);
   System.out.print(team);
   System.out.print("3");
   velocity.add(new PVector(random(-0.1,0.1),random(-0.1,0.1)));
   //idx++;
   //velocity.add(path.get(idx+1).location.copy().sub(velocity).normalize().mult(5));
  }*/
  }
    else if (idx >= (path.size() -1)){
   //velocity.mult(0);
   path.clear();
   idx = 0;
   lastidx = 0;
     target = closestagent(location);
       if(target != null){
    //path = A_Star(closest2(location), closest2(target.location), this);
          if(alg == 0){
          path = tconASTAR(closest2(location), closest2(target.location), this,tms,tdiv);
          }
          else if(alg == 1){
          path = theta_star(closest2(location), closest2(target.location), this);
          }
          else if (alg == 2){
          path = A_Star(closest2(location), closest2(target.location), this);
          }
    }
    }
    else{
    
    System.out.println("help!");
    }
  location.add(velocity);
  if(team == 1 &&location.y < scensize/2 + agentsize){
  location.y = scensize/2 + agentsize;
  }
  else if(team == 0 && location.y > scensize/2 - agentsize){
    location.y = scensize/2 - agentsize;
  }
}
  else{
    timer2 = 0;
    target = closestagent(location);
    if(target != null){
    //path = A_Star(closest2(location), closest2(target.location), this);
          if(alg == 0){
          path = tconASTAR(closest2(location), closest2(target.location), this,tms,tdiv);
          }
          else if(alg == 1){
          path = theta_star(closest2(location), closest2(target.location), this);
          }
          else if (alg == 2){
          path = A_Star(closest2(location), closest2(target.location), this);
          }
    }
    idx = 0;
  }
}


void update(){
pushMatrix();
computePhysics(.1);
if(team == 0){
fill(200,0,0);
noStroke(); 
//lights();
translate(location.x,location.y,location.z);
circle(0,0,radius);
popMatrix();
stroke(200,0,0);
}
else{
fill(0,0,200);
noStroke(); 
//lights();
translate(location.x,location.y,location.z);
circle(0,0,radius);
popMatrix();
stroke(0,0,200);
}
for (Line ps: lines) {
     ps.run();
    }
}







  void separate () {
    
        for (agent other : agentlist) {
      float look = location.dist(other.location);
      if(look < agentsize*2 && other.type != 0 && other.type == type){
        velocitytemp.add((location.copy().sub(other.location.copy()).normalize()).mult((agentsize*2-look)*(agentsize*2-look)));
    }
  }if(false){
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
    }}
  }
  
  
agent closestagent(PVector me){
    Double closest = inf;
    agent closp = null;
    for(agent a: agentlist){
      Double temp = new Double (a.location.dist(me.copy()));
      if(temp <closest && a.type != 5 && a.team != team){
        closp = a;
        closest = temp;
      }
    }
    return closp;
}

agent flagagent(){
    agent closp = null;
    for(agent a: agentlist){
      if(a.type != 5 && a.hasFlag && a.team != team){
          if(team == 1 && !(a.location.y < scensize/2)){
             closp = a;
          
  }
    else if(team == 0 && !(a.location.y > scensize/2)){
       closp = a;
  }
      }
    }
    return closp;
}


}


Point closest2(PVector x){
    Double closest = inf;
    Point closp = null;
    for(Point p: pointlist){
      Double temp = new Double (p.location.dist(x.copy()));
      if(temp < closest && p.location != x){
        closp = p;
        closest = temp;
      }
    }
    return closp;
}


agent closestagent2(PVector me){
    Double closest = inf;
    agent closp = null;
    for(agent a: agentlist){
      Double temp = new Double (a.location.dist(me.copy()));
      if(temp <closest && a.type != 5){
        closp = a;
        closest = temp;
      }
    }
    return closp;
}
