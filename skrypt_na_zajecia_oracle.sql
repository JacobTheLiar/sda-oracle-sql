CREATE TABLE ZESPOLY
	(ID_ZESP NUMBER(2) CONSTRAINT PK_ZESP PRIMARY KEY,
	NAZWA VARCHAR2(20),
	ADRES VARCHAR2(20) );

CREATE TABLE ETATY
      ( NAZWA VARCHAR2(10) CONSTRAINT PK_ETAT PRIMARY KEY,
	PLACA_MIN NUMBER(6,2),
	PLACA_MAX NUMBER(6,2));

CREATE TABLE PRACOWNICY
       (ID_PRAC NUMBER(4) CONSTRAINT PK_PRAC PRIMARY KEY,
	NAZWISKO VARCHAR2(15),
	ETAT VARCHAR2(10) CONSTRAINT FK_ETAT REFERENCES ETATY(NAZWA),
	ID_SZEFA NUMBER(4) CONSTRAINT FK_ID_SZEFA REFERENCES PRACOWNICY(ID_PRAC), 
	ZATRUDNIONY DATE,
	PLACA_POD NUMBER(6,2) CONSTRAINT MIN_PLACA_POD CHECK(PLACA_POD>100),
	PLACA_DOD NUMBER(6,2),
	ID_ZESP NUMBER(2) CONSTRAINT FK_ID_ZESP REFERENCES ZESPOLY(ID_ZESP));
  
INSERT INTO ZESPOLY VALUES (10,'ADMINISTRACJA',      'PIOTROWO 3A');
INSERT INTO ZESPOLY VALUES (20,'SYSTEMY ROZPROSZONE','PIOTROWO 3A');
INSERT INTO ZESPOLY VALUES (30,'SYSTEMY EKSPERCKIE', 'STRZELECKA 14');
INSERT INTO ZESPOLY VALUES (40,'ALGORYTMY',          'WLODKOWICA 16');
INSERT INTO ZESPOLY VALUES (50,'BADANIA OPERACYJNE', 'MIELZYNSKIEGO 30');

INSERT INTO ETATY VALUES ('PROFESOR'  ,800.00,1500.00);
INSERT INTO ETATY VALUES ('ADIUNKT'   ,510.00, 750.00);
INSERT INTO ETATY VALUES ('ASYSTENT'  ,300.00, 500.00);
INSERT INTO ETATY VALUES ('STAZYSTA'  ,150.00, 250.00);
INSERT INTO ETATY VALUES ('SEKRETARKA',270.00, 450.00);
INSERT INTO ETATY VALUES ('DYREKTOR' ,1280.00,2100.00);
 
INSERT INTO PRACOWNICY VALUES (100,'NOWAK'    ,'DYREKTOR'  ,NULL,to_date('05-10-2010','DD-MM-RRRR'),1730.00,420.50,10);
INSERT INTO PRACOWNICY VALUES (110,'JURASIK'  ,'PROFESOR'  ,100 ,to_date('22-10-2003','DD-MM-RRRR'),1350.00,210.00,40);
INSERT INTO PRACOWNICY VALUES (120,'S�OWIK'  ,'PROFESOR'  ,100 ,to_date('24-10-1995','DD-MM-RRRR'),1070.00,  NULL,30);
INSERT INTO PRACOWNICY VALUES (130,'KOWALSKI' ,'PROFESOR'  ,100 ,to_date('22-05-1995','DD-MM-RRRR'), 960.00,  NULL,20);
INSERT INTO PRACOWNICY VALUES (140,'MIODEK'      ,'PROFESOR'  ,130 ,to_date('26-02-1996','DD-MM-RRRR'), 830.00,105.00,20);
INSERT INTO PRACOWNICY VALUES (150,'PLASTYK','ADIUNKT'   ,130 ,to_date('21-03-2010','DD-MM-RRRR'), 645.50,  NULL,20);
INSERT INTO PRACOWNICY VALUES (160,'MODRY'  ,'ADIUNKT'   ,130 ,to_date('25-12-1991','DD-MM-RRRR'), 590.00,  NULL,20);
INSERT INTO PRACOWNICY VALUES (170,'UFO'  ,'ASYSTENT'  ,130 ,to_date('14-01-1985','DD-MM-RRRR'), 439.70, 80.50,20);
INSERT INTO PRACOWNICY VALUES (190,'RATOS'   ,'ASYSTENT'  ,140 ,to_date('04-10-2008','DD-MM-RRRR'), 371.00,  NULL,20);
INSERT INTO PRACOWNICY VALUES (180,'KOMORNIK'      ,'SEKRETARKA',100 ,to_date('03-03-2003','DD-MM-RRRR'), 410.20,  NULL,10);
INSERT INTO PRACOWNICY VALUES (200,'KACZKA' ,'STAZYSTA'  ,140 ,to_date('24-03-1994','DD-MM-RRRR'), 208.00,  NULL,30);
INSERT INTO PRACOWNICY VALUES (210,'CZARNY'      ,'STAZYSTA'  ,130 ,to_date('24-05-1995','DD-MM-RRRR'), 250.00,170.60,30);
INSERT INTO PRACOWNICY VALUES (220,'ZIELONY'    ,'ASYSTENT'  ,110 ,to_date('31-01-2009','DD-MM-RRRR'), 480.00,  NULL,20);
INSERT INTO PRACOWNICY VALUES (230,'JUPITER'      ,'ASYSTENT'  ,120 ,to_date('23-08-2003','DD-MM-RRRR'), 480.00, 90.00,30);
commit;