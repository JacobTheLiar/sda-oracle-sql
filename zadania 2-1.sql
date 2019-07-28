-- Zadanie 2-1

--    1. Dla ka�dego pracownika wygeneruj kod sk�adaj�cy si� z dw�ch pierwszych 
--       liter jego etatu i jego numeru identyfikacyjnego.

select 
    p.nazwisko, 
    p.id_prac,
    p.etat,
    SUBSTR(p.etat,1,2) || p.id_prac as "code"
       
from system.pracownicy p
;

--    2. Wydaj wojn� literom �K�, �L�, �M� zamieniaj�c je wszystkie na liter� �X� w nazwiskach pracownik�w
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

--    3. Wy�wietl nazwiska i p�ace(wraz z dodatkow�) pracownik�w powi�kszone o 15% 
--       i zaokr�glone do liczb ca�kowitych zgodnie z zasadami matematyki ?
select
    p.nazwisko,
    round((p.placa_pod + NVL(p.placa_dod,0)) * 1.15, 0) as "pensja + grant"
from system.pracownicy p
;

--    4. Ka�dy pracownik od�o�y� 20% swoich miesi�cznych zarobk�w na 10-letni� lokat� 
--       oprocentowan� 10% w skali roku i kapitalizowan� co roku. Wy�wietl informacj� o tym, 
--       jaki zysk b�dzie mia� ka�dy pracownik po zamkni�ciu lokaty.(w tabeli b�d� nast�puj�ce kolumny: 
--       (nazwisko, p�aca podstawowa, inwestycja, kapita�, zysk) � nie uwzgl�dniamy p�acy dodatkowej.
select
    p.nazwisko,
    p.placa_pod,
    (p.placa_pod * 0.2) as "inwestycja",
    (p.placa_pod * 0.2) * power(1.1, 10) as "kapita�",
    (p.placa_pod * 0.2) * power(1.1, 10) - (p.placa_pod * 0.2) as "zysk"    
from system.pracownicy p
;

--    5. Policz, ile pe�nych lat pracuje ka�dy pracownik � w tabeli poka� te� 
--       jego dat� zatrudnienia ze s�ownie napisanym miesi�cem
select
    p.nazwisko,
    p.zatrudniony,
    trunc(MONTHS_BETWEEN(SYSDATE,p.zatrudniony)/12) as "przepracowanych lat",
    to_char(p.zatrudniony, 'Month') as "miesi�c zatrudnienia"
from system.pracownicy p
;

--    6. Wy�wietl poni�sze informacje o datach przyj�cia pracownik�w zespo�u 20 
--        a. Nazwisko
--        b. Miesi�c, DD(dzie�), YY
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

--    7. Policz zadanie: reszt� z dzielenia 134/8 przemn� przez pierwiastek z 81 
--       i podnie� wszystko do pot�gi 4. Podziel wszystko przez 563600 Do wyniku 
--       dodaj wygenerowan� losowo liczb� z przedzia�u od 0 do 3.
select
    power(
        mod(134, 8) * sqrt(81), 
        4) 
        / 563600 
        + dbms_random.value(0, 3)
from dual
;

--    8. Dla pracownik�w kt�rzy pracuj� ponad 5000 dni poka� stosown� informacj� w osobnej kolumnie.
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

--    9. Dla tych kt�rych nazwisko ma mniej ni� 7 liter utw�rz kolumn� i uzupe�nij 
--       j� znakiem �Z� po prawej stronie tak, by ka�de nazwisko mia�o 7 znak�w
select 
    p.nazwisko,
    case 
        when length(p.nazwisko)<7
        then rpad(p.nazwisko, 7, 'Z')
        end as "7 char"
from system.pracownicy p
--where length(p.nazwisko)<=7
;

--    10. Poka� nazwiska pracownik�w w taki spos�b, by ich ostatnie 3 litery 
--        by�y w odwr�conej kolejno�ci np. NOWAK -> NOKAW
select
    p.nazwisko,
    SUBSTR(p.nazwisko,1,length(p.nazwisko)-3)
        || reverse(SUBSTR(p.nazwisko,-3, 3))
from system.pracownicy p
;

