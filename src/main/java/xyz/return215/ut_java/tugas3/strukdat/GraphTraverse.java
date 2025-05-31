package xyz.return215.ut_java.tugas3.strukdat;

import java.util.Scanner;

public class GraphTraverse {
    Scanner scanner;

    public GraphTraverse(Scanner _scanner) {
        scanner = _scanner;

        Graph graph = new Graph(10);

        graph.addEdge(0, 2);
    }
}
