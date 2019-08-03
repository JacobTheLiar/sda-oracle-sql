--adanie 5-2
--    1. Wy�wietl nazwiska tych profesor�w, kt�rzy w�r�d swoich podw�adnych nie maj� �adnych sta�yst�w
select
    p.nazwisko
from pracownicy p
where p.etat = 'PROFESOR'
  and not exists (
                    select pin.id_szefa
                    from pracownicy pin
                    where pin.etat = 'STAZYSTA'
                      and pin.id_szefa = p.id_prac
  );

select
    p.nazwisko
from pracownicy p
where p.etat = 'PROFESOR'
  and p.id_prac not in (
                    select pin.id_szefa
                    from pracownicy pin
                    where pin.etat = 'STAZYSTA'
  );


--    2. Stosuj�c podzapytanie skorelowane wy�wietl informacje o zespole niezatrudniaj�cym �adnych pracownik�w (wykorzystaj operator EXISTS)
select
    z.nazwa,
    z.adres
from zespoly z
where not exists (
                    select p.id_zesp
                    from pracownicy p
                    where p.id_zesp=z.id_zesp
);
--    3. Wy�wietl numer zespo�u wyp�acaj�cego miesi�cznie swoim pracownikom najwi�cej pieni�dzy. Wykorzystaj koniecznie operator ALL
-- ???
select 
    p.id_zesp
from pracownicy p
where p.placa_pod > = all (
                    select sum(pin.placa_pod)
                    from pracownicy pin
);

-- z having
select 
    p.id_zesp,
    sum(p.placa_pod) suma
from pracownicy p

group by
    p.id_zesp
having sum(p.placa_pod)=(
                    select max(sum(pin.placa_pod))
                    from pracownicy pin
                    group by pin.id_zesp
);

--    4. Poka� pracownik�w, kt�rych p�aca podstawowa jest wi�ksza od 500, p�aca minimalana etat nie zawiera si� w przedzia�ach od 310 do 900, 
--       a p�aca maksymalna jest mniejsza od p�acy podstawowej pracownika o nazwisku MIODEK(wykorzystaj podzapytanie zagnie�d�one).
-- ???
select
    *
from pracownicy p
where p.placa_pod>500
  and p.etat not in (
            select ein.nazwa
            from etaty ein
            where ein.placa_min not between 310 and 900
              and ein.placa_max < (
                                    select pin.placa_pod
                                    from pracownicy pin
                                    where pin.nazwisko='MIODEK'
              )
              
);

--    5. Wy�wietl dla ka�dego roku liczb� zatrudnionych w nim pracownik�w, kt�rych w nazwisku mamy liter� �A�. 
--       Koniecznie wykorzystaj podzapytanie. Wyeliminuj duplikaty i posortuj malej�co po roku
select distinct
    extract(year from p.zatrudniony) as "rok",
    (   select count(*) 
        from pracownicy pin 
        where nazwisko like '%A%' 
          and extract(year from pin.zatrudniony)=extract(year from p.zatrudniony)) as "liczba pracownik�w z A"
from pracownicy p 
order by 1 desc
;