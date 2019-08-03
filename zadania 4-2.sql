--Zadanie 4-2
--    1. Wy�wietl wszystkie informacje o tych pracownikach, kt�rzy s� asystentami lub adiunktami 
--       i kt�rych roczne dochody przekraczaj� 5500. Roczne dochody to dwunastokrotno�� p�acy podstawowej 
--       powi�kszona o ewentualn� p�ac� dodatkow�. Ostatni atrybut to kategoria p�acowa pracownika.
--       (wykorzystaj po��czenie z tabel� etaty)

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
--    2. Wy�wietl nazwiska i numery pracownik�w wraz z numerami i nazwiskami ich szef�w.
select
    p.nazwisko as "pracownik",
    p.id_prac as "nr pracownika",
    nvl(s.nazwisko, ' ') as "szef",
    s.id_prac as "nr szefa"
from pracownicy p
    join pracownicy s
        on s.id_prac = p.id_szefa
;

--    3. Zmodyfikuj powy�sze zlecenie w ten spos�b, aby by�o mo�liwe wy�wietlenie pracownika kt�ry nie ma szefa.
select
    p.nazwisko as "pracownik",
    p.id_prac as "nr pracownika",
    nvl(s.nazwisko, ' ') as "szef",
    s.id_prac as "nr szefa"
from pracownicy p
    left join pracownicy s
        on s.id_prac = p.id_szefa
;

--    4. Dla ka�dego zespo�u wy�wietl liczb� zatrudnionych w nim pracownik�w i ich �redni� p�ac�(wraz z dodatkow�) zaokr�glon� do dw�ch miejsc po przecinku).
select
    z.nazwa,
    count(p.id_prac) as "liczba pracownik�w",
    round(avg(p.placa_pod+nvl(p.placa_dod, 0)), 2) as "�rednia p�aca"
from zespoly z
    left join pracownicy p
        on z.id_zesp = p.id_zesp
group by
    z.nazwa
;

--    5. Dla ka�dego pracownika posiadaj�cego podw�adnych wy�wietl ich liczb�. Wyniki posortuj zgodnie z malej�c� liczb� podw�adnych.
select
    s.nazwisko,
    count(*) as "liczba podw�adnych"
from pracownicy s
    join pracownicy p
        on p.id_szefa = s.id_prac
group by
    s.nazwisko
order by
    2 desc
;

--    6. Wy�wietl nazwiska i daty zatrudnienia pracownik�w, kt�rzy zostali zatrudnieni nie p�niej ni� 10 lat (3650 dni) po swoich prze�o�onych.
select
    s.nazwisko as "prze�o�ony",
    to_char(s.zatrudniony, 'yyyy-mm-dd') as "prze�o�ony zatrudniony dnia",
    p.nazwisko as "pracownik",
    to_char(p.zatrudniony, 'yyyy-mm-dd') as "pracownik zatrudniony dnia",
    round(p.zatrudniony-s.zatrudniony) as "pracownik zatrudniony po prze�o�onym po ilo�ci dni"
from pracownicy p
    join pracownicy s
        on p.id_szefa = s.id_prac
where round(p.zatrudniony-s.zatrudniony)<3650      
;

--    7. Wy�wietl nazwy etat�w, na kt�re przyj�to pracownik�w zar�wno w 1995 jak i 1996 roku.
select distinct
    p.etat,
    extract(year from p.zatrudniony) "rok"
from pracownicy p
where extract(year from p.zatrudniony) in (1995, 1996)
