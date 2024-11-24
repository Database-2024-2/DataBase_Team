-- load_data.sql
USE soccerdb;

LOAD DATA INFILE './data/stadium.csv'
INTO TABLE Stadium
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
(StadiumID,Name,Capacity,Location);

LOAD DATA INFILE './data/team.csv'
INTO TABLE Team
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
(TeamID,Name,Strength,WinRate,Strategy,Formation,Coach,AvgScore,AvgConcede);

LOAD DATA INFILE './data/player.csv'
INTO TABLE Player
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
(PlayerId, Name, Weight, Height, Age, Position, TeamId);

LOAD DATA INFILE './data/player_performance.csv'
INTO TABLE Stadium
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
(PlayerID, Goals, Assists, Shots, Fouls, YellowCards, RedCards);

LOAD DATA INFILE './data/game.csv'
INTO TABLE Stadium
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
(GameID,Date,LocationID);

LOAD DATA INFILE './data/game_participation.csv'
INTO TABLE Stadium
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
(GameID,TeamID,Role);

LOAD DATA INFILE './data/game_result.csv'
INTO TABLE Stadium
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
(GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards);
