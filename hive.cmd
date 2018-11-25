CREATE EXTERNAL TABLE IF NOT EXISTS ratings (
userId INT,
movieId INT,
rating double,
timest INT)
ROW FORMAT DELIMITED FIELDS TERMINATED BY '@';

CREATE EXTERNAL TABLE IF NOT EXISTS tags (
userId INT,
movieId INT,
tag string,
timest INT)
ROW FORMAT DELIMITED FIELDS TERMINATED BY '@';

dfs -cp -f /dane /user/jpieczatka/;

LOAD DATA INPATH '/user/jpieczatka/dane/movielens/hive/movies/movies.dat' OVERWRITE INTO TABLE movies;
LOAD DATA INPATH '/user/jpieczatka/dane/movielens/hive/ratings/ratings.dat' OVERWRITE INTO TABLE ratings;
LOAD DATA INPATH '/user/jpieczatka/dane/movielens/hive/tags/tags.dat' OVERWRITE INTO TABLE tags;

select avg(ratings.rating) as avgrate, movies.title from ratings, movies where movies.movieid=ratings.movieid group by movies.title having count(ratings.rating) > 100 order by avgrate desc limit 10;
 
select substring(title,-5,4) as year, count(1) as count from movies group by substring(title,-5,4) order by count desc limit 10;

select explode (split(genres,"\\|")) AS genre from movies limit 10;
