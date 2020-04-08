drop table if exists osoba
create table osoba
(
id_osoba int primary key identity,
imie varchar(15) not null,
nazwisko varchar(30) not null,
pesel varchar(30) unique not null,
data_ur date,
pensja int,
check (year(getdate()) - year(data_ur) >=18),
check(pensja >= 1111)
)


go
create trigger popraw_imie
on osoba
after insert
as
	declare @imiee varchar(15) = (select lower(imie) from inserted),
		@id int = (select id_osoba from inserted)
	set @imiee = upper(left(@imiee,1)) + lower(substring(@imiee,2,len(@imiee)))
	begin
		update osoba set imie = @imiee
		where id_osoba = @id
	end
go


create trigger popraw_nazwisko
on osoba
after insert
as
	declare @nazwisko varchar(30) = (select lower(nazwisko) from inserted),
		@id int = (select id_osoba from inserted),
		@i int = 2,
		@chr varchar(1),
		@nazwiskoo varchar(25)
	set @nazwisko = upper(left(@nazwisko,1))+lower(substring(@nazwisko, 2,len(@nazwisko)))
	set @nazwiskoo = @nazwisko

	while @i<=len(@nazwisko)
	begin
		set @chr = substring(@nazwiskoo, @i-1, 1)
		set @nazwisko = @nazwisko
		if(@chr = '-')
		begin
			set @nazwisko = substring(@nazwisko,1,@i-1)+(upper(substring(@nazwisko,@i,1))+lower(substring(@nazwisko,@i+1,len(@nazwisko))))
		end
		set @i = @i+1
	end
	begin
		update osoba set nazwisko = @nazwisko
		where id_osoba = @id
	end
go




insert into osoba values
(
'adam','pawlacz-pawulon','23123123','1997-12-23',3000
)
insert into osoba values
(
'bronis³aw','tab','23123124','1997-12-23',2000
)
insert into osoba values
(
'cecylia','shift','23123125','2001-12-23',3000
)

select * from osoba

drop table if exists osoba_historia
create table osoba_historia
(
	id_osoba int,
	imie varchar(15) not null,
	nazwisko varchar(30) not null,
	pesel varchar(30) unique not null,
	data_ur date,
	pensja int,
	operacja varchar(1),
	data date
)

go
create trigger after_del
on osoba
after delete
as
begin
	insert into osoba_historia (id_osoba, imie, nazwisko, pesel, data_ur, pensja, operacja, data)
	select d.id_osoba, d.imie, d.nazwisko, d.pesel, d.data_ur, d.pensja, 'D', getdate()
	from deleted d
end
go

go
create trigger after_upd
on osoba
after update
as
begin
	insert into osoba_historia (id_osoba, imie, nazwisko, pesel, data_ur, pensja, operacja, data)
	select d.id_osoba, d.imie, d.nazwisko, d.pesel, d.data_ur, d.pensja, 'U', getdate()
	from deleted d
end
go

delete from osoba where id_osoba = 2
update osoba set imie = 'Janusz' where id_osoba = 1
select * from osoba_historia
select * from osoba
