package xyz.return215.ut_java.tugas1.strukdat;

import java.util.Iterator;
import java.util.LinkedList;
import java.util.Scanner;

public class datatypes {
    Scanner scanner;
    public datatypes(Scanner scanner) {
        this.scanner = scanner;
        int jumlahBaris = 3;
        String kalimatBaru = "Deklarasi tipe data String";
        int[] empatAngka = {7, 10, 20, 23, };
        String[][] alfabet = {
            {"p", "s", "n"},
            {"w", "l", "b"},
            {"f", "r", "e"},
        };
        LinkedList<Integer> listAngka = new LinkedList<Integer>();
        listAngka.add(26);
        listAngka.add(8);
        listAngka.add(23);
        listAngka.add(24);
        listAngka.add(16);

        StringBuilder out = new StringBuilder(1000);
        out.append("int jumlahBaris = ")
            .append(jumlahBaris)
            .append(";\n")
            .append("String kalimatBaru = \"")
            .append(kalimatBaru)
            .append("\";\n")
            .append("int[] empatAngka = {");

        for (int i = 0; i < empatAngka.length; i++) {
            out.append(empatAngka[i])
                .append(", ");
        }

        out.append("};\n")
            .append("String[][] alfabet = {\n");

        for (String[] strings : alfabet) {
            out.append("    {")
                .append(String.join(", ", strings))
                .append("},\n");
        }

        out.append("};\n")
            .append("LinkedList<Integer> listAngka = {\n");

        Iterator<Integer> iterator = listAngka.iterator();
        out.append("    ");
        while (iterator.hasNext()) {
            out.append(iterator.next());
            if (iterator.hasNext()) {
                out.append(", ");
            }
        }

        out.append("\n};\n");

        System.out.print(out);
    }
}
