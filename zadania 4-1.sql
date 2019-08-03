--Zadanie 4-1
--    1. Wy�wietl nazwiska, etaty, numery zespo��w i nazwy zespo��w wszystkich pracownik�w.
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
--    2. Wy�wietl wszystkich pracownik�w z ul. Piotrowo 3a. Uporz�dkuj wyniki wed�ug nazwisk pracownik�w.
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

--    3. Wy�wietl nazwiska, miejsca pracy oraz nazwy zespo��w tych pracownik�w, kt�rych miesi�czna pensja przekracza 400.
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

--    4. Dla ka�dego pracownika wy�wietl jego p�ac� podstawow� i wide�ki p�acowe w jakich mie�ci si� pensja pracownika.
select
    p.nazwisko,
    p.placa_pod,
    e.placa_min,
    e.placa_max
from pracownicy p
    join etaty e
        on p.etat = e.nazwa
;
    
--    5. Wy�wietl nazwiska i etaty pracownik�w, kt�rych rzeczywiste zarobki odpowiadaj� wide�kom p�acowym przewidzianym 
--       dla sekretarek.
select
    p.nazwisko, p.etat
from pracownicy p
    join etaty e
        on e.nazwa = 'SEKRETARKA'
        and p.placa_pod between e.placa_min and e.placa_max
;

--    6. Wy�wietl nazwiska, etaty, wynagrodzenia, kategorie p�acowe i nazwy zespo��w pracownik�w nie b�d�cych asystentami. 
--       Wyniki uszereguj zgodnie z malej�cym wynagrodzeniem.
select
    p.nazwisko,
    p.etat,
    p.placa_pod,
    p.placa_dod,
    e.placa_min,
    e.placa_max,
    z.nazwa as "zesp�"
-- select *
from pracownicy p
    join etaty e
        on e.nazwa = p.etat
    join zespoly z
        on z.id_zesp = p.id_zesp
where p.etat<>'ASYSTENT'
;

--    7. Poka� ilo�� pracownik�w, kt�rzy nie pracuj� na ulicy zaczynaj�cej si� od litery P.
select
    z.adres as "adres zespo�u",
    count(*) as "ilo�� pracownik�w"
from pracownicy p
    join zespoly z
        on z.id_zesp = p.id_zesp
where z.adres not like 'P%'
group by 
    z.adres
;