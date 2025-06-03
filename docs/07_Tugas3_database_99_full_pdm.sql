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

CREATE TABLE konsultasi_event (
    id_konsultasi INT PRIMARY KEY AUTO_INCREMENT,
    waktu_konsultasi DATETIME NOT NULL
);

-- dokter <==> pasien
CREATE TABLE pasien_dokter (
  id INT PRIMARY KEY AUTO_INCREMENT,
  id_dokter INT NOT NULL,
  id_pasien INT NOT NULL,
  resep TEXT,
  id_konsultasi INT NOT NULL,

  CONSTRAINT fk_dokter_pasien
    FOREIGN KEY (id_dokter)
    REFERENCES dokter(id_dokter)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT fk_pasien_dokter
    FOREIGN KEY (id_pasien)
    REFERENCES pasien(id_pasien)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT fk_pasien_dokter_konsultasi
    FOREIGN KEY (id_konsultasi)
    REFERENCES konsultasi_event(id_konsultasi)
    ON DELETE CASCADE ON UPDATE CASCADE
);

-- dokter <==> administrator
CREATE TABLE dokter_admin (
  id_data INT PRIMARY KEY AUTO_INCREMENT,
  id_dokter INT NOT NULL,
  id_admin INT NOT NULL,
  id_konsultasi INT NOT NULL,

  CONSTRAINT fk_dokter_admin
    FOREIGN KEY (id_dokter)
    REFERENCES dokter(id_dokter)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT fk_admin_dokter
    FOREIGN KEY (id_admin)
    REFERENCES administrator(id_admin)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT fk_dokter_admin_konsultasi
    FOREIGN KEY (id_konsultasi)
    REFERENCES konsultasi_event(id_konsultasi)
    ON DELETE CASCADE ON UPDATE CASCADE
);

-- pasien <==> administrator
CREATE TABLE pendaftaran (
  id_daftar INT PRIMARY KEY AUTO_INCREMENT,
  id_pasien INT NOT NULL,
  id_admin INT NOT NULL,
  id_konsultasi INT NOT NULL,

  CONSTRAINT fk_pasien_admin
    FOREIGN KEY (id_pasien)
    REFERENCES pasien(id_pasien)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT fk_admin_pasien
    FOREIGN KEY (id_admin)
    REFERENCES administrator(id_admin)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT fk_pasien_admin_konsultasi
    FOREIGN KEY (id_konsultasi)
    REFERENCES konsultasi_event(id_konsultasi)
    ON DELETE CASCADE ON UPDATE CASCADE
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
