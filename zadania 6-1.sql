--Zadanie 6-1
--    1. Poka� sum� plac dla ka�dego zespo�u z podsumowaniem
select
    id_zesp, sum(p.placa_pod+nvl(p.placa_dod, 0)) zarobki
from pracownicy p
group by rollup(id_zesp);

--    2. Otrzymaj poni�szy efekt w zapytaniu
select
    case 
        when grouping(id_zesp)=1
        then 'RAZEM'
        else cast(id_zesp as varchar(4))
        end as "zesp�", 
    sum(p.placa_pod+nvl(p.placa_dod, 0)) "suma"
from pracownicy p
group by rollup(id_zesp)
;

--    3. Dla ka�dego zespo�u i etatu poka� �redni� p�ac� podstawow� wraz z podsumowaniami dla ka�dej podgrupy. 
--       Usu� podsumowanie dla ca�o�ci

select 
    p.id_zesp,
    p.etat,
    round(AVG(p.placa_pod), 2) as "�rednia p�. pod."
from pracownicy p
group by 
    rollup(p.id_zesp, p.etat)
having 
    grouping_id(p.id_zesp, p.etat)<=2
;

--    4. Dla ka�dego zespo�u i etatu poka� �redni� p�ac� z podsumowaniami. Uzyskaj poni�szy wynik

select 
    case 
        when grouping(id_zesp)=1
        then 'RAZEM'
        else cast(id_zesp as varchar(4))
        end as "zesp�", 
    case grouping_id(p.id_zesp, p.etat)
        when 1 then 'podsumownaie '|| cast(id_zesp as varchar(4))
        when 3 then '-----------'
        else p.etat end  as "etat",
    round(AVG(p.placa_pod), 2) as "�rednia p�. pod."
from pracownicy p
group by 
    rollup(p.id_zesp, p.etat)
;

--    5. Poka� w jedym zapytaniu sum� p�ac dla adiunkt�w i asystent�w z zespo�u 20 i 30 podsumowuj�c sumy zar�wno 
--       dla zespo��w jak i dla asystent�w. Poka� tylko te podsumowania, kt�re maj� warto�� wi�ksz� od 1300

--    TODO: poprawi� by si� nie wy�wietla�o podsumownaie adiunkta
select 
    p.id_zesp,
    p.etat,
    sum(p.placa_pod)
from pracownicy p
where p.id_zesp in (20, 30)
  and p.etat in ('ADIUNKT', 'ASYSTENT')
group by cube(
    p.id_zesp,
    p.etat)
having 
        sum(p.placa_pod)>1300 
    or 
        grouping(p.etat)=0
    
order by 1, 2            
;

--    6. Poka� miejsca pracy profesor�w i adiunkt�w z zespo�u 20,30 i 40 wraz z podsumowaniami ich sumy placy 
--       podstawowej i placy dodatkowej. W osobnej kolumnie napisz s�owo �PODSUMOWANIE�, gdy wiersz podsumowuje kt�r�� z grup, wykorzystaj do tego funkcje GROUPING. Skorzystaj te� z funkcji DECODE

select
    case
        when grouping(z.adres)=1
        then '--PODSUMOWANIE'
        else z.adres 
        end as "adres",
    case
        when grouping(p.etat)=1
        then '--PODSUMOWANIE'
        else p.etat
        end as "etat",
    sum(p.placa_pod+nvl(p.placa_dod, 0)) as "zarobki"
from pracownicy p
    join zespoly z
        on z.id_zesp = p.id_zesp

where p.id_zesp in (20, 30, 40)
  and p.etat in ('PROFESOR','ADIUNKT')
group by
    rollup(z.adres, p.etat)
;


--    7. Poka� tylko 2 i 3 poziom podsumowania dla sum p�ac podstawowych id_zesp i etat�w dla sta�yst�w i sekretarek

select
    p.id_zesp,
    p.etat,
    sum(p.placa_pod) as "suma"
from pracownicy p
where p.etat in ('STAZYSTA','SEKRETARKA')
group by rollup(
    p.id_zesp,
    p.etat
)
having grouping_id(p.id_zesp, p.etat) > 1



