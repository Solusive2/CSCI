ArrayList<Point> theta_star(Point start, Point goal, agent self){
      long starttime = System.nanoTime();
    tstrc++;
  
  
    // This main loop is the same as A*
    Map<Point, Double> gScore = new HashMap<Point, Double>();
    gScore.put( start, new Double(0.0));
    //gScore(start) := 0
    Map<Point, Point> cameFrom = new HashMap<Point, Point>();
    cameFrom.put(start, start);
    //parent(start) := start
    // Initializing open and closed sets. The open set is initialized 
    // with the start node and an initial cost
    //open := {}
    //open.insert(start, gScore(start) + heuristic(start))
    ArrayList<Point> openSet = new ArrayList<Point>();
    openSet.add(start);
    Map<Point, Double> fScore = new HashMap<Point, Double>();
    fScore.put(start,AS_H(start,goal, self));
    // gScore(node) is the current shortest distance from the start node to node
    // heuristic(node) is the estimated distance of node from the goal node
    // there are many options for the heuristic such as Euclidean or Manhattan 
    ArrayList<Point> closed = new ArrayList<Point>();
    //closed := {}
    while (!openSet.isEmpty()){
        //s := open.pop()
        Point s = lowest(openSet, fScore);
        openSet.remove(s);
        if (s == goal){
          
               tstrs+= System.nanoTime() - starttime;
          
            return reconstruct_path2(cameFrom, s);}
        closed.add(s);
        for(Point neighbor: s.neighbors){
        // Loop through each immediate neighbor of s
            if (!closed.contains(neighbor)){
                if (!openSet.contains(neighbor)){
                    // Initialize values for neighbor if it is 
                    // not already in the open list
                    //gScore(neighbor) := infinity
                    gScore.put(neighbor,inf);
                    fScore.put(neighbor,inf);
                    //parent(neighbor) := Null
                    cameFrom.put(neighbor, null);}
                    //System.out.println(neighbor);
                  
                              // This part of the algorithm is the main difference between A* and Theta*
                    if (CheckLBound(cameFrom.get(s), neighbor,true)){
                      //if(true){
                        // If there is line-of-sight between parent(s) and neighbor
                        // then ignore s and use the path from parent(s) to neighbor 
                        float c = cameFrom.get(s).location.dist(neighbor.location);
                        if (gScore.get(cameFrom.get(s)) + c < gScore.get(neighbor)){
                            // c(s, neighbor) is the Euclidean distance from s to neighbor
                           gScore.put(neighbor, gScore.get(cameFrom.get(s)) + c);
                           cameFrom.put(neighbor, cameFrom.get(s));
                            if (openSet.contains(neighbor)){
                                openSet.remove(neighbor);}
                            openSet.add(neighbor);
                            fScore.put(neighbor, gScore.get(neighbor) + AS_H(neighbor, goal, self));}}
                    else{
                        // If the length of the path from start to s and from s to 
                        // neighbor is shorter than the shortest currently known distance
                        // from start to neighbor, then update node with the new distance
                        if (gScore.get(s) + s.location.dist(neighbor.location) < gScore.get(neighbor)){
                            gScore.put(neighbor,gScore.get(s)+ s.location.dist(neighbor.location));
                            cameFrom.put(neighbor, s);
                            if (openSet.contains(neighbor)){
                                openSet.remove(neighbor);}
                            openSet.add(neighbor);
                            fScore.put(neighbor, gScore.get(neighbor) + AS_H(neighbor, goal, self));}}
              }}}
                //update_vertex(s, neighbor, cameFrom, gScore, fScore);}}}
  return null;}
            
    
ArrayList<Point> reconstruct_path2(Map<Point, Point> cameFrom, Point s){
    ArrayList<Point> total_path = new ArrayList<Point>();
    //total_path := {current}
    total_path.add(s);
    //while current in cameFrom.Keys:
    while(cameFrom.get(s) != s){
        //current := cameFrom[current]
       s = cameFrom.get(s);
        //total_path.prepend(current);
        total_path.add(0, s);
    }
    return total_path;
}
