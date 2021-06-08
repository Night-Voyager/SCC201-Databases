/*
 Data Transfer

 Author		: Hao Yukun
 LU ID		: 37532073
 BJTU ID	: 18722007

 Source File: LSH.db
 Date: 08/06/2021 09:39:01
*/

PRAGMA foreign_keys = false;

-- ----------------------------
-- Table structure for planets
-- ----------------------------
DROP TABLE IF EXISTS "planets";
CREATE TABLE "planets" (
  "planet_id" INTEGER,
  "name" VARCHAR(15),
  "popvalue" INTEGER,
  PRIMARY KEY ("planet_id")
);

-- ----------------------------
-- Records of planets
-- ----------------------------
INSERT INTO "planets" VALUES (1, 'Antares', 17);
INSERT INTO "planets" VALUES (2, 'Bgztl', 8);
INSERT INTO "planets" VALUES (3, 'Bismoll', 27);
INSERT INTO "planets" VALUES (4, 'Braal', 8);
INSERT INTO "planets" VALUES (5, 'Cargg', 20);
INSERT INTO "planets" VALUES (6, 'Colu', 30);
INSERT INTO "planets" VALUES (7, 'Daxam', 30);
INSERT INTO "planets" VALUES (8, 'Dryad', \N);
INSERT INTO "planets" VALUES (9, 'Durla', 10);
INSERT INTO "planets" VALUES (10, 'Earth', \N);
INSERT INTO "planets" VALUES (11, 'Hyrakius', \N);
INSERT INTO "planets" VALUES (12, 'Imsk', 27);
INSERT INTO "planets" VALUES (13, 'Krypton', 0);
INSERT INTO "planets" VALUES (14, 'Naltor', 27);
INSERT INTO "planets" VALUES (15, 'Orando', 8);
INSERT INTO "planets" VALUES (16, 'Phlon', \N);
INSERT INTO "planets" VALUES (17, 'Rimbor', 30);
INSERT INTO "planets" VALUES (18, 'Starhaven', 27);
INSERT INTO "planets" VALUES (19, 'Talok VIII', 27);
INSERT INTO "planets" VALUES (20, 'Teall', \N);
INSERT INTO "planets" VALUES (21, 'Tharr', 27);
INSERT INTO "planets" VALUES (22, 'Titan', \N);
INSERT INTO "planets" VALUES (23, 'Trom', 27);
INSERT INTO "planets" VALUES (24, 'Winath', 8);
INSERT INTO "planets" VALUES (25, 'Xanthu', \N);
INSERT INTO "planets" VALUES (26, 'Zoon', 34);

-- ----------------------------
-- Table structure for heroes
-- ----------------------------
DROP TABLE IF EXISTS "heroes";
CREATE TABLE "heroes" (
  "hero_id" INTEGER,
  "codename" VARCHAR(30),
  "secretIdentity" VARCHAR(30),
  "homeWorld_id" INTEGER,
  PRIMARY KEY ("hero_id"),
  FOREIGN KEY ("homeWorld_id") REFERENCES "planets" ("planet_id")
);

-- ----------------------------
-- Records of heroes
-- ----------------------------
INSERT INTO "heroes" VALUES (1, 'Cosmic Boy', 'Rokk Krinn ', 4);
INSERT INTO "heroes" VALUES (2, 'Lightning Lad ', 'Garth Ranzz ', 24);
INSERT INTO "heroes" VALUES (3, 'Saturn Girl ', 'Imra Ardeen ', 22);
INSERT INTO "heroes" VALUES (4, 'Triplicate Girl', 'Luornu Durgo ', 5);
INSERT INTO "heroes" VALUES (5, 'Phantom Girl', 'Tinya Wazzo ', 2);
INSERT INTO "heroes" VALUES (6, 'Superboy', 'Kal-El (a.k.a. Clark Kent) ', 13);
INSERT INTO "heroes" VALUES (7, 'Chameleon Boy', 'Reep Daggle ', 9);
INSERT INTO "heroes" VALUES (8, 'Colossal Boy ', 'Gim Allon ', 10);
INSERT INTO "heroes" VALUES (9, 'Invisible Kid ', 'Lyle Norg ', 10);
INSERT INTO "heroes" VALUES (10, 'Star Boy ', 'Thom Kallor ', 25);
INSERT INTO "heroes" VALUES (11, 'Kid Quantum ', 'James Cullen ', 1);
INSERT INTO "heroes" VALUES (12, 'Brainiac 5', 'Querl Dox ', 6);
INSERT INTO "heroes" VALUES (13, 'Supergirl ', 'Kara Zor-El', 13);
INSERT INTO "heroes" VALUES (14, 'Laurel Gand ', '', 7);
INSERT INTO "heroes" VALUES (15, 'Sun Boy ', 'Dirk Morgna ', 10);
INSERT INTO "heroes" VALUES (16, 'Shrinking Violet', 'Salu Digby ', 12);
INSERT INTO "heroes" VALUES (17, 'Bouncing Boy ', 'Chuck Taine ', 10);
INSERT INTO "heroes" VALUES (18, 'Ultra Boy', 'Jo Nah ', 17);
INSERT INTO "heroes" VALUES (19, 'Mon-El', 'Lar Gand ', 7);
INSERT INTO "heroes" VALUES (20, 'Matter-Eater Lad ', 'Tenzil Kem ', 3);
INSERT INTO "heroes" VALUES (21, 'Element Lad', 'Jan Arrah ', 21);
INSERT INTO "heroes" VALUES (22, 'Lightning Lass', 'Ayla Ranzz ', 24);
INSERT INTO "heroes" VALUES (23, 'Dream Girl ', 'Nura Nal ', 14);
INSERT INTO "heroes" VALUES (24, 'Ferro Lad ', 'Andrew Nolan ', 10);
INSERT INTO "heroes" VALUES (25, 'Karate Kid ', 'Val Armorr ', 10);
INSERT INTO "heroes" VALUES (26, 'Princess Projectra', 'Projectra Wind''zzor ', 15);
INSERT INTO "heroes" VALUES (27, 'Shadow Lass ', 'Tasmia Mallor ', 19);
INSERT INTO "heroes" VALUES (28, 'Chemical King ', 'Condo Arlik ', 16);
INSERT INTO "heroes" VALUES (29, 'Timber Wolf', 'Brin Londo ', 26);
INSERT INTO "heroes" VALUES (30, 'Wildfire', 'Drake Burroughs ', 10);
INSERT INTO "heroes" VALUES (31, 'Tyroc ', 'Troy Stewart ', 10);
INSERT INTO "heroes" VALUES (32, 'Dawnstar', '', 18);
INSERT INTO "heroes" VALUES (33, 'Blok ', '', 8);
INSERT INTO "heroes" VALUES (34, 'Invisible Kid II ', 'Jacques Foccart ', 10);
INSERT INTO "heroes" VALUES (35, 'White Witch', 'Mysa Nal ', 14);
INSERT INTO "heroes" VALUES (36, 'Magnetic Kid ', 'Pol Krinn ', 4);
INSERT INTO "heroes" VALUES (37, 'Polar Boy ', 'Brek Bannin ', 21);
INSERT INTO "heroes" VALUES (38, 'Quislet ', '(an unpronounceable glyph) ', 20);
INSERT INTO "heroes" VALUES (39, 'Tellus ', 'Ganglios ', 11);
INSERT INTO "heroes" VALUES (40, 'Hero on non-existant planet', 'Nobody', 473);

-- ----------------------------
-- Table structure for powers
-- ----------------------------
DROP TABLE IF EXISTS "powers";
CREATE TABLE "powers" (
  "hero_id" INTEGER,
  "description" VARCHAR (100),
  PRIMARY KEY ("hero_id", "description"),
  FOREIGN KEY ("hero_id") REFERENCES "heroes" ("hero_id")
);

-- ----------------------------
-- Records of powers
-- ----------------------------
INSERT INTO "powers" VALUES (1, 'Magnetism manipulation');
INSERT INTO "powers" VALUES (1, 'control and generation of magnetic fields');
INSERT INTO "powers" VALUES (2, 'Electrical manipulation');
INSERT INTO "powers" VALUES (2, 'control and generation of electrical fields');
INSERT INTO "powers" VALUES (3, 'Telepathy');
INSERT INTO "powers" VALUES (3, 'ability to read and control minds');
INSERT INTO "powers" VALUES (4, 'Ability to split into three bodies');
INSERT INTO "powers" VALUES (5, 'Intangibility');
INSERT INTO "powers" VALUES (6, 'Flight');
INSERT INTO "powers" VALUES (6, 'Invulnerability');
INSERT INTO "powers" VALUES (6, 'Superhuman Strength');
INSERT INTO "powers" VALUES (6, 'Superhuman Speed');
INSERT INTO "powers" VALUES (6, 'Super vision, consisting of');
INSERT INTO "powers" VALUES (6, 'X-Ray Vision');
INSERT INTO "powers" VALUES (6, 'Telescopic/Microscopic Vision');
INSERT INTO "powers" VALUES (6, 'Heat Vision');
INSERT INTO "powers" VALUES (6, 'Super-hearing');
INSERT INTO "powers" VALUES (6, 'Super Breath (including Freeze Breath)');
INSERT INTO "powers" VALUES (6, 'Eidetic memory');
INSERT INTO "powers" VALUES (6, 'Regeneration');
INSERT INTO "powers" VALUES (6, 'Longevity');
INSERT INTO "powers" VALUES (6, 'Other enhanced physical senses (including olfaction)');
INSERT INTO "powers" VALUES (7, 'Shapeshifting');
INSERT INTO "powers" VALUES (8, 'Ability to grow to gigantic size');
INSERT INTO "powers" VALUES (9, 'Invisibility to the naked eye');
INSERT INTO "powers" VALUES (10, 'Ability to increase the mass of objects');
INSERT INTO "powers" VALUES (11, 'Ability to cast stasis fields');
INSERT INTO "powers" VALUES (12, '12th level intelligence');
INSERT INTO "powers" VALUES (13, 'Flight');
INSERT INTO "powers" VALUES (13, 'Invulnerability');
INSERT INTO "powers" VALUES (13, 'Superhuman Strength');
INSERT INTO "powers" VALUES (13, 'Superhuman Speed');
INSERT INTO "powers" VALUES (13, 'Super vision, consisting of');
INSERT INTO "powers" VALUES (13, 'X-Ray Vision');
INSERT INTO "powers" VALUES (13, 'Telescopic/Microscopic Vision');
INSERT INTO "powers" VALUES (13, 'Heat Vision');
INSERT INTO "powers" VALUES (13, 'Super-hearing');
INSERT INTO "powers" VALUES (13, 'Super Breath (including Freeze Breath)');
INSERT INTO "powers" VALUES (13, 'Eidetic memory');
INSERT INTO "powers" VALUES (13, 'Regeneration');
INSERT INTO "powers" VALUES (13, 'Longevity');
INSERT INTO "powers" VALUES (13, 'Other enhanced physical senses (including olfaction)');
INSERT INTO "powers" VALUES (14, 'Flight');
INSERT INTO "powers" VALUES (14, 'Invulnerability');
INSERT INTO "powers" VALUES (14, 'Superhuman Strength');
INSERT INTO "powers" VALUES (14, 'Superhuman Speed');
INSERT INTO "powers" VALUES (14, 'Super vision, consisting of');
INSERT INTO "powers" VALUES (14, 'X-Ray Vision');
INSERT INTO "powers" VALUES (14, 'Telescopic/Microscopic Vision');
INSERT INTO "powers" VALUES (14, 'Heat Vision');
INSERT INTO "powers" VALUES (14, 'Super-hearing');
INSERT INTO "powers" VALUES (14, 'Super Breath (including Freeze Breath)');
INSERT INTO "powers" VALUES (14, 'Eidetic memory');
INSERT INTO "powers" VALUES (14, 'Regeneration');
INSERT INTO "powers" VALUES (14, 'Longevity');
INSERT INTO "powers" VALUES (14, 'Other enhanced physical senses (including olfaction)');
INSERT INTO "powers" VALUES (15, 'light generation');
INSERT INTO "powers" VALUES (15, 'Heat generation');
INSERT INTO "powers" VALUES (16, 'Ability to shrink to microscopic size');
INSERT INTO "powers" VALUES (17, 'Super-bouncing');
INSERT INTO "powers" VALUES (18, 'Super-strength');
INSERT INTO "powers" VALUES (18, 'super-speed');
INSERT INTO "powers" VALUES (18, 'flight');
INSERT INTO "powers" VALUES (18, 'invulnerability');
INSERT INTO "powers" VALUES (18, 'flash vision');
INSERT INTO "powers" VALUES (18, 'penetra-vision');
INSERT INTO "powers" VALUES (19, 'Flight');
INSERT INTO "powers" VALUES (19, 'Invulnerability');
INSERT INTO "powers" VALUES (19, 'Superhuman Strength');
INSERT INTO "powers" VALUES (19, 'Superhuman Speed');
INSERT INTO "powers" VALUES (19, 'Super vision, consisting of');
INSERT INTO "powers" VALUES (19, 'X-Ray Vision');
INSERT INTO "powers" VALUES (19, 'Telescopic/Microscopic Vision');
INSERT INTO "powers" VALUES (19, 'Heat Vision');
INSERT INTO "powers" VALUES (19, 'Super-hearing');
INSERT INTO "powers" VALUES (19, 'Super Breath (including Freeze Breath)');
INSERT INTO "powers" VALUES (19, 'Eidetic memory');
INSERT INTO "powers" VALUES (19, 'Regeneration');
INSERT INTO "powers" VALUES (19, 'Longevity');
INSERT INTO "powers" VALUES (19, 'Other enhanced physical senses (including olfaction)');
INSERT INTO "powers" VALUES (20, 'Can eat any substance');
INSERT INTO "powers" VALUES (21, 'Elemental transmutation');
INSERT INTO "powers" VALUES (22, 'Electrical manipulation');
INSERT INTO "powers" VALUES (22, 'control and generation of electrical fields');
INSERT INTO "powers" VALUES (23, 'Precognition');
INSERT INTO "powers" VALUES (24, 'Ability to transform into iron');
INSERT INTO "powers" VALUES (24, 'superhuman strength');
INSERT INTO "powers" VALUES (24, 'invulnerability');
INSERT INTO "powers" VALUES (25, 'Mastery of all known martial arts');
INSERT INTO "powers" VALUES (26, 'Generation of illusions');
INSERT INTO "powers" VALUES (27, 'Shadow-casting');
INSERT INTO "powers" VALUES (28, 'Control over the rate of chemical reactions');
INSERT INTO "powers" VALUES (29, 'Superhuman agility');
INSERT INTO "powers" VALUES (29, 'Superhuman strength');
INSERT INTO "powers" VALUES (30, 'Energy blasts');
INSERT INTO "powers" VALUES (30, 'Energy manipulation');
INSERT INTO "powers" VALUES (30, 'flight.');
INSERT INTO "powers" VALUES (31, 'Sonic power that creates unusual effects');
INSERT INTO "powers" VALUES (32, 'Interstellar tracking');
INSERT INTO "powers" VALUES (32, 'unaided space travel');
INSERT INTO "powers" VALUES (32, 'flight');
INSERT INTO "powers" VALUES (33, 'Superhuman strength');
INSERT INTO "powers" VALUES (33, 'Superhuman physical resistance');
INSERT INTO "powers" VALUES (500, 'deliberately wrong');
INSERT INTO "powers" VALUES (33, 'energy absorption');
INSERT INTO "powers" VALUES (34, 'Invisibility to the naked eye and to most forms of detection');
INSERT INTO "powers" VALUES (35, 'Spellcasting');
INSERT INTO "powers" VALUES (36, 'Magnetism manipulation');
INSERT INTO "powers" VALUES (36, 'ability to generate and control magnetic fields');
INSERT INTO "powers" VALUES (37, 'Cold manipulation');
INSERT INTO "powers" VALUES (37, 'ability to absorb heat and produce cold');
INSERT INTO "powers" VALUES (39, 'Telepathy');
INSERT INTO "powers" VALUES (39, 'telekinesis');

-- ----------------------------
-- Table structure for missions
-- ----------------------------
DROP TABLE IF EXISTS "missions";
CREATE TABLE "missions" (
  "name" VARCHAR (100),
  "planet_name" VARCHAR (15),
  PRIMARY KEY ("name"),
  FOREIGN KEY ("planet_name") REFERENCES "planets" ("name")
);

-- ----------------------------
-- Records of missions
-- ----------------------------
INSERT INTO "missions" VALUES ('Darkseid', 'Apocalypse');
INSERT INTO "missions" VALUES ('Earth War', 'Earth');
INSERT INTO "missions" VALUES ('Planet Kidnap', 'Daxam');
INSERT INTO "missions" VALUES ('Mission on non-existant planet', 'Zorgorn');

PRAGMA foreign_keys = true;
