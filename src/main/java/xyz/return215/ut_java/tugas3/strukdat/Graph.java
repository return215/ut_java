package xyz.return215.ut_java.tugas3.strukdat;

import java.util.List;
import java.util.ArrayList;

/**
 * Contoh implementasi directed graph
 */
public class Graph {
    private List<List<Integer> > adjacencyList;

    public Graph(int vertex_count) {
        adjacencyList = new ArrayList<ArrayList<Integer> >();
        for (int i = 0; i < vertex_count; i++) {
            adjacencyList.add(new ArrayList<Integer>());
        }
    }

    public void addEdge(int src, int dest) {
        adjacencyList.get(src).add(dest);
    }

    public List<Integer> getAdjacentVertices(int vertex) {
        return adjacencyList.get(vertex);
    }
}
