import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.HashSet;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Set;

public class DijkstraAlgorithm {

    private final List<Point> nodes;
    private final List<Line> Lines;
    private Set<Point> settledNodes;
    private Set<Point> unSettledNodes;
    private Map<Point, Point> predecessors;
    private Map<Point, Float> distance;

    public DijkstraAlgorithm(ArrayList<Point> pointlist, ArrayList<Line> linelist) {
        // create a copy of the array so that we can operate on this array
        this.nodes = new ArrayList<Point>(pointlist);
        this.Lines = new ArrayList<Line>(linelist);
    }

    public void execute(Point source) {
        settledNodes = new HashSet<Point>();
        unSettledNodes = new HashSet<Point>();
        distance = new HashMap<Point, Float>();
        predecessors = new HashMap<Point, Point>();
        distance.put(source, 0.0);
        unSettledNodes.add(source);
        while (unSettledNodes.size() > 0) {
            Point node = getMinimum(unSettledNodes);
            settledNodes.add(node);
            unSettledNodes.remove(node);
            findMinimalDistances(node);
        }
    }

    private void findMinimalDistances(Point node) {
        List<Point> adjacentNodes = getNeighbors(node);
        for (Point target : adjacentNodes) {
            if (getShortestDistance(target) > getShortestDistance(node)
                    + getDistance(node, target)) {
                distance.put(target, getShortestDistance(node)
                        + getDistance(node, target));
                predecessors.put(target, node);
                unSettledNodes.add(target);
            }
        }

    }

    private float getDistance(Point node, Point target) {
        for (Line Line : Lines) {
            if (Line.p1.equals(node)
                    && Line.p2.equals(target)) {
                return Line.dist;
            }
        }
        throw new RuntimeException("Should not happen");
    }

    private List<Point> getNeighbors(Point node) {
        List<Point> neighbors = new ArrayList<Point>();
        for (Line Line : Lines) {
            if (Line.p1.equals(node)
                    && !isSettled(Line.p2)) {
                neighbors.add(Line.p2);
            }
        }
        return neighbors;
    }

    private Point getMinimum(Set<Point> Pointes) {
        Point minimum = null;
        for (Point Point : Pointes) {
            if (minimum == null) {
                minimum = Point;
            } else {
                if (getShortestDistance(Point) < getShortestDistance(minimum)) {
                    minimum = Point;
                }
            }
        }
        return minimum;
    }

    private boolean isSettled(Point Point) {
        return settledNodes.contains(Point);
    }

    private float getShortestDistance(Point destination) {
        Float d = distance.get(destination);
        if (d == null) {
            return Float.MAX_VALUE;
        } else {
            return d;
        }
    }

    /*
     * This method returns the path from the source to the selected target and
     * NULL if no path exists
     */
    public ArrayList<Point> getPath(Point target) {
        ArrayList<Point> path = new ArrayList<Point>();
        Point step = target;
        // check if a path exists
        if (predecessors.get(step) == null) {
            return null;
        }
        path.add(step);
        while (predecessors.get(step) != null) {
            step = predecessors.get(step);
            path.add(step);
        }
        // Put it into the correct order
        Collections.reverse(path);
        return path;
    }

}









/*ArrayList<Point> search(Point s, Point g){
ArrayList<Point> pathlist = new ArrayList<Point>();
Point goal = g;
Point start = s;
pathlist.add(start);
pointlist.add(goal);

float closestdist = 90000;
int closest = -1;
boolean found = false;
Point current = start;
int searchdist = 30;
int count = 0;
while(!found){
if(closest == -1){
  count++;
}
if(count == 3){
 searchdist+=10; 
}
ArrayList<Point> closelist = new ArrayList<Point>();
for(int i = 0; i <pointlist.size(); i++){
if(current.location.dist(pointlist.get(i).location) < searchdist && CheckLBound(current,pointlist.get(i))){
closelist.add(pointlist.get(i));
}
}
for(int i = 0; i <closelist.size(); i++){
    if(closelist.get(i) == goal){
      found = true;
      pathlist.add(goal);
      break;
    }
    else if(closelist.get(i).location.dist(goal.location) < closestdist){
      closestdist = closelist.get(i).location.dist(goal.location);
      closest = i;//pointlist.get(i);
    }
 
}
if(closest != -1){
pathlist.add(closelist.get(closest));
current = closelist.get(closest);
//found = true;
//pathlist.add(goal);
closest = -1;
}
}
return pathlist;
}*/
