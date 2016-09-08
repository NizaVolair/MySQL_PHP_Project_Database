-- --------------------------------------------------------------------------------------------------
-- Filename: projectsDB.sql
-- Authors: Niza Volair
-- Date: 09/04/2016
-- Description: Project database table creation and insertion statements
-- 				used to catalogue coursework and future CS projects
-- --------------------------------------------------------------------------------------------------

-- Disable foreign key constraint checks
SET FOREIGN_KEY_CHECKS = 0;

-- Drop existing tables to reset database
DROP TABLE IF EXISTS Projects;
DROP TABLE IF EXISTS Skills;
DROP TABLE IF EXISTS People;
DROP TABLE IF EXISTS Courses;
DROP TABLE IF EXISTS Levels;
DROP TABLE IF EXISTS Semesters;
DROP TABLE IF EXISTS Project_Skills;
DROP TABLE IF EXISTS Project_Collaborators;
DROP TABLE IF EXISTS Project_Clients;


-- Table creation queries
CREATE TABLE Projects (
	id int(11) AUTO_INCREMENT,
	name varchar(255) NOT NULL UNIQUE,
	description varchar(255),
	link varchar(255),
	image varchar(255),
	cid int(11),
	yr_started year(4),
	yr_completed year(4),
	PRIMARY KEY (id),
	FOREIGN KEY (cid) REFERENCES Courses(id)
) ENGINE=InnoDB;

CREATE TABLE Skills (
	id int(11) AUTO_INCREMENT,
	name varchar(255) NOT NULL UNIQUE,
	lang bool,
	yrs_used int(11),
	lid int(11),
	PRIMARY KEY (id),
	FOREIGN KEY (lid) REFERENCES Levels(id)
) ENGINE=InnoDB;

CREATE TABLE People (
	id int(11) AUTO_INCREMENT,
	first_name varchar(30) NOT NULL,
	last_name varchar(30) NOT NULL,
	UNIQUE KEY (first_name, last_name),
	PRIMARY KEY (id)
) ENGINE=InnoDB;

CREATE TABLE Courses (
	id int(11) AUTO_INCREMENT,
	name varchar(255) NOT NULL,
	num int(11) NOT NULL,
	grade varchar(30),
	sid int(11) NOT NULL,
	UNIQUE KEY (num, sid),
	PRIMARY KEY (id),
	FOREIGN KEY (sid) REFERENCES Semesters(id)
) ENGINE=InnoDB;

CREATE TABLE Levels (
	id int(11),
	name varchar(30) NOT NULL UNIQUE,
	PRIMARY KEY (id)
) ENGINE=InnoDB;

CREATE TABLE Semesters (
	id int(11),
	season varchar(30) NOT NULL,
	yr int(11) NOT NULL,
	PRIMARY KEY (id)
) ENGINE=InnoDB;

CREATE TABLE Project_Skills (
	pid int(11),
	sid int(11),
	PRIMARY KEY (pid, sid),
	FOREIGN KEY (pid) REFERENCES Projects(id),
	FOREIGN KEY (sid) REFERENCES Skills(id)
) ENGINE=InnoDB;

CREATE TABLE Project_Collaborators (
	prj_id int(11),
	ppl_id int(11),
	PRIMARY KEY (prj_id, ppl_id),
	FOREIGN KEY (prj_id) REFERENCES Projects(id),
	FOREIGN KEY (ppl_id) REFERENCES People(id)
) ENGINE=InnoDB;

CREATE TABLE Project_Clients (
	prj_id int(11),
	ppl_id int(11),
	PRIMARY KEY (prj_id, ppl_id),
	FOREIGN KEY (prj_id) REFERENCES Projects(id),
	FOREIGN KEY (ppl_id) REFERENCES People(id)
) ENGINE=InnoDB;

-- Insertion queries
-- Levels - look-up table
INSERT INTO Levels (id, name) 
	VALUES (1, "Basic");
INSERT INTO Levels (id, name) 
	VALUES (2, "Intermediate");
INSERT INTO Levels (id, name) 
	VALUES (3, "Advanced");
	
-- Semesters - look-up table
INSERT INTO Semesters (id, season, yr) 
	VALUES (1, "Winter", 2015);
INSERT INTO Semesters (id, season, yr) 
	VALUES (2, "Spring", 2015);
INSERT INTO Semesters (id, season, yr) 
	VALUES (3, "Summer", 2015);
INSERT INTO Semesters (id, season, yr) 
	VALUES (4, "Fall", 2015);
INSERT INTO Semesters (id, season, yr) 
	VALUES (5, "Winter", 2016);
INSERT INTO Semesters (id, season, yr) 
	VALUES (6, "Spring", 2016);
INSERT INTO Semesters (id, season, yr) 
	VALUES (7, "Summer", 2016);
INSERT INTO Semesters (id, season, yr) 
	VALUES (8, "Fall", 2016);
INSERT INTO Semesters (id, season, yr) 
	VALUES (9, "Winter", 2017);
INSERT INTO Semesters (id, season, yr) 
	VALUES (10, "Spring", 2017);
	
-- Courses
INSERT INTO Courses (id, name, num, grade, sid)
	VALUES (id, "INTRO TO COMPUTER SCIENCE I", 161, "B+", 1);
INSERT INTO Courses (id, name, num, grade, sid)
	VALUES (id, "DISCRETE STRUCTURES IN COMPUTER SCIENCE", 225, "A", 1);
INSERT INTO Courses (id, name, num, grade, sid)
	VALUES (id, "INTRO TO COMPUTER SCIENCE II", 162, "A", 2);
INSERT INTO Courses (id, name, num, grade, sid)
	VALUES (id, "INTRO TO USABILITY ENGINEERING", 352, "A", 2);
INSERT INTO Courses (id, name, num, grade, sid)
	VALUES (id, "DATA STRUCTURES", 261, "A",  3);
INSERT INTO Courses (id, name, num, grade, sid)
	VALUES (id, "COMPUTER ARCH & ASSEM LANGUAGE", 271, "B+", 4);
INSERT INTO Courses (id, name, num, grade, sid)
	VALUES (id, "WEB DEVELOPMENT", 290, "A", 4);
INSERT INTO Courses (id, name, num, grade, sid)
	VALUES (id, "INTRO TO DATABASES", 240, "A", 5);
INSERT INTO Courses (id, name, num, grade, sid)
	VALUES (id, "OPERATING SYSTEMS I", 344, "A", 5);
INSERT INTO Courses (id, name, num, grade, sid)
	VALUES (id, "INTRO TO COMPUTER NETWORKS", 372, "A", 6);
INSERT INTO Courses (id, name, num, grade, sid)
	VALUES (id, "SOFTWARE ENGINEERING I", 361, "A", 6);
INSERT INTO Courses (id, name, num, grade, sid)
	VALUES (id, "ANALYSIS OF ALGORITHMS", 325, "B+", 7);
INSERT INTO Courses (id, name, num, grade, sid)
	VALUES (id, "SOFTWARE ENGINEERING II", 362, "Not Yet Completed", 8);
INSERT INTO Courses (id, name, num, grade, sid)
	VALUES (id, "MOBILE/CLOUD SOFTWARE DEVEL", 496, "Not Yet Completed", 8);
INSERT INTO Courses (id, name, num, grade, sid)
	VALUES (id, "DATABASE MANAGEMENT SYSTEMS", 419, "Not Yet Completed", 9);	

-- Projects
INSERT INTO Projects (id, name, link, description, image, cid, yr_started, yr_completed) 
	VALUES (id, "Text Based Adventure Game", "https://github.com/NizaVolair/C-Plus-Plus_Adventure_Game",
	"Object-oriented program allowing users to traverse through and interact with 11 linked structures.",
	"http://web.engr.oregonstate.edu/~volairn/projects/images/TextAdventure.jpg",
	(SELECT id FROM Courses WHERE num = 162 AND sid = 2), 2015, 2015);
INSERT INTO Projects (id, name, link, description, image, cid, yr_started, yr_completed) 
	VALUES (id, "Fantasy Battle Program", "https://github.com/NizaVolair/C-Plus-Plus_Fantasy_Tournament",
	"Program using classes and inheritance to create a combat simulator with 5 distinct character classes.",
	"http://web.engr.oregonstate.edu/~volairn/projects/images/TextBattle.jpg",
	(SELECT id FROM Courses WHERE num = 162 AND sid = 2), 2015, 2015);
INSERT INTO Projects (id, name, link, description, image, cid, yr_started, yr_completed) 
	VALUES (id, "Enhanced Website Design", "https://github.com/NizaVolair/Web_Site_Design_PDF",
	"Modernized website design interactive PDF based on usability principles and user feedback.",
	"http://web.engr.oregonstate.edu/~volairn/projects/images/WebsiteDesign.jpg",
	(SELECT id FROM Courses WHERE num = 352 AND sid = 2), 2015, 2015);
INSERT INTO Projects (id, name, link, description, image, cid, yr_started, yr_completed) 
	VALUES (id, "Low Level I/O Conversion Program","https://github.com/NizaVolair/Assembly_Low_Level_IO_Procedures",
	"Manually convert strings to integers, sort, and find medians using macros and procedures.",
	"http://web.engr.oregonstate.edu/~volairn/projects/images/LowIO.jpg",
	(SELECT id FROM Courses WHERE num = 271 AND sid = 4), 2015, 2015);
INSERT INTO Projects (id, name, link, description, image, cid, yr_started, yr_completed) 
	VALUES (id, "Workout Tracker Web Application", "https://github.com/NizaVolair/Web-Dev_Workout_Tracker",
	"Online workout tracker to save activities to a database and display results.",
	"http://web.engr.oregonstate.edu/~volairn/projects/images/Workout.jpg",
	(SELECT id FROM Courses WHERE num = 290 AND sid = 4), 2015, 2015);
INSERT INTO Projects (id, name, link, description, image, cid, yr_started, yr_completed) 
	VALUES (id, "Grade Calculator", "https://github.com/NizaVolair/BASH_Grade_Calculator",
	"Shell script to take in file or console integer input, validate, and calculate averages in rows in columns.",
	"http://web.engr.oregonstate.edu/~volairn/projects/images/GradeCalc.jpg",
	(SELECT id FROM Courses WHERE num = 344 AND sid = 5), 2016, 2016);
INSERT INTO Projects (id, name, link, description, image, cid, yr_started, yr_completed) 
	VALUES (id, "Client Server Chat Program", "https://github.com/NizaVolair/C_Python_Client_Server_Chat",
	"Chat program between host and client using socket API.",
	"http://web.engr.oregonstate.edu/~volairn/projects/images/Chat.jpg",
	(SELECT id FROM Courses WHERE num = 344 AND sid = 5), 2016, 2016);
INSERT INTO Projects (id, name, link, description, image, cid, yr_started, yr_completed) 
	VALUES (id, "Art Archive Database", "https://github.com/NizaVolair/MySQL-PHP_Art_Database",
	"Database to display, sort, and organize paintings by series, exhibition, and medium.",
	"http://web.engr.oregonstate.edu/~volairn/projects/images/ArtDB.jpg",
	(SELECT id FROM Courses WHERE num = 344 AND sid = 5), 2016, 2016);
INSERT INTO Projects (id, name, link, description, image, cid, yr_started, yr_completed) 
	VALUES (id, "Helping Hands Volunteer Coordination App", "https://github.com/NizaVolair/Web-Dev_Helping_Hands_App",
	"Website with basic functionality designed with agile software team personally focusing on database integration.",
	"http://web.engr.oregonstate.edu/~volairn/projects/images/HelpHands.jpg",
	(SELECT id FROM Courses WHERE num = 361 AND sid = 6), 2016, 2016);
INSERT INTO Projects (id, name, link, description, image, cid, yr_started, yr_completed) 
	VALUES (id, "Project Database", "https://github.com/NizaVolair/MySQL_PHP_Project_Database",
	"Personal project to help track programs and skills in Computer Science.",
	"http://web.engr.oregonstate.edu/~volairn/projects/images/ProjDB.jpg", NULL, 2016, 2016);
INSERT INTO Projects (id, name, link, description, image, cid, yr_started, yr_completed) 
	VALUES (id, "To Do List", "https://github.com/NizaVolair/C_To-Do_List",
	"Editable To Do list to keep track of daily tasks.",
	"http://web.engr.oregonstate.edu/~volairn/projects/images/ToDo.jpg", NULL, 2015, 2015);

-- Tools
INSERT INTO Skills (id, name, lang, yrs_used, lid) 
	VALUES (id, "Agile Development", 0, 1, 1);
INSERT INTO Skills (id, name, lang, yrs_used, lid) 
	VALUES (id, "APIs", 0, 1, 1);
INSERT INTO Skills (id, name, lang, yrs_used, lid) 
	VALUES (id, "Assembly", 1, 1, 1);
INSERT INTO Skills (id, name, lang, yrs_used, lid) 
	VALUES (id, "AWS", 0, 1, 1);
INSERT INTO Skills (id, name, lang, yrs_used, lid) 
	VALUES (id, "Bash", 1, 1, 1);
INSERT INTO Skills (id, name, lang, yrs_used, lid) 
	VALUES (id, "C", 1, 2, 2);
INSERT INTO Skills (id, name, lang, yrs_used, lid) 
	VALUES (id, "C++", 1, 2, 2);
INSERT INTO Skills (id, name, lang, yrs_used, lid) 
	VALUES (id, "CSS", 1, 1,1);
INSERT INTO Skills (id, name, lang, yrs_used, lid) 
	VALUES (id, "Handlebars", 0, 1, 1);
INSERT INTO Skills (id, name, lang, yrs_used, lid) 
	VALUES (id, "HTML", 1, 1,1);
INSERT INTO Skills (id, name, lang, yrs_used, lid) 
	VALUES (id, "Interactive PDF", 0, 1, 2);
INSERT INTO Skills (id, name, lang, yrs_used, lid) 
	VALUES (id, "JavaScript", 1, 1, 1);
INSERT INTO Skills (id, name, lang, yrs_used, lid) 
	VALUES (id, "Java", 1, 1, 2);
INSERT INTO Skills (id, name, lang, yrs_used, lid) 
	VALUES (id, "JSON", 0, 1, 1);
INSERT INTO Skills (id, name, lang, yrs_used, lid) 
	VALUES (id, "Linux", 0, 2, 2);
INSERT INTO Skills (id, name, lang, yrs_used, lid) 
	VALUES (id, "MySQL", 1, 1, 2);
INSERT INTO Skills (id, name, lang, yrs_used, lid) 
	VALUES (id, "Node.js", 0, 1, 1);
INSERT INTO Skills (id, name, lang, yrs_used, lid) 
	VALUES (id, "PuTTY", 0, 1, 2);
INSERT INTO Skills (id, name, lang, yrs_used, lid) 
	VALUES (id, "Object Oriented Design", 0, 2, 2);
INSERT INTO Skills (id, name, lang, yrs_used, lid) 
	VALUES (id, "Python", 1, 1, 2);
INSERT INTO Skills (id, name, lang, yrs_used, lid) 
	VALUES (id, "Shell Scripting", 0, 1, 1);
INSERT INTO Skills (id, name, lang, yrs_used, lid) 
	VALUES (id, "Ubuntu", 0, 1, 1);
	
-- People
INSERT INTO People (id, first_name, last_name) 
	VALUES (id, "Sara", "Hashem");
INSERT INTO People (id, first_name, last_name) 
	VALUES (id, "Alex", "Marsh");
INSERT INTO People (id, first_name, last_name) 
	VALUES (id, "Sara", "Sakamoto");
INSERT INTO People (id, first_name, last_name) 
	VALUES (id, "William", "Kim");
INSERT INTO People (id, first_name, last_name) 
	VALUES (id, "John", "Teuber");
INSERT INTO People (id, first_name, last_name) 
	VALUES (id, "David", "Corna");
INSERT INTO People (id, first_name, last_name) 
	VALUES (id, "Zachary", "Lang");
INSERT INTO People (id, first_name, last_name) 
	VALUES (id, "John", "Watts");
INSERT INTO People (id, first_name, last_name) 
	VALUES (id, "Matthew", "Palmer");

-- Project_Tools - reference table
INSERT INTO Project_Skills(pid, sid) 
	VALUES ((SELECT id FROM Projects WHERE name = "Helping Hands Volunteer Coordination App"),
			(SELECT id FROM Tools WHERE name = "CSS"));
INSERT INTO Project_Skills(pid, sid) 
	VALUES ((SELECT id FROM Projects WHERE name = "Helping Hands Volunteer Coordination App"),
			(SELECT id FROM Tools WHERE name = "Handlebars"));
INSERT INTO Project_Skills(pid, sid) 
	VALUES ((SELECT id FROM Projects WHERE name = "Helping Hands Volunteer Coordination App"),
			(SELECT id FROM Tools WHERE name = "JavaScript"));
INSERT INTO Project_Skills(pid, sid) 
	VALUES ((SELECT id FROM Projects WHERE name = "Helping Hands Volunteer Coordination App"),
			(SELECT id FROM Tools WHERE name = "MySQL"));
INSERT INTO Project_Skills(pid, sid) 
	VALUES ((SELECT id FROM Projects WHERE name = "Client Server Chat Program"),
			(SELECT id FROM Tools WHERE name = "Java"));			
INSERT INTO Project_Skills(pid, sid) 
	VALUES ((SELECT id FROM Projects WHERE name = "Client Server Chat Program"),
			(SELECT id FROM Tools WHERE name = "Python"));
INSERT INTO Project_Skills(pid, sid) 
	VALUES ((SELECT id FROM Projects WHERE name = "Workout Tracker Web Application"),
			(SELECT id FROM Tools WHERE name = "CSS"));
INSERT INTO Project_Skills(pid, sid) 
	VALUES ((SELECT id FROM Projects WHERE name = "Workout Tracker Web Application"),
			(SELECT id FROM Tools WHERE name = "HTML"));
INSERT INTO Project_Skills(pid, sid) 
	VALUES ((SELECT id FROM Projects WHERE name = "Workout Tracker Web Application"),
			(SELECT id FROM Tools WHERE name = "JavaScript"));
INSERT INTO Project_Skills(pid, sid) 
	VALUES ((SELECT id FROM Projects WHERE name = "Workout Tracker Web Application"),
			(SELECT id FROM Tools WHERE name = "MySQL"));
INSERT INTO Project_Skills(pid, sid) 
	VALUES ((SELECT id FROM Projects WHERE name = "Workout Tracker Web Application"),
			(SELECT id FROM Tools WHERE name = "Node.js"));
INSERT INTO Project_Skills(pid, sid) 
	VALUES ((SELECT id FROM Projects WHERE name = "Text Based Adventure Game"),
			(SELECT id FROM Tools WHERE name = "C++"));
INSERT INTO Project_Skills(pid, sid) 
	VALUES ((SELECT id FROM Projects WHERE name = "Text Based Adventure Game"),
			(SELECT id FROM Tools WHERE name = "Linux"));	
INSERT INTO Project_Skills(pid, sid) 
	VALUES ((SELECT id FROM Projects WHERE name = "Text Based Adventure Game"),
			(SELECT id FROM Tools WHERE name = "Object Oriented Design"));	
INSERT INTO Project_Skills(pid, sid) 
	VALUES ((SELECT id FROM Projects WHERE name = "Low Level I/O Conversion Program"),
			(SELECT id FROM Tools WHERE name = "Assembly"));			
INSERT INTO Project_Skills(pid, sid) 
	VALUES ((SELECT id FROM Projects WHERE name = "Grade Calculator"),
			(SELECT id FROM Tools WHERE name = "Bash"));	
INSERT INTO Project_Skills(pid, sid) 
	VALUES ((SELECT id FROM Projects WHERE name = "Grade Calculator"),
			(SELECT id FROM Tools WHERE name = "Linux"));
INSERT INTO Project_Skills(pid, sid) 
	VALUES ((SELECT id FROM Projects WHERE name = "Grade Calculator"),
			(SELECT id FROM Tools WHERE name = "Shell Scripting"));	
INSERT INTO Project_Skills(pid, sid) 
	VALUES ((SELECT id FROM Projects WHERE name = "Enhanced Website Design"),
			(SELECT id FROM Tools WHERE name = "Interactive PDF"));		
INSERT INTO Project_Skills(pid, sid) 
	VALUES ((SELECT id FROM Projects WHERE name = "Project Database"),
			(SELECT id FROM Tools WHERE name = "MySQL"));
INSERT INTO Project_Skills(pid, sid) 
	VALUES ((SELECT id FROM Projects WHERE name = "Project Database"),
			(SELECT id FROM Tools WHERE name = "CSS"));
INSERT INTO Project_Skills(pid, sid) 
	VALUES ((SELECT id FROM Projects WHERE name = "Project Database"),
			(SELECT id FROM Tools WHERE name = "HTML"));
			INSERT INTO Project_Skills(pid, sid) 
	VALUES ((SELECT id FROM Projects WHERE name = "Art Archive Database"),
			(SELECT id FROM Tools WHERE name = "MySQL"));
INSERT INTO Project_Skills(pid, sid) 
	VALUES ((SELECT id FROM Projects WHERE name = "Art Archive Database"),
			(SELECT id FROM Tools WHERE name = "HTML"));
INSERT INTO Project_Skills(pid, sid) 
	VALUES ((SELECT id FROM Projects WHERE name = "Art Archive Database"),
			(SELECT id FROM Tools WHERE name = "CSS"));
INSERT INTO Project_Skills(pid, sid) 
	VALUES ((SELECT id FROM Projects WHERE name = "To Do List"),
			(SELECT id FROM Tools WHERE name = "C"));

						

			
-- Project_Collaborators - reference table
INSERT INTO Project_Collaborators (prj_id, ppl_id) 
	VALUES ((SELECT id FROM Projects WHERE name = "Enhanced Website Design"),
			(SELECT id FROM People WHERE first_name = "Sara" AND last_name = "Hashem"));
INSERT INTO Project_Collaborators (prj_id, ppl_id) 
	VALUES ((SELECT id FROM Projects WHERE name = "Enhanced Website Design"),
			(SELECT id FROM People WHERE first_name = "Alex" AND last_name = "Marsh"));
INSERT INTO Project_Collaborators (prj_id, ppl_id) 
	VALUES ((SELECT id FROM Projects WHERE name = "Enhanced Website Design"),
			(SELECT id FROM People WHERE first_name = "Sara" AND last_name = "Sakamoto"));
INSERT INTO Project_Collaborators (prj_id, ppl_id) 
	VALUES ((SELECT id FROM Projects WHERE name = "Helping Hands Volunteer Coordination App"),
			(SELECT id FROM People WHERE first_name = "William" AND last_name = "Kim"));
INSERT INTO Project_Collaborators (prj_id, ppl_id) 
	VALUES ((SELECT id FROM Projects WHERE name = "Helping Hands Volunteer Coordination App"),
			(SELECT id FROM People WHERE first_name = "John" AND last_name = "Teuber"));
INSERT INTO Project_Collaborators (prj_id, ppl_id) 
	VALUES ((SELECT id FROM Projects WHERE name = "Helping Hands Volunteer Coordination App"),
			(SELECT id FROM People WHERE first_name = "David" AND last_name = "Corna"));
INSERT INTO Project_Collaborators (prj_id, ppl_id) 
	VALUES ((SELECT id FROM Projects WHERE name = "Helping Hands Volunteer Coordination App"),
			(SELECT id FROM People WHERE first_name = "Zachary" AND last_name = "Lang"));
INSERT INTO Project_Collaborators (prj_id, ppl_id) 
	VALUES ((SELECT id FROM Projects WHERE name = "Art Archive Database"),
			(SELECT id FROM People WHERE first_name = "Sara" AND last_name = "Hashem"));

-- Project_Clients - reference table
INSERT INTO Project_Clients (prj_id, ppl_id) 
	VALUES ((SELECT id FROM Projects WHERE name = "Helping Hands Volunteer Coordination App"),
			(SELECT id FROM People WHERE first_name = "John" AND last_name = "Watts"));