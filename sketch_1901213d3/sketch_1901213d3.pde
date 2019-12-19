
long time1;
long timeavg = 0;

long astrs = 0;
long aastrs = 0;
long tstrs = 0;

long astrc = 0;
long aastrc = 0;
long tstrc = 0;

double astravg = 0;
double aastravg = 0;
double tstravg = 0;

double astravg2 = 0;
double aastravg2 = 0;
double tstravg2 = 0;

int bgoalavg = 0;
int bleftavg = 0;
int rgoalavg = 0;
int rleftavg = 0;
double flago = 0;

boolean nocor = false;
boolean premake = true;
boolean ready = false;
float Yrot = 0;
float Xrot = 0;
boolean isPressed = false;
boolean mouseflag = false;
PVector saved;
boolean changed = false;
boolean place = true;
boolean game = false;
boolean maze = false;
boolean isLeft, isRight, isUp, isDown; 
float Ztran= 0;
float Xtran= 0;
float Ytran= 0;
ArrayList<Point> pointlist;
ArrayList<Shape> shapelist;
ArrayList<agent> agentlist;
//ArrayList<agentmanager> managerlist;
//ArrayList<Point> pathlist;
ArrayList<Line> lineg;

int scensize = 600;
int startwid = 20;
int startlen = 20;
int randcount = 100;
int rad = 50;
int agentsize = 10;
PVector lasloc;
Point grabbed = null;
int selected = 0;
Shape me;

Point enemyflag;
Point allyflag;
int AScore = 0;
int EScore = 0;

void setup() {size(600, 600, P3D);
time1 = System.currentTimeMillis();
 shapelist = new ArrayList<Shape>();
 agentlist = new ArrayList<agent>();
 // managerlist = new ArrayList<agentmanager>();
 pointlist = new ArrayList<Point>();
 lineg = new ArrayList<Line>();
starts = new ArrayList<Point>();
goals = new ArrayList<Point>();
me = new Shape(new PVector(scensize/2,scensize/2),2,25);
shapelist.add(me);
//buildmap();
//reset = false;
 //shapelist.add(new Shape(new PVector(100,100,0), 0, rad));
  //delay(10000);
  hint(DISABLE_OPTIMIZED_STROKE);
}

  


void mouseReleased() {
  if(!game){
  if(place){
  int squaresize = 90;
  shapelist.add(new Shape(new PVector(mouseX-squaresize/2,mouseY-squaresize/2,0), 1, squaresize));
  changed = true; 
  filter();
  }
  else{
  if(!mouseflag){
  mouseflag = true;
  saved = new PVector(mouseX,mouseY,0);
 }
 else if(mouseflag){
   mouseflag = false;
   Point start = new Point(saved);
   Point goal = new Point(new PVector(mouseX,mouseY,0));
   if(!reset){
   starts.add(start);
   goals.add(goal);
   }
   else{
   changed = true;
   pointlist.add(0,start);
   //starts.add(start);
   //goals.add(goal);
   //pointlist.add(0,start);
   pointlist.add(goal);
   filter();
   agentlist.add(new agent(start,goal,0,0,2));}
 } 
  }
  }
}


void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  Ztran+=-20*e;
}

void keyPressed() {
  isPressed = true;
  setMove(keyCode, true);
    if (key == 'w') {
      Yrot+=0.01;
    } else if (key == 's') {
      Yrot-=0.01;
    } else if (key == 'q') {
      Xtran+=10;
    } else if (key == 'e') {
      Xtran-=10;
    } else if (key == 'r') {
      Ytran+=10;
    } else if (key == 'f') {
      Ytran-=10;
    } else if (key == 'd') {
      Xrot+=0.01;
    } else if (key == 'a') {
      Xrot-=0.01;
    }
    /*if (key == CODED) {
      if (keyCode == UP) {
      me.location.y-=3;
      }
      if (keyCode == DOWN) {
      me.location.y+=3;
      }
      if (keyCode == RIGHT) {
      me.location.x+=3;
      }
      if (keyCode == LEFT) {
      me.location.x-=3;
      }
    }*/
      
    }

void keyReleased(){
  setMove(keyCode, false);
  isPressed = false;
  if (key == 'p') {
        ready = true;
        //g1 = new gameM();
        agentlist.clear();
        pointlist.clear();
        lineg.clear();
        goals.clear();
        starts.clear();
        init();
    }
  if (key == '2') {
    if(game){
      maze = false;
    }
    else{
        maze = true;
    }
    }
  if (key == '1') {
      if(place){
      place = false;
    }
    else{
        place = true;
    }
    }
      if (key == '3') {
      if(premake){
      premake = false;
    }
    else{
        premake = true;
    }
    } if (key == '4') {
      if(nocor){
      nocor = false;
    }
    else{
        nocor = true;
    }
    }
  
}
boolean setMove(int k, boolean b) {
  switch (k) {
  case UP:
    return isUp = b;
 
  case DOWN:
    return isDown = b;
 
  case LEFT:
    return isLeft = b;
 
  case RIGHT:
    return isRight = b;
 
  default:
    return b;
  }
}

void draw() {
astravg += astrs/(1000000.0);
aastravg += aastrs/(1000000.0);
tstravg += tstrs/(1000000.0);
astrs = 0;
aastrs = 0;
tstrs = 0;
  if(ready && false){
  if(System.currentTimeMillis()-time1 > 120000|| enemies == 0 || allies == 0){
    System.out.println(flago+1);
  if(flago < 5){
    System.out.println("First");
  timeavg += ((System.currentTimeMillis()-time1));
  //algtimeavg += realsum/usecount;
  astravg2 = astravg/astrc;
  aastravg2 = aastravg/aastrc;
  tstravg2 = tstravg/tstrc;
  bgoalavg += AScore;
  bleftavg += allies;
  rgoalavg +=  EScore;
  rleftavg +=  enemies;
  }
   if( (int)flago == 4){
   int temp = allytype;
   allytype = enemytype;
   enemytype = temp;
   }
   if(flago > 4){
     System.out.println("Second");
  timeavg += ((System.currentTimeMillis()-time1));
  //algtimeavg += realsum/usecount;
    astravg2 = astravg/astrc;
  aastravg2 = aastravg/aastrc;
  tstravg2 = tstravg/tstrc;
  bgoalavg += EScore;
  bleftavg += enemies;
  rgoalavg += AScore;
  rleftavg += allies;
   }
   if((int)flago == 9){
     flago++;
  System.out.println("Avg-time: "+ timeavg/flago);
  System.out.println("A_Star-time: "+astravg2/flago);
  System.out.println("Anytime_A*-time: "+aastravg2/flago);
  System.out.println("Theta*-time: "+tstravg2/flago);
  System.out.println("Blue Type: " +enemytype);
  System.out.println("Blue Left: " +bleftavg/flago);
  System.out.println("Blue Goals: " + bgoalavg/flago);
  System.out.println("Red Type: " +allytype);
  System.out.println("Red Left: "+ rleftavg/flago);
  System.out.println("Red Goals: " + rgoalavg/flago);
   }

astrc = 0;
aastrc = 0;
tstrc = 0;

astravg = 0;
aastravg = 0;
tstravg = 0;

time1 = System.currentTimeMillis();
  AScore = 0;
  allies = 0;
  EScore = 0;
  enemies = 0;
        agentlist.clear();
        pointlist.clear();
        lineg.clear();
        goals.clear();
        starts.clear();
        init();
   flago++;
}
}
  background(0);
  float X = mouseX;
  float Y = mouseY;
  if(game){
  if(Xtran < 0){
    X *= -1;
  }
  if(Ytran < 0){
    Y *= -1;
  }}
  stroke(17,160,130);
  //noStroke(); 
  fill(100);
  pushMatrix();
  translate(X + Xtran,Y+Ytran, Ztran);
  //circle(0,0,5);
  popMatrix();
  
  translate(Xtran,Ytran,Ztran);
  rotateX(-Yrot);
  rotateY(-Xrot);
  if(isPressed){
  keyPressed();}
  if(mouseflag){
  mousePressed();}
  if (isLeft)me.location.x-=3;
  if (isRight)me.location.x+=3;
  if (isDown)me.location.y+=3;
  if (isUp)me.location.y-=3;
   noFill();
  stroke(255);
  //System.out.println(agentlist.size());
  square(0,0,scensize);
  line(0,scensize/2,scensize,scensize/2);
  //line(scensize/2,0,scensize/2,scensize);
  fill(255);
  //circle(100,100,rad*2-10);
  for (Shape s: shapelist) {
   s.run();
  }
  if(ready){
  if(game){
  //me.run();
  }
  stroke(17,160,130);
  //for (Line ps: lineg) {
 // ps.run();
 // }
  stroke(255,0,200);
  for (Point ps: goals) {
  ps.run();
  }
 //for (Point ps: pointlist) {
//  ps.run();
// }
  //hint(ENABLE_DEPTH_SORT);
  //bal.update();
 for (agent a: agentlist) {
  //a.cohesion();
  //a.align();
  a.separate();
 }
  for(int i = agentlist.size()-1; i >= 0; i--){
     stroke(17,160,130);
      if(!game){
    //  for (Line ps: agentlist.get(i).lines) {
   //  ps.run();
   // }
      }/*
      if(allies == 0 && agentlist.get(i).team == 0){
      PVector vec = agentlist.get(i).location.copy();
           Point temp = new Point(vec);
           starts.add(temp);
           addnode(temp);
           agentlist.remove(i);
           agentlist.add(new agent(temp,enemyflag,0, 0, allytype));
           allies++;
      }
      if(enemies == 0 && agentlist.get(i).team == 1){
      PVector vec = agentlist.get(i).location.copy();
           Point temp = new Point(vec);
           starts.add(temp);
           addnode(temp);
           agentlist.remove(i);
           agentlist.add(new agent(temp,allyflag,0,1,enemytype));
           enemies++;
      }*/
    agentlist.get(i).update();
  }
 /* for(agentmanager m: managerlist){
  m.update();
  }*/
  //hint(DISABLE_DEPTH_SORT);
  }
  else{
    fill(0,255,0);
    for (Point ps: pointlist) {
  ps.run();
  }
  fill(155,0,155);
  for (Point ps: starts) {
  ps.run();
  }
  }
  
  
  
   /*  fill(255,0,0);
    rect(0,-50,100,30,7);
    textSize(24);
    fill(0);
    text(HP +"HP", 5, -24);*/
textSize(72);
fill(255,0,0);
text("Red Score: " + AScore, 100, -25);
fill(0,0,255);
text("Blue Score: " + EScore, 100, scensize+70);
//text(frameRate, -40, -150);

  
  
  
  
  
  
}
