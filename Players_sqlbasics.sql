CREATE TABLE Players (
    PlayerID int NOT NULL,   
    LastName varchar(50),
    FirstName varchar(50),
    Contact varchar(50),
    City varchar(50)
	
);

--DROP TABLE Players
select * from Players

ALTER TABLE Players
ADD CONSTRAINT PK_Players PRIMARY KEY (PlayerID);

INSERT INTO Players
VALUES (1, 'Ghosh', 'Richa', 9658476321, 'West Bengal'),
       (2, 'Sharma', 'Deepti', 6325418587,'Uttar Pradesh'),
	   (3, 'Kaur', 'Harmanpreet', 9658123475,'Punjab'),
	   (4, 'Rodrigues', 'Jemimah', 9658472351,'Maharashtra'),
	   (5, 'Bhatia', 'Yastika', 9872653145,'Gujarat'),
	   (6, 'Kaur', 'Amanjot', 9683251476,'Punjab'),
	   (7, 'Sobhana', 'Asha', 6547915438,'Kerala'),
	   (8, 'Bareddy', 'Anusha', 6359841285,'Andhra Pradesh'),
	   (9, 'Goswami', 'Jhulan', 6589421545,'West Bengal'),
	   (10, 'Raj', 'Mithali', 9864753251,'Rajasthan'),
	   (11, 'David', 'Neetu Lawrence', 9874563251,'Uttar Pradesh'),
	   (12, 'Vastrakar', 'Pooja', 9965625815,'Madhya Pradesh'),
	   (13, 'Raut', 'Punam Ganesh', 9862235547,'Maharashtra'),
	   (14, 'Verma', 'Shafali', 6895587441,'Haryana'),
	   (15, 'Pandey', 'Shikha', 9666584421,'Andhra Pradesh'),
	   (16, 'Patil', 'Shreyanka', 6895584224,'Karnataka');
	   

CREATE TABLE Matches (
    MatchID int NOT NULL PRIMARY KEY,
    Score int NOT NULL,
    PlayerID int,
    CONSTRAINT FK_PlayerMatch FOREIGN KEY (PlayerID)
    REFERENCES Players(PlayerID)
);


--DROP TABLE Matches

select * from Matches

ALTER TABLE Players
ADD Age int NULL;

select * from Players

UPDATE Players 
SET Age = 21
WHERE PlayerID = 1;

UPDATE Players 
SET Age = 27
WHERE PlayerID = 2;

UPDATE Players 
SET Age = 36
WHERE PlayerID = 3;

UPDATE Players 
SET Age = 24
WHERE PlayerID = 4;

UPDATE Players 
SET Age = 25
WHERE PlayerID = 5;

UPDATE Players 
SET Age = 28
WHERE PlayerID = 6;

UPDATE Players 
SET Age = 24
WHERE PlayerID = 7;

UPDATE Players 
SET Age = 24
WHERE PlayerID = 8;

UPDATE Players 
SET Age = 33
WHERE PlayerID = 9;

UPDATE Players 
SET Age = 21
WHERE PlayerID = 10;

UPDATE Players 
SET Age = 42
WHERE PlayerID = 11;

UPDATE Players 
SET Age = 42
WHERE PlayerID = 12;

UPDATE Players 
SET Age = 47
WHERE PlayerID = 13;

UPDATE Players 
SET Age = 25
WHERE PlayerID = 14;

UPDATE Players 
SET Age = 35
WHERE PlayerID = 15;

UPDATE Players 
SET Age = 21
WHERE PlayerID = 16;


select * from Players

EXEC sp_rename 'Players.City', 'State', 'COLUMN';

ALTER TABLE Matches
DROP CONSTRAINT FK_PlayerMatch;

ALTER TABLE Matches
ADD CONSTRAINT FK_PlayerMatch FOREIGN KEY (PlayerID)
REFERENCES Players(PlayerID);

SELECT * FROM Players
ORDER BY Age;

SELECT * FROM Players
WHERE LastName = 'Kaur' AND Age LIKE '28';

SELECT * FROM Players
WHERE LastName = 'Kaur' AND Age LIKE '36';

SELECT * FROM Players
WHERE State = 'West Bengal' OR State = 'Punjab';

SELECT * FROM Players
WHERE NOT State = 'Uttar Pradesh';

ALTER TABLE Players
ADD Address varchar(255);

select * from Players
WHERE Address IS NULL;

select * from Players
WHERE Address IS NOT NULL;

select TOP 3 * from Players;

select MIN(Age) from Players;

select MAX(Age) from Players;

select COUNT(Age) from Players;

select SUM(Age) from Players;

select AVG(Age) from Players;

select * from Players
WHERE Age LIKE '3%';

SELECT * FROM Players
WHERE State IN ('Punjab', 'Andhra Pradesh', 'West Bengal');

SELECT * FROM Players
WHERE PlayerID BETWEEN 2 AND 10;

SELECT PlayerID AS ID
FROM Players;

SELECT Matches.MatchID, Players.FirstName, Matches.Score
FROM Matches
INNER JOIN Players ON Matches.PlayerID=Players.PlayerID;

SELECT Players.FirstName, Matches.MatchID
FROM Players
LEFT JOIN Matches ON Players.PlayerID = Matches.MatchID
ORDER BY Players.FirstName;

SELECT Matches.MatchID, Players.LastName, Players.FirstName
FROM Matches
RIGHT JOIN Players ON Matches.PlayerID = Players.PlayerID
ORDER BY Matches.MatchID;

SELECT Players.FirstName, Matches.MatchID
FROM Players
FULL OUTER JOIN Matches ON Players.PlayerID=Matches.PlayerID
ORDER BY Players.FirstName;

SELECT COUNT(PlayerID), State
FROM Players
GROUP BY State;

SELECT COUNT(PlayerID), State
FROM Players
GROUP BY State
HAVING COUNT(PlayerID) > 5;

SELECT Contact
FROM Players
WHERE EXISTS (SELECT LastName FROM Players WHERE Players.PlayerID = Players.PlayerID AND Age < 20);


SELECT Contact FROM Players
WHERE Contact = ANY (SELECT Contact FROM Players WHERE Age = 36);

SELECT Contact FROM Players
WHERE Contact = ALL (SELECT Contact FROM Players WHERE Age > 46);

SELECT * INTO CricketPlayers FROM Players;

SELECT * FROM CricketPlayers;

SELECT * FROM Players;

SELECT FirstName, LastName INTO CricketWomanPlayers FROM Players;

SELECT * FROM CricketWomanPlayers;

SELECT * INTO PlayersAge FROM Players
WHERE Age = '21';

SELECT * FROM PlayersAge;

INSERT INTO Players(Age)
SELECT Age FROM PlayersAge;

SELECT PlayerID, Age,
CASE
    WHEN Age > 30 THEN 'The age is greater than 30'
    WHEN Age = 30 THEN 'The age is 30'
    ELSE 'The age is under 30'
END AS AgeText
FROM Players;

CREATE PROCEDURE SelectAllPlayers
AS
SELECT * FROM Players
GO

EXEC SelectAllPlayers;


ALTER TABLE Players
ADD CONSTRAINT df_State
DEFAULT 'AP' FOR State;

CREATE INDEX idx_contact
ON Players (Contact);

CREATE INDEX idx_pname
ON Players (LastName, FirstName);

select * FROM Players;

ALTER TABLE Players
ADD DOB DATE;


ALTER TABLE Players
DROP COLUMN DOB;

UPDATE Players
SET DOB = '2003-09-28'
WHERE PlayerID = 1;

UPDATE Players
SET DOB = '1997-08-24'
WHERE PlayerID = 2;

UPDATE Players
SET DOB = '1989-03-08'
WHERE PlayerID = 3;

UPDATE Players
SET DOB = '2000-09-05'
WHERE PlayerID = 4;

UPDATE Players
SET DOB = '2000-11-01'
WHERE PlayerID = 5;

UPDATE Players
SET DOB = '1997-04-04'
WHERE PlayerID = 6;

UPDATE Players
SET DOB = '1991-03-16'
WHERE PlayerID = 7;

UPDATE Players
SET DOB = '2003-06-06'
WHERE PlayerID = 8;

UPDATE Players
SET DOB = '1982-11-25'
WHERE PlayerID = 9;

UPDATE Players
SET DOB = '1982-12-03'
WHERE PlayerID = 10;

UPDATE Players
SET DOB = '1977-09-01'
WHERE PlayerID = 11;

UPDATE Players
SET DOB = '1999-09-25'
WHERE PlayerID = 12;

UPDATE Players
SET DOB = '1989-09-14'
WHERE PlayerID = 13;

UPDATE Players
SET DOB = '2004-01-28'
WHERE PlayerID = 14;

UPDATE Players
SET DOB = '1989-05-12'
WHERE PlayerID = 15;

UPDATE Players
SET DOB = '2002-07-31'
WHERE PlayerID = 16;


SELECT * FROM Players WHERE DOB='1997-04-04'

