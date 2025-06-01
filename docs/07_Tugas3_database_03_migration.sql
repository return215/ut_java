-- Migrasi SQL untuk Menambahkan Tabel Konsultasi Event

ALTER TABLE pasien_dokter
ADD COLUMN id_konsultasi INT;

ALTER TABLE dokter_admin
ADD COLUMN id_konsultasi INT;

ALTER TABLE pendaftaran
ADD COLUMN id_konsultasi INT;

CREATE TABLE konsultasi_event (
    id_konsultasi INT PRIMARY KEY AUTO_INCREMENT,
    waktu_konsultasi DATETIME NOT NULL
);

CREATE TEMPORARY TABLE temp_pasien_dokter_konsultasi_map (
    old_pasien_dokter_id INT PRIMARY KEY,
    new_konsultasi_id INT
);

INSERT INTO konsultasi_event (waktu_konsultasi)
SELECT waktu_periksa FROM pasien_dokter ORDER BY id;

SET @first_konsultasi_id = (SELECT MIN(id_konsultasi) FROM konsultasi_event);

UPDATE pasien_dokter pd
SET id_konsultasi = @first_konsultasi_id + (pd.id - 1);

UPDATE dokter_admin da
SET id_konsultasi = @first_konsultasi_id + (da.id_data - 1);

UPDATE pendaftaran p
SET id_konsultasi = @first_konsultasi_id + (p.id_daftar - 1);

ALTER TABLE pasien_dokter
ADD CONSTRAINT fk_pasien_dokter_konsultasi
FOREIGN KEY (id_konsultasi) REFERENCES konsultasi_event(id_konsultasi)
ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE dokter_admin
ADD CONSTRAINT fk_dokter_admin_konsultasi
FOREIGN KEY (id_konsultasi) REFERENCES konsultasi_event(id_konsultasi)
ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE pendaftaran
ADD CONSTRAINT fk_pendaftaran_konsultasi
FOREIGN KEY (id_konsultasi) REFERENCES konsultasi_event(id_konsultasi)
ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE pasien_dokter
DROP COLUMN waktu_periksa;

-- Ubah prosedur ProsesPasien agar menggunakan id_konsultasi
DROP PROCEDURE IF EXISTS ProsesPasien; -- Hapus prosedur lama jika ada

CREATE PROCEDURE ProsesPasien (
    IN id_pasien_p INT,
    IN id_dokter_p INT,
    IN id_admin_p INT,
    IN resep_p TEXT,
    IN waktu_temu DATETIME
)
NOT DETERMINISTIC
SQL SECURITY INVOKER
BEGIN
    DECLARE bisa_konsul BOOLEAN;
    DECLARE v_id_konsultasi INT; -- Variabel untuk menyimpan ID konsultasi baru
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK; -- Rollback perubahan jika terjadi error
        RESIGNAL; -- Teruskan exception
    END;

    START TRANSACTION;

    SELECT CekKetersediaanDokter(id_dokter_p, TIME(waktu_temu)) INTO bisa_konsul;

    IF bisa_konsul = 0 THEN
        -- Error: dokter tidak tersedia
        SIGNAL SQLSTATE '45D00' SET
            MESSAGE_TEXT = 'Dokter tidak tersedia pada waktu yang dipilih',
            MYSQL_ERRNO = 2000;
    END IF;

    INSERT INTO konsultasi_event (waktu_konsultasi) VALUES (waktu_temu);
    SET v_id_konsultasi = LAST_INSERT_ID();

    INSERT INTO pasien_dokter (id_dokter, id_pasien, resep, id_konsultasi) VALUES
        (id_dokter_p, id_pasien_p, resep_p, v_id_konsultasi);
    INSERT INTO dokter_admin (id_dokter, id_admin, id_konsultasi) VALUES
        (id_dokter_p, id_admin_p, v_id_konsultasi);
    INSERT INTO pendaftaran (id_pasien, id_admin, id_konsultasi) VALUES
        (id_pasien_p, id_admin_p, v_id_konsultasi);

    COMMIT;
END;

ALTER TABLE pasien_dokter MODIFY COLUMN id_konsultasi INT NOT NULL;
ALTER TABLE dokter_admin MODIFY COLUMN id_konsultasi INT NOT NULL;
ALTER TABLE pendaftaran MODIFY COLUMN id_konsultasi INT NOT NULL;
