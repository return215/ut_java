delimiter //

create definer = 'nord'@'%'
procedure DemoProsesObat (
  in id_pasien_p int
) non deterministic
  sql security invoker
begin
  declare id_transaksi_b int;
  declare harga_obat int;
  declare exit handler for sqlexception
  begin
    rollback; -- rollback changes on error
    resignal; -- pass the exception again
  end;

  start transaction;

  INSERT INTO transaksi_obat (id_pasien, total_harga) VALUES (id_pasien_p, 0);
  select LAST_INSERT_ID() into id_transaksi_b;

  -- add obat
  select harga into harga_obat from obat where id_obat = 30;
  INSERT INTO transaksi_obat_detail (id_transaksi, id_obat, jumlah, harga, total_harga) VALUES
  (id_transaksi_b, 30, 2, harga_obat, 0); -- obat tetes mata kering

  select harga into harga_obat from obat where id_obat = 19;
  INSERT INTO transaksi_obat_detail (id_transaksi, id_obat, jumlah, harga, total_harga) VALUES
  (id_transaksi_b, 19, 3, harga_obat, 0); -- suplemen mata

  commit;
end //

create definer = 'nord'@'%'
procedure DemoProsesObatGagal (
  in id_pasien_p int
) non deterministic
  sql security invoker
begin
  declare id_transaksi_b int;
  declare harga_obat int;
  declare exit handler for sqlexception
  begin
    rollback; -- rollback changes on error
    resignal; -- pass the exception again
  end;

  start transaction;

  INSERT INTO transaksi_obat (id_pasien, total_harga) VALUES (id_pasien_p, 0);
  select LAST_INSERT_ID() into id_transaksi_b;

  -- add obat
  select harga into harga_obat from obat where id_obat = 30;
  INSERT INTO transaksi_obat_detail (id_transaksi, id_obat, jumlah, harga, total_harga) VALUES
  (id_transaksi_b, 30, 2, harga_obat, 0); -- obat tetes mata kering

  select harga into harga_obat from obat where id_obat = 19;
  INSERT INTO transaksi_obat_detail (id_transaksi, id_obat, jumlah, harga, total_harga) VALUES
  (id_transaksi_b, 19, 60, harga_obat, 0); -- suplemen mata

  commit;
end //

delimiter ;

-- using function
select CekKetersediaanDokter(1, '20:00:00'); -- returns 1
select CekKetersediaanDokter(1, '21:00:00'); -- returns 0

call ProsesPasien(
  8,
  5,
  2,
  '3x Suplemen Mata, 2x Obat Tetes Mata Kering',
  '2025-05-31 22:00:00'
); -- fail: waktu dokter

call ProsesPasien(
  8,
  5,
  4,
  '3x Suplemen Mata, 2x Obat Tetes Mata Kering',
  '2025-05-31 17:30:00'
); -- fail: invalid admin, pasien_dokter harusnya tidak ada

call ProsesPasien(
  8,
  5,
  2,
  '3x Suplemen Mata, 2x Obat Tetes Mata Kering',
  '2025-05-31 17:30:00'
); -- success

call DemoProsesObatGagal(8);
call DemoProsesObat(8);
