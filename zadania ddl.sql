-- dru¿yny ----
create table druzyna(
    idDruzyna int primary key,
    nazwa varchar(50)
);

create table pilkarz(
    idPilkarz int,
    nazwisko varchar(100),
    idDruzyna int,
    
    primary key (idPilkarz),
    constraint FK_DruzynaPilkarz foreign key (idDruzyna) references druzyna(idDruzyna)
);



insert into druzyna values (1, 'A');
insert into pilkarz values (1, 'Dzik', 1);
insert into pilkarz values (2, 'Mrozu', 1);
insert into pilkarz values (3, 'Mietek', 1);

insert into druzyna values (2, 'Czesky');
insert into pilkarz values (4, 'Popi³', 2);
insert into pilkarz values (5, 'Porucha³', 2);
insert into pilkarz values (6, 'Asmutny',2);


select * from druzyna;
select * from pilkarz;

select 
    d.nazwa as "nazwa dru¿yny",
    p.nazwisko as "nazwisko pi³karza"
from druzyna d
    join pilkarz p
        on p.iddruzyna = d.iddruzyna
;
-- sklep


create table sklep(
    idSklep int,
    nazwa varchar(50),
    miasto varchar(50),
    
    primary key (idSklep)
);

create table produkt(
    idProdukt int,
    nazwa varchar(50),
    cena numeric,
    idSklep int,
    
    primary key (idProdukt),
    constraint FK_SklepProdukt foreign key (idSklep) references sklep(idSklep)
);

insert into sklep values (1, 'Dino', 'Sulêcinek');
insert into sklep values (2, 'Biedra', 'Œroda Wlkp.');

insert into produkt values (1, 'Piwerko', 1.99, 1);
insert into produkt values (2, 'Winiacz', 12.99, 1);
insert into produkt values (3, 'Piwerko', 1.69, 2);
insert into produkt values (4, 'Winiacz', 9.99, 2);

select * from sklep;
select * from produkt;

select 
    s.nazwa as "nazwa sklepu",
    p.nazwa as "nazwa produktu",
    p.cena as "cena produktu"
from produkt p
    join sklep s
        on s.idSklep = p.idSklep;