create table Animals(

IdAnimal int,
NameAnimal text,
TypeAnimal text,
ColorAnimal text,
SexAnimal text,

PRIMARY KEY (IdAnimal),
);

create table Owner(

Surname text,
Name text,
Street text,
Cellphone int,

PRIMARY KEY (Surname, Name),
);

create table Address(

Street text,
CodePostal int,
City text,
PRIMARY KEY (
);

create table City(

City text,
NbHabitantsCity int,
CodeCity int,
);

create table HealthBook(

IdAnimal int,
Sterilized text,
YearBirth int,
Vaccine1 int,
Vaccine2 int,
Vaccine3 int,
);