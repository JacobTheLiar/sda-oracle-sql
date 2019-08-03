select
    p.nazwisko,
    e.nazwa,
    p.placa_pod,
    (select zin.nazwa from zespoly zin where zin.id_zesp = p.id_zesp) as "nazwa zespo³u"
from pracownicy p
    join etaty e
        on e.nazwa = p.etat

where p.id_zesp in (
                    select id_zesp
                    from zespoly z
                    where z.nazwa like 'SY%'
)
;

