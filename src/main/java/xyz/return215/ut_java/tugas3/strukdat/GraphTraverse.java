package xyz.return215.ut_java.tugas3.strukdat;

import java.util.Random;
import java.util.Scanner;

public class GraphTraverse {
    Scanner scanner;

    public GraphTraverse(Scanner _scanner) {
        scanner = _scanner;

        Graph graph = new Graph(10);

        // Generate random edges
        Random random = new Random(42); // Fixed seed for reproducibility
        for (int i = 0; i < 50; i++) {
            int src = random.nextInt(10);
            int dest;
            do {
                dest = random.nextInt(10);
            } while (dest == src);
            graph.addEdge(src, dest);
        }

        // Print adjacency list
        for (int i = 0; i < 10; i++) {
            System.out.print("Vertex " + i + ": ");
            for (int neighbor : graph.getAdjacentVertices(i)) {
                System.out.print(neighbor + " ");
            }
            System.out.println();
        }

        System.out.println("Breadth-first traversal:");
        BreadthFirst.traverseAll(graph);
        System.out.println();

        System.out.println("Depth-first traversal:");
        DepthFirst.traverseAll(graph);
        System.out.println();
    }
}
