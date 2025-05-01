Drop Database if exists DisasterRelief;
Create Database DisasterRelief;
Use DisasterRelief;

-- Creation of the Incident Entity / Table --
DROP TABLE IF EXISTS INCIDENT;
CREATE TABLE INCIDENT (
  Incident_ID  	int not null auto_increment,
  Fire_Type   	varchar(50) not null,
  Incident_Date	date not null, 
  Danger_Level 	int not null,
  Zipcode		int not null,
  CONSTRAINT pk_incident primary key (Incident_id)
);

-- Creation of the Plan Entity / Table --
DROP TABLE IF EXISTS PLANS;
CREATE TABLE PLANS (
  Plan_ID  		int not null auto_increment,
  Plan_Type   	varchar(50) not null,
  Information	varchar(750) not null, 
  Incident_ID	int not null,
  CONSTRAINT pk_plan primary key (Plan_ID),
  CONSTRAINT fk_plan foreign key (Incident_ID) references INCIDENT(Incident_ID)
);

-- Creation of the Persons Entity / Table --
DROP TABLE IF EXISTS PERSONS;
CREATE TABLE PERSONS (
  Person_ID  	int not null auto_increment,
  CONSTRAINT pk_persons primary key (Person_ID)
);

-- Creation of the Victims Entity / Table --
DROP TABLE IF EXISTS VICTIMS;
CREATE TABLE VICTIMS (
  Person_ID  	int not null,
  Victim_Name  	varchar(150) not null,
  Victim_ID   int not null auto_increment,
  CONSTRAINT pk_victims primary key (Victim_ID),
  CONSTRAINT fk_victims foreign key (Person_ID) references PERSONS(Person_ID)
);

-- Creation of the Employee Entity / Table --
DROP TABLE IF EXISTS EMPLOYEE;
CREATE TABLE EMPLOYEE (
  Person_ID  	int not null auto_increment,
  Employee_name   varchar(150) not null,
  Employee_ID  	int not null,
  CONSTRAINT pk_employee primary key (Person_ID),
  CONSTRAINT fk_employee foreign key (Person_ID) references PERSONS(Person_ID)
);

-- Creation of the Recovery Site Entity / Table --
DROP TABLE IF EXISTS RECOVERYSITE;
CREATE TABLE RECOVERYSITE (
  Site_ID	  	int not null auto_increment,
  Site_Name  	varchar(100) not null,
  Location		varchar(200) not null,
  Zipcode		int not null,
  CONSTRAINT pk_recoverysite primary key (Site_ID)
);

-- Creation of the Includes Entity / Table --
DROP TABLE IF EXISTS INCLUDES;
CREATE TABLE INCLUDES (
  Plan_ID  		int not null,
  Person_ID  	int not null,
  Victim_ID		int not null,
  Site_ID		int not null,
  CONSTRAINT pk_includes_1 primary key (Plan_ID, Person_ID, Victim_ID, Site_ID),
  CONSTRAINT fk_includes_1 foreign key (Person_ID) references PERSONS(Person_ID),
  CONSTRAINT fk_includes_2 foreign key (Plan_ID) references PLANS(Plan_ID),
  CONSTRAINT fk_includes_3 foreign key (Victim_ID) references VICTIMS(Victim_ID),
  CONSTRAINT fk_includes_4 foreign key (Site_ID) references RECOVERYSITE(Site_ID)
);

-- Creation of the Resources Entity / Table --
DROP TABLE IF EXISTS RESOURCES;
CREATE TABLE RESOURCES (
  Resource_ID		int not null auto_increment,
  Resource_Type 	varchar(100) not null,
  Resource_Name		varchar(100) not null,
  CONSTRAINT pk_resources primary key (Resource_ID)
);

-- Creation of the Carries Entity / Table --
DROP TABLE IF EXISTS CARRIES;
CREATE TABLE CARRIES (
  Site_ID  		int not null,
  Resource_ID  	int not null,
  CONSTRAINT pk_carries_1 primary key (Site_ID, Resource_ID),
  CONSTRAINT fk_carries_1 foreign key (Site_ID) references RECOVERYSITE(Site_ID),
  CONSTRAINT fk_carries_2 foreign key (Resource_ID) references RESOURCES(Resource_ID)
);

-- Creation of the Business Process Entity / Table --
DROP TABLE IF EXISTS BUSINESSPROCESS;
CREATE TABLE BUSINESSPROCESS (
  Process_ID		int not null auto_increment,
  BP_Name		 	varchar(100) not null,
  BP_Level			int not null,
  Resource_ID  		int not null,
  CONSTRAINT pk_resources primary key (Process_ID),
  CONSTRAINT fk_resources foreign key (Resource_ID) references RESOURCES(Resource_ID)
);

-- Creation of the Requires Entity / Table --
DROP TABLE IF EXISTS REQUIRES;
CREATE TABLE REQUIRES (
  Process_ID  	int not null,
  Resource_ID  	int not null,
  CONSTRAINT pk_requires_1 primary key (Process_ID,Resource_ID),
  CONSTRAINT fk_requires_1 foreign key (Process_ID) references BUSINESSPROCESS(Process_ID),
  CONSTRAINT fk_requires_2 foreign key (Resource_ID) references RESOURCES(Resource_ID)
);

-- Creation of the Works For Entity / Table --
DROP TABLE IF EXISTS WORKSFOR;
CREATE TABLE WORKSFOR (
  Process_ID  	int not null,
  Plan_ID  		int not null,
  CONSTRAINT pk_worksfor_1 primary key (Process_ID, Plan_ID),
  CONSTRAINT fk_worksfor_1 foreign key (Process_ID) references BUSINESSPROCESS(Process_ID),
  CONSTRAINT fk_worksfor_2 foreign key (Plan_ID) references PLANS(Plan_ID)
);

-- Populating the Incident Table with some values
INSERT INTO INCIDENT(Incident_ID, Fire_Type, Incident_Date, Danger_Level, Zipcode) VALUES
(1, 'Wild Fire', '2003-01-02', 4, 55105),
(2, 'Structural Fire', '2005-06-14', 3,89923),
(3, 'Vehicle Fire', '2010-09-22', 2,86213),
(4, 'Chemical Fire', '2012-11-10', 5,55214),
(5, 'Electrical Fire', '2015-01-05', 3,39310),
(6, 'Gas Explosion', '2017-07-04', 5,39221),
(7, 'Kitchen Fire', '2019-03-15', 2,99031),
(8, 'Industrial Fire', '2020-12-08', 4,28012),
(9, 'Forest Fire', '2021-08-19', 5,80121),
(10, 'Warehouse Fire', '2022-02-28', 3,85245),
(11, 'Arson Incident', '2007-10-30', 4,59032),
(12, 'Lightning-Caused Fire', '2018-04-09', 4,55510),
(13, 'Underground Fire', '2006-09-13', 3,99210),
(14, 'Electrical Substation Fire', '2013-12-25', 4,96007),
(15, 'Train Car Fire', '2004-07-18', 3,96208),
(16, 'Fireworks Accident', '2023-01-01', 4,84120),
(17, 'Residential Fire', '2024-05-10', 2,97042),
(18, 'Brush Fire', '2011-02-20', 3,55509),
(19, 'Oil Rig Fire', '2009-08-03', 5,28128),
(20, 'Landfill Fire', '2025-04-01', 2,97123);

-- Populating the Plan table --
INSERT INTO PLANS(Plan_id, Plan_Type, Information, Incident_ID) VALUES
(1, 'Evacuation Plan', 'Coordinate full neighborhood evacuation due to expanding wild-fire zone.', 1),
(2, 'Containment Strategy', 'Firewalls and suppression foam to control structural fire spread.', 2),
(3, 'Vehicle Fire Response', 'Deploy emergency extinguishing teams to highway 71.', 3),
(4, 'Hazmat Protocol', 'Dispatch chemical hazard team with containment kits.', 4),
(5, 'Power Shutdown Procedure', 'Deactivate main power grid in affected residential area.', 5),
(6, 'Explosive Material Response', 'Secure perimeter and evacuate a 5-mile radius.', 6),
(7, 'Kitchen Safety Outreach', 'Deploy community training and smoke detector distribution.', 7),
(8, 'Industrial Risk Mitigation', 'Enforce OSHA compliance and deploy foam systems.', 8),
(9, 'Forest Fire Aerial Response', 'Utilize air tankers and drones for thermal surveillance.', 9),
(10, 'Warehouse Safety Audit', 'Conduct structural safety inspection and sprinkler maintenance.', 10),
(11, 'Arson Investigation Plan', 'Coordinate with law enforcement and install security systems.', 11),
(12, 'Lightning Fire Preparedness', 'Raise community awareness, install surge protectors.', 12),
(13, 'Underground Fire Assessment', 'Use robotic sensors to detect source in tunnel systems.', 13),
(14, 'Substation Isolation Protocol', 'Redirect grid flow, deploy cooling units, notify utility firms.', 14),
(15, 'Rail Transport Emergency Plan', 'Evacuate passengers, initiate emergency brake systems.', 15),
(16, 'Fireworks Event Precaution Plan', 'Set up controlled zones, restrict fireworks usage.', 16),
(17, 'Residential Fire Safety Plan', 'Install sprinkler systems and conduct fire drills.', 17),
(18, 'Brush Fire Containment Plan', 'Use hand crews and dozers to cut fire lines.', 18),
(19, 'Oil Rig Emergency Plan', 'Shut down rig and airlift personnel, activate sea-based foam units.', 19),
(20, 'Landfill Smoke Control', 'Cover fire with soil and use odor-reducing chemicals.', 20);

-- Populating the persons table with Person id's --
INSERT INTO PERSONS(Person_ID) VALUES
(1), (2), (3), (4), (5), (6), (7), (8), (9), (10), 
(11), (12), (13), (14), (15), (16), (17), (18), (19), (20), 
(21), (22), (23), (24), (25), (26), (27), (28), (29), (30),
(31), (32), (33), (34), (35), (36), (37), (38), (39), (40),
(41), (42), (43), (44), (45), (46), (47), (48), (49);

-- Populating the victims table with the Persons name, victim id and the person id --
INSERT INTO VICTIMS(Person_ID, Victim_Name, Victim_ID) VALUES
(1, 'Jessica Carter', 1),
(2, 'Alan Nguyen', 2),
(3, 'Maria Gonzalez', 3),
(4, 'Thomas Brooks', 4),
(5, 'Ava Patel', 5),
(6, 'Michael Johnson', 6),
(7, 'Sofia Kim', 7),
(8, 'David Connor', 8),
(9, 'Lila Thompson', 9),
(10, 'Benjamin Lee', 10),
(11, 'Chloe Adams', 11),
(12, 'Noah Wright', 12),
(13, 'Isabella Martinez', 13),
(14, 'Ethan Ross', 14),
(15, 'Grace Liu', 15),
(16, 'Omar Haddad', 16),
(36, 'Fahad Sandoval', 17),
(37, 'Abby Mcdonald', 18),
(38, 'Keanu Bright', 19),
(39, 'Ruby Oliver',20),
(40, 'Theodore Quinn', 21),
(41, 'Karina Hill', 22),
(42, 'Kajus Beck', 23),
(43, 'Ronan Daugherty', 24),
(44, 'Kallum Daugherty', 25),
(45, 'Abbey Dean', 26),
(46, 'Leyla Bishop', 27),
(47, 'Penny Frederick', 28),
(48, 'Jean Frederick', 29),
(49, 'Mason Zuniga', 30);

-- Populate the employee table with Persons Id, Employee name, and the Employee Id --
INSERT INTO EMPLOYEE(Person_ID, Employee_name, Employee_ID) VALUES
(17, 'Rachel Greene', 1),
(18, 'Marcus Bennett', 2),
(19, 'Emily Zhao', 3),
(20, 'Liam Walker', 4),
(21, 'Olivia Stone', 5),
(22, 'Caleb Rivers', 6),
(23, 'Nina Das', 7),
(24, 'Daniel Park', 8),
(25, 'Zara Kingsley', 9),
(26, 'Leo Armstrong', 10),
(27, 'Amelia Fox', 11),
(28, 'Isaac Moretti', 12),
(29, 'Jade Sinclair', 13),
(30, 'Miles Carter', 14),
(31, 'Talia Nguyen', 15),
(32, 'Hunter Blake', 16),
(33, 'Layla Shah', 17),
(34, 'Gavin Ellis', 18),
(35, 'Brooklyn Reed', 19);

-- Populate the Recovery Sitre Entity Table --
INSERT INTO RECOVERYSITE(Site_ID, Site_Name, Location, Zipcode) VALUES
(1, 'Flagstaff Interagency Dispatch Center', '1824 S Thompson St, Flagstaff, AZ',86001),
(2, 'Phoenix Interagency Dispatch Center', '6335 S Downwind Circle, Ste 101, Mesa, AZ',85212),
(3, 'Modoc Interagency Command Center', '225 W 8th St, Alturas, CA',96101),
(4, 'Minnesota Interagency Coordination Center', '402 SE 11th St, Grand Rapids, MN',55744),
(5, 'Mississippi Interagency Coordination Center', '3139 Hwy 468 W, Pearl, MS',39208),
(6, 'Rocky Boys Agency Dispatch Center', '98 Veterans Park Rd, Box Elder, MT',59521),
(7, 'Ely Interagency Communication Center', '702 N Industrial Ave, Ely, NV',89301),
(8, 'North Carolina Interagency Coordination Center', '160 A Zillicoa St, Asheville,NC',28801),
(9, 'Lakeview Interagency Fire Center', '1000 S 9th St, Lakeview, OR',97630),
(10, 'Yukon Fire Dispatch Center', '1541 Gaffney Rd, Fort Wainwright, AK',99703);

-- Populate the Relation table for Includes --
INSERT INTO INCLUDES (Plan_ID, Person_ID, Victim_ID, Site_ID) VALUES
(1, 17, 1, 4), (1, 18, 2, 4),
(2, 19, 3, 7), (2, 20, 4, 7),
(3, 21, 5, 7), (3, 22, 6 ,7),
(4, 23, 7, 10), (4, 24,8 ,10),
(5, 25, 9 , 5), (5, 26, 10 ,5),
(6, 27, 11, 5), (6, 28, 12 ,5),
(7, 29, 13, 2),
(8, 30, 14, 8), (8, 31, 15, 8),
(9, 32, 16, 1), (9, 33,17,1),
(10, 34,18,2),
(11, 35,19,6),
(12, 17,20,4),
(13, 18,21,1), (13, 19,21,1),
(14, 20,22,3),
(15, 21,23,3), (15, 22,23,3),
(16, 23,24,6),
(17, 24,25,9), (17,25,25,9),
(18, 26,26,4),
(19, 27,27,8), (19, 28,28,8),
(20, 29,29,9), (20, 30,30,9);

-- Populating the various resources into the Resources table --
INSERT INTO RESOURCES (Resource_ID, Resource_Type, Resource_Name) VALUES
(1, 'Medical Equipment', 'Emergency Trauma Kit'),
(2, 'Communication Device', 'Satellite Phone'),
(3, 'Vehicle', 'All-Terrain Ambulance'),
(4, 'Shelter Material', 'Modular Tent System'),
(5, 'Food Supply', 'Emergency MRE Packs'),
(6, 'Water Supply', 'Portable Water Purifier'),
(7, 'Power Supply', 'Solar Generator'),
(8, 'Rescue Tool', 'Hydraulic Cutter'),
(9, 'Fire Suppression', 'Mobile Foam Unit'),
(10, 'Safety Gear', 'Hazmat Suit'),
(11, 'Logistics Equipment', 'Portable Storage Container'),
(12, 'Medical Equipment', 'Defibrillator'),
(13, 'Navigation Aid', 'Handheld GPS Unit'),
(14, 'Rescue Tool', 'Thermal Imaging Camera'),
(15, 'Communication Device', 'Two-Way Radio Set'),
(16, 'Food Supply', 'Cases of Bottled Water'),
(17, 'Food Supply', 'Crackers and Nut Mix Packs'),
(18, 'Food Supply', 'Shelf-Stable Bread Loaves'),
(19, 'Food Supply', 'Canned Vegetables'),
(20, 'Food Supply', 'Rice and Bean Bags'),
(21, 'Food Supply', 'Infant Formula and Baby Food'),
(22, 'Food Supply', 'High-Calorie Protein Bars'),
(23, 'Water Supply', 'Bulk 5-Gallon Water Jugs');

-- Populating the carries table --
INSERT INTO CARRIES (Site_ID, Resource_ID) VALUES
(1, 1), (1, 5), (1, 6), (1, 16), (1, 17),
(2, 2), (2, 7), (2, 18), (2, 19),
(3, 3), (3, 4), (3, 8), (3, 20),
(4, 9), (4, 21), (4, 16), (4, 22),
(5, 10), (5, 12), (5, 23),
(6, 6), (6, 13), (6, 17), (6, 20),
(7, 11), (7, 14), (7, 19), (7, 21),
(8, 1), (8, 3), (8, 15), (8, 22),
(9, 5), (9, 7), (9, 18), (9, 23),
(10, 2), (10, 8), (10, 9), (10, 20);

-- Populating the Bussines process relation table --
INSERT INTO BUSINESSPROCESS (Process_ID, BP_Name, BP_Level, Resource_ID) VALUES
(1, 'Setup Emergency Medical Tents', 1, 1),
(2, 'Establish Communication Line', 2, 2),
(3, 'Deploy Search and Rescue Vehicle', 3, 3),
(4, 'Assemble Shelter Units', 1, 4),
(5, 'Distribute MRE Packs', 1, 5),
(6, 'Install Water Purification Units', 2, 6),
(7, 'Deploy Hazmat Containment', 3, 10),
(8, 'Setup Power Backup Systems', 2, 7),
(9, 'Logistics and Storage Management', 2, 11),
(10, 'Fire Suppression Setup', 3, 9);

-- Populating the requires relation table --
INSERT INTO REQUIRES (Process_ID, Resource_ID) VALUES
(1, 12), (1, 6),        
(2, 15),              
(3, 8), (3, 13),
(4, 5), (4, 16),  
(5, 17), (5, 20),  
(6, 23),             
(7, 14),           
(8, 7), (8, 15),      
(9, 11), (9, 18),      
(10, 22),             
(10, 19);

-- Populating the Works for relation table -- 
INSERT INTO WORKSFOR (Process_ID, Plan_ID) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10);

-- Queries all incidents' closest recovery site --
SELECT i.Incident_ID, r.Site_ID, r.Site_name, r.Location, i.Zipcode as Incident_Zip, r.Zipcode as Site_Zip
FROM Incident i, RECOVERYSITE r
WHERE r.Zipcode LIKE concat(LEFT(i.Zipcode,2),'%');

 -- Queries a specific incident's closest recovery site --
SELECT i.Incident_ID, r.Site_ID, r.Site_name, r.Location, i.Zipcode as Incident_Zip, r.Zipcode as Site_Zip
FROM INCIDENT i, RECOVERYSITE r
WHERE r.Zipcode LIKE concat(LEFT(i.Zipcode,2),'%') and i.Incident_ID = 2; -- Change the ID for different incidents

-- Queries all incidents for assosiated employees --
SELECT i.Incident_ID, i.Fire_Type, i.Incident_Date, e.Employee_name, e.Employee_ID
FROM INCIDENT i
JOIN PLANS p ON i.Incident_ID = p.Incident_ID
JOIN INCLUDES inc ON p.Plan_ID = inc.Plan_ID
JOIN EMPLOYEE e ON inc.Person_ID = e.Person_ID
ORDER BY i.Incident_ID, e.Employee_name;

-- Queries all incidents a specific employee --
SELECT i.Incident_ID, i.Fire_Type, i.Incident_Date, e.Employee_name, e.Employee_ID
FROM INCIDENT i
JOIN PLANS p ON i.Incident_ID = p.Incident_ID
JOIN INCLUDES inc ON p.Plan_ID = inc.Plan_ID
JOIN EMPLOYEE e ON inc.Person_ID = e.Person_ID
WHERE e.Employee_name LIKE '%Greene%' -- Change the name for different employees
ORDER BY i.Incident_ID, e.Employee_name;

-- Queries all high danger level incidents --
SELECT Incident_ID, Fire_Type, Incident_Date, Danger_Level
FROM INCIDENT
WHERE Danger_Level >= 4;

-- Queries which sites have a specific resource --
SELECT s.Site_Name, s.Location
FROM RECOVERYSITE s
JOIN CARRIES c ON s.Site_ID = c.Site_ID
JOIN RESOURCES r ON c.Resource_ID = r.Resource_ID
WHERE r.Resource_Name = 'Thermal Imaging Camera'; -- Change the resource for different results

-- Queries each plan's specific business process --
SELECT p.Plan_Type, bp.BP_Name
FROM PLANS p
JOIN WORKSFOR wf ON p.Plan_ID = wf.Plan_ID
JOIN BUSINESSPROCESS bp ON wf.Process_ID = bp.Process_ID
ORDER BY p.Plan_Type, bp.BP_Level;

-- Queries where each plan has low personnel --
SELECT p.Plan_Type, COUNT(inc.Person_ID) AS Personnel_Assigned
FROM PLANS p
JOIN INCLUDES inc ON p.Plan_ID = inc.Plan_ID
GROUP BY p.Plan_Type
HAVING Personnel_Assigned < 2; -- Increased with larger sample

-- Queries each incident type for its plan information --
SELECT distinct i.Fire_type, p.information
FROM PLANS p
JOIN INCIDENT i ON i.Incident_ID = p.Incident_ID;

-- Queries each reasource of a specific type --
SELECT Resource_Name
FROM Resources
WHERE Resource_Type = 'Food Supply'; -- Change the type for different results

-- Queries each high danger level incidents' closest recovery site --
SELECT High.Incident_ID, r.Site_ID, r.Site_name, r.Location, High.Zipcode as Incident_Zip, r.Zipcode as Site_Zip, High.Danger_Level
FROM RECOVERYSITE r, (SELECT Incident_ID, Fire_Type, Incident_Date, Danger_Level, Zipcode
FROM INCIDENT
WHERE Danger_Level >= 4) as High
WHERE r.Zipcode LIKE concat(LEFT(High.Zipcode,2),'%');

-- Queries a list of each incident's victims --
SELECT distinct i.Incident_Id, i.Fire_type, v.Victim_name
FROM INCIDENT i
JOIN PLANS p on i.Incident_ID = p.Incident_id
JOIN INCLUDES inc on p.Plan_ID = inc.Plan_ID
JOIN VICTIMS v on v.Victim_ID = inc.Victim_ID;

-- Queries all  victims' Incident Zipcode and Recoverysite --
Select distinct big.Victim_name, big.Zipcode as Incident_Zip, r.Zipcode as Recovery_Zip
FROM (SELECT i.Incident_Id, i.Fire_type, v.Victim_name, i.Zipcode, inc.Site_ID
FROM INCIDENT i
JOIN PLANS p on i.Incident_ID = p.Incident_id
JOIN INCLUDES inc on p.Plan_ID = inc.Plan_ID
JOIN VICTIMS v on v.Victim_ID = inc.Victim_ID) as big
JOIN RECOVERYSITE r on big.Site_ID = r.Site_ID
ORDER BY big.Victim_name asc;

-- Queries a specific victim's Incident Zipcode and Recoverysite --
Select distinct big.Victim_name, big.Zipcode as Incident_Zip, r.Zipcode as Recovery_Zip
FROM (SELECT i.Incident_Id, i.Fire_type, v.Victim_name, i.Zipcode, inc.Site_ID
FROM INCIDENT i
JOIN PLANS p on i.Incident_ID = p.Incident_id
JOIN INCLUDES inc on p.Plan_ID = inc.Plan_ID
JOIN VICTIMS v on v.Victim_ID = inc.Victim_ID) as big
JOIN RECOVERYSITE r on big.Site_ID = r.Site_ID
WHERE big.Victim_name = 'Abbey Dean'; -- Change name for different results

-- Queries which processes use the most resources --
SELECT P.BP_Name, COUNT(RQ.Resource_ID) AS Resource_Count
FROM BUSINESSPROCESS P
JOIN REQUIRES RQ ON P.Process_ID = RQ.Process_ID
GROUP BY P.Process_ID
ORDER BY Resource_Count DESC;

-- Queries which incident happened most recently --
SELECT * FROM INCIDENT 
ORDER BY Incident_Date DESC 
LIMIT 1; 

-- Queries employees who are assigned to multiple recovery plans --
SELECT e.Employee_name, COUNT(DISTINCT inc.Plan_ID) AS Plan_Count
FROM EMPLOYEE e
JOIN INCLUDES inc ON e.Person_ID = inc.Person_ID
GROUP BY e.Employee_name
HAVING COUNT(DISTINCT inc.Plan_ID) > 1;

-- Queries incidents that had the most victims -- 
SELECT i.Zipcode, i.Fire_Type, COUNT(DISTINCT v.Victim_ID) AS Victim_Count
FROM VICTIMS v
JOIN INCLUDES inc ON v.Victim_ID = inc.Victim_ID
JOIN PLANS p ON inc.Plan_ID = p.Plan_ID
JOIN INCIDENT i ON p.Incident_ID = i.Incident_ID
GROUP BY i.Zipcode, i.Fire_Type
ORDER BY Victim_Count DESC;

-- Queries resources used by more than one business process --
SELECT r.Resource_Name, COUNT(*) AS Usage_Count 
FROM REQUIRES rq
JOIN RESOURCES r ON rq.Resource_ID = r.Resource_ID
GROUP BY r.Resource_ID
HAVING COUNT(*) > 1
ORDER BY Usage_Count DESC;

-- Queries incidents and sorts them by date == 
SELECT DATE_FORMAT(Incident_Date, '%Y-%m') AS Month, COUNT(*) AS Incident_Count
FROM INCIDENT
GROUP BY Month
ORDER BY Month; 

-- Queries employees working on the most dangerous incidents --
SELECT e.Employee_name, i.Fire_Type, i.Danger_Level
FROM EMPLOYEE e
JOIN INCLUDES inc ON e.Person_ID = inc.Person_ID
JOIN PLANS p ON inc.Plan_ID = p.Plan_ID
JOIN INCIDENT i ON p.Incident_ID = i.Incident_ID
WHERE i.Danger_Level = (SELECT MAX(Danger_Level) FROM INCIDENT);
 
-- Queries recovery sites used by multiple plans --
SELECT rs.Site_Name, COUNT(*) AS Usage_Count
FROM RECOVERYSITE rs
JOIN INCLUDES inc ON rs.Site_ID = inc.Site_ID
GROUP BY rs.Site_Name
ORDER BY Usage_Count DESC;
 
-- views
-- Example view for a victim
Create view VictimAccess as 
Select distinct v.Victim_Name, i.Fire_Type, i.Incident_Date, i.Zipcode, Includes.Person_ID as EmployeeNum, p.Plan_Type, p.Information as PlanInfo, r.Location as RecoverySiteLocation
From Incident i, Includes, Victims v, Plans p, RecoverySite r
Where v.Victim_ID = Includes.Victim_ID 
AND Includes.plan_id = p.plan_id
AND p.incident_id = i.incident_id
AND includes.site_id = r.site_ID
AND v.Victim_Name = 'Theodore Quinn';

select * from VictimAccess;

-- Example view for an Employee
Create View EmployeeAccess as
Select distinct e.Employee_name, p.Plan_Type, p.Information, v.Victim_Name, i.Fire_Type, i.Incident_date, i.Danger_Level, b.BP_Name, r.Resource_Type, r.Resource_Name, rec.Site_Name, rec.Location , i.Zipcode
From Employee e, Plans p, Includes, Incident i, WorksFor w, BusinessProcess b, Resources r, Victims v, RecoverySite rec
Where e.Person_ID = Includes.Person_ID
AND p.Plan_ID = Includes.Plan_ID
AND w.Plan_ID = p.Plan_ID
AND i.Incident_ID = p.Incident_ID
AND w.Process_Id = b.Process_ID
AND b.Resource_ID = r.Resource_ID
AND v.Victim_ID = Includes.Victim_ID
AND rec.Site_ID = Includes.Site_ID
AND e.Employee_Name = 'Rachel Greene';

select * from EmployeeAccess;