CREATE TABLE Animals(

IdAnimal int,
NameAnimal text,
TypeAnimal text,
ColorAnimal text,
SexAnimal text,

PRIMARY KEY (IdAnimal));

CREATE TABLE Owner(

IdAnimal text,
Surname text,
Name text,
Cellphone int,
Street text,
City text,
PostalCode int,

PRIMARY KEY (Cellphone));

CREATE TABLE City(

City text,
NbHabitantsCity int,
DepartmentCode int,

PRIMARY KEY (City));

CREATE TABLE HealthBook(

IdAnimal int,
Sterilized text,
YearOfBirth int,
Vaccine1 int,
Vaccine2 int,
Vaccine3 int,

PRIMARY KEY (IdAnimal));
