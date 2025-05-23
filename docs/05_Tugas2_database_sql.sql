create table dokter (
  id_dokter int primary key auto_increment,
  nama_dokter varchar(150) not null,
  tanggal_lahir date not null,
  alamat_dokter text not null,
  spesialis varchar(100) not null,
  waktu_kerja time not null,
  no_hp varchar(15) not null
);

create table pasien (
  id_pasien int primary key auto_increment,
  nama_pasien varchar(150) not null,
  jenis_kelamin char(1) not null, -- laki-laki L, perempuan P, lainnya ?
  alamat_pasien text not null
);

create table administrator (
  id_admin int primary key auto_increment,
  nama_admin varchar(150) not null,
  waktu_jaga time not null
);

-- dokter <==> pasien
create table pasien_dokter (
  id int primary key auto_increment,
  id_dokter int not null,
  id_pasien int not null,
  resep text,
  waktu_periksa datetime not null,

  constraint fk_dokter_pasien foreign key (id_dokter) references dokter(id_dokter) on delete cascade on update cascade,
  constraint fk_pasien_dokter foreign key (id_pasien) references pasien(id_pasien) on delete cascade on update cascade
);

-- dokter <==> administrator
create table dokter_admin (
  id_data int primary key auto_increment,
  id_dokter int not null,
  id_admin int not null,

  constraint fk_dokter_admin foreign key (id_dokter) references dokter(id_dokter) on delete cascade on update cascade,
  constraint fk_admin_dokter foreign key (id_admin) references administrator(id_admin) on delete cascade on update cascade
);


-- pasien <==> administrator
create table pendaftaran (
  id_daftar int primary key auto_increment,
  id_pasien int not null,
  id_admin int not null,

  constraint fk_pasien_admin foreign key (id_pasien) references pasien(id_pasien) on delete cascade on update cascade,
  constraint fk_admin_pasien foreign key (id_admin) references administrator(id_admin) on delete cascade on update cascade
);


-- thank you claude for mock data
-- mock data dokter
insert into dokter (nama_dokter, tanggal_lahir, alamat_dokter, spesialis, waktu_kerja, no_hp) values
  ('Dr. Ahmad Wijaya, Sp.JP', '1978-05-15', 'Jl. Sudirman No. 45, Jakarta Pusat', 'Kardiologi', '08:00:00', '081234567890'),
  ('Dr. Sari Indrawati, Sp.A', '1982-11-22', 'Jl. Gatot Subroto No. 12, Jakarta Selatan', 'Pediatri', '09:00:00', '081234567891'),
  ('Dr. Budi Santoso, Sp.OG', '1975-03-08', 'Jl. Thamrin No. 78, Jakarta Pusat', 'Obstetri Ginekologi', '07:30:00', '081234567892'),
  ('Dr. Maya Kusuma, Sp.M', '1980-09-12', 'Jl. Kuningan No. 33, Jakarta Selatan', 'Mata', '10:00:00', '081234567893'),
  ('Dr. Roni Pratama, Sp.B', '1977-01-25', 'Jl. Kemang No. 56, Jakarta Selatan', 'Bedah Umum', '06:00:00', '081234567894');

-- mock data pasien
insert into pasien (nama_pasien, jenis_kelamin, alamat_pasien) values
  ('Andi Setiawan', 'L', 'Jl. Merdeka No. 10, Depok'),
  ('Lina Maharani', 'P', 'Jl. Proklamasi No. 25, Bogor'),
  ('Bambang Wijaya', 'L', 'Jl. Diponegoro No. 15, Tangerang'),
  ('Siti Nurhaliza', 'P', 'Jl. Pahlawan No. 8, Bekasi'),
  ('Eko Prasetyo', 'L', 'Jl. Veteran No. 20, Jakarta Timur'),
  ('Dewi Sartika', 'P', 'Jl. Kartini No. 12, Jakarta Barat'),
  ('Hendra Gunawan', 'L', 'Jl. Cut Nyak Dien No. 30, Jakarta Utara');

-- mock data administrator
insert into administrator (nama_admin, waktu_jaga) values
  ('Nina Astuti', '08:00:00'),
  ('Dodi Hermawan', '14:00:00'),
  ('Rizka Amelia', '20:00:00');

-- mock data pasien_dokter
insert into pasien_dokter (id_dokter, id_pasien, resep, waktu_periksa) values
  (1, 1, 'Captopril 25mg 2x1, Furosemide 40mg 1x1', '2024-05-01 09:15:00'),
  (2, 2, 'Paracetamol syrup 3x5ml, Amoxicillin 250mg 3x1', '2024-05-01 10:30:00'),
  (3, 4, 'Asam folat 1x1, Vitamin prenatal 1x1', '2024-05-01 11:00:00'),
  (4, 6, 'Lubricating eye drops 4x1 tetes', '2024-05-01 14:20:00'),
  (5, 3, 'Metamizole 500mg 3x1 post op', '2024-05-02 08:45:00'),
  (1, 5, 'Amlodipine 10mg 1x1, Diet rendah garam', '2024-05-02 09:30:00'),
  (2, 7, 'Ibuprofen syrup 3x5ml, ORS sachets', '2024-05-02 15:15:00'),
  (3, 2, 'USG kontrol minggu depan', '2024-05-03 10:15:00'),
  (4, 1, 'Kacamata baca +2.0', '2024-05-03 16:30:00'),
  (5, 4, 'Kontrol luka jahitan 1 minggu', '2024-05-04 07:30:00'),
  (1, 7, 'EKG kontrol 2 minggu', '2024-05-04 11:15:00'),
  (2, 3, 'Vitamin D3 1000IU 1x1', '2024-05-05 14:45:00'),
  (3, 6, 'Iron supplement 1x1', '2024-05-05 09:20:00'),
  (4, 5, 'Artificial tears preservative free', '2024-05-06 13:30:00'),
  (5, 2, 'Wound care instruction sheet', '2024-05-06 08:15:00'),
  (1, 4, 'Aspirin 100mg 1x1', '2024-05-07 10:45:00'),
  (2, 1, 'Probiotics 2x1', '2024-05-07 15:30:00'),
  (3, 3, 'Prenatal class referral', '2024-05-08 11:30:00'),
  (4, 7, 'Contact lens fitting', '2024-05-08 16:45:00'),
  (5, 6, 'Physical therapy referral', '2024-05-09 09:00:00');

-- mock data dokter_admin (dokter dan admin yang sama bisa ditambahkan)
insert into dokter_admin (id_dokter, id_admin) values
  (1, 1), (2, 1), (3, 1), (4, 1), (5, 1),  -- Admin 1 pagi
  (1, 2), (2, 2), (3, 2), (4, 2), (5, 2),  -- Admin 2 siang
  (1, 3), (2, 3), (3, 3), (4, 3), (5, 3),  -- Admin 3 malam
  (1, 1), (3, 1), (5, 1), (2, 2), (4, 2);  -- Tambahan

-- mock data pendaftaran
insert into pendaftaran (id_pasien, id_admin) values
  -- pendaftaran pagi
  (1, 1), (2, 1), (3, 1), (4, 1), (5, 1), (6, 1), (7, 1),
  -- pendaftaran siang
  (1, 2), (2, 2), (3, 2), (4, 2), (5, 2), (6, 2),
  -- pendaftaran malam
  (1, 3), (2, 3), (3, 3), (4, 3), (5, 3), (6, 3), (7, 3);
