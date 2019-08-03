--Zadanie 5-1
--
--    1. Wyœwietl nazwiska i etaty pracowników pracuj¹cych w tym samym zespole co pracownik o nazwisku Kowalski

select
    p.nazwisko,
    p.etat
from pracownicy p
where p.id_zesp = (
                    select pin.id_zesp
                    from pracownicy pin
                    where pin.nazwisko = 'KOWALSKI'
);

--    2. Wyœwietl poni¿sze dane o najd³u¿ej zatrudnionym profesorze.
select 
    p.nazwisko,
    p.etat,
    to_char(p.zatrudniony, 'yyyy-mm-dd') as "zatrudniony"
from pracownicy p
where p.zatrudniony = (
                    select max(pin.zatrudniony)
                    from pracownicy pin
);

--    3. Wyœwietl najd³u¿ej pracuj¹cych pracowników ka¿dego zespo³u. Uszereguj wyniki zgodnie z kolejnoœci¹ zatrudnienia
select
    p.nazwisko,
    to_char(p.zatrudniony, 'yyyy-mm-dd') as "zatrudniony",
    p.id_zesp
from pracownicy p
where p.zatrudniony = (
                    select min(pin.zatrudniony)
                    from pracownicy pin
                    where pin.id_zesp = p.id_zesp
)
order by
    2;

--    4. Wyœwietl zespo³y, które nie zatrudniaj¹ pracowników. Koniecznie wykorzystaj do tego podzapytanie a nie z³¹czenia tabel
select
    *
from zespoly z
where not exists (
                    select p.id_zesp
                    from pracownicy p
                    where p.id_zesp=z.id_zesp
);

--    5. Wyœwietl informacje o pracownikach zarabiaj¹cych wiêcej ni¿ œrednia pensja dla ich etatu.
select 
    p.nazwisko,
    p.etat,
    p.placa_pod
from pracownicy p
where p.placa_pod > (
                    select avg(pin.placa_pod)
                    from pracownicy pin
                    where pin.etat = p.etat
);
  
--    6. Wyœwietl nazwiska i pensje pracowników którzy zarabiaj¹ co najmniej 75% pensji swojego szefa
select
    p.nazwisko,
    p.placa_pod
from pracownicy p
where p.placa_pod > (
                    select pin.placa_pod*0.75
                    from pracownicy pin
                    where pin.id_prac = p.id_szefa
);
