/*
 Data Transfer

 Author		: Hao Yukun
 LU ID		: 37532073
 BJTU ID	: 18722007

 Source File: test1.db
 Date: 10/06/2021 08:36:06
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
INSERT INTO "Course" VALUES (1, 'math', 2);
INSERT INTO "Course" VALUES (2, 'science', 1);
INSERT INTO "Course" VALUES (3, 'physic', 5);
INSERT INTO "Course" VALUES (4, 'english', 3);
INSERT INTO "Course" VALUES (5, 'alysice', 4);
INSERT INTO "Course" VALUES (6, 'math', 1);
INSERT INTO "Course" VALUES (7, 'network', 3);
INSERT INTO "Course" VALUES (8, 'computer', 4);

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
INSERT INTO "Student" VALUES (1, 'q');
INSERT INTO "Student" VALUES (2, 'a');
INSERT INTO "Student" VALUES (3, 'w');
INSERT INTO "Student" VALUES (4, 'z');
INSERT INTO "Student" VALUES (5, 'e');
INSERT INTO "Student" VALUES (6, 'd');
INSERT INTO "Student" VALUES (7, 'r');
INSERT INTO "Student" VALUES (8, 'c');
INSERT INTO "Student" VALUES (9, 's');

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
INSERT INTO "Teacher" VALUES (1, 'aa');
INSERT INTO "Teacher" VALUES (2, 'bb');
INSERT INTO "Teacher" VALUES (3, 'cc');
INSERT INTO "Teacher" VALUES (4, 'dd');
INSERT INTO "Teacher" VALUES (5, 'ee');

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
