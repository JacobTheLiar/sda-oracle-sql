--Zadanie 3-1 

--1. Wy�wietl najni�sz� i najwy�sz� pensj� w firmie. Wy�wietl informacj� o r�nicy dziel�cej najlepiej i najgorzej zarabiaj�cych pracownik�w. 
select 
    min(p.placa_pod + nvl(p.placa_dod, 0)) as "p�aca minimalna",
    max(p.placa_pod + nvl(p.placa_dod, 0)) as "p�aca maksymalna",
    max(p.placa_pod + nvl(p.placa_dod, 0))
        - min(p.placa_pod + nvl(p.placa_dod, 0))
        as "r�nica p�ac max i min"
        
from system.pracownicy p
;

--2. Wy�wietl �rednie pensje dla wszystkich etat�w. Wyniki uporz�dkuj wg malej�cej �redniej pensji. 
select 
    p.etat,
    avg(p.placa_pod + nvl(p.placa_dod, 0)) as "�rednia pensja"

from system.pracownicy p

group by
    p.etat
;

--3. Wy�wietl liczb� profesor�w zatrudnionych w Instytucie 
select
    count(*) as "liczba profesor�w"
    
from system.pracownicy p    

where p.etat = 'PROFESOR'
;

--4. Znajd� sumaryczne miesi�czne p�ace dla ka�dego zespo�u. Nie zapomnij o p�acach dodatkowych. 
select 
    p.id_zesp,
    sum(p.placa_pod + nvl(p.placa_dod, 0)) as "sumaryczna pensja zespo�u"

from system.pracownicy p

group by
    p.id_zesp
;

--5. Dla ka�dego szefa wy�wietl pensj� najgorzej zarabiaj�cego podw�adnego. Wyniki uporz�dkuj wg malej�cej pensji. 
select
    p.id_szefa,
    min(p.placa_pod + nvl(p.placa_dod, 0)) as "najni�sza pensja podw�adnego"
    
from 
    system.pracownicy p

where 
    p.id_szefa is not null

group by 
    p.id_szefa
    
order by 
    2 desc
;

--6. Poka� ile �rednio zarobili przez ostatnie 5 lat profesorowie i adiunkci 
select
    p.etat,
    avg(p.placa_pod + nvl(p.placa_dod, 0))*60 as "srednio przez 5 lat"
    
from system.pracownicy p

where p.etat in ('PROFESOR','ADIUNKT')

group by
    p.etat
;

--7. Poka� ile zespo�y zarabia�by pieni�dzy, gdyby otrzyma�y podwy�k� dwukrotno�ci swojego id_zespo�u 
select
    p.id_zesp,
    count(*) as "ilo�� os�b",
    sum(p.placa_pod + nvl(p.placa_dod, 0)) as "suma zarobk�w zespo�u",
    sum(p.id_zesp*2) as "podwy�ka",
    sum(p.placa_pod + nvl(p.placa_dod, 0) + p.id_zesp*2) as "suma zarobk�w zespo�u z podwy�k�"
    
from system.pracownicy p

group by
    p.id_zesp
;

--8. Sprawd� ilu mamy pracownik�w z liter� O i R w nazwisku 
select
    case 
        when INSTR(p.nazwisko, 'O')>0 and INSTR(p.nazwisko, 'R')>0
        then 'OR'
        when INSTR(p.nazwisko, 'O')>0 
        then 'O'
        when INSTR(p.nazwisko, 'R')>0
        then 'R'
        else ' ' end as "litery",
    count(*) as "ilo�� os�b"
    
from system.pracownicy p

group by
    case 
        when INSTR(p.nazwisko, 'O')>0 and INSTR(p.nazwisko, 'R')>0
        then 'OR'
        when INSTR(p.nazwisko, 'O')>0 
        then 'O'
        when INSTR(p.nazwisko, 'R')>0
        then 'R'
        else ' ' end 
;

select
    'O' as "litera", 
    count(*) as "ilo�� os�b"
from system.pracownicy p
where INSTR(p.nazwisko, 'O')>0
union
select
    'R',
    count(*) as "ilo�� os�b"
from system.pracownicy p
where INSTR(p.nazwisko, 'R')>0
;

select
    count(*) as "ilo�� os�b"
from system.pracownicy p
where INSTR(p.nazwisko, 'O')>0
   or INSTR(p.nazwisko, 'R')>0
;

--9. Czy istnieje zesp�, kt�ry b�dzie zarabia� w sumie ponad 5000(placy podstawowej), gdy przez 10 lat b�dzie otrzymywa� 10% podwy�k�? Poka� id tych zespo��w 

select
    p.id_zesp
    
from system.pracownicy p

group by
    p.id_zesp
    
having 
    sum(p.placa_pod*power(1.1, 10))>5000
;
--10. Poka� maksymaln� i minimaln� p�ac� dla pracownik�w zatrudnionych przed 2000 rokiem i maj�cych szefa z id r�wnym 100 lub 130 
select
    min(p.placa_pod) as "minimalne wynagrodzenie",
    max(p.placa_pod) as "maksymalne wynagrodzenie"
from system.pracownicy p

where extract(year from p.zatrudniony)<2000
  and p.id_szefa in (100, 130)

