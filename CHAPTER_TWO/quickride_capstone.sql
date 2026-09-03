-- Q1 “For the report I need every completed trip showing the rider's name, the driver's name, the city and the fare. The trips table only keeps ids, so bring in the actual names.”
SELECT r.rider_name, d.driver_name, t.city, t.fare
FROM trips t
JOIN riders r ON t.rider_id = r.rider_id
JOIN drivers d ON t.driver_id = d.driver_id
WHERE t.status = 'Completed';

-- Q2 “Pull all our Lagos trips, showing the rider, the driver, the vehicle type and the fare.”
SELECT r.rider_name, d.driver_name, d.vehicle_type, t.fare
FROM trips t
JOIN riders r ON t.rider_id = r.rider_id
JOIN drivers d ON t.driver_id = d.driver_id
WHERE t.city = 'Lagos';

-- Q3 “Who are our most valuable riders? Total spend per rider on completed trips, biggest spender first.”
SELECT r.rider_name, SUM(t.fare) AS total_spend
FROM trips t
JOIN riders r ON t.rider_id = r.rider_id
WHERE t.status = 'Completed'
GROUP BY r.rider_id, r.rider_name
ORDER BY total_spend DESC;

-- Q4 “For the driver scorecard: for each driver, how many completed trips they did and their average rating.”
SELECT d.driver_name, COUNT(t.trip_id) AS completed_trips, AVG(t.rating) AS average_rating
FROM drivers d
LEFT JOIN trips t ON d.driver_id = t.driver_id AND t.status = 'Completed'
GROUP BY d.driver_id, d.driver_name;

-- Q5 “Show me the trips that cost more than our average fare. I want to see the premium rides.”
SELECT * 
FROM trips 
WHERE fare > (SELECT AVG(fare) FROM trips WHERE status = 'Completed')
  AND status = 'Completed';

-- Q6 “For a reliability badge, which drivers have never had a single cancelled trip?”
SELECT driver_id, driver_name 
FROM drivers 
WHERE driver_id NOT IN (
    SELECT DISTINCT driver_id 
    FROM trips 
    WHERE status = 'Cancelled'
);

-- Q7 “Marketing wants to feature our biggest ride ever. Which rider took the most expensive trip of all?”
SELECT r.rider_name, t.fare 
FROM trips t
JOIN riders r ON t.rider_id = r.rider_id
WHERE t.fare = (SELECT MAX(fare) FROM trips WHERE status = 'Completed')
  AND t.status = 'Completed';

-- Q8 “Chioma Bello is our benchmark regular rider. Which riders have taken more trips than she has?”
SELECT r.rider_name, COUNT(t.trip_id) AS total_trips
FROM trips t
JOIN riders r ON t.rider_id = r.rider_id
GROUP BY r.rider_id, r.rider_name
HAVING COUNT(t.trip_id) > (
    SELECT COUNT(trip_id) 
    FROM trips t2
    JOIN riders r2 ON t2.rider_id = r2.rider_id
    WHERE r2.rider_name = 'Chioma Bello'
);

-- Q9 “We want to thank our happy riders. Which riders have given us at least one 5-star trip?”
SELECT DISTINCT r.rider_name
FROM trips t
JOIN riders r ON t.rider_id = r.rider_id
WHERE t.rating = 5;

-- Q10 “Investors want one combined contact list of everyone in the system: riders and drivers together, each with their name, their city, and whether they are a Rider or a Driver.”
SELECT rider_name AS name, city, 'Rider' AS role FROM riders
UNION
SELECT driver_name AS name, home_city AS city, 'Driver' AS role FROM drivers;

-- Q11 “Give me one clean list of every city we touch, whether a trip happened there or a driver is based there. No duplicates.”
SELECT city FROM trips
UNION
SELECT home_city FROM drivers;

-- Q12 “Which single driver has earned us the most money in total, and how much? I only want the top earner.”
SELECT d.driver_name, SUM(t.fare) AS total_earnings
FROM trips t
JOIN drivers d ON t.driver_id = d.driver_id
WHERE t.status = 'Completed'
GROUP BY d.driver_id, d.driver_name
ORDER BY total_earnings DESC
LIMIT 1;
