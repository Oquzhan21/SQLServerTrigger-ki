create database grup2
use grup2
create table sayilar(
sayi int,
us int
)
create table eski_deger(
sayi int,
us int
)
insert into sayilar values(2,3)
insert into sayilar values(3,4)
insert into sayilar values(4,2)
insert into sayilar values(12,2)
insert into sayilar values(11,2)
insert into sayilar values(15,2)
Select * from sayilar

--sayinin karesini hesaplayan fonksiyon
create function sayi_kare(@sayi int)
returns int 
as 
begin
	declare @kare int 
	set @kare=@sayi*@sayi 
	return(@kare)
end
select dbo.sayi_kare(6) as kare
select sayi,dbo.sayi_kare(sayi) as Sonuc from sayilar
----------sayinin �s de�erini hesaplatma-------------------------------
create function us_hesaplama(@sayi int,@us int)
returns int
as
begin
	declare @sonuc int=1
	while(@us>0)
	begin
		set @sonuc =@sonuc*@sayi
		set @us-=1
	end
	return(@sonuc)
	end

	select dbo.us_hesaplama(2,6) as Yan�t
	Select *,dbo.us_hesaplama(sayi,us) as Yan�t from sayilar
	--trigger(Kay�t eklendikten sonra veri giri�i yap�ld� mesaj� verecek)--
	create trigger trg_kayit
	on sayilar after insert
	as 
	print 'Veri giri�i yap�ld�'
	
	insert into sayilar values(6,3)

	--G�ncelleme k�s�tlama
	--Say�lar tablosunda g�ncelleme yapmak yerine
	--G�ncelleme yetkiniz yok diyen trigger
    create trigger trg_guncelleme
	on sayilar instead of update
	as
	print 'Yetkin yok'

	update sayilar set sayi=5 where sayi=6
	--Say�lardan silinenler silenen_sayilara eklensin--
	create table silinen_sayilar(
		sayi int,
		us int
		)
	create trigger trg_silineniekleme
	on sayilar after delete
	as
	begin
	declare @s_sayi int, @s_us int
	Select @s_sayi=sayi, @s_us=us from deleted
	insert into silinen_sayilar values(@s_sayi,@s_us)
	end 

	select * from sayilar
	select * from silinen_sayilar 
	delete from sayilar where sayi=2 and us=4
	disable trigger trg_guncelleme on sayilar
	update sayilar set sayi=17 where sayi=15
	--G�ncellenen verinin eski de�erini
	--ba�ka bir tabloya kay�t olarak ekler trigger--
	create trigger trg_eski_deger
	on sayilar after update
	as
	begin
	declare @g_sayi int, @g_us int
	Select @g_sayi=sayi, @g_us=us from deleted
	insert into eski_deger values(@g_sayi,@g_us)
	end 

	select * from eski_deger

	

