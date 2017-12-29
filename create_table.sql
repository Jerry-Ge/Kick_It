DROP DATABASE IF EXISTS finalProject;
CREATE DATABASE finalProject;
USE finalProject;

CREATE TABLE Users (
	userID INT(11) PRIMARY KEY AUTO_INCREMENT,
	image VARCHAR(100),
    username VARCHAR(50) NOT NULL,
    userPassword VARCHAR(50) NOT NULL,
    canJoin INT(1) NOT NULL,
    canMessage INT(1) NOT NULL,
    gender VARCHAR(10) NOT NULL,
    age VARCHAR(50) NOT NULL,
    location VARCHAR(50) NOT NULL
);

CREATE TABLE Friends (
    userID INT(11) NOT NULL,
	friendID INT(11) NOT NULL,
    FOREIGN KEY fk1(userID) REFERENCES Users(userID)
);

CREATE TABLE Skills (
    userID INT(11) NOT NULL,
	sportType VARCHAR(50) NOT NULL,
    skillLevel VARCHAR(50) NOT NULL,
    FOREIGN KEY fk1(userID) REFERENCES Users(userID)
);

CREATE TABLE GamesJoined (
    userID INT(11) NOT NULL,
	gameID INT(11) NOT NULL,
    FOREIGN KEY fk1(userID) REFERENCES Users(userID)
);

CREATE TABLE Games (
	gameID INT(11) PRIMARY KEY AUTO_INCREMENT,
    administratorID INT(11) NOT NULL,
    gameName VARCHAR(50) NOT NULL,
	sportType VARCHAR(50) NOT NULL,
    location VARCHAR(50) NOT NULL,
    maxPlayer INT(10) NOT NULL,
    currPlayer INT(10) NOT NULL,
    gameTime VARCHAR(50) NOT NULL,
    gender VARCHAR(10) NOT NULL,
    skillLevel VARCHAR(50) NOT NULL,
    age VARCHAR(50) NOT NULL,
    isReady INT(1) NOT NULL,
    description VARCHAR(50) NOT NULL
);


CREATE TABLE Image (
	imageID INT(11) PRIMARY KEY AUTO_INCREMENT,
    sportType VARCHAR(50) NOT NULL,
    image VARCHAR(100) NOT NULL
);

INSERT INTO Image (sportType, image) 
	VALUES  ('Baseball', 'http://obht3yfa8.bkt.clouddn.com/baseball.jpg'),
					('Basketball', 'http://obht3yfa8.bkt.clouddn.com/basketball1.jpg'),
                    ('Football', 'http://obht3yfa8.bkt.clouddn.com/football1.jpg'),
                    ('Golf', 'http://obht3yfa8.bkt.clouddn.com/golf.jpg'),
                     ('Icehockey', 'http://obht3yfa8.bkt.clouddn.com/icehockey1.jpg'),
                     ('Soccer', 'http://obht3yfa8.bkt.clouddn.com/soccer.jpg'),
					('Tabletennis', 'http://obht3yfa8.bkt.clouddn.com/tabletennis.jpg'),
                     ('Tennis', 'http://obht3yfa8.bkt.clouddn.com/tennis.jpg'),
                     ('Volleyball', 'http://obht3yfa8.bkt.clouddn.com/volleyball.jpg'),
                     ('Badminton', 'http://obht3yfa8.bkt.clouddn.com/badminton.jpg');
    
INSERT INTO Users (image, username, userPassword, canJoin, canMessage, gender, age, location)
	VALUES (null, 'Xavier', '123', 1, 1, 'Male', '18-25', 'USC'),
	VALUES (null, 'Bradley', '123', 1, 1, 'Male', '18-25', 'USC'),
	VALUES (null, 'Jason', '123', 1, 1, 'Male', '25-30', 'USC'),
	VALUES (null, 'Jerry', '123', 1, 1, 'Male', '18-25', 'USC'),
	VALUES (null, 'Natalie', '123', 1, 1, 'Female', '18-25', 'USC'),
                     
INSERT INTO Games (administratorID, gameName, sportType, location, maxPlayer, currPlayer, gameTime, gender, skillLevel, age, isReady, decription)
	VALUES (1, 'DunkContest', 'Basketball', 'USC', 10, 1, '2017-08-03T09:00', 'Male', 'Advance', '18-25', 0, 'BBall Pick up and Dunk contest'),
	VALUES (1, 'TheCup', 'Soccer', 'USC', 10, 1, '2017-08-03T09:00', 'Male', 'Intermediate', '18-25', 0, 'Get Your Team together for a kick off'),
	VALUES (2, 'OpenCourt', 'Tennis', 'USC', 10, 1, '2017-08-03T09:00', 'Male', 'Intermediate', '18-25', 0, 'It is a cool game'),
	VALUES (2, 'Trojan', 'Football', 'USC', 10, 1, '2017-08-03T09:00', 'Male', 'Advanced', '18-25', 0, 'Twohand Touch pick up?'),
	VALUES (3, 'QuickRun', 'Baseball', 'USC', 10, 1, '2017-08-03T09:00', 'Any', 'Advanced', '25-30', 0, 'Not so mini golf!'),
	VALUES (3, 'GOLFWANG', 'Golf', 'USC', 10, 1, '2017-08-03T09:00', 'Male', 'Any', '25-30', 0, 'How low can you go ?'),
	VALUES (4, 'SnipeShow', 'Icehockey', 'USC', 10, 1, '2017-08-03T09:00', 'Male', 'Advanced', '18-25', 0, 'Open practice'),
	VALUES (4, 'Badminton', 'Badminton', 'USC', 10, 1, '2017-08-03T09:00', 'Male', 'Intermediate', '18-25', 0, 'Hit Off ? '),
	VALUES (5, 'PingPong tournament', 'Tabletennis', 'USC', 10, 1, '2017-08-03T09:00', 'Female', 'Any', '18-25', 0, 'PingPongggggg!!!!'),
	VALUES (5, 'Fast and Fury', 'Volleyball', 'USC', 10, 1, '2017-08-03T09:00', 'Female', 'Intermediate', '18-25', 0, 'Summer sadness ? Come through');
	
INSERT INTO GamesJoined(userID, gameID)
	VALUES (1, 1),
	VALUES (1, 2),
	VALUES (2, 3),
	VALUES (2, 4),
	VALUES (3, 5),
	VALUES (3, 6),
	VALUES (4, 7),
	VALUES (4, 8),
	VALUES (5, 9),
	VALUES (5, 10);
                    
                    
                    
                    