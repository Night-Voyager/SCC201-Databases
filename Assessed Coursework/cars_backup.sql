/*
 Data Transfer

 Author		: Hao Yukun
 LU ID		: 37532073
 BJTU ID	: 18722007

 Source File: cars.db
 Date: 17/06/2021 10:08:00
*/

PRAGMA foreign_keys = false;

-- ----------------------------
-- Table structure for model
-- ----------------------------
DROP TABLE IF EXISTS "model";
CREATE TABLE "model" (
  "model_id" INTEGER,
  "manu" VARCHAR(15),
  "range" VARCHAR(15),
  "model" VARCHAR(30),
  PRIMARY KEY ("model_id")
);

-- ----------------------------
-- Records of model
-- ----------------------------
INSERT INTO "model" VALUES (1, 'Honda', 'Jazz', 'S');
INSERT INTO "model" VALUES (2, 'Honda', 'Jazz', 'S A/C');
INSERT INTO "model" VALUES (3, 'Honda', 'Jazz', 'S-T');
INSERT INTO "model" VALUES (4, 'Honda', 'Jazz', 'S-T A/C');
INSERT INTO "model" VALUES (5, 'Volkswagon', 'Up!', 'Take up!');
INSERT INTO "model" VALUES (6, 'Volkswagon', 'Up!', 'Move up!');
INSERT INTO "model" VALUES (7, 'Volkswagon', 'Up!', 'High up!');
INSERT INTO "model" VALUES (8, 'Honda', 'Civic', '1.4 i-VTEC (Petrol) Manual');
INSERT INTO "model" VALUES (9, 'Honda', 'Civic', '1.6 i_DTEC (Diesel) Manual');
INSERT INTO "model" VALUES (10, 'Honda', 'Civic', '1.8 i-VTEC (Petrol) Automatic');
INSERT INTO "model" VALUES (11, 'Honda', 'Civic', '2.2 i-DTEC (Diesel) Manual');

-- ----------------------------
-- Table structure for car
-- ----------------------------
DROP TABLE IF EXISTS "car";
CREATE TABLE "car" (
  "car_id" INTEGER,
  "model_id" INTEGER,
  "reg_num" VARCHAR(10),
  "mileage" INTEGER,
  PRIMARY KEY ("car_id"),
  FOREIGN KEY ("model_id") REFERENCES "model" ("model_id")
);

-- ----------------------------
-- Records of car
-- ----------------------------
INSERT INTO "car" VALUES (1, 1, 'aa111gfd', 28000);
INSERT INTO "car" VALUES (2, 1, 'bb222jhg', 5000);
INSERT INTO "car" VALUES (3, 5, 'zz999qwe', 30000);
INSERT INTO "car" VALUES (4, 6, 'sw76qpr', 10000);
INSERT INTO "car" VALUES (5, 2, 'kj87wer', 50007);

-- ----------------------------
-- Table structure for features
-- ----------------------------
DROP TABLE IF EXISTS "features";
CREATE TABLE "features" (
  "model_id" INTEGER,
  "description" VARCHAR(40),
  PRIMARY KEY ("model_id", "description"),
  FOREIGN KEY ("model_id") REFERENCES "model" ("model_id")
);

-- ----------------------------
-- Records of features
-- ----------------------------
INSERT INTO "features" VALUES (1, 'Active front headrests');
INSERT INTO "features" VALUES (1, 'Anti-Lock Breaking System');
INSERT INTO "features" VALUES (2, 'Active front headrests');
INSERT INTO "features" VALUES (2, 'Anti-Lock Breaking System');
INSERT INTO "features" VALUES (2, 'A/C - manual air conditioning');
INSERT INTO "features" VALUES (3, 'Active front headrests');
INSERT INTO "features" VALUES (3, 'Anti-Lock Breaking System');
INSERT INTO "features" VALUES (3, 'Hands-free phone system');
INSERT INTO "features" VALUES (5, 'Airbags');
INSERT INTO "features" VALUES (5, 'Rear headrest, adjustable x 2');
INSERT INTO "features" VALUES (6, 'Airbags');
INSERT INTO "features" VALUES (6, 'Rear headrest, adjustable x 2');
INSERT INTO "features" VALUES (6, 'A/C - manual air conditioning');
INSERT INTO "features" VALUES (6, 'Central Locking');
INSERT INTO "features" VALUES (7, 'Airbags');
INSERT INTO "features" VALUES (7, 'Rear headrest, adjustable x 2');
INSERT INTO "features" VALUES (7, 'A/C - manual air conditioning');
INSERT INTO "features" VALUES (7, 'Central Locking');
INSERT INTO "features" VALUES (7, 'Touch Screen Navigation');

-- ----------------------------
-- Table structure for employees
-- ----------------------------
DROP TABLE IF EXISTS "employees";
CREATE TABLE "employees" (
  "emp_id" INTEGER,
  "name" VARCHAR(40),
  "dept" VARCHAR(20),
  "manager_id" INTEGER,
  PRIMARY KEY ("emp_id"),
  FOREIGN KEY ("manager_id") REFERENCES "employees" ("emp_id")
);

-- ----------------------------
-- Records of employees
-- ----------------------------
INSERT INTO "employees" VALUES (1, 'Sherridan', 'Design', NULL);
INSERT INTO "employees" VALUES (2, 'Ivanova', 'Production', NULL);
INSERT INTO "employees" VALUES (3, 'Garibaldi', 'Design', 1);
INSERT INTO "employees" VALUES (4, 'Mollari', 'Production', 20);

-- ----------------------------
-- Table structure for owner
-- ----------------------------
DROP TABLE IF EXISTS "owner";
CREATE TABLE "owner" (
  "owner_id" INTEGER,
  "name" VARCHAR(15),
  "car_id" INTEGER,
  PRIMARY KEY ("owner_id", "car_id"),
  FOREIGN KEY ("owner_id") REFERENCES "employees" ("emp_id"),
  FOREIGN KEY ("car_id") REFERENCES "car" ("car_id")
);

-- ----------------------------
-- Records of owner
-- ----------------------------
INSERT INTO "owner" VALUES (1, 'Picard', 1);
INSERT INTO "owner" VALUES (1, 'Picard', 2);
INSERT INTO "owner" VALUES (2, 'Worf', 3);
INSERT INTO "owner" VALUES (3, 'Troi', 4);
INSERT INTO "owner" VALUES (4, 'Riker', 5);

-- ----------------------------
-- Indexes structure for table employees
-- ----------------------------
CREATE UNIQUE INDEX "emp_name"
ON "employees" (
  "name"
);

-- ----------------------------
-- Indexes structure for table owner
-- ----------------------------
CREATE UNIQUE INDEX "owner_car"
ON "owner" (
  "car_id"
);

PRAGMA foreign_keys = true;
