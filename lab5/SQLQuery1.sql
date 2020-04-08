drop table if exists adres
drop table if exists klient

create table klient
(
id_klient int primary key identity,
imie varchar(15) not null,
nazwisko varchar(30) not null,
data_ur date
)
create table adres
(
id_adres int primary key identity,
id_klient int foreign key references klient(id_klient),
miasto varchar(30),
ulica varchar(30)
)
insert into klient values('Tomasz','Hajto','1990-12-12')
insert into klient values('Roman','Polanski','1942-12-12')
insert into klient values('Mateusz','Kot','1962-12-12')
insert into klient values('Janusz','Pawulonik','1992-12-12')
insert into klient values('Bartek','Maupa','1990-12-12')


insert into adres values(1,'Kraków','Podwale')
insert into adres values(2,'Gdañsk','Nadwale')
insert into adres values(3,'Warszawa','Odwale')
insert into adres values(4,'Wroc³aw','Spodwale')
insert into adres values(5,'Kraków','Mickiewicza')


select * from klient
select * from adres

