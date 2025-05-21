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

        // Membentuk array terurut sesuai jumlah kemunculan nilai
        int currentIndex = 0;
        for (int value = 0; value < count.length; value++) {
            int freq = count[value];
            for (int j = 0; j < freq; j++) {
                array[currentIndex] = value;
                currentIndex++;
            }
        }
    }
}
