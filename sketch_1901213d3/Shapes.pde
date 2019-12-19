class Shape{
  int type;
  int size;
  PVector location;
  Shape(PVector loc, int t, int s){
    location = loc.copy();
    type = t;
    size = s;
  }
  
  
  void run(){
  if(type == 0){
    fill(255);
    circle(location.x,location.y,(size*2));
  }
  else if (type == 1){
    fill(255);
    square(location.x,location.y,size);
  }
  else if (type == 2){
    if(game){
    fill(255);
    circle(location.x,location.y,(size*2));
    PVector mouse = new PVector(mouseX,mouseY,0);
    mouse.sub(location);
    mouse.normalize();
    //mouse.limit(2);
    mouse.mult(40);
    endShape(CLOSE);
    line(location.x+mouse.x,location.y+mouse.y,location.x,location.y);
    }
  }
  }
  
  
  boolean check(PVector p, int c){
  if(type == 0){
    if(p.dist(new PVector(location.x,location.y,0)) >  (size + agentsize*c)){
     return true;
    }
    else{
      return false;
    }
  }
  else if (type == 1){
    
    if(p.x > location.x - agentsize*c && 
       p.x < location.x + size + agentsize*c &&
       p.y > location.y - agentsize*c && 
       p.y < location.y + size + agentsize*c){
         return false;
  }else{
    return true;                   
  }
  }
  if(type == 2){
    if(game){
      if(p.dist(new PVector(location.x,location.y,0)) >  (size + agentsize*c)){
     return true;
    }
    else{
      return false;
    }
    }
   else{
   return true;
   }
  }
  return false;
  }
  
  
  PVector side(PVector p, int c){
  PVector temp = new PVector(0,0,0);
  if(type == 1){
    //if(p.dist(new PVector(location.x,location.y,0)) >  (size + agentsize)){
    float x1 = abs(p.x - (location.x+size/2));
    float y1 = abs(p.y - (location.y+size/2));
    if(x1 > y1){
    if(p.x < location.x + size/2 && p.x > location.x - agentsize*c){
        float x = p.x - (location.x-agentsize*c);
        x*=-1;
        temp.x = ((x*((agentsize*c-abs(x))*(agentsize*c-abs(x)))));
        return temp;
    }
    else if(p.x > location.x + size/2 && p.x < location.x + size + agentsize*c){
      float x = p.x - (location.x + size + agentsize*c);
      x*=-1;
      temp.x = ((x*((agentsize*c-abs(x))*(agentsize*c-abs(x)))));
      return temp;
    }
    }
    else if(y1 > x1){
     if(p.y < location.y + size/2 && p.y > location.y - agentsize*c){
        float y = p.y - (location.y - agentsize*c);
        y*=-1;
        temp.y = ((y*((agentsize*c-abs(y))*(agentsize*c-abs(y)))));
        return temp;
      }
   else if(p.y > location.y + size/2 && p.y < location.y + size + agentsize*c){
        float y = p.y - (location.y + size + agentsize*c);
        y*=-1;
        temp.y = ((y*((agentsize*c-abs(y))*(agentsize*c-abs(y)))));
        return temp;
      }
    }
  }
  else if(type == 2){
    /*
    if(game){
    float look = p.dist(location);
      if(look < size + agentsize/2){

        //temp.add((p.copy().sub(location.copy()).normalize()).mult(((agentsize*2+size)-look)*((agentsize*2+size)-look)));
        //return temp.mult(1);
    agentlist.remove(d);
    if(g1.HP > 0){
    g1.HP -= 10;
    }
      }
     }*/
  }
  return new PVector(1,1,0);
}
}
