-- Zadanie 2-2

--    1. Oblicz kiedy ka�dy z pracownik�w p�jdzie na emerytur� zak�adaj�c, �e musi przepracowa� 35 lat i 6 miesi�cy 
--       aby �w �wiadczenia otrzyma�. Nast�pnie poka� ile dni ka�demu z nich brakuje do emerytury.
select
    p.nazwisko as "nazwisko",
    to_char(p.zatrudniony, 'yyyy-mm-dd') as "zatrudniony dnia",
    to_char(ADD_Months(p.zatrudniony, 426), 'yyyy-mm-dd') as "dzie� emerytury",
    ADD_Months(p.zatrudniony, 426) - trunc(SYSDATE) as "dni do emerytury"

from system.pracownicy p
;

--    2. Nape�nij nadziej� sta�yst�w i oblicz ile b�d� zarabiali za 10 lat je�eli ka�dego roku 
--       otrzymaj� 5% podwy�k� p�acy podstawowej(kapitalizuje si� co roku!), a co dwa i p� roku ich p�aca dodatkowa wzro�nie o  2.5% p�acy podstawowej.
select
    p.nazwisko as "nazwisko",
    round(p.placa_pod + nvl(p.placa_dod, 0), 2) as "p�aca dzi�",
    round(p.placa_pod*power(1.05, 10) + nvl(p.placa_dod, 0)*power(1.025, 4), 2) as "p�aca za 10 lat"

from system.pracownicy p
;

--    3. Wszystkich tych, kt�rzy w nazwisku posiadaj� liter� �O� nagr�d� podwy�k� p�acy dodatkowej 
--       zwi�kszaj�c j� o 10 %. Nie zapomnij o tych, kt�rzy nie maj� p�acy dodatkowej i daj im 150 z� bonusu. 
--       Wyniki zaokr�gli do drugiego miejsca po przecinku zgodnie z zasadami matematyki.
select
    p.nazwisko as "nazwisko",
    round(p.placa_pod + nvl(p.placa_dod, 0), 2) as "p�aca",
    case 
        when instr(p.nazwisko, 'O')>0
        then round(nvl(p.placa_dod*0.1, 150), 2)
        end as "bonus",
    case 
        when instr(p.nazwisko, 'O')>0
        then round(p.placa_pod + nvl(p.placa_dod*1.1, 150), 2)
        else round(p.placa_pod + nvl(p.placa_dod, 0), 2)
        end as "p�aca + bonus"

from system.pracownicy p
;

--    4. Oblicz ile dni min�o pomi�dzy  01-01-1980 a dat� zatrudnienia ka�dego pracownika. 
--       W kolejnej kolumnie dodaj informacj� TAK, je�li liczba dni przekracza 11000.
select
    p.nazwisko as "nazwisko",
    trunc(p.zatrudniony - to_date('1980-01-01', 'yyyy-mm-dd')) as "zatrudniony po dniach",
    case 
        when trunc(p.zatrudniony - to_date('1980-01-01', 'yyyy-mm-dd'))>10000
        then 'TAK'
        else ' '
        end as "po czasie"

from system.pracownicy p
;

--    5. Jak przez najbli�sze 3 lata b�d� kszta�towa�y si� ca�kowite zarobki wszystkich 
--       pracownik�w je�li za�o�ymy, �e ka�dy z nich w roku raz  otrzyma podwy�k� 4% od p�ac podstawowej. 
--       Wyp�aty zaokr�glij do dw�ch miejsc po przecinku. Poka� nazwisko, p�ac� podstawow� i wyp�at� ka�dego roku.
select
    p.nazwisko as "nazwisko",
    round(p.placa_pod + nvl(p.placa_dod, 0), 2) as "p�aca teraz",
    round(p.placa_pod * 1.04 + nvl(p.placa_dod, 0), 2) as "p�aca za rok",
    round(p.placa_pod * power(1.04, 2) + nvl(p.placa_dod, 0), 2) as "p�aca 2 lata",
    round(p.placa_pod * power(1.04, 3) + nvl(p.placa_dod, 0), 2) as "p�aca 3 lata"

from system.pracownicy p
;


--    6. Utw�rz kod sk�adaj�cy si� z du�ej drugiej litery nazwiska, ma�ej 3 litery etatu i nr zespo�u podniesionego do drugiej pot�gi
select
    p.nazwisko,
    p.etat,
    p.id_zesp,
    UPPER(SUBSTR(p.nazwisko,2,1))
        || LOWER(SUBSTR(p.etat, 3, 1))
        || POWER(p.id_zesp, 2) as "userCode"
        
from system.pracownicy p
;

--    7. Poka� ile miesi�cy ka�dy z pracownik�w musi czeka�, by zarobi� 40000 wiedz�c, �e mo�e odk�ada� ze swojej pensji po 50%
select
    p.nazwisko as "nazwisko",
    ceil(40000 / (p.placa_pod + nvl(p.placa_dod, 0)/2)) as "liczba miesi�cy by zarobi� 40000"
    
from system.pracownicy p
;

--    8. Poka� w osobnych kolumnach nazwisko, miesi�c(s�ownie), rok i dzie� dla pracownik�w, 
--       kt�rych liczba liter w nazwisku jest mniejsza ni� 8 i maj� liter� �A� lub �E� w etacie
select
    p.nazwisko as "nazwisko",
    extract(year from p.zatrudniony) as "rok",
    extract(month from p.zatrudniony) as "miesi�c",
    extract(day from p.zatrudniony) as "dzie�"
from system.pracownicy p
where length(p.nazwisko)<8
  and (
    instr(p.nazwisko, 'A')>0
    or
    instr(p.nazwisko, 'E')>0
    )
;
--    9. Sprawd� czy suma placy podstawowej, dodatkowej, id_prac i id_zesp daje liczb� podzieln� przez 3. 
--       W osobnej kolumnie napisz TAK lub NIE dla ka�dego pracownika
select
    p.nazwisko as "nazwisko",
    round(p.placa_pod + nvl(p.placa_dod, 0) + p.id_prac + p.id_zesp) as "suma",
    case
        when mod(round(p.placa_pod + nvl(p.placa_dod, 0) + p.id_prac + p.id_zesp), 3)=0
        then 'TAK'
        else ' '
        end as "podzielna przez 3"
 from system.pracownicy p
;

--    10. Poka� jak prezentowa�by si� etaty, gdyby pracownicy ze sta�em ponad 10 letnim na dzie� 01-01-2005 
--        byliby automatycznie profesorami, ze sta�em od 7 lat asystentami a pozostali stazystami.

select
    p.nazwisko as "nazwisko",
    p.zatrudniony,
    p.etat,
    months_between(to_Date('2005-01-01', 'yyyy-mm-dd'), p.zatrudniony) as "miesi�ce",
    case
        when months_between(to_Date('2005-01-01', 'yyyy-mm-dd'), p.zatrudniony)>120
        then 'PROFESOR'
        when months_between(to_Date('2005-01-01', 'yyyy-mm-dd'), p.zatrudniony)>84
        then 'ASYSTENT'
        when months_between(to_Date('2005-01-01', 'yyyy-mm-dd'), p.zatrudniony)>0
        then 'STAZYSTA'
        else ' '
        end as "stanowiska"
 from system.pracownicy p
