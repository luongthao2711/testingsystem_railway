DROP DATABASE changhi;
CREATE DATABASE changhi;
USE changhi;

CREATE TABLE department (
departmentID 	TINYINT AUTO_INCREMENT PRIMARY KEY,
departmentName	VARCHAR(255) NOT NULL
);

Drop table if exists `position`;
CREATE TABLE position (
positionID		SMALLINT AUTO_INCREMENT PRIMARY KEY,
positionName	ENUM('Dev', 'Test', 'Scrum Master', 'PM') NOT NULL
);

CREATE TABLE `account` (
accountID 		TINYINT AUTO_INCREMENT PRIMARY KEY,
email			VARCHAR(100),
usename			NVARCHAR(100),
fullname		NVARCHAR(225),
departmentID     TINYINT,
positionID		SMALLINT,
createdate 		DATE,
CONSTRAINT `dep_fk` FOREIGN KEY (departmentID) REFERENCES department(departmentID),
CONSTRAINT `pos_fk` FOREIGN KEY (positionID)	REFERENCES `position`(positionID)
);

CREATE TABLE `Group`(
groupID		TINYINT AUTO_INCREMENT PRIMARY KEY,
groupname	NVARCHAR(50),
creatorID	SMALLINT,
createdate	DATE
);		

CREATE TABLE groupaccount (
groupID	TINYINT AUTO_INCREMENT,
accountID TINYINT,
joindate	DATE,
PRIMARY KEY (groupID, accountID),
FOREIGN KEY (groupID) REFERENCES `group`(groupID),
FOREIGN KEY (accountID) REFERENCES `account`(accountID)
);


CREATE TABLE typequestion (
typeID 		TINYINT AUTO_INCREMENT PRIMARY KEY,
typeName	ENUM('Essay', 'Multiple-choice') NOT NULL
);

CREATE table categoryquestion (
categoryID		TINYINT AUTO_INCREMENT PRIMARY KEY,
categoryName	VARCHAR(255)
);

CREATE TABLE question (
questionID 	TINYINT AUTO_INCREMENT PRIMARY KEY,
content		NVARCHAR(255),
categoryID	TINYINT  NOT NULL,
typeID 		TINYINT NOT NULL,
creatorID	TINYINT NOT NULL,
createDate	DATE,
FOREIGN KEY(categoryID) REFERENCES categoryquestion(categoryID),
FOREIGN KEY(typeID) 	REFERENCES typequestion(typeID),
FOREIGN KEY(creatorID) REFERENCES `account`(accountID)
);

CREATE TABLE answer (
answerID	SMALLINT AUTO_INCREMENT PRIMARY KEY,
content		NVARCHAR(255) NOT NULL,
questionID	TINYINT NOT NULL,
iscorrect	NVARCHAR(50) NOT NULL,
FOREIGN KEY(questionID) REFERENCES question(questionID)
);

CREATE TABLE exam (
examID 		TINYINT AUTO_INCREMENT PRIMARY KEY,
`code`		VARCHAR(50),
title		NVARCHAR(255),
categoryID	TINYINT,
duration 	NVARCHAR(50),
creatorID	TINYINT NOT NULL,
createdate	DATE,
FOREIGN KEY(categoryID) REFERENCES categoryquestion(categoryID),
FOREIGN KEY(creatorID) REFERENCES `account`(accountID)
);     

CREATE TABLE examquestion (
examID TINYINT,
questionID TINYINT,
CONSTRAINT `exa_qs_pk` PRIMARY KEY ( examID,questionID),
FOREIGN KEY (examID) REFERENCES exam(examID),
FOREIGN KEY (questionID) REFERENCES question(questionID)
);


INSERT INTO department(departmentName)
VALUES 
('maketing'),
('sale'),
('manager'),
('secretary'),
('design'),
('staff'),
('guard'),
('peronnel'),
('technical'),
('program');

-- INSERT INTO `databaseint`.`position` (`positionID`, `positionName`) VALUES ('1', 'dev');
INSERT INTO`position`(positionName)
VALUES 
("Dev"),
('Test'),
('Scrum Master'),
('PM');

INSERT INTO `account` ( email, usename, fullname, departmentID, positionID, createdate)
VALUES
( 'mail1@gmail.com' , 'use1' , 'full1' , 1 , 2 , '2019-09-11' ),
( 'mail2@gmail.com' , 'use2' , 'full2' , 2 , 3 , '2020-11-09' ),
( 'mail3@gmail.com' , 'use3' , 'full3' , 3 , 7, '2020-10-11' ),
( 'mail4@gmail.com' , 'use4' , 'full4' , 4 ,4 , '2020-09-02' ),
( 'mail5@gmail.com' , 'use5' , 'full5' , 5 ,1 , '2020-06-07' ),
( 'mail6@gmail.com' , 'use6' , 'full6' , 6 , 5 , '2019-09-10' ),
( 'mail7@gmail.com' , 'use7' , 'full7' , 7 , 6 , '2010-07-03'),
( 'mail8@gmail.com' , 'use8' , 'full8' , 8 , 8 , '2018-09-07'),
( 'mail9@gmail.com' , 'use9' , 'full9' , 9 , 10, '2022-09-27'),
( 'mail10@gmail.com', 'use10', ' full10', 10,9, '2022-11-27');

INSERT INTO `group`(groupname, creatorID, createdate)
VALUES 
( 'ten1' , 1 ,'2012-03-09'),
( 'ten2' , 2 , '2012-07-09'),
( 'ten3' , 3 , '2020-09-06'),
( 'ten4' , 4 , '2020-09-17'),
( 'ten5' , 5, '2012-11-27'),
( 'ten6' , 6 , '2018-11-09'),
( 'ten7' , 7 , '2022-12-09'),
( 'ten8' , 8 , '2020-12-08'),
( 'ten9' , 9 , '2022-11-06'),
( 'ten10', 10, '2022-11-08');


INSERT INTO groupaccount(groupID, accountID, joindate)
VALUES 
(1, 1 , '2019-09-11'),
(2, 3,'2020-11-09'),
(3, 5, '2020-10-11'),
(4,2, '2020-09-02'),
(5, 4, '2020-06-07'),
(6, 5, '2019-09-10'),
(7, 7, '2010-07-03'),
(8, 8, '2018-09-07'),
(9,10, '2022-07-11'),
(10,9, '2022-09-09');
INSERT INTO typequestion(typeName)
VALUES
( 'Essay'),
( 'Multiple-choice');

INSERT INTO categoryquestion(categoryName)
VALUES
('Net'),
('SQL'),
('Postman'),
('Ruby'),
('Java'),
('Python'),
('Pascal'),
('Javascript'),
('Php'),
('C++');


INSERT INTO question(content, categoryID, typeID, creatorID, createDate)
VALUES 
( 'conten1', 2,  1, 3	, '2020-11-09'),
('conten2', 1,  2,  4,'2020-09-08'),
('conten3',	3,	2,	8,	'2020-09-11'),
('conten4',	7,	2,	1,	'2020-07-11'),
('conten5',	8,	2,	2,	'2010-05-19'),
('conten6',	9,	1,	6,	'2020-03-11'),
('conten7', 6,	2,	5,	'2018-05-09'),
('conten8',	4,	2,	7,	'2020-06-11'),
('conten9', 5,  2 , 10, '2022-07-05'),
('conten10', 10, 1, 9 , '2022-07-03');

INSERT INTO answer( content, questionID, iscorrect)
VALUES
('traloi1' , 1 , 'true'),
('traloi2' ,8, 'false'),
('traloi3' , 4 , 'true'),
('traloi4' ,2 , 'true'),
('traloi5' , 5 , 'false'),
('traloi6' , 6 , 'true'),
('traloi7' , 3 , 'false'),
('traloi8' , 7 , 'true'),
('traloi9' , 10, 'false'),
('traloi10', 9 , 'true');

INSERT INTO Exam(`code`, title, categoryID, duration, creatorID, createdate)
VALUES
( 'f123' , 'cauhoi1' , 1 , '90 phút' , 1 , '2020-11-07' ),
( 'f234' , 'cauhoi2' , 3 , '45 phút' , 3 , '2020-11-07' ),
( 'f345', 'cauhoi3',   2 ,  '45 phút', 6, '2020-11-07'),
( 'f456' , 'cauhoi4' , 4 , '90 phút' , 4 , '2020-11-07' ),
( 'f567' , 'cauhoi5' , 5 , '45 phút' , 5 , '2020-11-07' ),
( 'f678' , 'cauhoi6' , 6 , '45 phút' , 2 , '2020-11-07' ),
( 'f789' , 'cauhoi7' , 7 , '60 phút' , 7 , '2020-11-07' ),
( 'f899' , 'cauhoi8' , 8 , '45 phút' , 8 , '2020-11-07' ),
( 'f098' , 'cauhoi9' , 9 , '60 phút' , 9 , '2022-09-01'),
( 'f585' , 'cauhoi10' , 10, '45 phút' , 10, '2022-05- 02');

INSERT INTO examquestion(examID, questionID)
VALUES 
(1 , 2 ),
(2 , 3 ),
(3 , 4 ),
(4,  5 ),
(5 , 1 ),
(6 , 6 ),
(7,  7 ),
(8,  8 ),
(9,  10),
(10,  9);

