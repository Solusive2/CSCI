
//assume goal is in pointlist
//pointlist and lineg should be moved to team lists

// A* finds a path from start to goal.
// h is the heuristic function. h(n) estimates the cost to reach goal from node n.
ArrayList<Point> tconASTAR(Point start, Point goal, agent self, long duration, float div){
    long starttime2 = System.nanoTime();
    aastrc++;
  
  
  
    // The set of discovered nodes that may need to be (re-)expanded.
    // Initially, only the start node is known.
    // openSet := {start}
    long starttime = System.currentTimeMillis();
    //long starttime = System.nanoTime();
    // 1 million milliseconds
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
        if (current == goal || ((System.currentTimeMillis() - starttime) > duration/div)){
            aastrs+= System.nanoTime() - starttime2;
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




/*public class ctr_manager
{
  boolean is_First = true;
  Point new_Solution = null;
  
  
  public void run_A( ){
    Thread.sleep(1000);
    boolean goalSucc = true;
  }
  public void thread_AA(int sleep_Time, Point rN, Point gN, agent self)
  {
    Thread a = new Thread("run_A");
    if(is_First)
    {
       new_Solution = rN;
       a.start();
       A_Star(rN, gN, self);
    } else if( rN == new_Solution)
    {
       // keep all the states intact because algorithm needs more time
       // to find a better solution
       a.start();
       A_Star(rN, gN, self);
    } else if( rN != new_Solution)
    {
       // algorithm finds an improve solution, clears all the previous states
       // to allow algorithm a fresh start
       //closeList.RemoveAll( );
       //openList.RemoveAll( );
       a.start();
       A_Star( new_Solution, gN, self);
    }
  }
}*/
