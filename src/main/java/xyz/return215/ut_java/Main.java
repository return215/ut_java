package xyz.return215.ut_java;

import xyz.return215.ut_java.tugas1.alpro.Overtime;
import xyz.return215.ut_java.tugas1.strukdat.Datatypes;
import xyz.return215.ut_java.tugas2.alpro.Overtime2;
import xyz.return215.ut_java.tugas2.alpro.Overtime2plus;
import xyz.return215.ut_java.tugas2.strukdat.Sorting;
import xyz.return215.ut_java.tugas3.alpro.Overtime3;
import xyz.return215.ut_java.tugas3.strukdat.GraphTraverse;

import java.lang.reflect.Constructor;
import java.util.Scanner;
import java.util.function.Function;

public class Main {
    // MenuItem class to hold program information and instantiation logic
    private static class MenuItem {
        private final String title;
        private final String description;
        private final Function<Scanner, Object> constructor;

        public <T> MenuItem(String title, String description, Class<T> clazz) {
            this.title = title;
            this.description = description;
            this.constructor = scanner -> {
                try {
                    Constructor<T> constructor = clazz.getConstructor(Scanner.class);
                    return constructor.newInstance(scanner);
                } catch (Exception e) {
                    System.err.println("Error instantiating " + clazz.getSimpleName() + ": " + e.getMessage());
                    return null;
                }
            };
        }

        public void run(Scanner scanner) {
            constructor.apply(scanner);
        }

        @Override
        public String toString() {
            return title + " - " + description;
        }
    }


    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);

        // Array of menu items
        MenuItem[] menuItems = {
            new MenuItem("1.AP/Overtime", "Handles overtime calculations (proof of concept).", Overtime.class),
            new MenuItem("1.SD/Datatypes", "Handles various data types.", Datatypes.class),
            new MenuItem("2.AP/Overtime2", "Handles overtime calculations.", Overtime2.class),
            new MenuItem("2.AP/Overtime2plus", "Handles overtime calculations (alt implement).", Overtime2plus.class),
            new MenuItem("2.SD/Sorting", "Demonstrate sorting algorithms.", Sorting.class),
            new MenuItem("3.AP/Overtime3", "Handles overtime calculations (with arrays).", Overtime3.class),
            new MenuItem("3.SD/GraphTraversal", "Demonstrate graph traversal algorithms.", GraphTraverse.class)
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

        while (true) {
            // Display menu
            System.out.println("Select program:");
            for (int i = 0; i < menuItems.length; i++) {
                System.out.println((i + 1) + ". " + menuItems[i]);
            }
            System.out.println("0. Exit");
            
            // Get user input
            System.out.print("Enter your choice (0-" + menuItems.length + "): ");
            int choice;
            try {
                choice = Integer.parseInt(scanner.nextLine());
            } catch (NumberFormatException e) {
                System.out.println("Please enter a valid number.\n");
                continue;
            }

            // Handle exit
            if (choice == 0) {
                break;
            }

            // Validate choice
            if (choice < 0 || choice > menuItems.length) {
                System.out.println("Invalid choice. Please try again.\n");
                continue;
            }


            // Run selected program (adjusting for 0-based index)
            System.out.println("\n--- Running " + menuItems[choice - 1].title + " ---");
            menuItems[choice - 1].run(scanner);
            System.out.println("\n--- Program finished. ---\n");


            if (scanner.hasNextLine()) {
                scanner.nextLine(); // flush
                System.out.println("STDIN flushed.");
            }
        }

        scanner.close();
        System.out.println("Goodbye!");
    }
}