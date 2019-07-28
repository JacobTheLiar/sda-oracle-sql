-- Zadanie 2-2

--    1. Oblicz kiedy ka¿dy z pracowników pójdzie na emeryturê zak³adaj¹c, ¿e musi przepracowaæ 35 lat i 6 miesiêcy 
--       aby ów œwiadczenia otrzymaæ. Nastêpnie poka¿ ile dni ka¿demu z nich brakuje do emerytury.
select
    p.nazwisko as "nazwisko",
    to_char(p.zatrudniony, 'yyyy-mm-dd') as "zatrudniony dnia",
    to_char(ADD_Months(p.zatrudniony, 426), 'yyyy-mm-dd') as "dzieñ emerytury",
    ADD_Months(p.zatrudniony, 426) - trunc(SYSDATE) as "dni do emerytury"

from system.pracownicy p
;

--    2. Nape³nij nadziej¹ sta¿ystów i oblicz ile bêd¹ zarabiali za 10 lat je¿eli ka¿dego roku 
--       otrzymaj¹ 5% podwy¿kê p³acy podstawowej(kapitalizuje siê co roku!), a co dwa i pó³ roku ich p³aca dodatkowa wzroœnie o  2.5% p³acy podstawowej.
select
    p.nazwisko as "nazwisko",
    round(p.placa_pod + nvl(p.placa_dod, 0), 2) as "p³aca dziœ",
    round(p.placa_pod*power(1.05, 10) + nvl(p.placa_dod, 0)*power(1.025, 4), 2) as "p³aca za 10 lat"

from system.pracownicy p
;

--    3. Wszystkich tych, którzy w nazwisku posiadaj¹ literê „O” nagródŸ podwy¿k¹ p³acy dodatkowej 
--       zwiêkszaj¹c j¹ o 10 %. Nie zapomnij o tych, którzy nie maj¹ p³acy dodatkowej i daj im 150 z³ bonusu. 
--       Wyniki zaokr¹gli do drugiego miejsca po przecinku zgodnie z zasadami matematyki.
select
    p.nazwisko as "nazwisko",
    round(p.placa_pod + nvl(p.placa_dod, 0), 2) as "p³aca",
    case 
        when instr(p.nazwisko, 'O')>0
        then round(nvl(p.placa_dod*0.1, 150), 2)
        end as "bonus",
    case 
        when instr(p.nazwisko, 'O')>0
        then round(p.placa_pod + nvl(p.placa_dod*1.1, 150), 2)
        else round(p.placa_pod + nvl(p.placa_dod, 0), 2)
        end as "p³aca + bonus"

from system.pracownicy p
;

--    4. Oblicz ile dni minê³o pomiêdzy  01-01-1980 a dat¹ zatrudnienia ka¿dego pracownika. 
--       W kolejnej kolumnie dodaj informacjê TAK, jeœli liczba dni przekracza 11000.
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

--    5. Jak przez najbli¿sze 3 lata bêd¹ kszta³towa³y siê ca³kowite zarobki wszystkich 
--       pracowników jeœli za³o¿ymy, ¿e ka¿dy z nich w roku raz  otrzyma podwy¿kê 4% od p³ac podstawowej. 
--       Wyp³aty zaokr¹glij do dwóch miejsc po przecinku. Poka¿ nazwisko, p³acê podstawow¹ i wyp³atê ka¿dego roku.
select
    p.nazwisko as "nazwisko",
    round(p.placa_pod + nvl(p.placa_dod, 0), 2) as "p³aca teraz",
    round(p.placa_pod * 1.04 + nvl(p.placa_dod, 0), 2) as "p³aca za rok",
    round(p.placa_pod * power(1.04, 2) + nvl(p.placa_dod, 0), 2) as "p³aca 2 lata",
    round(p.placa_pod * power(1.04, 3) + nvl(p.placa_dod, 0), 2) as "p³aca 3 lata"

from system.pracownicy p
;


--    6. Utwórz kod sk³adaj¹cy siê z du¿ej drugiej litery nazwiska, ma³ej 3 litery etatu i nr zespo³u podniesionego do drugiej potêgi
select
    p.nazwisko,
    p.etat,
    p.id_zesp,
    UPPER(SUBSTR(p.nazwisko,2,1))
        || LOWER(SUBSTR(p.etat, 3, 1))
        || POWER(p.id_zesp, 2) as "userCode"
        
from system.pracownicy p
;

--    7. Poka¿ ile miesiêcy ka¿dy z pracowników musi czekaæ, by zarobiæ 40000 wiedz¹c, ¿e mo¿e odk³adaæ ze swojej pensji po 50%
select
    p.nazwisko as "nazwisko",
    ceil(40000 / (p.placa_pod + nvl(p.placa_dod, 0)/2)) as "liczba miesiêcy by zarobiæ 40000"
    
from system.pracownicy p
;

--    8. Poka¿ w osobnych kolumnach nazwisko, miesi¹c(s³ownie), rok i dzieñ dla pracowników, 
--       których liczba liter w nazwisku jest mniejsza ni¿ 8 i maj¹ literê „A” lub „E” w etacie
select
    p.nazwisko as "nazwisko",
    extract(year from p.zatrudniony) as "rok",
    extract(month from p.zatrudniony) as "miesi¹c",
    extract(day from p.zatrudniony) as "dzieñ"
from system.pracownicy p
where length(p.nazwisko)<8
  and (
    instr(p.nazwisko, 'A')>0
    or
    instr(p.nazwisko, 'E')>0
    )
;
--    9. SprawdŸ czy suma placy podstawowej, dodatkowej, id_prac i id_zesp daje liczbê podzieln¹ przez 3. 
--       W osobnej kolumnie napisz TAK lub NIE dla ka¿dego pracownika
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

--    10. Poka¿ jak prezentowa³by siê etaty, gdyby pracownicy ze sta¿em ponad 10 letnim na dzieñ 01-01-2005 
--        byliby automatycznie profesorami, ze sta¿em od 7 lat asystentami a pozostali stazystami.

select
    p.nazwisko as "nazwisko",
    p.zatrudniony,
    p.etat,
    months_between(to_Date('2005-01-01', 'yyyy-mm-dd'), p.zatrudniony) as "miesi¹ce",
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
