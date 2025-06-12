package xyz.return215.ut_java.tugas3.alpro;

import java.text.DecimalFormat;
import java.util.Scanner;

public class Overtime3 {
    Scanner scanner;

    public Overtime3(Scanner scanner) {
        this.scanner = scanner;

        // Define variables
        char golongan;
        int golongan_index;
        double jamLembur;
        int jamLembur_index;
        double gajiGolongan = 0;
        double gajiLembur = 0;
        double gajiAkhir;
        DecimalFormat df = new DecimalFormat("#,##0");

        // Define arrays
        int[] gajiGolonganList = {5000000, 6500000, 9500000};
        int[] gajiLemburList = {0, 30, 32, 34, 36, 38};

        // Input golongan
        System.out.print("Masukkan golongan (A/B/C): ");
        golongan = scanner.nextLine().toUpperCase().charAt(0);

        // petakan indeks array
        golongan_index = (int)golongan - 65;
        // gagal jika di luar golongan
        if (golongan_index < 0 || golongan_index >= gajiGolonganList.length) {
            System.out.println("Golongan tidak valid.");
            return;
        }

        // Determine gaji golongan
        gajiGolongan = gajiGolonganList[golongan_index];
        System.out.println("Gaji golongan: " + df.format(gajiGolongan));

        // Input jam lembur
        System.out.print("Masukkan jam lembur: ");
        jamLembur = scanner.nextDouble();

        // petakan indeks array
        jamLembur_index = (int)Math.floor(jamLembur);
        // untuk mencegah overflow/underflow (ArrayIndexOutOfBoundsException)
        if (jamLembur_index >= gajiLemburList.length)
          jamLembur_index = gajiLemburList.length - 1;
        else if (jamLembur_index < 0)
          jamLembur_index = 0;

        // Determine gaji lembur
        // gaji pokok sudah double, tetap otomatis double
        gajiLembur = gajiGolongan / 100 * gajiLemburList[jamLembur_index];
        System.out.println("Gaji lembur: " + df.format(gajiLembur));

        // Calculate gaji akhir
        gajiAkhir = gajiGolongan + gajiLembur;
        System.out.println("Gaji akhir: " + df.format(gajiAkhir));
    }

    public static void main(String[] args) {
        new Overtime3(new Scanner(System.in));
    }
}
