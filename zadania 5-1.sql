--Zadanie 5-1
--
--    1. Wy�wietl nazwiska i etaty pracownik�w pracuj�cych w tym samym zespole co pracownik o nazwisku Kowalski

select
    p.nazwisko,
    p.etat
from pracownicy p
where p.id_zesp = (
                    select pin.id_zesp
                    from pracownicy pin
                    where pin.nazwisko = 'KOWALSKI'
);

--    2. Wy�wietl poni�sze dane o najd�u�ej zatrudnionym profesorze.
select 
    p.nazwisko,
    p.etat,
    to_char(p.zatrudniony, 'yyyy-mm-dd') as "zatrudniony"
from pracownicy p
where p.zatrudniony = (
                    select max(pin.zatrudniony)
                    from pracownicy pin
);

--    3. Wy�wietl najd�u�ej pracuj�cych pracownik�w ka�dego zespo�u. Uszereguj wyniki zgodnie z kolejno�ci� zatrudnienia
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

--    4. Wy�wietl zespo�y, kt�re nie zatrudniaj� pracownik�w. Koniecznie wykorzystaj do tego podzapytanie a nie z��czenia tabel
select
    *
from zespoly z
where not exists (
                    select p.id_zesp
                    from pracownicy p
                    where p.id_zesp=z.id_zesp
);

--    5. Wy�wietl informacje o pracownikach zarabiaj�cych wi�cej ni� �rednia pensja dla ich etatu.
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
  
--    6. Wy�wietl nazwiska i pensje pracownik�w kt�rzy zarabiaj� co najmniej 75% pensji swojego szefa
select
    p.nazwisko,
    p.placa_pod
from pracownicy p
where p.placa_pod > (
                    select pin.placa_pod*0.75
                    from pracownicy pin
                    where pin.id_prac = p.id_szefa
);
