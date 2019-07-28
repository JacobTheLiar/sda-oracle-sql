--Zadanie 3-2

--1. Wyœwietl numery zespo³ów  wraz z liczb¹ pracowników w ka¿dym zespole. Wyniki uporz¹dkuj wg malej¹cej liczby pracowników.
select
    p.id_zesp,
    count(*) as "liczba pracowników"
    
from system.pracownicy p

group by 
    p.id_zesp

order by
    "liczba pracowników" desc
;

--2. Zmodyfikuj zapytanie z zadania 1, aby wyœwietliæ numery tylko tych zespo³ów, które zatrudniaj¹ wiêcej ni¿ 3 pracowników.
select
    p.id_zesp,
    count(*) as "liczba pracowników"
    
from system.pracownicy p

group by 
    p.id_zesp
    
having 
    count(*)>3
    
order by
    "liczba pracowników" desc
;

--3. Zbuduj zapytanie, które wyœwietli œrednie i maksymalne pensje podstawowe asystentów i profesorów w poszczególnych zespo³ach. 
--   Dokonaj zaokr¹glenia pensji do wartoœci ca³kowitych. Wynik zapytania posortuj wg identyfikatorów zespo³ów i nazw etatów.
select
    p.id_zesp, 
    p.etat,
    round(avg(p.placa_pod)) as "œrednia p³aca",
    round(max(p.placa_pod)) as "maksymalna p³aca"
    
from system.pracownicy p

where
    p.etat in ('PROFESOR','ASYSTENT') 
    
group by 
    p.id_zesp, 
    p.etat

order by
    p.id_zesp, 
    p.etat
;

--4. Zbuduj zapytanie, które wyœwietli, ilu pracowników zosta³o zatrudnionych w poszczególnych latach. Wynik posortuj rosn¹co ze wzglêdu na rok zatrudnienia.
select
    extract(year from p.zatrudniony) as "rok",
    count(*) as "liczba zatrudnionych"
    
from system.pracownicy p

group by 
    extract(year from p.zatrudniony)
    
order by
    1
;

--5. Zbuduj zapytanie, które policzy liczbê liter w nazwiskach pracowników i wyœwietli liczbê nazwisk z dan¹ liczb¹ liter. 
select
    length(p.nazwisko) as "d³ugoœc nazwiska",
    count(*) as "liczba osób"
    
from system.pracownicy p 

group by length(p.nazwisko)
;

--6. Policz ilu pracowników by³o zatrudnionych w poszczególnych miesi¹cach poszczególnych lat.
select
    to_char(p.zatrudniony, 'yyyy, month') as "miesi¹c zatrudnienia",
    count(*) as "liczba zatrudnionych"
    
from system.pracownicy p

group by 
    to_char(p.zatrudniony, 'yyyy, month') 
    
order by
    1
;

--7. Pogrupuj pracowników ze wzglêdu na ich ostatni¹ literê w nazwisku. Poka¿ iloœæ pracowników z poszczególn¹ liter¹
select
    SUBSTR(p.nazwisko,length(p.nazwisko),1) as "ostatnia litera nazwiska",
    count(*) as "libcz pracowników"
    
from system.pracownicy p

group by 
    SUBSTR(p.nazwisko,length(p.nazwisko),1)
;