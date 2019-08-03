--Zadanie 4-2
--    1. Wyœwietl wszystkie informacje o tych pracownikach, którzy s¹ asystentami lub adiunktami 
--       i których roczne dochody przekraczaj¹ 5500. Roczne dochody to dwunastokrotnoœæ p³acy podstawowej 
--       powiêkszona o ewentualn¹ p³acê dodatkow¹. Ostatni atrybut to kategoria p³acowa pracownika.
--       (wykorzystaj po³¹czenie z tabel¹ etaty)

select
    p.nazwisko,
    p.etat,
    p.placa_pod,
    p.placa_dod,
    (p.placa_pod+nvl(p.placa_dod, 0))*12 as "wynagrodzenie roczne",
    e.nazwa "zarobki na poziomie"
from pracownicy p
    join etaty e
        on p.placa_pod between e.placa_min and e.placa_max

where p.etat in ('ADIUNKT', 'ASYSTENT')
  and (p.placa_pod+nvl(p.placa_dod, 0))*12 > 5500
;
--    2. Wyœwietl nazwiska i numery pracowników wraz z numerami i nazwiskami ich szefów.
select
    p.nazwisko as "pracownik",
    p.id_prac as "nr pracownika",
    nvl(s.nazwisko, ' ') as "szef",
    s.id_prac as "nr szefa"
from pracownicy p
    join pracownicy s
        on s.id_prac = p.id_szefa
;

--    3. Zmodyfikuj powy¿sze zlecenie w ten sposób, aby by³o mo¿liwe wyœwietlenie pracownika który nie ma szefa.
select
    p.nazwisko as "pracownik",
    p.id_prac as "nr pracownika",
    nvl(s.nazwisko, ' ') as "szef",
    s.id_prac as "nr szefa"
from pracownicy p
    left join pracownicy s
        on s.id_prac = p.id_szefa
;

--    4. Dla ka¿dego zespo³u wyœwietl liczbê zatrudnionych w nim pracowników i ich œredni¹ p³acê(wraz z dodatkow¹) zaokr¹glon¹ do dwóch miejsc po przecinku).
select
    z.nazwa,
    count(p.id_prac) as "liczba pracowników",
    round(avg(p.placa_pod+nvl(p.placa_dod, 0)), 2) as "œrednia p³aca"
from zespoly z
    left join pracownicy p
        on z.id_zesp = p.id_zesp
group by
    z.nazwa
;

--    5. Dla ka¿dego pracownika posiadaj¹cego podw³adnych wyœwietl ich liczbê. Wyniki posortuj zgodnie z malej¹c¹ liczb¹ podw³adnych.
select
    s.nazwisko,
    count(*) as "liczba podw³adnych"
from pracownicy s
    join pracownicy p
        on p.id_szefa = s.id_prac
group by
    s.nazwisko
order by
    2 desc
;

--    6. Wyœwietl nazwiska i daty zatrudnienia pracowników, którzy zostali zatrudnieni nie póŸniej ni¿ 10 lat (3650 dni) po swoich prze³o¿onych.
select
    s.nazwisko as "prze³o¿ony",
    to_char(s.zatrudniony, 'yyyy-mm-dd') as "prze³o¿ony zatrudniony dnia",
    p.nazwisko as "pracownik",
    to_char(p.zatrudniony, 'yyyy-mm-dd') as "pracownik zatrudniony dnia",
    round(p.zatrudniony-s.zatrudniony) as "pracownik zatrudniony po prze³o¿onym po iloœci dni"
from pracownicy p
    join pracownicy s
        on p.id_szefa = s.id_prac
where round(p.zatrudniony-s.zatrudniony)<3650      
;

--    7. Wyœwietl nazwy etatów, na które przyjêto pracowników zarówno w 1995 jak i 1996 roku.
select distinct
    p.etat,
    extract(year from p.zatrudniony) "rok"
from pracownicy p
where extract(year from p.zatrudniony) in (1995, 1996)
