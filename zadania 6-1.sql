--Zadanie 6-1
--    1. Poka¿ sumê plac dla ka¿dego zespo³u z podsumowaniem
select
    id_zesp, sum(p.placa_pod+nvl(p.placa_dod, 0)) zarobki
from pracownicy p
group by rollup(id_zesp);

--    2. Otrzymaj poni¿szy efekt w zapytaniu
select
    case 
        when grouping(id_zesp)=1
        then 'RAZEM'
        else cast(id_zesp as varchar(4))
        end as "zespó³", 
    sum(p.placa_pod+nvl(p.placa_dod, 0)) "suma"
from pracownicy p
group by rollup(id_zesp)
;

--    3. Dla ka¿dego zespo³u i etatu poka¿ œredni¹ p³acê podstawow¹ wraz z podsumowaniami dla ka¿dej podgrupy. 
--       Usuñ podsumowanie dla ca³oœci

select 
    p.id_zesp,
    p.etat,
    round(AVG(p.placa_pod), 2) as "œrednia p³. pod."
from pracownicy p
group by 
    rollup(p.id_zesp, p.etat)
having 
    grouping_id(p.id_zesp, p.etat)<=2
;

--    4. Dla ka¿dego zespo³u i etatu poka¿ œredni¹ p³acê z podsumowaniami. Uzyskaj poni¿szy wynik

select 
    case 
        when grouping(id_zesp)=1
        then 'RAZEM'
        else cast(id_zesp as varchar(4))
        end as "zespó³", 
    case grouping_id(p.id_zesp, p.etat)
        when 1 then 'podsumownaie '|| cast(id_zesp as varchar(4))
        when 3 then '-----------'
        else p.etat end  as "etat",
    round(AVG(p.placa_pod), 2) as "œrednia p³. pod."
from pracownicy p
group by 
    rollup(p.id_zesp, p.etat)
;

--    5. Poka¿ w jedym zapytaniu sumê p³ac dla adiunktów i asystentów z zespo³u 20 i 30 podsumowuj¹c sumy zarówno 
--       dla zespo³ów jak i dla asystentów. Poka¿ tylko te podsumowania, które maj¹ wartoœæ wiêksz¹ od 1300
select 
    p.id_zesp,
    p.etat,
    sum(p.placa_pod)
from pracownicy p
where p.etat in ('ADIUNKT', 'ASYSTENT')
group by cube(
    p.id_zesp,
    p.etat)
having 
        (id_zesp is null and sum(p.placa_pod)>1300 or id_zesp is not null) -- mo¿na u¿yc grouping_id >0
    and  
        (etat is null and sum(p.placa_pod)>1300 or etat is not null)
    
order by 1, 2            
;

select 
    p.id_zesp,
    p.etat,
    sum(p.placa_pod)
from pracownicy p
where p.etat in ('ADIUNKT', 'ASYSTENT')
group by cube(
    p.id_zesp,
    p.etat)
having 
    grouping_id(id_zesp, etat)>0 and sum(p.placa_pod)>1300
    or
    grouping_id(id_zesp, etat)=0
    
order by 1, 2            
;

select 
    p.id_zesp,
    p.etat,
    sum(p.placa_pod)
from pracownicy p
where p.etat in ('ADIUNKT', 'ASYSTENT')
group by cube(
    p.id_zesp,
    p.etat)
having 
    grouping(id_zesp)+grouping(etat)>0 and sum(p.placa_pod)>1300
    or
    grouping(id_zesp)+grouping(etat)=0
    
order by 1, 2            
;
--    6. Poka¿ miejsca pracy profesorów i adiunktów z zespo³u 20,30 i 40 wraz z podsumowaniami ich sumy placy 
--       podstawowej i placy dodatkowej. W osobnej kolumnie napisz s³owo „PODSUMOWANIE”, gdy wiersz podsumowuje któr¹œ z grup, wykorzystaj do tego funkcje GROUPING. Skorzystaj te¿ z funkcji DECODE

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


--    7. Poka¿ tylko 2 i 3 poziom podsumowania dla sum p³ac podstawowych id_zesp i etatów dla sta¿ystów i sekretarek

select
    p.id_zesp,
    p.etat,
    sum(p.placa_pod) as "suma"
from pracownicy p
where p.etat in ('STAZYSTA','SEKRETARKA')
group by cube(
    p.id_zesp,
    p.etat
)
having 
    grouping_id(p.id_zesp, p.etat) >= 2



