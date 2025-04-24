Drop Database if exists DisasterRelief;
Create Database DisasterRelief;
Use DisasterRelief;

DROP TABLE IF EXISTS INCIDENT;
CREATE TABLE INCIDENT (
  Incident_ID  	int not null auto_increment,
  Fire_Type   	varchar(50) not null,
  Incident_Date	date not null, 
  Danger_Level 	int not null,
  CONSTRAINT pk_incident primary key (Incident_id)
);

DROP TABLE IF EXISTS PLAN;
CREATE TABLE PLAN (
  Plan_ID  		int not null auto_increment,
  Plan_Type   	varchar(50) not null,
  Information	varchar(750) not null, 
  Incident_ID	int not null,
  CONSTRAINT pk_plan primary key (Plan_ID),
  CONSTRAINT fk_plan foreign key (Incident_ID) references INCIDENT(Incident_ID)
);

DROP TABLE IF EXISTS PERSONS;
CREATE TABLE PERSONS (
  Person_ID  	int not null auto_increment,
  CONSTRAINT pk_persons primary key (Person_ID)
);

DROP TABLE IF EXISTS VICTIMS;
CREATE TABLE VICTIMS (
  Person_ID  	int not null auto_increment,
  Victim_Name  	varchar(150) not null,
  CONSTRAINT pk_victims primary key (Person_ID),
  CONSTRAINT fk_victims foreign key (Person_ID) references PERSONS(Person_ID)
);

DROP TABLE IF EXISTS EMPLOYEE;
CREATE TABLE EMPLOYEE (
  Person_ID  	int not null auto_increment,
  Employee_ID  	int not null,
  CONSTRAINT pk_employee primary key (Person_ID),
  CONSTRAINT fk_employee foreign key (Person_ID) references PERSONS(Person_ID)
);

DROP TABLE IF EXISTS RECOVERYSITE;
CREATE TABLE RECOVERYSITE (
  Site_ID	  	int not null auto_increment,
  Site_Name  	varchar(100) not null,
  Location		varchar(200) not null,
  CONSTRAINT pk_recoverysite primary key (Site_ID)
);

DROP TABLE IF EXISTS INCLUDES;
CREATE TABLE INCLUDES (
  Plan_ID  		int not null,
  Person_ID  	int not null,
  CONSTRAINT pk_includes_1 primary key (Plan_ID, Person_ID),
  CONSTRAINT fk_includes_1 foreign key (Person_ID) references PERSONS(Person_ID),
  CONSTRAINT fk_includes_2 foreign key (Plan_ID) references PLAN(Plan_ID)
);

DROP TABLE IF EXISTS RESOURCES;
CREATE TABLE RESOURCES (
  Resource_ID		int not null auto_increment,
  Resource_Type 	varchar(100) not null,
  Resource_Name		varchar(100) not null,
  CONSTRAINT pk_resources primary key (Resource_ID)
);

DROP TABLE IF EXISTS CARRIES;
CREATE TABLE CARRIES (
  Site_ID  		int not null,
  Resource_ID  	int not null,
  CONSTRAINT pk_carries_1 primary key (Site_ID, Resource_ID),
  CONSTRAINT fk_carries_1 foreign key (Site_ID) references RECOVERYSITE(Site_ID),
  CONSTRAINT fk_carries_2 foreign key (Resource_ID) references RESOURCES(Resource_ID)
);

DROP TABLE IF EXISTS BUSINESSPROCESS;
CREATE TABLE BUSINESSPROCESS (
  Process_ID		int not null auto_increment,
  BP_Name		 	varchar(100) not null,
  BP_Level			int not null,
  Resource_ID  		int not null,
  CONSTRAINT pk_resources primary key (Process_ID),
  CONSTRAINT fk_resources foreign key (Resource_ID) references RESOURCES(Resource_ID)
);

DROP TABLE IF EXISTS REQUIRES;
CREATE TABLE REQUIRES (
  Process_ID  	int not null,
  Resource_ID  	int not null,
  CONSTRAINT pk_requires_1 primary key (Process_ID,Resource_ID),
  CONSTRAINT fk_requires_1 foreign key (Process_ID) references BUSINESSPROCESS(Process_ID),
  CONSTRAINT fk_requires_2 foreign key (Resource_ID) references RESOURCES(Resource_ID)
);

DROP TABLE IF EXISTS WORKSFOR;
CREATE TABLE WORKSFOR (
  Process_ID  	int not null,
  Plan_ID  		int not null,
  CONSTRAINT pk_worksfor_1 primary key (Process_ID, Plan_ID),
  CONSTRAINT fk_worksfor_1 foreign key (Process_ID) references BUSINESSPROCESS(Process_ID),
  CONSTRAINT fk_worksfor_2 foreign key (Plan_ID) references PLAN(Plan_ID)
);