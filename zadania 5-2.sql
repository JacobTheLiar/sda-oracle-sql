--adanie 5-2
--    1. Wyœwietl nazwiska tych profesorów, którzy wœród swoich podw³adnych nie maj¹ ¿adnych sta¿ystów
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


--    2. Stosuj¹c podzapytanie skorelowane wyœwietl informacje o zespole niezatrudniaj¹cym ¿adnych pracowników (wykorzystaj operator EXISTS)
select
    z.nazwa,
    z.adres
from zespoly z
where not exists (
                    select p.id_zesp
                    from pracownicy p
                    where p.id_zesp=z.id_zesp
);
--    3. Wyœwietl numer zespo³u wyp³acaj¹cego miesiêcznie swoim pracownikom najwiêcej pieniêdzy. Wykorzystaj koniecznie operator ALL
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

--    4. Poka¿ pracowników, których p³aca podstawowa jest wiêksza od 500, p³aca minimalana etat nie zawiera siê w przedzia³ach od 310 do 900, 
--       a p³aca maksymalna jest mniejsza od p³acy podstawowej pracownika o nazwisku MIODEK(wykorzystaj podzapytanie zagnie¿d¿one).
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

--    5. Wyœwietl dla ka¿dego roku liczbê zatrudnionych w nim pracowników, których w nazwisku mamy literê „A”. 
--       Koniecznie wykorzystaj podzapytanie. Wyeliminuj duplikaty i posortuj malej¹co po roku
select distinct
    extract(year from p.zatrudniony) as "rok",
    (   select count(*) 
        from pracownicy pin 
        where nazwisko like '%A%' 
          and extract(year from pin.zatrudniony)=extract(year from p.zatrudniony)) as "liczba pracowników z A"
from pracownicy p 
order by 1 desc
;