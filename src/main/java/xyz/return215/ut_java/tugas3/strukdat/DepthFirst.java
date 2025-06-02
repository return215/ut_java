package xyz.return215.ut_java.tugas3.strukdat;

import java.util.Stack;

/**
 * Contoh implementasi depth-first traversal
 * menggunakan stack
 */
public class DepthFirst {
    public static void traverseAll(Graph graph) {
        int vertexCount = graph.getVertexCount();
        for (int i = 0; i < vertexCount; i++) {
            traverse(graph, i);
        }
    }

    public static void traverse(Graph graph, int vertex) {
        int vertexCount = graph.getVertexCount();
        boolean[] visited = new boolean[vertexCount];
        Stack<Integer> stack = new Stack<>();

        // menambahkan vertex awal ke stack
        stack.push(vertex);

        while (!stack.isEmpty()) {
            int currentVertex = stack.pop();

            if (!visited[currentVertex]) {
                visited[currentVertex] = true;
                System.out.print(currentVertex + " ");

                for (int neighbor : graph.getAdjacentVertices(currentVertex)) {
                    if (!visited[neighbor]) {
                        stack.push(neighbor);
                    }
                }
            }
        }

        System.out.println();
    }
}
