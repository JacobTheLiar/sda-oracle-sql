-- Zadanie 2-1

--    1. Dla ka¿dego pracownika wygeneruj kod sk³adaj¹cy siê z dwóch pierwszych 
--       liter jego etatu i jego numeru identyfikacyjnego.

select 
    p.nazwisko, 
    p.id_prac,
    p.etat,
    SUBSTR(p.etat,1,2) || p.id_prac as "code"
       
from system.pracownicy p
;

--    2. Wydaj wojnê literom „K”, „L”, „M” zamieniaj¹c je wszystkie na literê „X” w nazwiskach pracowników
select
    p.nazwisko,
    REPLACE(
        REPLACE(
            REPLACE(
                p.nazwisko,
                'M', 'X')
            ,'L','X')
        ,'K','X') "kill_KLM"
from system.pracownicy p
;

--    3. Wyœwietl nazwiska i p³ace(wraz z dodatkow¹) pracowników powiêkszone o 15% 
--       i zaokr¹glone do liczb ca³kowitych zgodnie z zasadami matematyki ?
select
    p.nazwisko,
    round((p.placa_pod + NVL(p.placa_dod,0)) * 1.15, 0) as "pensja + grant"
from system.pracownicy p
;

--    4. Ka¿dy pracownik od³o¿y³ 20% swoich miesiêcznych zarobków na 10-letni¹ lokatê 
--       oprocentowan¹ 10% w skali roku i kapitalizowan¹ co roku. Wyœwietl informacjê o tym, 
--       jaki zysk bêdzie mia³ ka¿dy pracownik po zamkniêciu lokaty.(w tabeli bêd¹ nastêpuj¹ce kolumny: 
--       (nazwisko, p³aca podstawowa, inwestycja, kapita³, zysk) – nie uwzglêdniamy p³acy dodatkowej.
select
    p.nazwisko,
    p.placa_pod,
    (p.placa_pod * 0.2) as "inwestycja",
    (p.placa_pod * 0.2) * power(1.1, 10) as "kapita³",
    (p.placa_pod * 0.2) * power(1.1, 10) - (p.placa_pod * 0.2) as "zysk"    
from system.pracownicy p
;

--    5. Policz, ile pe³nych lat pracuje ka¿dy pracownik – w tabeli poka¿ te¿ 
--       jego datê zatrudnienia ze s³ownie napisanym miesi¹cem
select
    p.nazwisko,
    p.zatrudniony,
    trunc(MONTHS_BETWEEN(SYSDATE,p.zatrudniony)/12) as "przepracowanych lat",
    to_char(p.zatrudniony, 'Month') as "miesi¹c zatrudnienia"
from system.pracownicy p
;

--    6. Wyœwietl poni¿sze informacje o datach przyjêcia pracowników zespo³u 20 
--        a. Nazwisko
--        b. Miesi¹c, DD(dzieñ), YY
select
    p.nazwisko,
    trim(to_char(p.zatrudniony, 'month'))
        ||', '
        ||to_char(p.zatrudniony, 'd')
        ||', '
        ||to_char(p.zatrudniony, 'yy'),
        to_char(p.zatrudniony, 'month, d, yy')
from system.pracownicy p
where p.id_zesp = 20
;

--    7. Policz zadanie: resztê z dzielenia 134/8 przemnó¿ przez pierwiastek z 81 
--       i podnieœ wszystko do potêgi 4. Podziel wszystko przez 563600 Do wyniku 
--       dodaj wygenerowan¹ losowo liczbê z przedzia³u od 0 do 3.
select
    power(
        mod(134, 8) * sqrt(81), 
        4) 
        / 563600 
        + dbms_random.value(0, 3)
from dual
;

--    8. Dla pracowników którzy pracuj¹ ponad 5000 dni poka¿ stosown¹ informacjê w osobnej kolumnie.
select
    p.nazwisko,
    trunc(sysdate) - trunc(p.zatrudniony),
    case 
        when trunc(sysdate) - trunc(p.zatrudniony) > 5000
        then 'pracuje ponad 5000 dni'
        else ' '
        end as "pracuje 5k"
from system.pracownicy p
;

--    9. Dla tych których nazwisko ma mniej ni¿ 7 liter utwórz kolumnê i uzupe³nij 
--       j¹ znakiem „Z” po prawej stronie tak, by ka¿de nazwisko mia³o 7 znaków
select 
    p.nazwisko,
    case 
        when length(p.nazwisko)<7
        then rpad(p.nazwisko, 7, 'Z')
        end as "7 char"
from system.pracownicy p
--where length(p.nazwisko)<=7
;

--    10. Poka¿ nazwiska pracowników w taki sposób, by ich ostatnie 3 litery 
--        by³y w odwróconej kolejnoœci np. NOWAK -> NOKAW
select
    p.nazwisko,
    SUBSTR(p.nazwisko,1,length(p.nazwisko)-3)
        || reverse(SUBSTR(p.nazwisko,-3, 3))
from system.pracownicy p
;

