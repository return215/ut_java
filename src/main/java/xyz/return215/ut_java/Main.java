package xyz.return215.ut_java;

import xyz.return215.ut_java.tugas1.alpro.Overtime;
import xyz.return215.ut_java.tugas1.strukdat.Datatypes;
import xyz.return215.ut_java.tugas2.alpro.Overtime2;
import xyz.return215.ut_java.tugas2.alpro.Overtime2plus;
import xyz.return215.ut_java.tugas2.strukdat.Sorting;
import xyz.return215.ut_java.tugas3.alpro.Overtime3;
import xyz.return215.ut_java.tugas3.strukdat.GraphTraverse;

import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        boolean stop = false;

        String[] programs = {
            "1.AP/Overtime",
            "1.SD/Datatypes",
            "2.AP/Overtime2",
            "2.AP/Overtime2plus",
            "2.SD/Sorting",
            "3.AP/Overtime3",
            "3.SD/GraphTraversal",
        };
        String[] descriptions = {
            "Handles overtime calculations (proof of concept).",
            "Handles various data types.",
            "Handles overtime calculations.",
            "Handles overtime calculations (alt implement).",
            "Demonstrate sorting algorithms.",
            "Handles overtime calculations (with arrays).",
            "Demonstrate graph traversal algorithms.",
        };

        System.out.println("""
            Nama : Muhammad Hidayat
            NIM  : 052747132
            Prodi: Sains Data
            UPBJJ: Bogor
            - MSIM4202 Struktur Data, Kelas 65
            - MSIM4203 Algoritma dan Pemrograman, Kelas 42
            - MSIM4206 Basis Data, Kelas 66
            """);

        //TIP Start main loop

        while (!stop) {
            System.out.println("Select program:");
            for (int i = 0; i < programs.length; i++) {
                System.out.println(i + 1 + ": " + programs[i] + " - " + descriptions[i]);
            }
            System.out.println("0: Exit");
            int choice = scanner.nextInt();
            // flush
            scanner.nextLine();

            // INSTANTIATE TO RUN
            switch (choice) {
                case 0:
                    stop = true;
                    break;
                case 1:
                    new Overtime(scanner);
                    break;
                case 2:
                    new Datatypes(scanner);
                    break;
                case 3:
                    new Overtime2(scanner);
                    break;
                case 4:
                    new Overtime2plus(scanner);
                    break;
                case 5:
                    new Sorting(scanner);
                    break;
                case 6:
                    new Overtime3(scanner);
                    break;
                case 7:
                    new GraphTraverse(scanner);
                    break;
                default:
                    System.out.println("Invalid choice, please try again.");
                    break;
            }
        }
        scanner.close();
    }
}