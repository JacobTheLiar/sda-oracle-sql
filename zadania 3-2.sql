--Zadanie 3-2

--1. Wy�wietl numery zespo��w� wraz z liczb� pracownik�w w ka�dym zespole. Wyniki uporz�dkuj wg malej�cej liczby pracownik�w.
select
    p.id_zesp,
    count(*) as "liczba pracownik�w"
    
from system.pracownicy p

group by 
    p.id_zesp

order by
    "liczba pracownik�w" desc
;

--2.�Zmodyfikuj zapytanie z zadania 1, aby wy�wietli� numery tylko tych zespo��w, kt�re zatrudniaj� wi�cej ni� 3 pracownik�w.
select
    p.id_zesp,
    count(*) as "liczba pracownik�w"
    
from system.pracownicy p

group by 
    p.id_zesp
    
having 
    count(*)>3
    
order by
    "liczba pracownik�w" desc
;

--3.�Zbuduj zapytanie, kt�re wy�wietli �rednie i maksymalne pensje podstawowe asystent�w i profesor�w w poszczeg�lnych zespo�ach. 
--   Dokonaj zaokr�glenia pensji do warto�ci ca�kowitych. Wynik zapytania posortuj wg identyfikator�w zespo��w i nazw etat�w.
select
    p.id_zesp, 
    p.etat,
    round(avg(p.placa_pod)) as "�rednia p�aca",
    round(max(p.placa_pod)) as "maksymalna p�aca"
    
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

--4.�Zbuduj zapytanie, kt�re wy�wietli, ilu pracownik�w zosta�o zatrudnionych w poszczeg�lnych latach. Wynik posortuj rosn�co ze wzgl�du na rok zatrudnienia.
select
    extract(year from p.zatrudniony) as "rok",
    count(*) as "liczba zatrudnionych"
    
from system.pracownicy p

group by 
    extract(year from p.zatrudniony)
    
order by
    1
;

--5.�Zbuduj zapytanie, kt�re policzy liczb� liter w nazwiskach pracownik�w i wy�wietli liczb� nazwisk z dan� liczb� liter. 
select
    length(p.nazwisko) as "d�ugo�c nazwiska",
    count(*) as "liczba os�b"
    
from system.pracownicy p 

group by length(p.nazwisko)
;

--6. Policz ilu pracownik�w by�o zatrudnionych w poszczeg�lnych miesi�cach poszczeg�lnych lat.
select
    to_char(p.zatrudniony, 'yyyy, month') as "miesi�c zatrudnienia",
    count(*) as "liczba zatrudnionych"
    
from system.pracownicy p

group by 
    to_char(p.zatrudniony, 'yyyy, month') 
    
order by
    1
;

--7. Pogrupuj pracownik�w ze wzgl�du na ich ostatni� liter� w nazwisku. Poka� ilo�� pracownik�w z poszczeg�ln� liter�
select
    SUBSTR(p.nazwisko,length(p.nazwisko),1) as "ostatnia litera nazwiska",
    count(*) as "libcz pracownik�w"
    
from system.pracownicy p

group by 
    SUBSTR(p.nazwisko,length(p.nazwisko),1)
;