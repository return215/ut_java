package xyz.return215.ut_java.tugas3.strukdat;

import java.util.LinkedList;
import java.util.Queue;

/**
 * Contoh implementasi breadth-first traversal
 * menggunakan queue
 */
public class BreadthFirst {
    public static void traverseAll(Graph graph) {
        int vertexCount = graph.getVertexCount();
        for (int i = 0; i < vertexCount; i++) {
            traverse(graph, i);
        }
    }

    public static void traverse(Graph graph, int vertex) {
        int vertexCount = graph.getVertexCount();
        boolean[] visited = new boolean[vertexCount];
        Queue<Integer> queue = new LinkedList<>();

        // menambahkan vertex awal ke queue
        queue.offer(vertex);
        visited[vertex] = true;

        while (!queue.isEmpty()) {
            int currentVertex = queue.poll();
            System.out.print(currentVertex + " ");

            for (int neighbor : graph.getAdjacentVertices(currentVertex)) {
                if (!visited[neighbor]) {
                    queue.offer(neighbor);
                    visited[neighbor] = true;
                }
            }
        }

        System.out.println();
    }
}
