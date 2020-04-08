drop table if exists osoba_historia
create table osoba_historia
(
	id_osoba int primary key identity,
	imie varchar(15) not null,
	nazwisko varchar(30) not null,
	pesel varchar(30) unique not null,
	data_ur date,
	pensja int,
	operacja varchar(1),
	data date
)

go
create trigger after_update
on osoba
after update
as
begin
insert into osoba_historia (id_osoba, imie, nazwisko, pesel, data_ur, pensja, operacja, data)
values ()