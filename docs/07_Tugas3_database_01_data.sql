CREATE TABLE dokter (
  id_dokter INT PRIMARY KEY AUTO_INCREMENT,
  nama_dokter VARCHAR(150) NOT NULL,
  tanggal_lahir DATE NOT NULL,
  alamat_dokter TEXT NOT NULL,
  spesialis VARCHAR(100) NOT NULL,
  waktu_kerja TIME NOT NULL,
  no_hp VARCHAR(15) NOT NULL
);

CREATE TABLE pasien (
  id_pasien INT PRIMARY KEY AUTO_INCREMENT,
  nama_pasien VARCHAR(150) NOT NULL,
  -- laki-laki L, perempuan P, lainnya ?
  jenis_kelamin CHAR(1) NOT NULL,
  alamat_pasien TEXT NOT NULL
);

CREATE TABLE administrator (
  id_admin INT PRIMARY KEY AUTO_INCREMENT,
  nama_admin VARCHAR(150) NOT NULL,
  waktu_jaga TIME NOT NULL
);

-- dokter <==> pasien
CREATE TABLE pasien_dokter (
  id INT PRIMARY KEY AUTO_INCREMENT,
  id_dokter INT NOT NULL,
  id_pasien INT NOT NULL,
  resep TEXT,
  waktu_periksa DATETIME NOT NULL,

  CONSTRAINT fk_dokter_pasien
    FOREIGN KEY (id_dokter)
    REFERENCES dokter(id_dokter)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT fk_pasien_dokter
    FOREIGN KEY (id_pasien)
    REFERENCES pasien(id_pasien)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

-- dokter <==> administrator
CREATE TABLE dokter_admin (
  id_data INT PRIMARY KEY AUTO_INCREMENT,
  id_dokter INT NOT NULL,
  id_admin INT NOT NULL,

  CONSTRAINT fk_dokter_admin
    FOREIGN KEY (id_dokter)
    REFERENCES dokter(id_dokter)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT fk_admin_dokter
    FOREIGN KEY (id_admin)
    REFERENCES administrator(id_admin)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

-- pasien <==> administrator
CREATE TABLE pendaftaran (
  id_daftar INT PRIMARY KEY AUTO_INCREMENT,
  id_pasien INT NOT NULL,
  id_admin INT NOT NULL,

  CONSTRAINT fk_pasien_admin
    FOREIGN KEY (id_pasien)
    REFERENCES pasien(id_pasien)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT fk_admin_pasien
    FOREIGN KEY (id_admin)
    REFERENCES administrator(id_admin)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE obat (
  id_obat INT AUTO_INCREMENT PRIMARY KEY,
  kode_obat VARCHAR(5),
  nama_obat VARCHAR(30),
  harga INT,
  stok INT,

  -- harga dan stok tidak boleh negatif
  CONSTRAINT harga_noneg check (harga >= 0),
  CONSTRAINT stok_noneg check (stok >= 0)
);

-- pasien <==> transaksi
CREATE TABLE transaksi_obat (
  id_transaksi INT AUTO_INCREMENT PRIMARY KEY,
  id_pasien INT,
  total_harga INT,

  CONSTRAINT fk_pasien_obat
    FOREIGN KEY (id_pasien)
    REFERENCES pasien(id_pasien)
    ON DELETE CASCADE ON UPDATE CASCADE
);

-- transaksi <==> obat
CREATE TABLE transaksi_obat_detail (
  id_transaksi_detail INT AUTO_INCREMENT PRIMARY KEY,
  id_transaksi INT,
  id_obat INT,
  jumlah INT,
  harga INT, -- harga saat dicatat
  total_harga INT,

  CONSTRAINT fk_obat_transaksi
    FOREIGN KEY (id_obat)
    REFERENCES obat(id_obat)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT fk_transaksi_detail
    FOREIGN KEY (id_transaksi)
    REFERENCES transaksi_obat(id_transaksi)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

-- Mock data dibuat oleh Gemini

-- Mock Data untuk Database Klinik

-- 1. Data Administrator (3 entri)
INSERT INTO administrator (nama_admin, waktu_jaga) VALUES
('Budi Santoso', '08:00:00'),
('Citra Dewi', '14:00:00'),
('Dian Pratama', '20:00:00');

-- 2. Data Dokter (6 entri)
INSERT INTO dokter (nama_dokter, tanggal_lahir, alamat_dokter, spesialis, waktu_kerja, no_hp) VALUES
('Dr. Aisha Rahman', '1985-03-15', 'Jl. Merdeka No. 10, Jakarta', 'Umum', '09:00:00', '081234567890'),
('Dr. Bayu Kusuma', '1978-11-22', 'Jl. Sudirman No. 25, Bandung', 'Gigi', '10:00:00', '081345678901'),
('Dr. Cahaya Putri', '1990-07-01', 'Jl. Diponegoro No. 5, Surabaya', 'Anak', '08:30:00', '081456789012'),
('Dr. Danu Wijaya', '1982-01-28', 'Jl. Gatot Subroto No. 12, Medan', 'Kulit', '11:00:00', '081567890123'),
('Dr. Eka Lestari', '1975-09-05', 'Jl. Thamrin No. 8, Yogyakarta', 'Mata', '09:30:00', '081678901234'),
('Dr. Fajar Nugroho', '1988-04-19', 'Jl. Pahlawan No. 30, Semarang', 'THT', '13:00:00', '081789012345');

-- 3. Data Pasien (15 entri)
INSERT INTO pasien (nama_pasien, jenis_kelamin, alamat_pasien) VALUES
('Ani Rahmawati', 'P', 'Jl. Mawar No. 1, Jakarta'),
('Budi Santoso', 'L', 'Jl. Melati No. 2, Bandung'),
('Citra Dewi', 'P', 'Jl. Anggrek No. 3, Surabaya'),
('Dedi Kurniawan', 'L', 'Jl. Kenanga No. 4, Medan'),
('Eka Putri', 'P', 'Jl. Dahlia No. 5, Yogyakarta'),
('Fajar Setiawan', 'L', 'Jl. Cempaka No. 6, Semarang'),
('Gita Lestari', 'P', 'Jl. Teratai No. 7, Jakarta'),
('Hadi Wijaya', 'L', 'Jl. Kamboja No. 8, Bandung'),
('Indah Sari', 'P', 'Jl. Edelweis No. 9, Surabaya'),
('Joko Susilo', 'L', 'Jl. Bougenville No. 10, Medan'),
('Kartika Ayu', 'P', 'Jl. Tulip No. 11, Yogyakarta'),
('Lukman Hakim', 'L', 'Jl. Sakura No. 12, Semarang'),
('Maya Indah', 'P', 'Jl. Lily No. 13, Jakarta'),
('Nanda Pratama', 'L', 'Jl. Anyelir No. 14, Bandung'),
('Putri Amelia', 'P', 'Jl. Melati No. 15, Surabaya');

-- 4. Data Pasien_Dokter (40 entri)
-- Resep akan disesuaikan dengan obat yang ada nanti.
-- Untuk sementara, resep akan berisi placeholder.
INSERT INTO pasien_dokter (id_dokter, id_pasien, resep, waktu_periksa) VALUES
(1, 1, 'Paracetamol 500mg, Amoxicillin 500mg', '2024-01-05 10:00:00'),
(2, 2, 'Ibuprofen 400mg, Vitamin C 1000mg', '2024-01-06 11:30:00'),
(3, 3, 'Obat Batuk Sirup, Dekstrometorfan', '2024-01-07 09:15:00'),
(4, 4, 'Salep Kulit Hidrokortison, Antihistamin', '2024-01-08 14:00:00'),
(5, 5, 'Tetes Mata Antiseptik, Kacamata', '2024-01-09 16:00:00'),
(6, 6, 'Obat Tetes Telinga, Antibiotik', '2024-01-10 10:45:00'),
(1, 7, 'Paracetamol 500mg, Vitamin B Complex', '2024-01-11 13:00:00'),
(2, 8, 'Pasta Gigi Sensitif, Fluoride Gel', '2024-01-12 09:00:00'),
(3, 9, 'Sirup Penurun Panas, Multivitamin Anak', '2024-01-13 11:00:00'),
(4, 10, 'Krim Anti Jamur, Bedak Salicyl', '2024-01-14 15:30:00'),
(5, 11, 'Obat Tetes Mata Glaucoma, Suplemen Mata', '2024-01-15 10:00:00'),
(6, 12, 'Semprot Hidung Dekongestan, Obat Flu', '2024-01-16 14:30:00'),
(1, 13, 'Antasida, Domperidone', '2024-01-17 08:00:00'),
(2, 14, 'Obat Kumur Antiseptik, Sikat Gigi', '2024-01-18 12:00:00'),
(3, 15, 'Obat Diare, Oralit', '2024-01-19 10:00:00'),
(4, 1, 'Krim Anti Gatal, Losion Calamine', '2024-01-20 11:00:00'),
(5, 2, 'Obat Tetes Mata Kering, Air Mata Buatan', '2024-01-21 13:00:00'),
(6, 3, 'Obat Sakit Tenggorokan, Lozenges', '2024-01-22 09:30:00'),
(1, 4, 'Antibiotik Spektrum Luas, Pereda Nyeri', '2024-01-23 15:00:00'),
(2, 5, 'Obat Sakit Gigi, Eugenol', '2024-01-24 10:00:00'),
(3, 6, 'Obat Demam Anak, Suppositoria', '2024-01-25 11:00:00'),
(4, 7, 'Antifungal Oral, Sabun Antiseptik', '2024-01-26 14:00:00'),
(5, 8, 'Obat Alergi Mata, Kompres Hangat', '2024-01-27 16:00:00'),
(6, 9, 'Obat Vertigo, Betahistine', '2024-01-28 09:00:00'),
(1, 10, 'Obat Maag, Ranitidine', '2024-01-29 10:30:00'),
(2, 11, 'Pemutih Gigi, Dental Floss', '2024-01-30 12:30:00'),
(3, 12, 'Obat Cacing, Albendazole', '2024-01-31 08:45:00'),
(4, 13, 'Obat Eksim, Pelembab Kulit', '2024-02-01 11:45:00'),
(5, 14, 'Obat Mata Merah, Nafazolin', '2024-02-02 13:15:00'),
(6, 15, 'Obat Sinusitis, Pseudoefedrin', '2024-02-03 10:15:00'),
(1, 1, 'Vitamin D, Kalsium', '2024-02-04 09:00:00'),
(2, 2, 'Obat Sariawan, Gentian Violet', '2024-02-05 14:00:00'),
(3, 3, 'Obat Asma Inhaler, Salbutamol', '2024-02-06 16:00:00'),
(4, 4, 'Obat Jerawat, Retinoid', '2024-02-07 10:00:00'),
(5, 5, 'Obat Katarak, Latanoprost', '2024-02-08 11:00:00'),
(6, 6, 'Obat Radang Telinga, Ciprofloxacin Tetes', '2024-02-09 13:00:00'),
(1, 7, 'Obat Hipertensi, Amlodipine', '2024-02-10 09:30:00'),
(2, 8, 'Obat Gusi Berdarah, Asam Traneksamat', '2024-02-11 15:00:00'),
(3, 9, 'Obat Batuk Kering, Codein', '2024-02-12 10:00:00'),
(4, 10, 'Obat Psoriasis, Calcipotriol', '2024-02-13 12:00:00');

-- 5. Data Dokter_Admin (40 entri)
-- Menggunakan ID dokter dan admin secara acak untuk mencapai 40 entri
INSERT INTO dokter_admin (id_dokter, id_admin) VALUES
(1, 1), (2, 1), (3, 1), (4, 1), (5, 1), (6, 1),
(1, 2), (2, 2), (3, 2), (4, 2), (5, 2), (6, 2),
(1, 3), (2, 3), (3, 3), (4, 3), (5, 3), (6, 3),
(1, 1), (2, 1), (3, 1), (4, 1), (5, 1), (6, 1),
(1, 2), (2, 2), (3, 2), (4, 2), (5, 2), (6, 2),
(1, 3), (2, 3), (3, 3), (4, 3), (5, 3), (6, 3),
(1, 1), (2, 1), (3, 1), (4, 1); -- Total 40 entri

-- 6. Data Pendaftaran (Pasien_Admin) (40 entri)
-- Menggunakan ID pasien dan admin secara acak untuk mencapai 40 entri
INSERT INTO pendaftaran (id_pasien, id_admin) VALUES
(1, 1), (2, 1), (3, 1), (4, 1), (5, 1), (6, 1), (7, 1), (8, 1), (9, 1), (10, 1), (11, 1), (12, 1), (13, 1), (14, 1), (15, 1),
(1, 2), (2, 2), (3, 2), (4, 2), (5, 2), (6, 2), (7, 2), (8, 2), (9, 2), (10, 2), (11, 2), (12, 2), (13, 2), (14, 2), (15, 2),
(1, 3), (2, 3), (3, 3), (4, 3), (5, 3), (6, 3), (7, 3), (8, 3), (9, 3), (10, 3); -- Total 40 entri

-- 7. Data Obat (menyesuaikan resep)
-- Harga dan stok disesuaikan
INSERT INTO obat (kode_obat, nama_obat, harga, stok) VALUES
('PCL01', 'Paracetamol 500mg', 5000, 100),
('AMX01', 'Amoxicillin 500mg', 8000, 80),
('IBP01', 'Ibuprofen 400mg', 6000, 90),
('VTC01', 'Vitamin C 1000mg', 7500, 120),
('OBS01', 'Obat Batuk Sirup', 12000, 70),
('DKM01', 'Dekstrometorfan', 4000, 60),
('SKH01', 'Salep Kulit Hidrokortison', 15000, 50),
('ANT01', 'Antihistamin', 9000, 75),
('TMA01', 'Tetes Mata Antiseptik', 10000, 40),
('OTT01', 'Obat Tetes Telinga', 8500, 35),
('VBC01', 'Vitamin B Complex', 6500, 110),
('PGS01', 'Pasta Gigi Sensitif', 18000, 95),
('FLG01', 'Fluoride Gel', 20000, 30),
('SPP01', 'Sirup Penurun Panas', 11000, 85),
('MVA01', 'Multivitamin Anak', 13000, 100),
('KAF01', 'Krim Anti Jamur', 16000, 45),
('BDS01', 'Bedak Salicyl', 7000, 65),
('TMG01', 'Obat Tetes Mata Glaucoma', 25000, 20),
('SUM01', 'Suplemen Mata', 22000, 55),
('SHD01', 'Semprot Hidung Dekongestan', 14000, 50),
('OBF01', 'Obat Flu', 9500, 80),
('ANT02', 'Antasida', 6000, 130),
('DMP01', 'Domperidone', 7000, 70),
('OKU01', 'Obat Kumur Antiseptik', 10000, 60),
('SGT01', 'Sikat Gigi', 5000, 150),
('OBD01', 'Obat Diare', 8000, 90),
('ORL01', 'Oralit', 3000, 200),
('KAG01', 'Krim Anti Gatal', 11000, 40),
('LCL01', 'Losion Calamine', 9000, 50),
('TMK01', 'Obat Tetes Mata Kering', 12000, 30),
('AMB01', 'Air Mata Buatan', 15000, 25),
('OST01', 'Obat Sakit Tenggorokan', 7000, 80),
('LZG01', 'Lozenges', 4000, 100),
('ABS01', 'Antibiotik Spektrum Luas', 18000, 60),
('PRN01', 'Pereda Nyeri', 5500, 110),
('OSG01', 'Obat Sakit Gigi', 7000, 70),
('EUG01', 'Eugenol', 9000, 30),
('ODA01', 'Obat Demam Anak', 10000, 90),
('SUP01', 'Suppositoria', 8000, 50),
('AFL01', 'Antifungal Oral', 20000, 35),
('SAB01', 'Sabun Antiseptik', 13000, 80),
('OAM01', 'Obat Alergi Mata', 14000, 40),
('KPH01', 'Kompres Hangat', 6000, 100),
('OBV01', 'Obat Vertigo', 17000, 30),
('BTH01', 'Betahistine', 19000, 25),
('OBM01', 'Obat Maag', 8500, 120),
('RNT01', 'Ranitidine', 9500, 60),
('PGI01', 'Pemutih Gigi', 25000, 40),
('DFL01', 'Dental Floss', 6000, 100),
('OBC01', 'Obat Cacing', 11000, 50),
('ALB01', 'Albendazole', 13000, 40),
('OBE01', 'Obat Eksim', 18000, 30),
('PMK01', 'Pelembab Kulit', 10000, 70),
('OMR01', 'Obat Mata Merah', 9000, 50),
('NFZ01', 'Nafazolin', 11000, 45),
('OBS02', 'Obat Sinusitis', 16000, 35),
('PSE01', 'Pseudoefedrin', 10000, 60),
('VTD01', 'Vitamin D', 8000, 90),
('KLS01', 'Kalsium', 9000, 80),
('OSW01', 'Obat Sariawan', 7000, 75),
('GTV01', 'Gentian Violet', 5000, 40),
('OAI01', 'Obat Asma Inhaler', 22000, 20),
('SLB01', 'Salbutamol', 20000, 15),
('OBJ01', 'Obat Jerawat', 15000, 50),
('RTN01', 'Retinoid', 17000, 30),
('OBK01', 'Obat Katarak', 28000, 10),
('LTP01', 'Latanoprost', 30000, 8),
('ORT01', 'Obat Radang Telinga', 13000, 40),
('CPX01', 'Ciprofloxacin Tetes', 15000, 30),
('OBH01', 'Obat Hipertensi', 19000, 25),
('AML01', 'Amlodipine', 21000, 20),
('OBG01', 'Obat Gusi Berdarah', 10000, 50),
('ATX01', 'Asam Traneksamat', 12000, 30),
('OBK02', 'Obat Batuk Kering', 9000, 70),
('CDN01', 'Codein', 14000, 40),
('OBP01', 'Obat Psoriasis', 23000, 20),
('CLP01', 'Calcipotriol', 25000, 15);


-- 8. Data Transaksi_Obat (untuk tiap pasien_dokter)
-- Asumsi setiap entri pasien_dokter menghasilkan satu transaksi obat
INSERT INTO transaksi_obat (id_pasien, total_harga) VALUES
(1, 0), -- Akan diupdate setelah transaksi_obat_detail diisi
(2, 0),
(3, 0),
(4, 0),
(5, 0),
(6, 0),
(7, 0),
(8, 0),
(9, 0),
(10, 0),
(11, 0),
(12, 0),
(13, 0),
(14, 0),
(15, 0),
(1, 0),
(2, 0),
(3, 0),
(4, 0),
(5, 0),
(6, 0),
(7, 0),
(8, 0),
(9, 0),
(10, 0),
(11, 0),
(12, 0),
(13, 0),
(14, 0),
(15, 0),
(1, 0),
(2, 0),
(3, 0),
(4, 0),
(5, 0),
(6, 0),
(7, 0),
(8, 0),
(9, 0),
(10, 0);

-- 9. Data Transaksi_Obat_Detail (menyesuaikan resep, anggap semua pasien membeli obat tepat sesuai resep)
-- Ini adalah bagian yang paling kompleks, memerlukan pemetaan resep ke ID obat.
-- Untuk tujuan mock data, kita akan membuat entri manual berdasarkan resep yang ada.
-- ID Transaksi akan sesuai dengan urutan INSERT di transaksi_obat (1-40)
-- ID Obat akan sesuai dengan urutan INSERT di obat
INSERT INTO transaksi_obat_detail (id_transaksi, id_obat, jumlah, harga, total_harga) VALUES
-- Transaksi 1 (Resep: Paracetamol 500mg, Amoxicillin 500mg)
(1, 1, 1, 5000, 5000),
(1, 2, 1, 8000, 8000),
-- Transaksi 2 (Resep: Ibuprofen 400mg, Vitamin C 1000mg)
(2, 3, 1, 6000, 6000),
(2, 4, 1, 7500, 7500),
-- Transaksi 3 (Resep: Obat Batuk Sirup, Dekstrometorfan)
(3, 5, 1, 12000, 12000),
(3, 6, 1, 4000, 4000),
-- Transaksi 4 (Resep: Salep Kulit Hidrokortison, Antihistamin)
(4, 7, 1, 15000, 15000),
(4, 8, 1, 9000, 9000),
-- Transaksi 5 (Resep: Tetes Mata Antiseptik)
(5, 9, 1, 10000, 10000),
-- Transaksi 6 (Resep: Obat Tetes Telinga, Antibiotik)
(6, 10, 1, 8500, 8500),
(6, 2, 1, 8000, 8000), -- Asumsi antibiotik = Amoxicillin
-- Transaksi 7 (Resep: Paracetamol 500mg, Vitamin B Complex)
(7, 1, 1, 5000, 5000),
(7, 11, 1, 6500, 6500),
-- Transaksi 8 (Resep: Pasta Gigi Sensitif, Fluoride Gel)
(8, 12, 1, 18000, 18000),
(8, 13, 1, 20000, 20000),
-- Transaksi 9 (Resep: Sirup Penurun Panas, Multivitamin Anak)
(9, 14, 1, 11000, 11000),
(9, 15, 1, 13000, 13000),
-- Transaksi 10 (Resep: Krim Anti Jamur, Bedak Salicyl)
(10, 16, 1, 16000, 16000),
(10, 17, 1, 7000, 7000),
-- Transaksi 11 (Resep: Obat Tetes Mata Glaucoma, Suplemen Mata)
(11, 18, 1, 25000, 25000),
(11, 19, 1, 22000, 22000),
-- Transaksi 12 (Resep: Semprot Hidung Dekongestan, Obat Flu)
(12, 20, 1, 14000, 14000),
(12, 21, 1, 9500, 9500),
-- Transaksi 13 (Resep: Antasida, Domperidone)
(13, 22, 1, 6000, 6000),
(13, 23, 1, 7000, 7000),
-- Transaksi 14 (Resep: Obat Kumur Antiseptik, Sikat Gigi)
(14, 24, 1, 10000, 10000),
(14, 25, 1, 5000, 5000),
-- Transaksi 15 (Resep: Obat Diare, Oralit)
(15, 26, 1, 8000, 8000),
(15, 27, 1, 3000, 3000),
-- Transaksi 16 (Resep: Krim Anti Gatal, Losion Calamine)
(16, 28, 1, 11000, 11000),
(16, 29, 1, 9000, 9000),
-- Transaksi 17 (Resep: Obat Tetes Mata Kering, Air Mata Buatan)
(17, 30, 1, 12000, 12000),
(17, 31, 1, 15000, 15000),
-- Transaksi 18 (Resep: Obat Sakit Tenggorokan, Lozenges)
(18, 32, 1, 7000, 7000),
(18, 33, 1, 4000, 4000),
-- Transaksi 19 (Resep: Antibiotik Spektrum Luas, Pereda Nyeri)
(19, 34, 1, 18000, 18000),
(19, 35, 1, 5500, 5500),
-- Transaksi 20 (Resep: Obat Sakit Gigi, Eugenol)
(20, 36, 1, 7000, 7000),
(20, 37, 1, 9000, 9000),
-- Transaksi 21 (Resep: Obat Demam Anak, Suppositoria)
(21, 38, 1, 10000, 10000),
(21, 39, 1, 8000, 8000),
-- Transaksi 22 (Resep: Antifungal Oral, Sabun Antiseptik)
(22, 40, 1, 20000, 20000),
(22, 41, 1, 13000, 13000),
-- Transaksi 23 (Resep: Obat Alergi Mata, Kompres Hangat)
(23, 42, 1, 14000, 14000),
(23, 43, 1, 6000, 6000),
-- Transaksi 24 (Resep: Obat Vertigo, Betahistine)
(24, 44, 1, 17000, 17000),
(24, 45, 1, 19000, 19000),
-- Transaksi 25 (Resep: Obat Maag, Ranitidine)
(25, 46, 1, 8500, 8500),
(25, 47, 1, 9500, 9500),
-- Transaksi 26 (Resep: Pemutih Gigi, Dental Floss)
(26, 48, 1, 25000, 25000),
(26, 49, 1, 6000, 6000),
-- Transaksi 27 (Resep: Obat Cacing, Albendazole)
(27, 50, 1, 11000, 11000),
(27, 51, 1, 13000, 13000),
-- Transaksi 28 (Resep: Obat Eksim, Pelembab Kulit)
(28, 52, 1, 18000, 18000),
(28, 53, 1, 10000, 10000),
-- Transaksi 29 (Resep: Obat Mata Merah, Nafazolin)
(29, 54, 1, 9000, 9000),
(29, 55, 1, 11000, 11000),
-- Transaksi 30 (Resep: Obat Sinusitis, Pseudoefedrin)
(30, 56, 1, 16000, 16000),
(30, 57, 1, 10000, 10000),
-- Transaksi 31 (Resep: Vitamin D, Kalsium)
(31, 58, 1, 8000, 8000),
(31, 59, 1, 9000, 9000),
-- Transaksi 32 (Resep: Obat Sariawan, Gentian Violet)
(32, 60, 1, 7000, 7000),
(32, 61, 1, 5000, 5000),
-- Transaksi 33 (Resep: Obat Asma Inhaler, Salbutamol)
(33, 62, 1, 22000, 22000),
(33, 63, 1, 20000, 20000),
-- Transaksi 34 (Resep: Obat Jerawat, Retinoid)
(34, 64, 1, 15000, 15000),
(34, 65, 1, 17000, 17000),
-- Transaksi 35 (Resep: Obat Katarak, Latanoprost)
(35, 66, 1, 28000, 28000),
(35, 67, 1, 30000, 30000),
-- Transaksi 36 (Resep: Obat Radang Telinga, Ciprofloxacin Tetes)
(36, 68, 1, 13000, 13000),
(36, 69, 1, 15000, 15000),
-- Transaksi 37 (Resep: Obat Hipertensi, Amlodipine)
(37, 70, 1, 19000, 19000),
(37, 71, 1, 21000, 21000),
-- Transaksi 38 (Resep: Obat Gusi Berdarah, Asam Traneksamat)
(38, 72, 1, 10000, 10000),
(38, 73, 1, 12000, 12000),
-- Transaksi 39 (Resep: Obat Batuk Kering, Codein)
(39, 74, 1, 9000, 9000),
(39, 75, 1, 14000, 14000),
-- Transaksi 40 (Resep: Obat Psoriasis, Calcipotriol)
(40, 76, 1, 23000, 23000),
(40, 77, 1, 25000, 25000);

-- Update total_harga di tabel transaksi_obat
-- Ini harus dijalankan setelah semua transaksi_obat_detail diisi
UPDATE transaksi_obat
SET total_harga = (
    SELECT SUM(total_harga)
    FROM transaksi_obat_detail
    WHERE transaksi_obat_detail.id_transaksi = transaksi_obat.id_transaksi
)
WHERE id_transaksi IN (SELECT DISTINCT id_transaksi FROM transaksi_obat_detail);
