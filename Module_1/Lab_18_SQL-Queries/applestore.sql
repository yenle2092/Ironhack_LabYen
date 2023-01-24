create schema ironhack_example;
use ironhack_example;
select * from ironhack_example.applestore;

-- 1--What are the different genres? 
-- Games, Productivity, Weather, Shopping, Reference, Finance, Music, Utilities, Travel, 
-- Business, Photo & Video, Navigation, Entertainment, Education, Lifestyle, Food & Drink, 
-- News, Health  Fitness, Medical, Book, Social Networking, Sports

select distinct prime_genre from ironhack_example.applestore;

-- 2. Which is the genre with the most apps rated?
-- Games: 8717381

select prime_genre,sum(rating_count_tot) from ironhack_example.applestore
	group by prime_genre
	order by sum(rating_count_tot) DESC
	limit 1;
    
-- 3. Which is the genre with most apps?
-- Games: 169

select prime_genre,count(ï»¿id) from ironhack_example.applestore
	group by prime_genre
	order by count(ï»¿id) DESC
	limit 1;
    
-- 4. Which is the one with least?
-- Medical: 1, Book: 4, Food & Drink: 5, Navigation: 8, Reference: 10,
-- Finance: 13, Lifestyle: 14, Sports: 15, Business: 16, Weather: 17

select prime_genre,count(ï»¿id) from ironhack_example.applestore
	group by prime_genre
	order by count(ï»¿id) ASC
	limit 10;
    
-- 5. Find the top 10 apps most rated.
/*Facebook	2974676	0	Social Networking
Pandora - Music & Radio	1126879	0	Music
Pinterest	1061624	0	Social Networking
Bible	985920	0	Reference
Angry Birds	824451	0	Games
Fruit Ninja Classic	698516	1.99	Games
Solitaire	679055	0	Games
PAC-MAN	508808	0	Games
Calorie Counter & Diet Tracker by MyFitnessPal	507706	0	Health & Fitness
The Weather Channel: Forecast, Radar & Alerts	495626	0	Weather
*/

select track_name,sum(rating_count_tot),price,prime_genre from ironhack_example.applestore
	group by track_name,price,prime_genre
	order by sum(rating_count_tot) DESC
	limit 10;

-- 6. Find the top 10 apps best rated by users.
/*The Photographer's Ephemeris	5	8.99
J&J Official 7 Minute Workout	5	0
Daily Audio Bible App	5	0.99
Plants vs. Zombies	5	0.99
Learn English quickly with MosaLingua	5	4.99
Domino's Pizza USA	5	0
Kurumaki Calendar -month scroll calendar-	5	1.99
Fragment's Note	5	3.99
Dragon Island Blue	5	0.99
TurboScan Pro - document & receipt scanner: scan multiple pages and photos to PDF	5	4.99
*/

select track_name,AVG(user_rating),price, prime_genre from ironhack_example.applestore
	group by track_name, price, prime_genre
	order by AVG(user_rating) DESC
	limit 10;

-- 7. Take a look at the data you retrieved in question 5. Give some insights.
-- Most of apps in this question are free, are belong to the genre: Games and Social Networking

-- 8. Take a look at the data you retrieved in question 6. Give some insights.
-- Most of apps in this questions are not free

-- 9. Now compare the data from questions 5 and 6. What do you see?
-- The data from question 5 and 6 are not the same "track_name"

-- 10. How could you take the top 3 regarding both user ratings and number of votes?
/* Plants vs. Zombies	5	426463
Domino's Pizza USA	5	258624
Plants vs. Zombies HD	5	163598
*/

select track_name,user_rating,rating_count_tot from ironhack_example.applestore
	order by user_rating DESC, rating_count_tot DESC
	limit 3;

-- 11. Do people care about the price of an app?  I think Yes
-- Do some queries, 
-- comment why are you doing them and the results you retrieve. 
-- What is your conclusion?
-- Because most  of the app have the most rating who are free.

select track_name,sum(rating_count_tot),price from ironhack_example.applestore
	group by  track_name,price
	order by sum(rating_count_tot) DESC, price DESC
	limit 10;
    















