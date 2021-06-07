/*
 Data Transfer

 Author		: Hao Yukun
 LU ID		: 37532073
 BJTU ID	: 18722007

 Date: 07/06/2021 07:44:07
*/

PRAGMA foreign_keys = false;

-- ----------------------------
-- Table structure for department
-- ----------------------------
DROP TABLE IF EXISTS `department`;
CREATE TABLE `department` (
  `d_id` VARCHAR(5),
  `d_title` VARCHAR(10),
  `location` VARCHAR(15),
  PRIMARY KEY (`d_id`)
);

-- ----------------------------
-- Records of department
-- ----------------------------
INSERT INTO `department` VALUES (`COMP`, `Computing`, `SECAMS Building`);
INSERT INTO `department` VALUES (`NEXT`, `Nextology`, `Nexto Building`);

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
  PRIMARY KEY (`s_id`),
  FOREIGN KEY (`d_id`) REFERENCES `department` (`d_id`)
);

-- ----------------------------
-- Records of staff
-- ----------------------------
INSERT INTO `staff` VALUES (`JF`, `J. `, `Finney`, `Lecturer`, `PhD`, `COMP`);
INSERT INTO `staff` VALUES (`JAM`, `J.A. `, `Mariani`, `Senior Lecturer`, `PhD`, `COMP`);
INSERT INTO `staff` VALUES (`GSB`, `G.S. `, `Blair`, `Senior Lecturer`, `PhD`, `COMP`);
INSERT INTO `staff` VALUES (`ND`, `N. `, `Davies`, `Professor`, `PhD`, `COMP`);
INSERT INTO `staff` VALUES (`BB`, `B. `, `Bear`, `Professor`, `BA`, `NEXT`);

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
  PRIMARY KEY (`c_id`),
  FOREIGN KEY (`d_id`) REFERENCES `department` (`d_id`)
);

-- ----------------------------
-- Records of courses
-- ----------------------------
INSERT INTO `courses` VALUES (`MM`, `Multimedia Systems`, `361`, `3rd`, `COMP`);
INSERT INTO `courses` VALUES (`IOS`, `Introduction to Operating Systems`, `112c`, `1st`, `COMP`);
INSERT INTO `courses` VALUES (`DB`, `Databases`, `242`, `2nd`, `COMP`);
INSERT INTO `courses` VALUES (`PA`, `Programming in Assembler`, `111a`, `1st`, `COMP`);
INSERT INTO `courses` VALUES (`BN`, `Basic Nextology`, `110`, `1st`, `NEXT`);

-- ----------------------------
-- Table structure for projects
-- ----------------------------
DROP TABLE IF EXISTS `projects`;
CREATE TABLE `projects` (
  `p_id` VARCHAR(10),
  `p_title` VARCHAR(30),
  `funder` VARCHAR(10),
  `funding` INT,
  PRIMARY KEY (`p_id`)
);

-- ----------------------------
-- Records of projects
-- ----------------------------
INSERT INTO `projects` VALUES (`COMIC`, `COMIC`, `ESPRIT`, 100000);
INSERT INTO `projects` VALUES (`OSCAR`, `OSCAR`, `SERC`, 23400);
INSERT INTO `projects` VALUES (`GUIDE`, `Guide`, `SERC`, 34100);
INSERT INTO `projects` VALUES (`MCSCW`, `Multimedia and CSCW`, `SERC`, 19782);
INSERT INTO `projects` VALUES (`AN`, `Advanced Nextology`, `NERC`, 51200);

-- ----------------------------
-- Table structure for give_course
-- ----------------------------
DROP TABLE IF EXISTS `give_course`;
CREATE TABLE `give_course` (
  `s_id` VARCHAR(4),
  `c_id` VARCHAR(3),
  PRIMARY KEY (`s_id`, `c_id`),
  FOREIGN KEY (`c_id`) REFERENCES `courses` (`c_id`),
  FOREIGN KEY (`s_id`) REFERENCES `staff` (`s_id`)
);

-- ----------------------------
-- Records of give_course
-- ----------------------------
INSERT INTO `give_course` VALUES (`JF`, `MM`);
INSERT INTO `give_course` VALUES (`ND`, `MM`);
INSERT INTO `give_course` VALUES (`GSB`, `IOS`);
INSERT INTO `give_course` VALUES (`JAM`, `DB`);
INSERT INTO `give_course` VALUES (`JAM`, `PA`);
INSERT INTO `give_course` VALUES (`BB`, `BN`);

-- ----------------------------
-- Table structure for work_on
-- ----------------------------
DROP TABLE IF EXISTS `work_on`;
CREATE TABLE `work_on` (
  `s_id` VARCHAR(4),
  `p_id` VARCHAR(10),
  `start_date` INT,
  `stop_date` INT,
  PRIMARY KEY (`s_id`, `p_id`),
  FOREIGN KEY (`p_id`) REFERENCES `projects` (`p_id`),
  FOREIGN KEY (`s_id`) REFERENCES `staff` (`s_id`)
);

-- ----------------------------
-- Records of work_on
-- ----------------------------
INSERT INTO `work_on` VALUES (`JAM`, `COMIC`, 1994, 1998);
INSERT INTO `work_on` VALUES (`JAM`, `OSCAR`, 1989, 1991);
INSERT INTO `work_on` VALUES (`ND`, `GUIDE`, 1997, 1999);
INSERT INTO `work_on` VALUES (`JF`, `GUIDE`, 1998, 1999);
INSERT INTO `work_on` VALUES (`GSB`, `MCSCW`, 1990, 1994);
INSERT INTO `work_on` VALUES (`BB`, `AN`, 1985, 1989);

PRAGMA foreign_keys = true;
