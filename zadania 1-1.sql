-- Zadania 1-1 

--1. Wy�wietl nazwiska i roczne dochody pracownik�w 
select 
    p.nazwisko,
    p.placa_pod+NVL(placa_dod,0) * 12 as "wynagrodzenie"
from system.pracownicy p
;

--2. Wy�wietl ca�o�� informacji o zespo�ach sortuj�c wynik wed�ug nazw zespo��w 
select 
    *
from system.zespoly z
order by z.nazwa
;

--3. Wy�wietl list� etat�w bez duplikat�w 
select distinct
    p.etat
from system.pracownicy p
;

select
    e.nazwa
from system.etaty e
;

--4. wy�wietl wszystkie informacje o asystentach pracuj�cych w instytucie i posortuj ich wed�ug daty zatrudnienia(malej�co) 
select
    *
from system.pracownicy p
where p.etat = 'ASYSTENT'
order by
    p.zatrudniony desc
;

--5. wybierz tylko Id_prac, nazwisko i etat z zespo��w 30,40 w kolejno�ci rosn�cych zarobk�w 
select
    p.id_prac,
    p.nazwisko,
    p.etat
from system.pracownicy p
where p.id_zesp in (30,40)
order by
    p.placa_pod+NVL(placa_dod,0)
;

--6. wybierz dane o pracownikach kt�rych p�ace podstawowe mieszcz� si� w przedziale 300 do 800 
select
    *
from system.pracownicy p
where p.placa_pod between 300 and 800
;

--7. wy�wietl nazwisko, etat i p�ace podstawow� tych kt�rych nazwisko ko�czy si� na IK 
select
    p.nazwisko,
    p.etat,
    p.placa_pod
from system.pracownicy p
where p.nazwisko like '%IK'
;

--8. wy�wietl nazwisko i p�ace podstawow� tych kt�rzy zarabiaj� powy�ej 1000 z�otych i maj� szefa(tylko p�aca podstawowa) 
select
    p.nazwisko,
    p.placa_pod
from system.pracownicy p
where p.placa_pod+NVL(placa_dod,0) > 1000
  and p.id_szefa is not null
;

--9. wy�wietl nazwiska, etaty i stawki godzinowe tych pracownik�w, kt�rzy nie s� adiunktami ani asystentami ani sta�ystami 
--   i kt�rzy nie zarabiaj� w przedziale od 400 do 800 z�. 
--   Wyniki uszereguj wed�ug stawek godzinowych pracownik�w(przyjmij 20 dniowy miesi�c pracy i 8 godzinny dzie� pracy) (tylko p�aca podstawowa) 
select
    p.nazwisko,
    p.placa_pod / 20 / 8 as "stawka godzinowa"
   
from system.pracownicy p
where p.etat not in ('ADIUNKT', 'ASYSTENT', 'STAZYSTA')
  and p.placa_pod+NVL(placa_dod,0) not between 400 and 800
order by
    "stawka godzinowa"
;


--10. Poka� wszystkie informacje o pracownikach z liter� Y na ko�cu, kt�rzy nie maj� p�acy dodatkowej 
--    wyniki posortuj po 4 kolumnie malej�co 
select
    *
from system.pracownicy p
where p.nazwisko like '%Y'
  and p.placa_dod is null
order by
    4
;

--11. Poka� nazwiska wszystkich pracownik�w, kt�rych szefem jest pracownik o id 130 
select
    p.nazwisko
from system.pracownicy p
where p.id_szefa = 130
;

--12. Czy s� pracownicy, kt�rzy w ci�gu 5 lat sp�ac� samoch�d, kt�ry kosztowa� 24000 wiedz�c, 
--    �e mog� od�o�y� tylko po�ow� ze swojej pe�nej miesi�cznej pensji? Poka� ich nazwiska 
select
    p.nazwisko
from system.pracownicy p
where (p.placa_pod+NVL(placa_dod,0)) * 30 > 24000 -- 5 lat * 12 mies / 2 poowa pensji
;

--13. Poka� etaty na kt�re zmie�ci�y by si� osoby zarabiaj�ce 380. Skorzystaj z w�a�ciwej tabeli 
select 
    *
from system.etaty e
where 380 between e.placa_min and e.placa_max
--where  e.placa_min >= 380
;
