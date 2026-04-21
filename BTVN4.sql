CREATE DATABASE session06_btvn4;
USE session06_btvn4;
CREATE TABLE hotels(
	hotel_id INT PRIMARY KEY, 
    hotel_name VARCHAR(255) NOT NULL,
    price DECIMAL(18,2) CHECK(price > 0),
    orders_successful INT CHECK(orders_successful >= 0),
    orders_un_successful INT CHECK(orders_un_successful >= 0)
);

CREATE TABLE bookings(
	booking_id INT PRIMARY KEY, 
    status VARCHAR(50) NOT NULL,
    hotel_id INT PRIMARY KEY
);
DROP TABLE hotels;
INSERT INTO hotels
(hotel_id, hotel_name, price, orders_successful, orders_un_successful )
VALUES
(1, 'Sunrise Hotel', 1200000, 150, 54 ),
(2, 'Moonlight Resort', 2500000, 80, 45),
(3, 'Lotus Boutique', 900000, 200, 63),
(4, 'Nhà nghỉ Gia Huy', 400000,40,12);
INSERT INTO bookings (booking_id, hotel_id, status, total_price) VALUES
(101, 1, 'COMPLETED', 3500000),
(102, 1, 'COMPLETED', 4200000),
(103, 1, 'CANCELLED', 2000000),
(104, 1, 'COMPLETED', 3900000),
(105, 1, 'FAILED', 1500000),

(201, 2, 'COMPLETED', 2500000),
(202, 2, 'COMPLETED', 2700000),
(203, 2, 'COMPLETED', 2800000),

(301, 3, 'COMPLETED', 5000000),
(302, 3, 'COMPLETED', 5200000),
(303, 3, 'COMPLETED', 5100000),
(304, 3, 'COMPLETED', 5300000),
(305, 3, 'COMPLETED', 5400000);
-- CÁch 1
SELECT
    hotel_id
FROM bookings
GROUP BY hotel_id
HAVING
    SUM(CASE WHEN status = 'COMPLETED' THEN 1 ELSE 0 END) >= 50
    AND AVG(CASE WHEN status = 'COMPLETED' THEN total_price END) > 3000000;
-- Cách 2
SELECT
    hotel_id
FROM bookings
WHERE status = 'COMPLETED'
GROUP BY hotel_id
HAVING
    COUNT(*) >= 50
    AND AVG(total_price) > 3000000;