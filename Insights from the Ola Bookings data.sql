/*
18th Nov 2024 - 4:31am IST
Ola Data Analytics End to End Project
YT Source : Ola Data Analytics End to End Project | Data Analytics SQL, Excel & PowerBI Dashboard Project
*/

show tables;
desc ola_bookings;
select * from ola_bookings
limit 10;


-- 1. Retrieve all successful bookings
select *
from ola_bookings
where Booking_Status='Success';

-- 2. Find the average ride distance for each vehicle type.
select Vehicle_Type, avg(Ride_Distance) as avg_ride_distance
from ola_bookings
group by Vehicle_Type;

-- 3. Get the total number of canceled rides by customers.
select count(*)
from ola_bookings
where Booking_Status='Canceled by Customer';

-- 4. List the top 5 customers who booked the highest number of rides.
select Customer_ID, count(*)
from ola_bookings
where Booking_Status='Success'
group by Customer_ID
order by count(*) desc
limit 5;

-- 5. Get the number of rides canceled by drivers due to personal and car-related issues.
select count(*) no_of_rides
from ola_bookings
where Canceled_Rides_by_Driver='Personal & Car related issue';

-- 6. Find the maximum and minimum driver ratings for Prime Sedan bookings.
select max(Driver_Ratings), min(Driver_Ratings)
from ola_bookings
where Vehicle_Type='Prime Sedan' and Booking_Status='Success';

-- 7. Retrieve all rides where payment was made using UPI.
select *
from ola_bookings
where Payment_Method='UPI';

-- 8. Find the average customer rating per vehicle type.
select Vehicle_Type, avg(customer_rating)
from ola_bookings
group by Vehicle_Type;

-- 9. Calculate the total booking value of rides completed successfully.
select sum(booking_value)
from ola_bookings
where Incomplete_Rides='No';

select distinct Booking_Status
from ola_bookings
where Incomplete_Rides !='null';  -- this proves that the rides which are "success" (not canceled by driver/customer or driver not found) do not have null as their incomplete_rides

/*
10 additional queries (medium to tough level) framed from ChatGPT.
*/

-- Query 1: Write a query to find the top 5 most frequent pickup locations for completed rides.
select Pickup_Location, count(*) frequency_of_pickup
from ola_bookings
where Incomplete_Rides != 'null' or Incomplete_Rides = 'No'
group by Pickup_Location
order by frequency_of_pickup desc
limit 5;
 
-- Query 2: Identify the average ride distance for each vehicle type and display the vehicle type with the highest average ride distance.
select Vehicle_Type, avg(Ride_Distance) avg_ride_distance
from ola_bookings
group by Vehicle_Type
order by avg_ride_distance desc
limit 1;

-- Query 3: Create a query to calculate the total revenue generated (Booking_Value) for each payment method. Sort the results in descending order of total revenue.
select payment_method, sum(Booking_Value) total_revenue_generated
from ola_bookings
where Payment_Method!='null'
group by Payment_Method
order by total_revenue_generated desc;

-- Query 4: Write a query to find the customer(s) with the highest number of successful bookings. Display the Customer_ID and total successful bookings.
select Customer_ID, count(Booking_Status='Success') total_successful_bookings
from ola_bookings
group by Customer_ID
order by total_successful_bookings desc
limit 1;

-- Query 5: Identify bookings that were canceled by customers due to the reason "Driver is not moving towards pickup location". How many such cancellations were there?
select count(*) cancellations
from ola_bookings
where Canceled_Rides_by_Customer='Driver is not moving towards pickup location';

-- Query 6: Construct a query to find the average customer rating and driver rating for each unique pickup location.
select Pickup_Location, avg(customer_rating) avg_customer_rating, avg(Driver_Ratings) avg_driver_ratings
from ola_bookings
group by Pickup_Location;

-- Query 7: Find all bookings where the driver rating was greater than 4.0, but the customer rating was less than or equal to 3.0. Display the Booking_ID, driver rating, and customer rating.
select Booking_ID, Driver_Ratings, Customer_Rating
from ola_bookings
where Driver_Ratings>4 and Customer_Rating <=3;

-- Query 8: Write a query to determine the number of rides where the ride distance was 0. Filter for rides canceled by either customers or drivers and categorize them based on the reason for cancellation.
select Canceled_Rides_by_Customer, Canceled_Rides_by_Driver, count(*)
from ola_bookings
where Ride_Distance=0
and (Canceled_Rides_by_Customer!='null' or Canceled_Rides_by_Driver!='null')
group by Canceled_Rides_by_Customer, Canceled_Rides_by_Driver;

-- Query 9: Calculate the percentage of rides completed successfully out of the total bookings. Exclude entries where no status was provided.
select
(
(select count(*) from ola_bookings where Booking_Status='Success')
/
(select count(*) from ola_bookings)
)*100 as completed_rides_percentage;

-- Query 10: For rides completed via different payment methods, calculate the average Booking_Value. Compare and identify if there's a significant difference between different payment types.
select Payment_Method, avg(Booking_Value)
from ola_bookings
group by Payment_Method;