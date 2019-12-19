import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.HashSet;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Set;

double inf = Double.POSITIVE_INFINITY;


Double AS_H(Point p, Point goal, agent self){
//manhatten dist
float mandist =  p.location.dist(goal.location) *  p.location.dist(goal.location);
//check if enemy near node
int x = 200;
for (agent a: agentlist) {
//f(a != self && !a.done && a.type == 5 && self.type != 5){
  if(a != self && a.team != self.team && a.type == 5 && self.type != 5){
float distance = a.location.dist(p.location);
if(distance < x){
mandist += (x - distance) * (x - distance) * (x - distance)* 0.1; 
}
if( self.location != null && distance < self.location.dist(p.location) && self.location.dist(p.location) < 150){
mandist += ((self.location.dist(p.location) - distance)) * ((self.location.dist(p.location) - distance)) *50; 
}
}
/*else if(a != self && a.team == self.team && a.type == self.type){
x = 100;
float distance = a.location.dist(p.location);
if(distance < x){
mandist += (x - distance) * (x - distance) * (x - distance)* 0.001; 
}

}*/



}

if(self.type == 5 && self.team == 1){
float temp = enemyflag.location.dist(p.location); 
mandist +=  (temp*temp*temp)/2;

}
if(self.type == 5 && self.team == 0){
float temp = allyflag.location.dist(p.location); 
mandist +=  (temp*temp*temp)/2;

}
//float distance = p.location.dist(current.location);
//if(distance > x){
//mandist += (distance - x) * 1;
//}
return new Double(mandist);
}
Point lowest(ArrayList<Point> list, Map<Point, Double> fScore){
    Point near = null;
    Double nearscore = inf;
    for (Point p: list) {
     Double score = fScore.get(p);
     if(score < nearscore){
     nearscore = score;
     near = p;
     }
    }
    return near;
}

ArrayList<Point> neighbors(Point p){
      ArrayList<Point> bors = new ArrayList<Point>();
      for (Line l: lineg) {
     if(l.p1 == p){
       bors.add(l.p2);     
     }
}
return bors;
}
ArrayList<Point> reconstruct_path( Map<Point, Point> cameFrom,Point current) {
    ArrayList<Point> total_path = new ArrayList<Point>();
    //total_path := {current}
    total_path.add(current);
    //while current in cameFrom.Keys:
    while(cameFrom.get(current) != null){
        //current := cameFrom[current]
        current = cameFrom.get(current);
        //total_path.prepend(current);
        total_path.add(0, current);
    }
    return total_path;
}

//assume goal is in pointlist
//pointlist and lineg should be moved to team lists

// A* finds a path from start to goal.
// h is the heuristic function. h(n) estimates the cost to reach goal from node n.
ArrayList<Point> A_Star(Point start, Point goal, agent self){
  
    long starttime = System.nanoTime();
    astrc++;

  
  
    // The set of discovered nodes that may need to be (re-)expanded.
    // Initially, only the start node is known.
    // openSet := {start}
    ArrayList<Point> openSet = new ArrayList<Point>();
    openSet.add(start);
    // For node n, cameFrom[n] is the node immediately preceding it on the cheapest path from start to n currently known.
    // cameFrom := an empty map
    Map<Point, Point> cameFrom = new HashMap<Point, Point>();
    // For node n, gScore[n] is the cost of the cheapest path from start to n currently known.
    //gScore := map with default value of Infinity
    Map<Point, Double> gScore = new HashMap<Point, Double>();
    for (Point ps: pointlist) {
      gScore.put(ps,inf);
    }
    //gScore[start] := 0
    gScore.put( start, new Double(0.0));
    

    // For node n, fScore[n] := gScore[n] + h(n).
    //fScore := map with default value of Infinity
    Map<Point, Double> fScore = new HashMap<Point, Double>();
    for (Point ps: pointlist) {
      fScore.put(ps,inf);
    }
    //fScore[start] := h(start)
    fScore.put(start,AS_H(start,goal, self));

    while (!openSet.isEmpty()){
        //current := the node in openSet having the lowest fScore[] value
        Point current = lowest(openSet, fScore);
        if (current == goal){
          
          
            astrs+= System.nanoTime() - starttime;
            
            
            return reconstruct_path(cameFrom, current);
        }
        openSet.remove(current);
        //for each neighbor of current
       /* for (Line l: lineg){
          if(l.p1 == current && l.p2 != null){
            Point neighbor = l.p2;*/
        for(Point neighbor: current.neighbors){
            // d(current,neighbor) is the weight of the edge from current to neighbor
            // tentative_gScore is the distance from start to the neighbor through current
            //tentative_gScore := gScore[current] + d(current, neighbor)
            
            //Double tentative_gScore = gScore.get(current) + l.dist;
            Double tentative_gScore = gScore.get(current) + current.location.dist(neighbor.location);
            
            // if tentative_gScore < gScore[neighbor]
            //System.out.println(tentative_gScore);
            if (gScore.get(neighbor) == null){
                return null;
            }
            else if (tentative_gScore < gScore.get(neighbor)){
                // This path to neighbor is better than any previous one. Record it!
                //cameFrom[neighbor] := current
                cameFrom.put(neighbor, current);
                //gScore[neighbor] := tentative_gScore
                gScore.put(neighbor,tentative_gScore);
                //fScore[neighbor] := gScore[neighbor] + h(neighbor)
                 fScore.put(neighbor,tentative_gScore + AS_H(neighbor,goal, self));
                //if neighbor not in openSet
                if ( !openSet.contains(neighbor)){
                    openSet.add(neighbor);
                }
            }}}//}
    // Open set is empty but goal was never reached
    return null;
}
