-- Q1
SELECT * FROM avengers.avengers;

-- Q2
CREATE TABLE backupheroes (
     id MEDIUMINT NOT NULL AUTO_INCREMENT,
     name CHAR(30) NOT NULL,
     PRIMARY KEY (id)
);

INSERT INTO backupheroes (name) VALUES
    ('civ1'),('civ2'),('civ3'),
    ('The Lorax'),('civ4'),('civ5'),
    ('civ6'),('civ7'),('civ8'),
    ('civ9'),('civ10'),('civ11'),
    ('civ12'),('civ13'),('civ14'),
    ('civ15'),('civ16'),('civ17'),
    ('civ18'),('civ19'),('civ20'),
    ('civ21'),('civ22'),('civ23'),
    ('civ24'),('civ25'),('civ26'),
    ('civ27'),('civ28'),('civ29'),('civ30');

SELECT * FROM backupheroes;

-- Q3
ALTER TABLE backupheroes
ADD COLUMN interested VARCHAR(15) AFTER name;
-- NOTE: values were originally NULL, but figuring out how to get the yes/no value lead to them no longer being NULL.
UPDATE backupheroes 
SET interested = CASE WHEN interested < 0.5 THEN 'yes' ELSE 'no' end WHERE (interested IS NOT NULL and id <> 0);

SELECT * FROM backupheroes;

-- Q4
ALTER TABLE backupheroes
ADD COLUMN favorite VARCHAR(100) AFTER interested;

-- For reseting favorite to numbers during experimentation
UPDATE backupheroes
SET favorite = FLOOR(RAND() * 3 + 1) WHERE (favorite IS NOT NULL and id <> 0);

-- For reseting favorite to numbers during experimentation
UPDATE backupheroes
SET favorite = FLOOR(RAND() * 3 + 1) WHERE (favorite IS NULL and id <> 0);

UPDATE backupheroes
SET favorite = CASE WHEN favorite = 1 THEN 'Anthony Edward "Tony" Stark'
					WHEN favorite = 2 THEN 'Robert Bruce Banner'
                    WHEN favorite = 3 THEN 'Victor Shade (alias)' END

WHERE (favorite IS NOT NULL and id <> 0);
SELECT * FROM backupheroes;

-- Q5
SELECT backupheroes.name, backupheroes.interested, backupheroes.favorite, avengers.name FROM backupheroes
INNER JOIN avengers
ON backupheroes.favorite=avengers.name
WHERE interested = "yes";


-- Q6
CREATE TABLE possibleheroes AS
SELECT backupheroes.name, backupheroes.interested, backupheroes.favorite, avengers.name AS avengername FROM backupheroes
INNER JOIN avengers
ON backupheroes.favorite=avengers.name
WHERE interested = "yes";
    
SELECT * FROM possibleheroes;



-- Q7

SELECT name, appearances FROM avengers
WHERE appearances >= 1000
ORDER BY name ASC;

-- Q8

SELECT name, appearances FROM avengers
WHERE appearances < 1000;

-- Q9
SELECT name, appearances FROM avengers
WHERE appearances < 500;

-- Q10
SELECT name, appearances FROM avengers
WHERE appearances < 50;

-- Q11
SELECT name, appearances, gender FROM avengers
WHERE appearances < 50 AND gender = 'female';

-- Q12
SELECT name, appearances, gender, honorary FROM avengers
WHERE appearances > 150 AND gender LIKE 'male' AND honorary LIKE 'full'; 

-- Q13
-- Doesn't work
DELIMITER //
CREATE FUNCTION newhero(item VARCHAR(100)) RETURNS VARCHAR(100) DETERMINISTIC
BEGIN
	DECLARE herostatus VARCHAR(100);
    SELECT if(possibleheroes.favorite = "Victor Shade (alias)", possibleheroes.name) FROM possibleheroes INTO herostatus;
    RETURN herostatus;
END
//
delimiter ;
SELECT * FROM backupheroes
SELECT name FROM possibleheroes

-- Q14
DELIMITER //
CREATE FUNCTION totalrecords () RETURNS INT DETERMINISTIC
BEGIN
	DECLARE total INT;
	SELECT DISTINCT count(*) FROM avengers INTO total;
	RETURN total;
END
//
delimiter ;

SELECT DISTINCT totalRecords() AS total FROM avengers;