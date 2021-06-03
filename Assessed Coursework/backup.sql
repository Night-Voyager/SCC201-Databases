/*
 Data Transfer

 Author		: Hao Yukun
 LU ID		: 37532073
 BJTU ID	: 18722007

 Date: 04/06/2021 02:09:56
*/

-- ----------------------------
-- Table structure for department
-- ----------------------------
DROP TABLE IF EXISTS `department`;
CREATE TABLE `department` (
  `d_id` VARCHAR(5),
  `d_title` VARCHAR(10),
  `location` VARCHAR(15),
  PRIMARY KEY (`d_id`, ),
);

-- ----------------------------
-- Table structure for staff
-- ----------------------------
DROP TABLE IF EXISTS `staff`;
CREATE TABLE `staff` (
  `s_id` VARCHAR(4),
  `initials` VARCHAR (4),
  `s_name` VARCHAR(15),
  `pos` VARCHAR(15),
  `qual` VARCHAR(5),
  `d_id` VARCHAR(5),
  PRIMARY KEY (`s_id`, ),
  FOREIGN KEY (`d_id`) REFERENCES `department` (`d_id`), 
);

-- ----------------------------
-- Table structure for courses
-- ----------------------------
DROP TABLE IF EXISTS `courses`;
CREATE TABLE `courses` (
  `c_id` VARCHAR(3),
  `c_title` VARCHAR(30),
  `code` VARCHAR(4),
  `year` VARCHAR(4),
  `d_id` VARCHAR(5),
  PRIMARY KEY (`c_id`, ),
  FOREIGN KEY (`d_id`) REFERENCES `department` (`d_id`), 
);

-- ----------------------------
-- Table structure for projects
-- ----------------------------
DROP TABLE IF EXISTS `projects`;
CREATE TABLE `projects` (
  `p_id` VARCHAR(10),
  `p_title` VARCHAR(30),
  `funder` VARCHAR(10),
  `funding` INT,
  PRIMARY KEY (`p_id`, ),
);

-- ----------------------------
-- Table structure for give_course
-- ----------------------------
DROP TABLE IF EXISTS `give_course`;
CREATE TABLE `give_course` (
  `s_id` VARCHAR(4),
  `c_id` VARCHAR(3),
  PRIMARY KEY (`s_id`, `c_id`, ),
  FOREIGN KEY (`c_id`) REFERENCES `courses` (`c_id`), 
  FOREIGN KEY (`s_id`) REFERENCES `staff` (`s_id`), 
);

-- ----------------------------
-- Table structure for work_on
-- ----------------------------
DROP TABLE IF EXISTS `work_on`;
CREATE TABLE `work_on` (
  `s_id` VARCHAR(4),
  `p_id` VARCHAR(10),
  `start_date` INT,
  `stop_date` INT,
  PRIMARY KEY (`s_id`, `p_id`, ),
  FOREIGN KEY (`p_id`) REFERENCES `projects` (`p_id`), 
  FOREIGN KEY (`s_id`) REFERENCES `staff` (`s_id`), 
);
