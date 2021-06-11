/*
 Data Transfer

 Author		: Hao Yukun
 LU ID		: 37532073
 BJTU ID	: 18722007

 Source File: Northwind.db
 Date: 11/06/2021 02:14:34
*/

PRAGMA foreign_keys = false;

-- ----------------------------
-- Table structure for Categories
-- ----------------------------
DROP TABLE IF EXISTS "Categories";
CREATE TABLE "Categories" (
  "CategoryID" INT,
  "CategoryName" VARCHAR(15),
  "Description" TEXT,
  "Picture" BLOB,
  PRIMARY KEY ("CategoryID")
);

-- ----------------------------
-- Records of Categories
-- ----------------------------
INSERT INTO "Categories" VALUES (1, 'Beverages', 'Soft drinks, coffees, teas, beers, and ales', '/');
INSERT INTO "Categories" VALUES (2, 'Condiments', 'Sweet and savory sauces, relishes, spreads, and seasonings', '/');
INSERT INTO "Categories" VALUES (3, 'Confections', 'Desserts, candies, and sweet breads', '/');
INSERT INTO "Categories" VALUES (4, 'Dairy Products', 'Cheeses', '/');
INSERT INTO "Categories" VALUES (5, 'Grains/Cereals', 'Breads, crackers, pasta, and cereal', '/');
INSERT INTO "Categories" VALUES (6, 'Meat/Poultry', 'Prepared meats', '/');
INSERT INTO "Categories" VALUES (7, 'Produce', 'Dried fruit and bean curd', '/');
INSERT INTO "Categories" VALUES (8, 'Seafood', 'Seaweed and fish', '/');

-- ----------------------------
-- Table structure for CustomerCustomerDemo
-- ----------------------------
DROP TABLE IF EXISTS "CustomerCustomerDemo";
CREATE TABLE "CustomerCustomerDemo" (
  "CustomerID" VARCHAR(5),
  "CustomerTypeID" VARCHAR(10),
  PRIMARY KEY ("CustomerID", "CustomerTypeID")
);

-- ----------------------------
-- Records of CustomerCustomerDemo
-- ----------------------------

-- ----------------------------
-- Table structure for CustomerDemographics
-- ----------------------------
DROP TABLE IF EXISTS "CustomerDemographics";
CREATE TABLE "CustomerDemographics" (
  "CustomerTypeID" VARCHAR(10),
  "CustomerDesc" TEXT,
  PRIMARY KEY ("CustomerTypeID")
);

-- ----------------------------
-- Records of CustomerDemographics
-- ----------------------------

-- ----------------------------
-- Table structure for Customers
-- ----------------------------
DROP TABLE IF EXISTS "Customers";
CREATE TABLE "Customers" (
  "CustomerID" VARCHAR(5),
  "CompanyName" VARCHAR(40),
  "ContactName" VARCHAR(30),
  "ContactTitle" VARCHAR(30),
  "Address" VARCHAR(60),
  "City" VARCHAR(15),
  "Region" VARCHAR(15),
  "PostalCode" VARCHAR(10),
  "Country" VARCHAR(15),
  "Phone" VARCHAR(24),
  "Fax" VARCHAR(24),
  PRIMARY KEY ("CustomerID")
);
