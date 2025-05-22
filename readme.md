# Tugas Praktikum Universitas Terbuka

Periode: 2024/2025 Genap

```yaml
Nama: "Muhammad Hidayat"
NIM: "052747132"
Prodi: "Sains Data"
UPBJJ: "Bogor"
```

Mata kuliah yang dicakup:
- MSIM4202 Struktur Data
- MSIM4203 Algoritma dan Pemrograman
- MSIM4206 Basis Data

Ini merupakan project IntelliJ IDEA dengan build system Maven. Import dengan Eclipse atau IntelliJ untuk membuka.

## Menjalankan dengan Standalone `javac`
1. Masuk ke direktori utama proyek
2. Kompilasi file Java: `javac -d bin -sourcepath src/main/java src/main/java/xyz/return215/ut_java/Main.java`
3. Jalankan aplikasi: `java -cp bin xyz.return215.ut_java.Main`

## Menjalankan dengan Maven
1. Masuk ke direktori utama proyek
2. Untuk menjalankan proyek: `mvn exec:java -Dexec.mainClass="xyz.return215.ut_java.Main"`

## Menjalankan dengan IntelliJ
1. Buka IntelliJ IDEA dan impor proyek dengan file `pom.xml`.
2. Jalankan kelas `Main` dengan klik kanan dan pilih 'Run'.

File Main.java ditemukan [di sini](src/main/java/xyz/return215/ut_java/Main.java).

