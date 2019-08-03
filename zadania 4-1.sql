--Zadanie 4-1
--    1. Wyœwietl nazwiska, etaty, numery zespo³ów i nazwy zespo³ów wszystkich pracowników.
select 
    p.nazwisko,
    p.etat,
    p.id_zesp,
    z.nazwa
from pracownicy p
    left join zespoly z
        on p.id_zesp=z.id_zesp
        --using (id_zesp)  -- to samo co 
order by 3, 1
;
--    2. Wyœwietl wszystkich pracowników z ul. Piotrowo 3a. Uporz¹dkuj wyniki wed³ug nazwisk pracowników.
select 
    p.nazwisko,
    p.etat,
    p.id_zesp,
    z.nazwa,
    z.adres
from pracownicy p
    left join zespoly z
        on p.id_zesp=z.id_zesp
where z.adres = 'PIOTROWO 3A'        
;

--    3. Wyœwietl nazwiska, miejsca pracy oraz nazwy zespo³ów tych pracowników, których miesiêczna pensja przekracza 400.
select 
    p.nazwisko, 
    z.adres, 
    z.nazwa,
    p.placa_pod+nvl(p.placa_dod, 0) "pensja"
from pracownicy p
    left join zespoly z
        on z.id_zesp = p.id_zesp
where p.placa_pod+nvl(p.placa_dod, 0)>400
;

--    4. Dla ka¿dego pracownika wyœwietl jego p³acê podstawow¹ i wide³ki p³acowe w jakich mieœci siê pensja pracownika.
select
    p.nazwisko,
    p.placa_pod,
    e.placa_min,
    e.placa_max
from pracownicy p
    join etaty e
        on p.etat = e.nazwa
;
    
--    5. Wyœwietl nazwiska i etaty pracowników, których rzeczywiste zarobki odpowiadaj¹ wide³kom p³acowym przewidzianym 
--       dla sekretarek.
select
    p.nazwisko, p.etat
from pracownicy p
    join etaty e
        on e.nazwa = 'SEKRETARKA'
        and p.placa_pod between e.placa_min and e.placa_max
;

--    6. Wyœwietl nazwiska, etaty, wynagrodzenia, kategorie p³acowe i nazwy zespo³ów pracowników nie bêd¹cych asystentami. 
--       Wyniki uszereguj zgodnie z malej¹cym wynagrodzeniem.
select
    p.nazwisko,
    p.etat,
    p.placa_pod,
    p.placa_dod,
    e.placa_min,
    e.placa_max,
    z.nazwa as "zespó³"
-- select *
from pracownicy p
    join etaty e
        on e.nazwa = p.etat
    join zespoly z
        on z.id_zesp = p.id_zesp
where p.etat<>'ASYSTENT'
;

--    7. Poka¿ iloœæ pracowników, którzy nie pracuj¹ na ulicy zaczynaj¹cej siê od litery P.
select
    z.adres as "adres zespo³u",
    count(*) as "iloœæ pracowników"
from pracownicy p
    join zespoly z
        on z.id_zesp = p.id_zesp
where z.adres not like 'P%'
group by 
    z.adres
;