
CREATE FUNCTION CekKetersediaanDokter (
  id_dokter_f INT,
  waktu_temu TIME
) RETURNS BOOLEAN
  DETERMINISTIC         -- sistem saya ada binary logging, jadi harus ada ini
  SQL SECURITY INVOKER  -- gunakan izin dari yang memanggil fungsi
BEGIN
  DECLARE waktu_selesai TIME;
  DECLARE waktu_mulai TIME;

  SELECT waktu_kerja, waktu_kerja + INTERVAL 12 HOUR
  INTO waktu_mulai, waktu_selesai
  FROM dokter
  WHERE id_dokter_f = id_dokter;

  RETURN waktu_temu BETWEEN waktu_mulai AND (waktu_selesai - INTERVAL 1 SECOND);
END;

CREATE TRIGGER update_stok_obat
BEFORE INSERT ON transaksi_obat_detail
FOR EACH ROW
BEGIN
  UPDATE obat SET stok = stok - NEW.jumlah
    WHERE id_obat = NEW.id_obat;
END;

CREATE TRIGGER update_total_transaksi_obat
AFTER INSERT ON transaksi_obat_detail
FOR EACH ROW
BEGIN
  UPDATE transaksi_obat
    SET total_harga = (
      SELECT SUM(total_harga)
      FROM transaksi_obat_detail
      WHERE id_transaksi = NEW.id_transaksi
    )
    WHERE id_transaksi = NEW.id_transaksi;
END;

