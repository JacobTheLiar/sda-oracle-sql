--Zadanie 3-1 

--1. Wyœwietl najni¿sz¹ i najwy¿sz¹ pensjê w firmie. Wyœwietl informacjê o ró¿nicy dziel¹cej najlepiej i najgorzej zarabiaj¹cych pracowników. 
select 
    min(p.placa_pod + nvl(p.placa_dod, 0)) as "p³aca minimalna",
    max(p.placa_pod + nvl(p.placa_dod, 0)) as "p³aca maksymalna",
    max(p.placa_pod + nvl(p.placa_dod, 0))
        - min(p.placa_pod + nvl(p.placa_dod, 0))
        as "ró¿nica p³ac max i min"
        
from system.pracownicy p
;

--2. Wyœwietl œrednie pensje dla wszystkich etatów. Wyniki uporz¹dkuj wg malej¹cej œredniej pensji. 
select 
    p.etat,
    avg(p.placa_pod + nvl(p.placa_dod, 0)) as "œrednia pensja"

from system.pracownicy p

group by
    p.etat
;

--3. Wyœwietl liczbê profesorów zatrudnionych w Instytucie 
select
    count(*) as "liczba profesorów"
    
from system.pracownicy p    

where p.etat = 'PROFESOR'
;

--4. ZnajdŸ sumaryczne miesiêczne p³ace dla ka¿dego zespo³u. Nie zapomnij o p³acach dodatkowych. 
select 
    p.id_zesp,
    sum(p.placa_pod + nvl(p.placa_dod, 0)) as "sumaryczna pensja zespo³u"

from system.pracownicy p

group by
    p.id_zesp
;

--5. Dla ka¿dego szefa wyœwietl pensjê najgorzej zarabiaj¹cego podw³adnego. Wyniki uporz¹dkuj wg malej¹cej pensji. 
select
    p.id_szefa,
    min(p.placa_pod + nvl(p.placa_dod, 0)) as "najni¿sza pensja podw³adnego"
    
from 
    system.pracownicy p

where 
    p.id_szefa is not null

group by 
    p.id_szefa
    
order by 
    2 desc
;

--6. Poka¿ ile œrednio zarobili przez ostatnie 5 lat profesorowie i adiunkci 
select
    p.etat,
    avg(p.placa_pod + nvl(p.placa_dod, 0))*60 as "srednio przez 5 lat"
    
from system.pracownicy p

where p.etat in ('PROFESOR','ADIUNKT')

group by
    p.etat
;

--7. Poka¿ ile zespo³y zarabia³by pieniêdzy, gdyby otrzyma³y podwy¿kê dwukrotnoœci swojego id_zespo³u 
select
    p.id_zesp,
    count(*) as "iloœæ osób",
    sum(p.placa_pod + nvl(p.placa_dod, 0)) as "suma zarobków zespo³u",
    sum(p.id_zesp*2) as "podwy¿ka",
    sum(p.placa_pod + nvl(p.placa_dod, 0) + p.id_zesp*2) as "suma zarobków zespo³u z podwy¿k¹"
    
from system.pracownicy p

group by
    p.id_zesp
;

--8. SprawdŸ ilu mamy pracowników z liter¹ O i R w nazwisku 
select
    case 
        when INSTR(p.nazwisko, 'O')>0 and INSTR(p.nazwisko, 'R')>0
        then 'OR'
        when INSTR(p.nazwisko, 'O')>0 
        then 'O'
        when INSTR(p.nazwisko, 'R')>0
        then 'R'
        else ' ' end as "litery",
    count(*) as "iloœæ osób"
    
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
    count(*) as "iloœæ osób"
from system.pracownicy p
where INSTR(p.nazwisko, 'O')>0
union
select
    'R',
    count(*) as "iloœæ osób"
from system.pracownicy p
where INSTR(p.nazwisko, 'R')>0
;

select
    count(*) as "iloœæ osób"
from system.pracownicy p
where INSTR(p.nazwisko, 'O')>0
   or INSTR(p.nazwisko, 'R')>0
;

--9. Czy istnieje zespó³, który bêdzie zarabia³ w sumie ponad 5000(placy podstawowej), gdy przez 10 lat bêdzie otrzymywa³ 10% podwy¿kê? Poka¿ id tych zespo³ów 

select
    p.id_zesp
    
from system.pracownicy p

group by
    p.id_zesp
    
having 
    sum(p.placa_pod*power(1.1, 10))>5000
;
--10. Poka¿ maksymaln¹ i minimaln¹ p³acê dla pracowników zatrudnionych przed 2000 rokiem i maj¹cych szefa z id równym 100 lub 130 
select
    min(p.placa_pod) as "minimalne wynagrodzenie",
    max(p.placa_pod) as "maksymalne wynagrodzenie"
from system.pracownicy p

where extract(year from p.zatrudniony)<2000
  and p.id_szefa in (100, 130)

