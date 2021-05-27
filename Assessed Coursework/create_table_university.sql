CREATE TABLE department (d_id varchar(5) primary key, d_title varchar(10), location varchar(15));
CREATE TABLE staff (s_id varchar(4) primary key, initials varchar (4), s_name varchar(15), pos varchar(15), qual varchar(5), d_id varchar(5), foreign key(d_id) references department(d_id));
CREATE TABLE courses (c_id varchar(3) primary key, c_title varchar(30), code varchar(4), year varchar(4), d_id varchar(5), foreign key(d_id) references department(d_id));
CREATE TABLE projects (p_id varchar(10) primary key, p_title varchar(30), funder varchar(10), funding int);
CREATE TABLE give_course (s_id varchar(4), c_id varchar(3), primary key (s_id, c_id), foreign key(s_id) references staff(s_id), foreign key (c_id) references courses(c_id));
CREATE TABLE work_on (s_id varchar(4), p_id varchar(10), start_date int, stop_date int, primary key(s_id, p_id), foreign key(s_id) references staff(s_id), foreign key (p_id) references projects(p_id)
);
