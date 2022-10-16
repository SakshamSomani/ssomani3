	create table classroom
		(building		varchar(15),
		 room_number	varchar(7),
		 capacity		numeric(4,0),
		 primary key (room_number)
		);

	create table department
		(dept_name		varchar(20), 
		 building		varchar(15), 
		 budget		    numeric(12,2) check (budget > 0),
		 primary key (dept_name)
		);

	create table course
		(course_id		varchar(8), 
		 title			varchar(50), 
		 dept_name		varchar(20),
		 credits		numeric(2,0) check (credits > 0),
		 primary key (course_id),
		 foreign key (dept_name) references department
			on delete set null
		);

	create table instructor
		(ID			varchar(5), 
		 name		varchar(20) not null, 
		 dept_name	varchar(20), 
		 salary		numeric(8,2) check (salary > 29000),
		 primary key (ID),
		 foreign key (dept_name) references department on delete set null
		);

	create table section
		(course_id		varchar(8), 
		 sec_id			varchar(8),
		 semester		varchar(6) check (semester in ('Fall', 'Winter', 'Spring', 'Summer')), 
		 year			numeric(4,0) check (year > 1701 and year < 2100), 
		 building		varchar(15),
		 room_number	varchar(7),
		 time_slot_id	varchar(4),	 primary key (course_id, sec_id, semester, year),
		 foreign key (course_id) references course on delete cascade,
		 foreign key (room_number) references classroom on delete set null
		);

	create table teaches
		(ID				varchar(5), 
		 course_id		varchar(8),
		 sec_id			varchar(8), 
		 semester		varchar(6),
		 year			numeric(4,0),
		 primary key (ID, course_id, sec_id, semester, year),
		 foreign key (course_id,sec_id, semester, year) references section on delete cascade,
		 foreign key (ID) references instructor on delete cascade
		);

	create table student
		(ID				varchar(5), 
		 name			varchar(20) not null, 
		 dept_name		varchar(20), 
		 tot_cred		numeric(3,0) check (tot_cred >= 0),
		 primary key (ID),
		 foreign key (dept_name) references department on delete set null
		);

	create table takes
		(ID				varchar(5), 
		 course_id		varchar(8),
		 sec_id			varchar(8), 
		 semester		varchar(6),
		 year			numeric(4,0),
		 grade		    varchar(2),
		 primary key (ID, course_id, sec_id, semester, year),
		 foreign key (course_id,sec_id, semester, year) references section on delete cascade,
		 foreign key (ID) references student on delete cascade
		);

	create table advisor
		(s_ID			varchar(5),
		 i_ID			varchar(5),
		 primary key (s_ID),
		 foreign key (i_ID) references instructor (ID) on delete set null,
		 foreign key (s_ID) references student (ID) on delete cascade
		);

	create table time_slot
		(time_slot_id		varchar(4),
		 day				varchar(1),
		 start_hr			numeric(2) check (start_hr >= 0 and start_hr < 24),
		 start_min			numeric(2) check (start_min >= 0 and start_min < 60),
		 end_hr				numeric(2) check (end_hr >= 0 and end_hr < 24),
		 end_min			numeric(2) check (end_min >= 0 and end_min < 60),
		 primary key (time_slot_id, day, start_hr, start_min)
		);

	create table prereq
		(course_id		varchar(8), 
		 prereq_id		varchar(8),
		 primary key (course_id, prereq_id),
		 foreign key (course_id) references course on delete cascade,
		 foreign key (prereq_id) references course
		);
	
	insert into classroom values ('Lecture_Center', 'A', '120');
	insert into classroom values ('Lecture_Center', 'B', '100');
	insert into classroom values ('Lecture_Center', 'C', '115');
	insert into classroom values ('Lecture_Center', 'D', '85');
	insert into classroom values ('ARC', '201', '85');
	insert into classroom values ('ARC', '202', '90');
	insert into classroom values ('ARC', '203', '95');
	insert into classroom values ('ARC', '204', '100');
	insert into classroom values ('Douglas_Hall', '101', '50');
	insert into classroom values ('Douglas_Hall', '102', '90');
	insert into classroom values ('Douglas_Hall', '103', '65');
	insert into classroom values ('Douglas_Hall', '104', '70');
	insert into classroom values ('Lincon_Hall', '301', '85');
	insert into classroom values ('Lincon_Hall', '302', '45');
	insert into classroom values ('Lincon_Hall', '303', '90');
	insert into classroom values ('Lincon_Hall', '304', '120');
	insert into classroom values ('Burnham_Hall', '001', '85');
	insert into classroom values ('Burnham_Hall', '002', '65');
	insert into classroom values ('Burnham_Hall', '003', '25');
	insert into classroom values ('Burnham_Hall', '004', '120');
	insert into classroom values ('Eng_Block', '111', '50');
	insert into classroom values ('Eng_Block', '112', '80');
	insert into classroom values ('Eng_Block', '113', '75');
	insert into classroom values ('Eng_Block', '114', '45');


	insert into department values ('IDS', 'ARC', '90000');
	insert into department values ('MARKETING.', 'Douglas_Hall', '75000');
	insert into department values ('ACCOUNTING', 'ARC', '85000');
	insert into department values ('FINANCE', 'Lincon_Hall', '120000');
	insert into department values ('BIOLOGY_SCIENCES', 'Burnham_Hall', '500000');
	insert into department values ('BIOMEDICAL_ENG', 'Eng_Block', '720000');
	insert into department values ('MECHANICAL_ENG', 'Eng_Block', '150000');
	insert into department values ('COMPUTER_SCIENCE', 'Lincon_Hall', '150000');

	insert into course values ('BIO-101', 'Intro. to Biology', 'BIOLOGY_SCIENCES', '4');
	insert into course values ('BIO-301', 'Genetics', 'BIOMEDICAL_ENG', '4');
	insert into course values ('BIO-399', 'Computational Biology', 'BIOMEDICAL_ENG', '3');
	insert into course values ('CS-101', 'Intro. to Computer Science', 'COMPUTER_SCIENCE', '4');
	insert into course values ('CS-190', 'Game Design', 'COMPUTER_SCIENCE', '2');
	insert into course values ('CS-315', 'Robotics', 'COMPUTER_SCIENCE', '2');
	insert into course values ('CS-319', 'Image Processing', 'COMPUTER_SCIENCE', '3');
	insert into course values ('IDS-200', 'Intro. to MIS', 'IDS', '4');
	insert into course values ('IDS-532', 'Intro. to Operations Management', 'IDS', '4');
	insert into course values ('IDS-270', 'Business Statistics', 'IDS', '4');
	insert into course values ('IDS-572', 'Data Mining for Business', 'IDS', '4');
	insert into course values ('IDS-594', 'Cybersecurity', 'IDS', '2');
	insert into course values ('IDS-575', 'ML for Business', 'IDS', '4');
	insert into course values ('IDS-521', 'Advanced Database Management', 'IDS', '4');
	insert into course values ('FIN-200', 'Intro. to Finance', 'FINANCE', '4');
	insert into course values ('FIN-302', 'Intro. to Investments', 'FINANCE', '4');
	insert into course values ('FIN-303', 'Investment Banking', 'FINANCE', '3');
	insert into course values ('FIN-320', 'Managerial Finance', 'FINANCE', '2');
	insert into course values ('FIN-330', 'Quantitative Methods', 'FINANCE', '2');
	insert into course values ('FIN-419', 'Behavioral Finance', 'FINANCE', '2');
	insert into course values ('ME-101', 'Physical Principles', 'MECHANICAL_ENG', '4');
	insert into course values ('ME-205', 'Thermodynamics', 'MECHANICAL_ENG', '4');
	insert into course values ('ME-211', 'Fluid Mechanics', 'MECHANICAL_ENG', '3');
	insert into course values ('ME-306', 'Robotic Manipulators', 'MECHANICAL_ENG', '4');
	insert into course values ('ME-220', 'Design and Graphics', 'MECHANICAL_ENG', '3');

	insert into instructor values ('10101', 'Bhatt', 'COMPUTER_SCIENCE', '65000');
	insert into instructor values ('12121', 'Lee', 'FINANCE', '90000');
	insert into instructor values ('15151', 'Hamid', 'MECHANICAL_ENG', '80000');
	insert into instructor values ('22222', 'Singh', 'MECHANICAL_ENG', '95000');
	insert into instructor values ('32343', 'Choi', 'IDS', '60000');
	insert into instructor values ('33456', 'Yang', 'BIOMEDICAL_ENG', '87000');
	insert into instructor values ('45565', 'Gupta', 'COMPUTER_SCIENCE', '75000');
	insert into instructor values ('58583', 'Azad', 'IDS', '62000');
	insert into instructor values ('76543', 'Agrawal', 'FINANCE', '80000');
	insert into instructor values ('76766', 'Cooper', 'BIOMEDICAL_ENG', '72000');
	insert into instructor values ('83821', 'Moseby', 'COMPUTER_SCIENCE', '92000');
	insert into instructor values ('98345', 'Geller', 'BIOLOGY_SCIENCES', '80000');

	insert into section values ('BIO-101', '1', 'Fall', '2022', 'Burnham_Hall', '001', 'B');
	insert into section values ('BIO-301', '1', 'Spring', '2023', 'Burnham_Hall', '002', 'A');
	insert into section values ('BIO-399', '1', 'Spring', '2023', 'Burnham_Hall', '002', 'F');
	insert into section values ('CS-101', '1', 'Fall', '2022', 'Lincon_Hall', '301', 'H');
	insert into section values ('CS-190', '2', 'Fall', '2022', 'Lincon_Hall', '304', 'B');
	insert into section values ('CS-190', '2', 'Spring', '2023', 'Lincon_Hall', '302', 'E');
	insert into section values ('CS-315', '1', 'Fall', '2022', 'Lincon_Hall', '302', 'D');
	insert into section values ('CS-319', '1', 'Fall', '2022', 'Lincon_Hall', '303', 'B');
	insert into section values ('CS-319', '2', 'Spring', '2023', 'Lincon_Hall', '303', 'C');
	insert into section values ('FIN-200', '1', 'Fall', '2022', 'ARC', '201', 'C');
	insert into section values ('FIN-200', '1', 'Spring', '2023', 'ARC', '201', 'C');
	insert into section values ('FIN-302', '2', 'Fall', '2022', 'Lincon_Hall', '101', 'B');
	insert into section values ('FIN-303', '2', 'Spring', '2023', 'Douglas_Hall', '104', 'C');
	insert into section values ('FIN-320', '1', 'Spring', '2023', 'Lincon_Hall', '301', 'D');
	insert into section values ('FIN-330', '2', 'Fall', '2022', 'Lincon_Hall', '304', 'A');
	insert into section values ('FIN-419', '2', 'Spring', '2023', 'ARC', '202', 'B');
	insert into section values ('IDS-200', '1', 'Fall', '2022', 'ARC', '201', 'A');
	insert into section values ('IDS-270', '1', 'Spring', '2023', 'ARC', '201', 'A');
	insert into section values ('IDS-521', '2', 'Fall', '2022', 'Lecture_Center', 'A', 'A');
	insert into section values ('IDS-521', '1', 'Spring', '2023', 'Lecture_Center', 'A', 'A');
	insert into section values ('IDS-532', '1', 'Fall', '2022', 'Lecture_Center', 'C', 'A');
	insert into section values ('IDS-572', '2', 'Spring', '2023', 'Lecture_Center', 'D', 'G');
	insert into section values ('IDS-575', '2', 'Fall', '2022', 'ARC', '202', 'F');
	insert into section values ('IDS-594', '2', 'Spring', '2023', 'Lecture_Center', 'B', 'D');
	insert into section values ('ME-101', '1', 'Fall', '2022', 'Eng_Block', '112', 'C');
	insert into section values ('ME-101', '1', 'Spring', '2023', 'Eng_Block', '112', 'C');
	insert into section values ('ME-205', '2', 'Fall', '2022', 'Eng_Block', '113', 'D');
	insert into section values ('ME-211', '2', 'Spring', '2023', 'Eng_Block', '114', 'F');
	insert into section values ('ME-220', '1', 'Spring', '2023', 'Eng_Block', '111', 'A');
	insert into section values ('ME-306', '2', 'Fall', '2022', 'Eng_Block', '112', 'H');
	

	insert into teaches values ('12121', 'FIN-200', '1', 'Spring', '2023');
	insert into teaches values ('12121', 'FIN-200', '1', 'Fall', '2022');
	insert into teaches values ('12121', 'FIN-303', '2', 'Spring', '2023');
	insert into teaches values ('76543', 'FIN-302', '2', 'Fall', '2022');
	insert into teaches values ('76543', 'FIN-320', '1', 'Spring', '2023');
	insert into teaches values ('76543', 'FIN-330', '2', 'Fall', '2022');
	insert into teaches values ('76543', 'FIN-419', '2', 'Spring', '2023');
	insert into teaches values ('15151', 'ME-101', '1', 'Spring', '2023');
	insert into teaches values ('15151', 'ME-101', '1', 'Fall', '2022');
	insert into teaches values ('22222', 'ME-205', '2', 'Fall', '2022');
	insert into teaches values ('22222', 'ME-211', '2', 'Spring', '2023');
	insert into teaches values ('22222', 'ME-306', '2', 'Fall', '2022');
	insert into teaches values ('22222', 'ME-220', '1', 'Spring', '2023');	
	insert into teaches values ('32343', 'IDS-521', '1', 'Spring', '2023');
	insert into teaches values ('32343', 'IDS-521', '2', 'Fall', '2022');
	insert into teaches values ('32343', 'IDS-200', '1', 'Fall', '2022');
	insert into teaches values ('32343', 'IDS-594', '2', 'Spring', '2023');
	insert into teaches values ('58583', 'IDS-270', '1', 'Spring', '2023');
	insert into teaches values ('58583', 'IDS-532', '1', 'Fall', '2022');
	insert into teaches values ('58583', 'IDS-572', '2', 'Spring', '2023');
	insert into teaches values ('58583', 'IDS-575', '2', 'Fall', '2022');
	insert into teaches values ('98345', 'BIO-101', '1', 'Fall', '2022');
	insert into teaches values ('33456', 'BIO-301', '1', 'Spring', '2023');
	insert into teaches values ('76766', 'BIO-399', '1', 'Spring', '2023');
	insert into teaches values ('10101', 'CS-101', '1', 'Fall', '2022');
	insert into teaches values ('10101', 'CS-315', '1', 'Fall', '2022');
	insert into teaches values ('83821', 'CS-190', '2', 'Fall', '2022');
	insert into teaches values ('83821', 'CS-190', '2', 'Spring', '2023');
	insert into teaches values ('83821', 'CS-319', '2', 'Spring', '2023');
	insert into teaches values ('45565', 'CS-319', '1', 'Fall', '2022');
	
	insert into student values ('00128', 'Somani', 'IDS', '40');
	insert into student values ('12345', 'Singh', 'ACCOUNTING', '36');
	insert into student values ('19991', 'Sharma', 'FINANCE', '30');
	insert into student values ('45678', 'Kubal', 'MARKETING.', '40');
	insert into student values ('70557', 'Shukla', 'IDS', '56');
	insert into student values ('76653', 'Kumar', 'ACCOUNTING', '32');
	insert into student values ('98765', 'Sethi', 'FINANCE', '30');
	insert into student values ('98988', 'Niar', 'IDS', '36');
	insert into student values ('55739', 'Hegde', 'COMPUTER_SCIENCE', '38');
	insert into student values ('76543', 'Abbas', 'COMPUTER_SCIENCE', '34');
	insert into student values ('23121', 'Rai', 'MECHANICAL_ENG', '32');
	insert into student values ('20202', 'Raj', 'MECHANICAL_ENG', '46');
	insert into student values ('44553', 'Pachpor', 'BIOMEDICAL_ENG', '48');
	insert into student values ('54321', 'Mistry', 'BIOLOGY_SCIENCES', '50');

	
	insert into takes values ('00128', 'IDS-521', '1', 'Spring', '2023', 'A');
	insert into takes values ('00128', 'IDS-572', '2', 'Spring', '2023', 'A');
	insert into takes values ('00128', 'FIN-200', '1', 'Fall', '2022', 'A');
	insert into takes values ('00128', 'IDS-575', '2', 'Fall', '2022', 'A');
	insert into takes values ('00128', 'IDS-594', '2', 'Spring', '2023', 'A');
	insert into takes values ('12345', 'IDS-200', '1', 'Fall', '2022', 'C');
	insert into takes values ('12345', 'FIN-200', '1', 'Spring', '2023', 'A');
	insert into takes values ('12345', 'FIN-320', '1', 'Spring', '2023', 'B');
	insert into takes values ('12345', 'FIN-419', '2', 'Spring', '2023', 'B');
	insert into takes values ('12345', 'IDS-575', '2', 'Fall', '2022', 'A');
	insert into takes values ('12345', 'IDS-572', '2', 'Spring', '2023', 'A');
	insert into takes values ('19991', 'FIN-320', '1', 'Spring', '2023', 'B');
	insert into takes values ('19991', 'IDS-594', '2', 'Spring', '2023', 'B');
	insert into takes values ('19991', 'IDS-532', '1', 'Fall', '2022', 'A');
	insert into takes values ('19991', 'FIN-302', '2', 'Fall', '2022', 'C');
	insert into takes values ('45678', 'FIN-200', '1', 'Fall', '2022', 'B');
	insert into takes values ('45678', 'IDS-270', '1', 'Spring', '2023', 'B');
	insert into takes values ('45678', 'IDS-200', '1', 'Fall', '2022', 'C');
	insert into takes values ('45678', 'IDS-521', '1', 'Spring', '2023', 'A');
	insert into takes values ('70557', 'FIN-302', '2', 'Fall', '2022', 'F');
	insert into takes values ('70557', 'FIN-419', '2', 'Spring', '2023', 'B');
	insert into takes values ('70557', 'IDS-532', '1', 'Fall', '2022', 'A');
	insert into takes values ('70557', 'IDS-200', '1', 'Fall', '2022', 'B');
	insert into takes values ('70557', 'IDS-572', '2', 'Spring', '2023', 'C');
	insert into takes values ('76653', 'IDS-200', '1', 'Fall', '2022', 'B');
	insert into takes values ('76653', 'IDS-575', '2', 'Fall', '2022', 'C');
	insert into takes values ('76653', 'IDS-594', '2', 'Spring', '2023', 'B');
	insert into takes values ('76653', 'FIN-330', '2', 'Fall', '2022', 'A');
	insert into takes values ('76653', 'FIN-320', '1', 'Spring', '2023', 'A');
	insert into takes values ('98765', 'FIN-200', '1', 'Fall', '2022', 'A');
	insert into takes values ('98765', 'FIN-330', '2', 'Fall', '2022', 'C');
	insert into takes values ('98765', 'IDS-270', '1', 'Spring', '2023', 'B');
	insert into takes values ('98765', 'FIN-419', '2', 'Spring', '2023', 'A');
	insert into takes values ('98765', 'IDS-575', '2', 'Fall', '2022', 'F');
	insert into takes values ('98988', 'IDS-200', '1', 'Fall', '2022', 'B');
	insert into takes values ('98988', 'FIN-302', '2', 'Fall', '2022', 'A');
	insert into takes values ('98988', 'IDS-594', '2', 'Spring', '2023', 'C');
	insert into takes values ('98988', 'IDS-532', '1', 'Fall', '2022', 'B');
	insert into takes values ('98988', 'IDS-270', '1', 'Spring', '2023', 'A');
	insert into takes values ('76543', 'CS-101', '1', 'Fall', '2022', 'B');
	insert into takes values ('76543', 'CS-190', '2', 'Fall', '2022', 'C');
	insert into takes values ('76543', 'CS-315', '1', 'Fall', '2022', 'B');
	insert into takes values ('76543', 'CS-319', '2', 'Spring', '2023', 'B');
	insert into takes values ('55739', 'CS-101', '1', 'Fall', '2022', 'A');
	insert into takes values ('55739', 'CS-190', '2', 'Spring', '2023', 'B');
	insert into takes values ('55739', 'CS-315', '1', 'Fall', '2022', 'A');
	insert into takes values ('55739', 'CS-319', '2', 'Spring', '2023', 'A');
	insert into takes values ('23121', 'ME-101', '1', 'Fall', '2022', 'A');
	insert into takes values ('23121', 'ME-205', '2', 'Fall', '2022', 'B');
	insert into takes values ('23121', 'ME-211', '2', 'Spring', '2023', 'C');
	insert into takes values ('23121', 'ME-220', '1', 'Spring', '2023', 'B');
	insert into takes values ('23121', 'ME-306', '2', 'Fall', '2022', 'B');
	insert into takes values ('20202', 'ME-101', '1', 'Fall', '2022', 'C');
	insert into takes values ('20202', 'ME-205', '2', 'Fall', '2022', 'B');
	insert into takes values ('20202', 'ME-211', '2', 'Spring', '2023', 'A');
	insert into takes values ('20202', 'ME-220', '1', 'Spring', '2023', 'C');
	insert into takes values ('20202', 'ME-306', '2', 'Fall', '2022', 'C');
	insert into takes values ('44553', 'BIO-101', '1', 'Fall', '2022', 'A');
	insert into takes values ('44553', 'BIO-301', '1', 'Spring', '2023', 'A');
	insert into takes values ('44553', 'BIO-399', '1', 'Spring', '2023', 'A');
	insert into takes values ('54321', 'BIO-101', '1', 'Fall', '2022', 'A');
	insert into takes values ('54321', 'BIO-301', '1', 'Spring', '2023', 'B');
	insert into takes values ('54321', 'BIO-399', '1', 'Spring', '2023', 'B');
		
	insert into advisor values ('00128', '58583');
	insert into advisor values ('12345', '12121');
	insert into advisor values ('23121', '22222');
	insert into advisor values ('20202', '15151');
	insert into advisor values ('44553', '33456');
	insert into advisor values ('45678', '32343');
	insert into advisor values ('54321', '98345');
	insert into advisor values ('76543', '45565');
	insert into advisor values ('76653', '76543');
	insert into advisor values ('55739', '10101');
	insert into advisor values ('98765', '76543');
	insert into advisor values ('98988', '58583');
	
	insert into time_slot values ('A', 'M', '8', '0', '8', '50');
	insert into time_slot values ('A', 'W', '8', '0', '8', '50');
	insert into time_slot values ('B', 'M', '9', '0', '9', '50');
	insert into time_slot values ('B', 'F', '9', '0', '9', '50');
	insert into time_slot values ('C', 'W', '11', '0', '11', '50');
	insert into time_slot values ('C', 'F', '11', '0', '11', '50');
	insert into time_slot values ('D', 'M', '13', '0', '13', '50');
	insert into time_slot values ('D', 'F', '13', '0', '13', '50');
	insert into time_slot values ('E', 'T', '10', '30', '11', '45 ');
	insert into time_slot values ('F', 'T', '14', '30', '15', '45 ');
	insert into time_slot values ('F', 'R', '14', '30', '15', '45 ');
	insert into time_slot values ('G', 'M', '16', '0', '16', '50');
	insert into time_slot values ('G', 'F', '16', '0', '16', '50');
	insert into time_slot values ('H', 'W', '10', '0', '12', '30');

	insert into prereq values ('BIO-301', 'BIO-101');
	insert into prereq values ('BIO-399', 'BIO-101');
	insert into prereq values ('CS-190', 'CS-101');
	insert into prereq values ('CS-315', 'CS-101');
	insert into prereq values ('CS-319', 'CS-101');




/*
#########################################################################################################################################################################*/
/* 

1.	Find the instructors with salary more than certain value */

select i.ID,
   	i.name,
   	   i.salary
from instructor i
where salary > 80000;



/*
2.	Select students from particular department
*/

select distinct
s.ID,
s.name,
s.dept_name

from student s
 join takes t
on s.ID = t.ID
left join course c
on t.course_id = c.course_id
where s.dept_name='IDS';




/*
3.	For each department find the maximum salary given to an instructor in that department.
*/

select dept_name,
   	max(salary)
from  instructor
group by dept_name;

/*
4.	Print the class schedule for a particular student for a given semester & year
*/
select	st.id,st.name,t.year,t.semester,t.grade,c.course_id,c.title,c.credits,s.building,s.room_number,	ts.day,ts.start_hr,ts.start_min,
		ts.end_hr,ts.end_min

from takes t
join student st
on t.ID = st.ID
join course c
on c.course_id = t.course_id
 join section s
on s.course_id = c.course_id
join time_slot ts
on s.time_slot_id = ts.time_slot_id
where st.id='20202' 
and t.year = 2022;



/*
5.	Print a list of all students who scored C or below in any course in a particular semester
*/
select		st.id,st.name, st.dept_name,	
c.course_id,c.title,t.sec_id,t.semester,t.year,t.grade
from student st
join takes t
on st.ID = t.ID
join course c
on c.course_id = t.course_id
where t.grade not in ('A','B')
and t.semester = 'FALL'
and t.year = 2022;




/*
6.	List the budget of all the departments from least to greatest
*/

select 
dt.dept_name,
dt.budget
from department dt
Order by dt.budget;






/*
7.	List all the building and room numbers for every course available
*/

select distinct
c.course_id,c.title,s.sec_id,s.semester,s.year,
s.building,
s.room_number

 
from section s
join course c
on s.course_id = c.course_id
join classroom cl
on s.building = cl.building
where cl.capacity is not NULL
Order by c.title;


/*
8.	List all students who have more than 38 credit hours completed.
*/

select 
st.id,
st.name,
st.tot_cred,
st.dept_name
 
from student st
where st.tot_cred > 38
Order by st.tot_cred





/*
9.	Find all IDS courses with a seating capacity greater than 100
*/

select distinct 
c.course_id,c.title,s.sec_id,s.semester,s.year,s.building,s.room_number
 
from section s
join course c
on s.course_id = c.course_id
inner join classroom cl
on s.building = cl.building
where (cl.capacity > 110)
and c.dept_name = 'IDS'





/*
10.	Find all courses in the ARC building in the FALL semester
*/

select
c.course_id,
c.title,
s.sec_id,
s.semester,
s.year,
s.building
from section s
join course c
on s.course_id = c.course_id
where (s.building = 'ARC')
and s.semester = 'FALL';



/*
11.	Find all professors with a salary between $60000 and $79000
*/

select i.id,
   	i.name,
   	i.salary,
   	i.dept_name
from instructor i
where salary between 60000 and 79000







/*
12.	Update the salary of the instructors from a certain department to certain value
*/

update instructor
set salary = 75000
where ID = '32343';

select * from instructor




/*
13.	 List all students who got A in Fall 2021
*/

select		st.id,st.name, st.dept_name,	c.course_id,c.title,t.sec_id,t.semester,t.year,t.grade
from student st
join takes t
on st.ID = t.ID
join course c
on c.course_id = t.course_id
where t.grade = 'A'
and t.semester = 'FALL'
and t.year = 2022;

/*
14.	Print a list of sections and courses with no student enrollment
*/

select		s.sec_id, 
		s.semester,
		s.year,
		s.course_id,
		c.title,
		c.dept_name,
		count(e.id) as student_count
from section s
left join takes e
on s.sec_id = e.sec_id
join course c
on s.course_id = c.course_id
group by s.sec_id, s.semester, s.year, s.course_id, c.title, c.dept_name
having count(e.id) < 1;


/*
15.	Find all the courses in a department with certain number of credits
*/

select title,
       credits
from course
where dept_name = 'IDS'
and credits = '4';


/*
16.	Create a new course.
*/

BEGIN TRANSACTION
INSERT INTO course (course_id, title, credits, dept_name) 
VALUES ('IDS-550', 'Python Programming', '2', 'IDS');
END;

select * from course




/*
17.	Get the pre-requisites for a course.
*/

select 
c.course_id, 
c.title,
p.prereq_id


from course c
join prereq p
on c.course_id = p.course_id
where p.course_id='BIO-399'


/*
18.	Get a list of all the departments and their respective buildings.
*/

select 
d.dept_name, d.building
from department d





/*
19.	For each department find the Average salary in that department
*/

select dept_name,
   	avg(salary)
from  instructor
group by dept_name;

/*
20.	Select instructors from particular department
*/

select distinct
s.ID,
s.name,
s.dept_name

from instructor s
 join teaches t
on s.ID = t.ID
left join course c
on t.course_id = c.course_id
where s.dept_name='IDS';