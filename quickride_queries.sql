
-- Request 1
SELECT trip_id, rider_name, fare
FROM trips
WHERE city = 'Lagos';

-- Request 2
SELECT rider_name, city, fare
FROM trips
ORDER BY fare DESC
LIMIT 5;

-- Request 3
SELECT DISTINCT city
FROM trips;

-- Request 4
SELECT *
FROM trips
WHERE payment_method = 'Card'
  AND fare > 5000;

-- Request 5: Trips where distance was between 5 and 10 km (inclusive)
SELECT *
FROM trips
WHERE distance_km BETWEEN 5 AND 10;

-- Request 6
SELECT *
FROM trips
WHERE rider_name LIKE 'A%';

-- Request 7
SELECT *
FROM trips
WHERE payment_method IN ('Card', 'Wallet');

-- Request 8
SELECT *
FROM trips
WHERE rating IS NULL;

-- Request 9
SELECT *
FROM trips
WHERE status = 'Completed'
ORDER BY city ASC, fare DESC;

-- Request 10
SELECT COUNT(*) AS cancelled_trips
FROM trips
WHERE status = 'Cancelled';

-- Request 11
SELECT
    SUM(fare) AS total_revenue,
    AVG(fare) AS avg_fare,
    MAX(fare) AS max_fare,
    MIN(fare) AS min_fare
FROM trips
WHERE status = 'Completed';

-- Request 12
SELECT vehicle_type, COUNT(*) AS trip_count
FROM trips
GROUP BY vehicle_type;

-- Request 13
SELECT city, SUM(fare) AS total_revenue
FROM trips
WHERE status = 'Completed'
GROUP BY city
ORDER BY total_revenue DESC;

-- Request 14
SELECT city, AVG(rating) AS avg_rating
FROM trips
GROUP BY city
HAVING AVG(rating) < 4.0;

-- Request 15
SELECT t.*, d.driver_name, d.home_city
FROM trips t
JOIN drivers d ON t.driver_id = d.driver_id;

-- Request 16
SELECT d.driver_name, COUNT(*) AS trip_count
FROM trips t
JOIN drivers d ON t.driver_id = d.driver_id
GROUP BY d.driver_name
HAVING COUNT(*) > 6;
