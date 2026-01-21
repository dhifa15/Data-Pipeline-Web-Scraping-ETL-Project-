/*
=================================================
Milestone 1

Nama  : Hazna Dhifa Putri Ardeva
Batch : CODA-RMT-014

Milestones ini dibuat untuk mengerjakan project data pipeline/ETL  
=================================================
*/

-- Membuat Database
CREATE DATABASE hotel_bali;

-- MEMBUAT TABLE STAGING
'''
	Table staging berisikan seluruh data pada file csv.
	Table ini dibuat untuk mempermudah pengisian table hasil normalisasi
'''
-- Query untuk membuat table staging 
CREATE TABLE staging_hotel (
			hotel_id SERIAL PRIMARY KEY,
			nama_hotel VARCHAR,
			lokasi VARCHAR,
			rating FLOAT,
			kategori_rating VARCHAR, 
			spesial_promo VARCHAR,
			harga INTEGER
);

-- Query untuk insert data dari file hotel_bali_clean.csv ke table staging
COPY staging_hotel(
			hotel_id,
			nama_hotel,
			lokasi,
			rating,
			kategori_rating, 
			spesial_promo,
			harga)
FROM 'C:\temp\hotel_bali_clean.csv'
DELIMITER ','
CSV HEADER

-- Query untuk melihat table staging_hotel yang sudah diisi
SELECT * FROM staging_hotel;

'''
	Pada data ini perlu dilakukan normalisasi karena terdapat kolom
	yang nilainya berulang-ulang (redundancy), dan terdapat kolom yang
	tidak bergantung pada primary key.
	Normalisasi dilakukan dengan memecah tabel staging menjadi 3 tabel 
	yaitu hotel_bali, rating_hotel, dan lokasi_hotel. 
'''

-- MEMBUAT TABLE rating_hotel
-- Query untuk membuat table rating_hotel
CREATE TABLE rating_hotel(
			rating_id SERIAL PRIMARY KEY,
			kategori_rating VARCHAR,
			min_rating DOUBLE PRECISION,
			max_rating DOUBLE PRECISION
);

-- Query untuk mengisi kolom kategori_rating di table rating_hotel dengan value di staging_hotel
INSERT INTO rating_hotel ( 
			kategori_rating
			)
SELECT DISTINCT kategori_rating 
FROM staging_hotel
WHERE kategori_rating IS NOT NULL;

-- Query untuk melihat unique value di kolom kategori-rating untuk pedoman pengisian min_rating dan max_rating
SELECT DISTINCT rating, kategori_rating
FROM staging_hotel;

-- Query untuk mengisi kolom min_rating dan max_rating berdasarkan kategori_rating
-- Mengisi min_rating dan max_rating untuk kategori 'Exceptional'
UPDATE rating_hotel
SET min_rating = 9.5,
    max_rating = 10
WHERE kategori_rating = 'Exceptional'; 

-- Mengisi min_rating dan max_rating untuk kategori 'Wonderful'
UPDATE rating_hotel
SET min_rating = 9,
    max_rating = 9.4
WHERE kategori_rating = 'Wonderful';

-- Mengisi min_rating dan max_rating untuk kategori 'Excellent'
UPDATE rating_hotel
SET min_rating = 8.7,
    max_rating = 8.9
WHERE kategori_rating = 'Excellent';

-- Mengisi min_rating dan max_rating untuk kategori 'Very Good'
UPDATE rating_hotel
SET min_rating = 8,
    max_rating = 8.6
WHERE kategori_rating = 'Very Good';

-- Query untuk melihat tabel rating_hotel yang sudah terisi
SELECT * FROM rating_hotel;


-- MEMBUAT TABLE lokasi_hotel
-- Query untuk membuat table lokasi_hotel
CREATE TABLE lokasi_hotel(
			 lokasi_id SERIAL PRIMARY KEY,
			 nama_lokasi VARCHAR
);

-- Query untuk mengisi kolom nama_lokasi di table lokasi_hotel dari value table staging_hotel
INSERT INTO lokasi_hotel(
			nama_lokasi
)
SELECT DISTINCT lokasi
FROM staging_hotel;

-- Query untuk melihat table lokasi_hotel yang sudah terisi
SELECT * FROM lokasi_hotel;
);

-- MEMBUAT TABLE hotel_bali
-- Query untuk membuat table hotel_bali
CREATE TABLE hotel_bali(
			 hotel_id SERIAL PRIMARY KEY,
			 nama_hotel VARCHAR,
			 lokasi_id INTEGER REFERENCES lokasi_hotel(lokasi_id),
			 rating DOUBLE PRECISION, 
			 spesial_promo VARCHAR,
			 harga INTEGER
);

-- Query untuk mengisi kolom-kolom di table hotel_bali dengan value di table staging_hotel dan lokasi_id dengan cara JOIN
INSERT INTO hotel_bali (
    		nama_hotel,
    		lokasi_id,
    		rating,
    		spesial_promo,
    		harga
)
SELECT  s.nama_hotel,
    	l.lokasi_id,
    	s.rating,
    	s.spesial_promo,
    	s.harga
FROM staging_hotel s
JOIN lokasi_hotel l ON s.lokasi = l.nama_lokasi;

-- Query untuk melihat table hotel_bali yang sudah terisi
SELECT * FROM hotel_bali;

-- RESULT
SELECT * FROM staging_hotel;
SELECT * FROM hotel_bali;
SELECT * FROM rating_hotel;
SELECT * FROM lokasi_hotel;
