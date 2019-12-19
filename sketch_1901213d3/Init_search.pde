 import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
 int nodedist = 20;
 int desiredagents = 6;
 int enemytype = 1;
 int allytype = 0;
 
 
 
 
 int allies = 0;
 int enemies = 0;
 ArrayList<Point> starts;
 ArrayList<Point> goals;
 boolean reset = false;
 
 void buildmap(){
  if(reset){
  pointlist.clear();
  lineg.clear();
  }
  reset = true;
  int frac = agentsize;//scensize/(agentsize);
  //for(Point s: starts){
  //  pointlist.add(s);
  //}
  /*for(int i = 0; i < randcount; i++){
    PVector rand = new PVector(0,0,0);
    //rand.x = (int)random(1,19)*10;
    //rand.y = (int)random(1,19)*10;
     rand.x = random(frac,scensize-frac);
    rand.y = random(frac,scensize-frac);
    if(CheckPBound(rand)){
      pointlist.add(new Point(rand));
    }
  }*/
  //1* has symmetry
    for(int i = frac*1; i <= scensize-frac*1; i+=nodedist){
    for(int j = frac*1; j <= scensize-frac*1; j+=nodedist){
    PVector rand = new PVector(0,0,0);
    //rand.x = (int)random(1,19)*10;
    //rand.y = (int)random(1,19)*10;
     rand.x = i;
    rand.y = j;
    if(CheckPBound(rand)){
      pointlist.add(new Point(rand));
    }
  }}
    for(Point g: goals){
    pointlist.add(g);
  }
    for(Point s: starts){
    pointlist.add(0,s);
  }
  for(int i = 0; i < pointlist.size()-1; i++){
    for(int j = i+1; j < pointlist.size(); j++){
  if(CheckLBound(pointlist.get(i),pointlist.get(j), false)){
    lineg.add(new Line(pointlist.get(i),pointlist.get(j)));
    pointlist.get(i).neighbors.add(pointlist.get(j));
    pointlist.get(j).neighbors.add(pointlist.get(i));
  }

}
  }
  //changed = false;
  // }
 }
 
 
 
 void init(){
   if(!premake && !game){
        int frac = agentsize;//scensize/(agentsize);
        int i = 0;
        int j = 0;
        float prop = (scensize-frac)/(desiredagents);
        agentlist.clear();
        goals.clear();
        starts.clear();
        while(i < desiredagents){
          
          goals.add(new Point(new PVector((scensize - frac)-prop*j , frac)));
          starts.add(new Point(new PVector(frac + prop*j,scensize-frac)));
          starts.add(new Point(new PVector((scensize - frac)-prop*j , frac)));
          goals.add(new Point(new PVector(frac + prop*j,scensize-frac)));
          goals.add(new Point(new PVector(frac, frac+prop*j )));
          starts.add(new Point(new PVector(scensize-frac,scensize-frac - prop*j)));
          starts.add(new Point(new PVector( frac,frac+prop*j)));
          goals.add(new Point(new PVector(scensize-frac,scensize-frac - prop*j)));
          i++;
          j++;
        }
   
  buildmap();
 /* if(premake && !game){
  for(int k = 0; k < desiredagents; k++){
  agentlist.add(new agent(starts.get(k),goals.get(k),0));
 }
  }
  else{*/
  //agentlist.add(new agentb(pointlist.get(50),5));
 for(int k = 0; k < goals.size(); k++){
 agentlist.add(new agent(starts.get(k),goals.get(k),0,0, allytype));
 }
 agentlist.add(new agentb(pointlist.get(10),closest2(closestagent2(pointlist.get(10).location).location),5,0,enemytype));
 //agentlist.add(new agentb(pointlist.get(50),5));
 //yeee = new agentb(pointlist.get(50),5);
 // }
   }
   else if(premake && !game){
     
     if(maze){
       int squaresize = 80;
  for(int i = 80; i < 520; i+=120){
  for(int j = 80; j < 520; j+=120){
      shapelist.add(new Shape(new PVector(i,j), 1, squaresize));
  }
  }
  filter();
  }
   allyflag = new Point(new PVector(scensize/2,agentsize*2));
   enemyflag = new Point(new PVector(scensize/2,scensize - agentsize*2));
   goals.add(allyflag);
   goals.add(enemyflag);
   buildmap();
  // allies++;
  //   Point temp1 = new Point(new PVector(scensize/2,agentsize*2));
 //    starts.add(temp1);
 //    addnode(temp1);
 //    agentlist.add(new agent(temp1,enemyflag,0));

 /*   for(int i = agentsize*2; i < scensize; i+= scensize/desiredagents){
     Point temp = new Point(new PVector(i,agentsize*2));
     starts.add(temp);
     addnode(temp);
     managerlist.add(new agentmanager(temp,enemyflag,0));
     allies++;
     }
     for(int i = scensize - agentsize*2; i > 0; i-= scensize/desiredagents){
     Point temp = new Point(new PVector(i, scensize-agentsize*2));
     starts.add(temp);
     addnode(temp);
     managerlist.add(new agentmanager(temp,allyflag,1));
     enemies++;
     }*/
 int x = 1;
   for(int i = agentsize*2; i < scensize- agentsize*2; i+= scensize/desiredagents){
     if (x%2 == 1){
     Point temp = new Point(new PVector(i,agentsize*2));
     starts.add(temp);
     addnode(temp);
     agentlist.add(new agent(temp,enemyflag,0,0,allytype));
     allies++;
     }
     else{
     Point temp = new Point(new PVector(i,agentsize*2));
     starts.add(temp);
     addnode(temp);
    agentlist.add(new agentb(temp,allyflag,5,0,allytype));     
     }
     x++;
  }x = 0;
     for(int i = scensize - agentsize*2; i > agentsize*2; i-= scensize/desiredagents){
     if (x%2 == 0){
     Point temp = new Point(new PVector(i, scensize-agentsize*2));
     starts.add(temp);
     addnode(temp);
     agentlist.add(new agent(temp,allyflag,0,1,enemytype));
     enemies++;
   }else{
     Point temp = new Point(new PVector(i, scensize-agentsize*2));
     starts.add(temp);
     addnode(temp);
     agentlist.add(new agentb(temp,enemyflag,5,1,enemytype));
   }
   x++;
   }
   }
 }
 
 boolean CheckPBound(PVector p){ 
     for (Shape s: shapelist) {
       if(!s.check(p,1)){
        return false;
       }
  }
  return true;
 }
 
 boolean CheckLBound(Point i, Point j, boolean alg){
  float distx = (j.location.x - i.location.x)/150;
  float disty = (j.location.y - i.location.y)/150;
  PVector loc = i.location.copy();
  //System.out.println(pointlist.get(50).location.dist(pointlist.get(125).location));
  if(j.location.dist(i.location)> ((nodedist*2)-1)){
    return false;
  }
  for(int y = 0; y < 150; y++){
    loc.x += distx;
    loc.y += disty;
    if(!CheckPBound(loc)){
     return false; 
    }
  }
  
  return true;
 }
 
 
  void filter(){
   if(changed && goals != null){
       //pointlist = new ArrayList<Point>();
  //pathlist = new ArrayList<Point>();
  //lineg = new ArrayList<Line>();
  ArrayList<Point> pl = new ArrayList<Point>(pointlist);
  pointlist.clear();
  lineg.clear();
   //for(Point g: goals){
  //  pointlist.add(g);
 // }
  //for(Point s: starts){
  //  pointlist.add(s);
  //}
  for(Point p: pl){
    if(CheckPBound(p.location)){
      pointlist.add(p);
      p.neighbors.clear();
    }
  }

  for(int i = 0; i < pointlist.size()-1; i++){
    for(int j = i+1; j < pointlist.size(); j++){
  if(CheckLBound(pointlist.get(i),pointlist.get(j),false)){
    lineg.add(new Line(pointlist.get(i),pointlist.get(j)));
    pointlist.get(i).neighbors.add(pointlist.get(j));
    pointlist.get(j).neighbors.add(pointlist.get(i));
  }

}
  }
  changed = false;
   }
 }
 

 void addnode(Point p){
 pointlist.add(p);
    for(int j = 0; j < pointlist.size(); j++){
  if(CheckLBound(p,pointlist.get(j),false) && pointlist.get(j) != p){
    lineg.add(new Line(p,pointlist.get(j)));
   p.neighbors.add(pointlist.get(j));
    pointlist.get(j).neighbors.add(p);
  }

}
 }
