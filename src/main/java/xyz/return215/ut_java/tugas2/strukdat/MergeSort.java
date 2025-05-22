package xyz.return215.ut_java.tugas2.strukdat;

import java.util.Arrays;

public class MergeSort {
    private static final boolean dev = false;

    /**
     * Lakukan sorting menggunakan algoritma Merge Sort
     * @param array Array yang ingin disortir
     */
    public static void sort(int[] array) {
        // Array kosong atau null tidak perlu sorting
        if (array == null || array.length <= 1) return;

        mergeSort(array, 0, array.length - 1);
    }

    private static void mergeSort(int[] array, int left, int right) {
        // ukuran hanya satu atau kurang, selesai sortir bagian ini
        // (kasus dasar rekursi)
        if (left >= right) return;

        int mid = left + (right - left) / 2;

        // print array part to be sorted and the parameters
        if (dev) System.out.println(
            "Array to sort: " + Arrays.toString(Arrays.copyOfRange(array, left, right + 1)) + "\n" +
            "Bounds: ("+ left +" "+ mid +" "+ right + ")"
        );

        mergeSort(array, left, mid);
        mergeSort(array, mid+1, right);

        merge(array, left, mid, right);

        // print sorted array part
        if (dev) System.out.println(
            "Array sorted : " + Arrays.toString(Arrays.copyOfRange(array, left, right + 1))
        );
    }

    private static void merge(int[] array, int left, int mid, int right) {
        int[] leftPart = new int[mid - left + 1];
        int[] rightPart = new int[right - mid];

        //  System.arraycopy(array, left + 0, leftPart, 0, leftPart.length);
        int leftSize = leftPart.length;
        for (int i = 0; i < leftSize; i++) {
            leftPart[i] = array[left+i];
        }

        int rightSize = rightPart.length;
        for (int i = 0; i < rightSize; i++) {
            rightPart[i] = array[mid+1+i];
        }

        int leftIndex = 0;
        int rightIndex = 0;
        int currentIndex = left;

        while (leftIndex < leftSize && rightIndex < rightSize) {
            if (leftPart[leftIndex] < rightPart[rightIndex]) {
                array[currentIndex] = leftPart[leftIndex];
                leftIndex++;
            } else {
                array[currentIndex] = rightPart[rightIndex];
                rightIndex++;
            }
            currentIndex++;
        }

        while (leftIndex < leftSize) {
            array[currentIndex] = leftPart[leftIndex];
            leftIndex++;
            currentIndex++;
        }

        while (rightIndex < rightSize) {
            array[currentIndex] = rightPart[rightIndex];
            rightIndex++;
            currentIndex++;
        }


    }
}
