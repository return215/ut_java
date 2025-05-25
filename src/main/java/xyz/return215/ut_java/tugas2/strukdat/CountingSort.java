package xyz.return215.ut_java.tugas2.strukdat;

public class CountingSort {
    public static void sort(int[] array) {
        // Array kosong atau null tidak perlu sorting
        if (array == null || array.length <= 1) return;

        // Mencari nilai maksimum
        int max = array[0];
        for (int value : array) {
            if (value > max) {
                max = value;
            }
        }

        // Inisialisasi array count sebanyak nilai maksimum
        int[] count = new int[max + 1];

        // Menghitung jumlah kemunculan setiap angka
        for (int num : array) {
            count[num]++;
        }

        // Menghitung jumlah kumulatif kemunculan secara mundur
        for (int i = count.length - 2; i >= 0; i--) {
            count[i] += count[i + 1];
        }

        // Buat salinan dari array asli
        int[] original = array.clone();

        // Membentuk array terurut sesuai kumulatif kemunculan nilai
        // dari kiri ke kanan
        for (int i = 0; i < array.length; i++) {
            int num = original[i];
            array[count[num] - 1] = num;
            count[num]--;
        }
    }
}
