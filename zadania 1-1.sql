-- Zadania 1-1 

--1. Wyœwietl nazwiska i roczne dochody pracowników 
select 
    p.nazwisko,
    p.placa_pod+NVL(placa_dod,0) * 12 as "wynagrodzenie"
from system.pracownicy p
;

--2. Wyœwietl ca³oœæ informacji o zespo³ach sortuj¹c wynik wed³ug nazw zespo³ów 
select 
    *
from system.zespoly z
order by z.nazwa
;

--3. Wyœwietl listê etatów bez duplikatów 
select distinct
    p.etat
from system.pracownicy p
;

select
    e.nazwa
from system.etaty e
;

--4. wyœwietl wszystkie informacje o asystentach pracuj¹cych w instytucie i posortuj ich wed³ug daty zatrudnienia(malej¹co) 
select
    *
from system.pracownicy p
where p.etat = 'ASYSTENT'
order by
    p.zatrudniony desc
;

--5. wybierz tylko Id_prac, nazwisko i etat z zespo³ów 30,40 w kolejnoœci rosn¹cych zarobków 
select
    p.id_prac,
    p.nazwisko,
    p.etat
from system.pracownicy p
where p.id_zesp in (30,40)
order by
    p.placa_pod+NVL(placa_dod,0)
;

--6. wybierz dane o pracownikach których p³ace podstawowe mieszcz¹ siê w przedziale 300 do 800 
select
    *
from system.pracownicy p
where p.placa_pod between 300 and 800
;

--7. wyœwietl nazwisko, etat i p³ace podstawow¹ tych których nazwisko koñczy siê na IK 
select
    p.nazwisko,
    p.etat,
    p.placa_pod
from system.pracownicy p
where p.nazwisko like '%IK'
;

--8. wyœwietl nazwisko i p³ace podstawow¹ tych którzy zarabiaj¹ powy¿ej 1000 z³otych i maj¹ szefa(tylko p³aca podstawowa) 
select
    p.nazwisko,
    p.placa_pod
from system.pracownicy p
where p.placa_pod+NVL(placa_dod,0) > 1000
  and p.id_szefa is not null
;

--9. wyœwietl nazwiska, etaty i stawki godzinowe tych pracowników, którzy nie s¹ adiunktami ani asystentami ani sta¿ystami 
--   i którzy nie zarabiaj¹ w przedziale od 400 do 800 z³. 
--   Wyniki uszereguj wed³ug stawek godzinowych pracowników(przyjmij 20 dniowy miesi¹c pracy i 8 godzinny dzieñ pracy) (tylko p³aca podstawowa) 
select
    p.nazwisko,
    p.placa_pod / 20 / 8 as "stawka godzinowa"
   
from system.pracownicy p
where p.etat not in ('ADIUNKT', 'ASYSTENT', 'STAZYSTA')
  and p.placa_pod+NVL(placa_dod,0) not between 400 and 800
order by
    "stawka godzinowa"
;


--10. Poka¿ wszystkie informacje o pracownikach z liter¹ Y na koñcu, którzy nie maj¹ p³acy dodatkowej 
--    wyniki posortuj po 4 kolumnie malej¹co 
select
    *
from system.pracownicy p
where p.nazwisko like '%Y'
  and p.placa_dod is null
order by
    4
;

--11. Poka¿ nazwiska wszystkich pracowników, których szefem jest pracownik o id 130 
select
    p.nazwisko
from system.pracownicy p
where p.id_szefa = 130
;

--12. Czy s¹ pracownicy, którzy w ci¹gu 5 lat sp³ac¹ samochód, który kosztowa³ 24000 wiedz¹c, 
--    ¿e mog¹ od³o¿yæ tylko po³owê ze swojej pe³nej miesiêcznej pensji? Poka¿ ich nazwiska 
select
    p.nazwisko
from system.pracownicy p
where (p.placa_pod+NVL(placa_dod,0)) * 30 > 24000 -- 5 lat * 12 mies / 2 poowa pensji
;

--13. Poka¿ etaty na które zmieœci³y by siê osoby zarabiaj¹ce 380. Skorzystaj z w³aœciwej tabeli 
select 
    *
from system.etaty e
where 380 between e.placa_min and e.placa_max
--where  e.placa_min >= 380
;
