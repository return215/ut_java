package xyz.return215.ut_java.tugas2.strukdat;

import java.util.Arrays;
import java.util.Scanner;

public class Sorting {
    Scanner scanner;
    public Sorting(Scanner scanner) {
        this.scanner = scanner;

        /* --- Setup --- */
        Runtime runtime = Runtime.getRuntime();

        int[] originalData = {
            5, 3, 8, 3, 9, 1, 4, 7, 3, 6,
            2, 5, 8, 6, 7, 2, 4, 1, 9, 0,
            3, 5, 7, 4, 2, 6, 8, 1, 9, 0,
            4, 5, 6, 3, 2, 7, 8, 1, 0, 9,
            6, 3, 2, 1, 5, 4, 7, 8, 9, 0,
            3, 4, 5, 6, 7, 8, 9, 1, 2, 0,
            5, 3, 7, 2, 4, 6, 1, 8, 0, 9,
            2, 4, 6, 8, 0, 1, 3, 5, 7, 9,
            6, 2, 4, 8, 1, 3, 5, 7, 9, 0,
            5, 3, 1, 7, 2, 4, 6, 0, 9, 8
        };

        System.out.println(runtime.totalMemory());
        System.out.println(runtime.freeMemory());
        System.out.println(runtime.maxMemory());

        // print original data
        // 10 at a time
        // format:
        // | -- originalData --- |
        // | 0 1 2 3 4 5 6 7 8 9 |

        System.out.println("| -- originalData --- |");

        for (int i = 0; i < originalData.length; i += 10) {
            System.out.print("| ");
            for (int j = i; j < Math.min(i + 10, originalData.length); j++) {
                System.out.print(originalData[j] + " ");
            }
            System.out.println("|");
        }

        /* ---  Sorting  --- */

        int[] sortedData = originalData.clone();
        int[] mergeSortData = originalData.clone();
        int[] countingSortData = originalData.clone();

        // Measure Arrays.sort
        runtime.gc();
        long memoryBefore = usedMemory(runtime);
        long startTime = System.nanoTime();
        Arrays.sort(sortedData);
        long endTime = System.nanoTime();
        long memoryAfter = usedMemory(runtime);
        long timeTaken = endTime - startTime;
        long memoryUsed = memoryAfter - memoryBefore;
        System.out.println("\nArrays.sort Performance:");
        System.out.println("Time: " + timeTaken + " nanoseconds");
        System.out.println("Memory: " + memoryUsed + " bytes");

        // Measure MergeSort
        runtime.gc();
        memoryBefore = usedMemory(runtime);
        startTime = System.nanoTime();
        MergeSort.sort(mergeSortData);
        endTime = System.nanoTime();
        memoryAfter = usedMemory(runtime);
        timeTaken = endTime - startTime;
        memoryUsed = memoryAfter - memoryBefore;
        System.out.println("\nMergeSort Performance:");
        System.out.println("Time: " + timeTaken + " nanoseconds");
        System.out.println("Memory: " + memoryUsed + " bytes");

        // Measure CountingSort
        runtime.gc();
        memoryBefore = usedMemory(runtime);
        startTime = System.nanoTime();
        CountingSort.sort(countingSortData);
        endTime = System.nanoTime();
        memoryAfter = usedMemory(runtime);
        timeTaken = endTime - startTime;
        memoryUsed = memoryAfter - memoryBefore;
        System.out.println("\nCountingSort Performance:");
        System.out.println("Time: " + timeTaken + " nanoseconds");
        System.out.println("Memory: " + memoryUsed + " bytes");

        /* --- Result --- */

        // print sortedData, mergeSortData, and countingSortData
        // 10 at a time, side by side
        // format:
        // | --- sortedData ---- | -- mergeSortData -- | countingSortData -- |
        // | 0 1 2 3 4 5 6 7 8 9 | 0 1 2 3 4 5 6 7 8 9 | 0 1 2 3 4 5 6 7 8 9 |

        System.out.println(
            "| --- sortedData ---- | -- mergeSortData -- | countingSortData -- |"
        );

        for (int i = 0; i < sortedData.length; i += 10) {
            System.out.print("| ");
            for (int j = i; j < Math.min(i + 10, sortedData.length); j++) {
                System.out.print(sortedData[j] + " ");
            }
            System.out.print("| ");
            for (int j = i; j < Math.min(i + 10, mergeSortData.length); j++) {
                System.out.print(mergeSortData[j] + " ");
            }
            System.out.print("| ");
            for (int j = i; j < Math.min(i + 10, countingSortData.length); j++) {
                System.out.print(countingSortData[j] + " ");
            }
            System.out.println("|");
        }
    }

    private static long usedMemory(Runtime runtime) {
        return runtime.totalMemory() - runtime.freeMemory();
    }
}
