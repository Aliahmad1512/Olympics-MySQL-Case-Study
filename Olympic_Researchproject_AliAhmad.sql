/*Creating a database*/
create database Olympics;

/*Use Olympics as a database*/
use Olympics;

/*Creating a table for athletes and events details*/
create table athlete_events
(ID	int,
Name varchar(100),
Sex	varchar(10),
Age	int,
Height int,
Weight int,
Team varchar(100),
NOC varchar(100),	
Games varchar(100),	
Year int,
Season varchar(100),	
City varchar(100),	
Sport varchar(100),	
Event varchar(100),	
Medal varchar(100)	
);

/*Now a query to look at table athlete_events in undefined order.*/
select * from athlete_events;

/*noc_regions table details are imported directly as the file is small*/
select * from noc_regions;

/*Business Analysis on the Olympics Dataset*/


/*No. of Regions in the dataset*/
select count(distinct region) as TotalRegions
from noc_regions;	
/*So there are 207 Countries that participated in the Olympics*/


/*List is the total number of females and males by gender?*/
select sex, count(*) as TotalNo
from athlete_events
group by sex
order by 2;


/*The total number of females and males by city. A query that also computes the male to female gender ratio in each city*/
select city, sex, count(*) as TotalNo, sum(case when sex = "M" then 1 else 0 end) as male,
sum(case when sex = "F" then 1 else 0 end) as female,
sum(case when sex = "M" then 1 else 0 end)/sum(case when sex = "F" then 1 else 0 end) as Ratio
from athlete_events
group by city
order by 4 desc, 5 desc
limit 20;


/*If we look by region-wise data*/
/*The total number of females and males by region? Provide a query that computes the male to female gender ratio in each region*/
select region, sex, count(*) as TotalNo, sum(case when sex = "M" then 1 else 0 end) as male,
sum(case when sex = "F" then 1 else 0 end) as female,
sum(case when sex = "M" then 1 else 0 end)/sum(case when sex = "F" then 1 else 0 end) as Ratio
from athlete_events a inner join noc_regions n on a.noc = n.noc
group by region
order by 1
limit 20; 


/*No. of males vs females who won medals*/
select medal, sum(case when sex = "M" then 1 else 0 end) as MedalByMale, sum(case when sex = "F" then 1 else 0 end) as MedalByfemale 
from athlete_events
where medal = "gold";
select medal, sum(case when sex = "M" then 1 else 0 end) as MedalByMale, sum(case when sex = "F" then 1 else 0 end) as MedalByfemale 
from athlete_events
where medal = "silver";
select medal, sum(case when sex = "M" then 1 else 0 end) as MedalByMale, sum(case when sex = "F" then 1 else 0 end) as MedalByfemale 
from athlete_events
where medal = "bronze";


/*No. of Gold medals from each Country. Top 5 Countries*/
select medal, count(*) as NoOfGold, region
from athlete_events a inner join noc_regions n on a.noc = n.noc
where medal = "gold"
group by region
order by 2 desc
limit 5;


/*Age distribution of the participants*/
select case when age < 20 then "0-20" when age between 20 and 30 then "20-30"
when age between 30 and 40 then "30-40" when age between 40 and 50 then "40-50"
when age between 50 and 60 then "50-60" when age between 60 and 70 then "60-70"
when age between 70 and 80 then "70-80" when age > 80 then "above 80" end as age_range, age, count(age) as Cnt
from athlete_events
group by age
order by age_range, Cnt desc;	


/*Gold medals from athletes that are beyond the age of 60*/
select sport, medal, count(*) as NumberofGolds
from athlete_events
where medal = "gold" and age > 60
group by sport;


/*List the country that has the highest number of participants sorted by the season. (2-level ordering)*/
select team, season, count(*) as Participants
from athlete_events 
group by team 
order by Participants desc, season
limit 10;


/*Country that has won the highest number of medals and in which year*/
select Team, count(Medal) as Total, year
from athlete_events
where medal in ("gold", "silver", "bronze")
group by Team
order by total desc;


/*Now if we look number of medals by region-wise.
Region that has won the highest number of medals and in which year*/
select region, count(medal) as total, year
from athlete_events a inner join noc_regions n on a.noc = n.noc
where medal in ("gold", "silver", "bronze")
group by region
order by 2 desc;


/*Medal Attained in Rio Olympics 2016*/
select team, year, count(medal) as NoOfGoldMedals
from athlete_events
where medal = "gold" and year = 2016
group by team
order by 3 desc
limit 20;


/*Total no. of female athletes in each olympics*/
select sex, count(*) as FemaleAthletes, year
from athlete_events
where sex = "F" and season = "summer"
group by year
order by 3; 


/*No. of athletes in Summer season vs Winter season*/
select season, sum(case when season = "summer" then 1 else 0 end) as SummerSport, sum(case when season = "winter" then 1 else 0 end) as WinterSport 
from athlete_events
where year >= 1986
group by season;


/*City that is most suitable for multiple games to be played?*/
select city, count(*) as TotalGamesPlayed
from athlete_events
group by team
order by 2 desc;


/*List the top 10 most popular sports events for women?*/
select event, count(*) as PopularSports
from athlete_events
where sex = "F"
group by event 
order by 2 desc
limit 10;
/*List the top 10 most popular sports events for men?*/
select event, count(*) as PopularSports
from athlete_events
where sex = "M"
group by event 
order by 2 desc
limit 10;


/*The number of participants in each sport and the event where it held. The participants should be sorted by their height and weight?*/
select sport, event, count(*) as Participants, region, height, weight
from athlete_events a inner join noc_regions n on a.noc = n.noc
group by sport
order by 3 desc, 4 desc, 5 desc, 6 desc
limit 20;


/*Height vs Weight distribution of the different athletes who won any Medal*/
select sex, medal, height, weight
from athlete_events 
where medal not like "%No Medal%"
group by height, weight;



/*How many athletes are in each city in the athlete_events table that have more than one athlete in the city ? 
Select the city and display the number of how many athletes are in each if its greater than 5000 sorted in descending manner.
Find the top 5 cities.*/

select city, count(*) as Athletes
from athlete_events
group by city
having athletes > 5000
order by 2 desc
limit 5;


														/*OLYMPICS CASE STUDY*/
/*#################################################################################################################################################*/






