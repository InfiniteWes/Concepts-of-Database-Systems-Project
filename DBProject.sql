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
  Person_ID  	int not null auto_increment,
  Victim_Name  	varchar(150) not null,
  Victim_ID   int not null auto_increment,
  CONSTRAINT pk_victims primary key (Person_ID),
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
  CONSTRAINT pk_recoverysite primary key (Site_ID)
);

-- Creation of the Includes Entity / Table --
DROP TABLE IF EXISTS INCLUDES;
CREATE TABLE INCLUDES (
  Plan_ID  		int not null,
  Person_ID  	int not null,
  CONSTRAINT pk_includes_1 primary key (Plan_ID, Person_ID),
  CONSTRAINT fk_includes_1 foreign key (Person_ID) references PERSONS(Person_ID),
  CONSTRAINT fk_includes_2 foreign key (Plan_ID) references PLAN(Plan_ID)
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
  CONSTRAINT fk_worksfor_2 foreign key (Plan_ID) references PLAN(Plan_ID)
);

-- Populating the Incident Table with some values
INSERT INTO INCIDENT(Incident_ID, Fire_Type, Incident_Date, Danger_Level) VALUES
(1, 'Wild Fire', '2/01/2003', 4),
(2, 'Structural Fire', '2005-06-14', 3),
(3, 'Vehicle Fire', '2010-09-22', 2),
(4, 'Chemical Fire', '2012-11-10', 5),
(5, 'Electrical Fire', '2015-01-05', 3),
(6, 'Gas Explosion', '2017-07-04', 5),
(7, 'Kitchen Fire', '2019-03-15', 2),
(8, 'Industrial Fire', '2020-12-08', 4),
(9, 'Forest Fire', '2021-08-19', 5),
(10, 'Warehouse Fire', '2022-02-28', 3),
(11, 'Arson Incident', '2007-10-30', 4),
(12, 'Lightning-Caused Fire', '2018-04-09', 4),
(13, 'Underground Fire', '2006-09-13', 3),
(14, 'Electrical Substation Fire', '2013-12-25', 4),
(15, 'Train Car Fire', '2004-07-18', 3),
(16, 'Fireworks Accident', '2023-01-01', 4),
(17, 'Residential Fire', '2024-05-10', 2),
(18, 'Brush Fire', '2011-02-20', 3),
(19, 'Oil Rig Fire', '2009-08-03', 5),
(20, 'Landfill Fire', '2025-04-01', 2);

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
INSERT INTO PERSON(Person_ID) VALUES
(1), (2), (3), (4), (5), (6), (7), (8), (9), (10), 
(11), (12), (13), (14), (15), (16), (17), (18), (19), (20), 
(21), (22), (23), (24), (25), (26), (27), (28), (29), (30),
(31), (32), (33), (34), (35);

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
(16, 'Omar Haddad', 16);

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
INSERT INTO RECOVERYSITE(Site_ID, Site_Name, Location) VALUES
(1, 'North Ridge Emergency Shelter', '1024 Pinehill Dr, Denver, CO'),
(2, 'Silver Lake Relief Center', '5808 Silver St, Austin, TX'),
(3, 'Maplewood Crisis Hub', '22 Maplewood Ave, Albany, NY'),
(4, 'Coastal Aid Station', '760 Bayview Rd, San Diego, CA'),
(5, 'Midwest Recovery Camp', '343 Riverbend Ln, Des Moines, IA'),
(6, 'Highland Relief Base', '11 Ridgeway Blvd, Salt Lake City, UT'),
(7, 'Cedar Valley Emergency Grounds', '800 Cedar St, Nashville, TN'),
(8, 'Bayfield Temporary Shelter', '90 Harbor Rd, Miami, FL'),
(9, 'Horizon Disaster Response Unit', '555 Skyview Dr, Phoenix, AZ'),
(10, 'Evergreen Evacuation Center', '1212 Forest Path, Portland, OR');

-- Populate the Relation table for Includes --
INSERT INTO INCLUDES (Plan_ID, Person_ID) VALUES
(1, 17), (1, 18),
(2, 19), (2, 20),
(3, 21), (3, 22),
(4, 23), (4, 24),
(5, 25), (5, 26),
(6, 27), (6, 28),
(7, 29),
(8, 30), (8, 31),
(9, 32), (9, 33),
(10, 34),
(11, 35),
(12, 17),
(13, 18), (13, 19),
(14, 20),
(15, 21), (15, 22),
(16, 23),
(17, 24), (17, 25),
(18, 26),
(19, 27), (19, 28),
(20, 29), (20, 30);

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
