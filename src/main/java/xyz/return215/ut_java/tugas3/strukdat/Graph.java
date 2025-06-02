package xyz.return215.ut_java.tugas3.strukdat;

import java.util.List;
import java.util.ArrayList;

/**
 * Contoh implementasi directed graph
 */
public class Graph {
    private final List<List<Integer>> adjacencyList;
    private final int vertex_count;

    public Graph(int vertex_count) {
        this.vertex_count = vertex_count;
        adjacencyList = new ArrayList<>();
        for (int i = 0; i < vertex_count; i++) {
            adjacencyList.add(new ArrayList<>());
        }
    }

    public int getVertexCount() {
        return vertex_count;
    }

    public void addEdge(int src, int dest) {
        // check if dest exists in src's adjacency list
        if (!adjacencyList.get(src).contains(dest)) {
            adjacencyList.get(src).add(dest);
        }
    }

    public List<Integer> getAdjacentVertices(int vertex) {
        return adjacencyList.get(vertex);
    }
}
