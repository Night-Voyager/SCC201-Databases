CREATE TABLE planets (planet_id integer, name varchar(15) unique not null, popvalue integer,
primary key(planet_id));
CREATE TABLE heroes(hero_id integer, codename varchar(30), secretIdentity varchar(30),
homeWorld_id integer, primary key(hero_id),
foreign key (homeWorld_id) references planets (planet_id)
);
CREATE TABLE powers(hero_id integer, description varchar (100),
primary key (hero_id, description),
foreign key (hero_id) references heroes(hero_id)
);
CREATE TABLE missions (name varchar (100), planet_name varchar (15) not null, primary key (name),
foreign key (planet_name) references planets(name)
);
