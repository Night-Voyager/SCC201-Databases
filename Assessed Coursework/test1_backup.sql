/*
 Data Transfer

 Author		: Hao Yukun
 LU ID		: 37532073
 BJTU ID	: 18722007

 Source File: test1.db
 Date: 16/06/2021 11:15:39
*/

PRAGMA foreign_keys = false;

-- ----------------------------
-- Table structure for Course
-- ----------------------------
DROP TABLE IF EXISTS "Course";
CREATE TABLE "Course" (
  "Cid" INTEGER(20),
  "Cname" TEXT(20),
  "Tid" INTEGER(20),
  PRIMARY KEY ("Cid")
);

-- ----------------------------
-- Records of Course
-- ----------------------------
INSERT INTO "Course" VALUES (1, '6d617468', 2);
INSERT INTO "Course" VALUES (2, '736369656e6365', 1);
INSERT INTO "Course" VALUES (3, '706879736963', 5);
INSERT INTO "Course" VALUES (4, '656e676c697368', 3);
INSERT INTO "Course" VALUES (5, '616c7973696365', 4);
INSERT INTO "Course" VALUES (6, '6d617468', 1);
INSERT INTO "Course" VALUES (7, '6e6574776f726b', 3);
INSERT INTO "Course" VALUES (8, '636f6d7075746572', 4);

-- ----------------------------
-- Table structure for Student
-- ----------------------------
DROP TABLE IF EXISTS "Student";
CREATE TABLE "Student" (
  "Sid" INTEGER(20),
  "Sname" TEXT(30),
  PRIMARY KEY ("Sid")
);

-- ----------------------------
-- Records of Student
-- ----------------------------
INSERT INTO "Student" VALUES (1, '71');
INSERT INTO "Student" VALUES (2, '61');
INSERT INTO "Student" VALUES (3, '77');
INSERT INTO "Student" VALUES (4, '7a');
INSERT INTO "Student" VALUES (5, '65');
INSERT INTO "Student" VALUES (6, '64');
INSERT INTO "Student" VALUES (7, '72');
INSERT INTO "Student" VALUES (8, '63');
INSERT INTO "Student" VALUES (9, '73');

-- ----------------------------
-- Table structure for Teacher
-- ----------------------------
DROP TABLE IF EXISTS "Teacher";
CREATE TABLE "Teacher" (
  "Tid" INTEGER(3),
  "Tname" TEXT(20),
  PRIMARY KEY ("Tid")
);

-- ----------------------------
-- Records of Teacher
-- ----------------------------
INSERT INTO "Teacher" VALUES (1, '6161');
INSERT INTO "Teacher" VALUES (2, '6262');
INSERT INTO "Teacher" VALUES (3, '6363');
INSERT INTO "Teacher" VALUES (4, '6464');
INSERT INTO "Teacher" VALUES (5, '6565');

-- ----------------------------
-- Table structure for SC
-- ----------------------------
DROP TABLE IF EXISTS "SC";
CREATE TABLE "SC" (
  "Sid" INTEGER(20),
  "Cid" INTEGER(20),
  "Grade" INTEGER(20),
  PRIMARY KEY ("Sid", "Cid"),
  FOREIGN KEY ("Cid") REFERENCES "Course" ("Cid"),
  FOREIGN KEY ("Sid") REFERENCES "Student" ("Sid")
);

-- ----------------------------
-- Records of SC
-- ----------------------------
INSERT INTO "SC" VALUES (1, 1, 90);
INSERT INTO "SC" VALUES (1, 2, 80);
INSERT INTO "SC" VALUES (2, 1, 60);
INSERT INTO "SC" VALUES (2, 2, 70);
INSERT INTO "SC" VALUES (3, 3, 88);
INSERT INTO "SC" VALUES (4, 5, 66);
INSERT INTO "SC" VALUES (5, 4, 100);

PRAGMA foreign_keys = true;
