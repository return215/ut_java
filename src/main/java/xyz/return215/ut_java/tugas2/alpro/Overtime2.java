package xyz.return215.ut_java.tugas2.alpro;

import java.text.DecimalFormat;
import java.util.Scanner;

public class Overtime2 {
    Scanner scanner;

    public Overtime2(Scanner scanner) {
        this.scanner = scanner;

        // Define variables
        String golongan;
        int jamLembur;
        double gajiGolongan = 0;
        double gajiLembur = 0;
        double gajiAkhir;
        // Output gaji akhir
        DecimalFormat df = new DecimalFormat("#,##0");

        // Input golongan
        System.out.print("Masukkan golongan (A/B/C): ");
        golongan = scanner.nextLine();

        // Determine gaji golongan
        if (golongan.equals("A")) {
            gajiGolongan = 5000000;
        } else if (golongan.equals("B")) {
            gajiGolongan = 6500000;
        } else if (golongan.equals("C")) {
            gajiGolongan = 9500000;
        } else {
            System.out.println("Golongan tidak valid.");
            return;
        }

        System.out.println("Gaji golongan: " + df.format(gajiGolongan));

        // Input jam lembur
        System.out.print("Masukkan jam lembur: ");
        jamLembur = scanner.nextInt();
        
        // Determine gaji lembur
        if (jamLembur <= 0) {
            gajiLembur = 0;
        } else if (jamLembur == 1) {
            gajiLembur = gajiGolongan * 0.30;
        } else if (jamLembur == 2) {
            gajiLembur = gajiGolongan * 0.32;
        } else if (jamLembur == 3) {
            gajiLembur = gajiGolongan * 0.34;
        } else if (jamLembur == 4) {
            gajiLembur = gajiGolongan * 0.36;
        } else /*if (jamLembur >= 5)*/ {
            gajiLembur = gajiGolongan * 0.38;
        }

        System.out.println("Gaji lembur: " + df.format(gajiLembur));

        // Calculate gaji akhir
        gajiAkhir = gajiGolongan + gajiLembur;


        System.out.println("Gaji akhir: " + df.format(gajiAkhir));
    }
    public static void main(String[] args) {
        new Overtime2(new Scanner(System.in));
    }
}
