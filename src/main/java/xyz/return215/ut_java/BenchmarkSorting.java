package xyz.return215.ut_java;

import xyz.return215.ut_java.tugas2.strukdat.MergeSort;
import xyz.return215.ut_java.tugas2.strukdat.CountingSort;

import java.io.FileWriter;
import java.io.IOException;
import java.text.DecimalFormat;
import java.text.NumberFormat;
import java.util.*;
import java.util.stream.Collectors;

public class BenchmarkSorting {
    private static final int WARMUP_RUNS = 10;
    private static final int BENCHMARK_RUNS = 500;
    private static final Runtime runtime = Runtime.getRuntime();
    private static final int[] originalData = {
        5, 3, 8, 3, 9, 1, 4, 7, 3, 6, 2, 5, 8, 6, 7, 2, 4, 1, 9, 0, 
        3, 5, 7, 4, 2, 6, 8, 1, 9, 0, 4, 5, 6, 3, 2, 7, 8, 1, 0, 9, 
        6, 3, 2, 1, 5, 4, 7, 8, 9, 0, 3, 4, 5, 6, 7, 8, 9, 1, 2, 0, 
        5, 3, 7, 2, 4, 6, 1, 8, 0, 9, 2, 4, 6, 8, 0, 1, 3, 5, 7, 9, 
        6, 2, 4, 8, 1, 3, 5, 7, 9, 0, 5, 3, 1, 7, 2, 4, 6, 0, 9, 8
    };

    private static class BenchmarkResult {
        String method;
        int runNumber;
        long timeNanos;
        long memoryUsedBytes;

        BenchmarkResult(String method, int runNumber, long timeNanos, long memoryUsedBytes) {
            this.method = method;
            this.runNumber = runNumber;
            this.timeNanos = timeNanos;
            this.memoryUsedBytes = memoryUsedBytes;
        }

        
        String toCsv() {
            return String.format("%s,%d,%d,%d", method, runNumber, timeNanos, memoryUsedBytes);
        }
        
        static String getCsvHeader() {
            return "method,run_number,time_ns,memory_bytes";
        }
    }


    public static void main(String[] args) {
        printOriginalData();
        
        List<BenchmarkResult> results = new ArrayList<>();
        
        // Warmup runs
        System.out.println("\nWarming up...");
        for (int i = 0; i < WARMUP_RUNS; i++) {
            runSort("Arrays.sort", i, i == 0);  // Print on first warmup run
            runSort("MergeSort", i, i == 0);    // Print on first warmup run
            runSort("CountingSort", i, i == 0); // Print on first warmup run
        }
        
        // Benchmark runs
        System.out.println("\nRunning benchmarks...");
        for (int i = 0; i < BENCHMARK_RUNS; i++) {
            results.add(runSort("Arrays.sort", i, false));
            results.add(runSort("MergeSort", i, false));
            results.add(runSort("CountingSort", i, false));
        }
        
        // Write results to CSV
        writeResultsToCsv(results);
        
        // Perform and print statistical analysis
        performStatisticalAnalysis(results);
    }
    
    private static void printOriginalData() {
        System.out.println("Original data (in columns of 10):");
        for (int i = 0; i < originalData.length; i += 10) {
            for (int j = 0; j < 10 && (i + j) < originalData.length; j++) {
                System.out.printf("%3d", originalData[i + j]);
            }
            System.out.println();
        }
    }
    
    private static BenchmarkResult runSort(String method, int runNumber, boolean printResult) {
        runGarbageCollector();
        int[] data = originalData.clone();
        runGarbageCollector();
        long startMem = getUsedMemory();
        long startTime = System.nanoTime();
        
        switch (method) {
            case "Arrays.sort":
                Arrays.sort(data);
                // Reverse to get descending order
                for (int i = 0; i < data.length / 2; i++) {
                    int temp = data[i];
                    data[i] = data[data.length - 1 - i];
                    data[data.length - 1 - i] = temp;
                }
                break;
            case "MergeSort":
                MergeSort.sort(data);
                break;
            case "CountingSort":
                CountingSort.sort(data);
                break;
        }
        
        long endTime = System.nanoTime();
        long endMem = getUsedMemory();
        
        if (printResult) {
            System.out.println("\nSorted result from " + method + " (first run):");
            for (int i = 0; i < data.length; i += 10) {
                for (int j = 0; j < 10 && (i + j) < data.length; j++) {
                    System.out.printf("%3d", data[i + j]);
                }
                System.out.println();
            }
        }
        
        return new BenchmarkResult(method, runNumber, endTime - startTime, endMem - startMem);
    }
    
    private static void runGarbageCollector() {
        // Run GC multiple times to ensure it's really cleaned up
        for (int i = 0; i < 3; i++) {
            System.gc();
            try {
                Thread.sleep(10);
            } catch (InterruptedException e) {
                Thread.currentThread().interrupt();
            }
        }
    }
    
    private static long getUsedMemory() {
        return runtime.totalMemory() - runtime.freeMemory();
    }
    
    private static void writeResultsToCsv(List<BenchmarkResult> results) {
        try (FileWriter writer = new FileWriter("benchmark_results.csv")) {
            writer.write(BenchmarkResult.getCsvHeader() + "\n");
            for (BenchmarkResult result : results) {
                writer.write(result.toCsv() + "\n");
            }
            System.out.println("\nBenchmark results written to benchmark_results.csv");
        } catch (IOException e) {
            System.err.println("Error writing benchmark results: " + e.getMessage());
        }
    }
    
    private static void performStatisticalAnalysis(List<BenchmarkResult> results) {
        Map<String, List<BenchmarkResult>> resultsByMethod = results.stream()
            .collect(Collectors.groupingBy(r -> r.method));
        
        NumberFormat nf = NumberFormat.getNumberInstance(Locale.US);
        if (nf instanceof DecimalFormat) {
            ((DecimalFormat) nf).applyPattern("#,##0.000");
        }
        
        StringBuilder analysis = new StringBuilder();
        analysis.append("\nStatistical Analysis (time in nanoseconds, memory in bytes):\n");
        analysis.append(String.format("%-20s %-10s %10s %10s %10s %10s %10s %10s %10s %10s\n",
            "Method", "Metric", "Count", "Mean", "StdDev", "Min", "25%", "Median", "75%", "Max"));
        
        try (FileWriter writer = new FileWriter("benchmark_stats.csv")) {
            writer.write("method,count,mean,std,min,25%,median,75%,max\n");
            
            for (Map.Entry<String, List<BenchmarkResult>> entry : resultsByMethod.entrySet()) {
                String method = entry.getKey();
                List<BenchmarkResult> methodResults = entry.getValue();
                
                // Time statistics
                double[] times = methodResults.stream()
                    .mapToDouble(r -> r.timeNanos)
                    .sorted()
                    .toArray();
                
                // Memory statistics
                double[] memory = methodResults.stream()
                    .mapToDouble(r -> r.memoryUsedBytes)
                    .sorted()
                    .toArray();
                
                // Calculate statistics for time
                double meanTime = Arrays.stream(times).average().orElse(0);
                double stdDevTime = Math.sqrt(
                    Arrays.stream(times)
                        .map(x -> Math.pow(x - meanTime, 2))
                        .average()
                        .orElse(0)
                );
                
                // Calculate percentiles for time
                double p25Time = percentile(times, 25);
                double medianTime = percentile(times, 50);
                double p75Time = percentile(times, 75);
                
                // Calculate statistics for memory
                double meanMem = Arrays.stream(memory).average().orElse(0);
                double stdDevMem = Math.sqrt(
                    Arrays.stream(memory)
                        .map(x -> Math.pow(x - meanMem, 2))
                        .average()
                        .orElse(0)
                );
                
                // Calculate percentiles for memory
                double p25Mem = percentile(memory, 25);
                double medianMem = percentile(memory, 50);
                double p75Mem = percentile(memory, 75);
                
                // Append time stats
                analysis.append(String.format("%-20s %-10s %10s %10s %10s %10s %10s %10s %10s %10s\n", 
                    method, 
                    "Time (ns)",
                    nf.format(times.length),
                    nf.format(meanTime),
                    nf.format(stdDevTime),
                    nf.format(times[0]),
                    nf.format(p25Time),
                    nf.format(medianTime),
                    nf.format(p75Time),
                    nf.format(times[times.length - 1])));
                
                // Append memory stats
                analysis.append(String.format("%-20s %-10s %10s %10s %10s %10s %10s %10s %10s %10s\n", 
                    "", 
                    "Mem (B)",
                    nf.format(memory.length),
                    nf.format(meanMem),
                    nf.format(stdDevMem),
                    nf.format(memory[0]),
                    nf.format(p25Mem),
                    nf.format(medianMem),
                    nf.format(p75Mem),
                    nf.format(memory[memory.length - 1])));
                
                // Add empty line between methods
                analysis.append("\n");
                
                // Write to CSV
                writer.write(String.format("%s_time,%d,%.2f,%.2f,%.2f,%.2f,%.2f,%.2f,%.2f\n",
                    method, times.length, meanTime, stdDevTime, 
                    times[0], p25Time, medianTime, p75Time, times[times.length - 1]));
                
                writer.write(String.format("%s_memory,%d,%.2f,%.2f,%.2f,%.2f,%.2f,%.2f,%.2f\n",
                    method, memory.length, meanMem, stdDevMem, 
                    memory[0], p25Mem, medianMem, p75Mem, memory[memory.length - 1]));
            }
            
            System.out.println(analysis.toString());
            System.out.println("Statistical analysis written to benchmark_stats.csv");
            
        } catch (IOException e) {
            System.err.println("Error writing statistical analysis: " + e.getMessage());
        }
    }
    
    private static double percentile(double[] sortedData, double percentile) {
        if (sortedData.length == 0) return 0;
        if (percentile <= 0) return sortedData[0];
        if (percentile >= 100) return sortedData[sortedData.length - 1];
        
        double index = (percentile / 100) * (sortedData.length - 1);
        int lower = (int) Math.floor(index);
        
        if (lower >= sortedData.length - 1) return sortedData[sortedData.length - 1];
        
        double fraction = index - lower;
        return sortedData[lower] + fraction * (sortedData[lower + 1] - sortedData[lower]);
    }
}
