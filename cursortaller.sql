--ejercicio 1 TALLER 1
-- Funciones matemáticas
---http://www.oracleya.com.ar/temarios/descripcion.php?cod=180&punto=22
--crear tabla ambulamcia
create table ambulancia(
placa varchar2(20),
nombrechofer varchar2(50),
cord_x NUMBER(5),
cord_y NUMBER(5)
)

--------------INSERTANDO REGISTROS----------------------
INSERT INTO AMBULANCIA VALUES ('abc32','Diana Pineda',3,5)
INSERT INTO AMBULANCIA VALUES ('agc62','Andres Piedraita',5,5)
INSERT INTO AMBULANCIA VALUES ('abg52','Sandra Amaya',2,21)
INSERT INTO AMBULANCIA VALUES ('mbc22','Angela Martines',3,8)
INSERT INTO AMBULANCIA VALUES ('dbK35','Claudoa Arrieta',3,7)
INSERT INTO AMBULANCIA VALUES ('ebl30','Jhon Andres',23,-5)
INSERT INTO AMBULANCIA VALUES ('bbc92','Alejandro Garcia',24,-45)
INSERT INTO AMBULANCIA VALUES ('klg32','Shakira Meneses',4,15)
INSERT INTO AMBULANCIA VALUES ('mdf31','Yeidari Rueda',22,-5)
INSERT INTO AMBULANCIA VALUES ('agk63','Katherine Muños',26,65)
INSERT INTO AMBULANCIA VALUES ('ops74','Sandra perez',15,49)
INSERT INTO AMBULANCIA VALUES ('ngd45','Maria Elvira',71,90)
INSERT INTO AMBULANCIA VALUES ('udd35','Silvia Ramirez',-71,-20)
INSERT INTO AMBULANCIA VALUES ('heñ23','Jhon Jairo',4,30)

--  mostrar registros
select * from ambulancia
--------------------tabla ambhistorial-----------------
CREATE TABLE table (
pca varchar2(20),
nomc varchar2(50),
px number(5),
py number(5),
distatncia number(10),
fecha date
)

--formula
--h^2=x^2+y^2=>RAIZ (x^2+y^2)
--distancia=>(P,Q)=>raiz(x1-y1)^2+(x2+y2)^2

-- power(x,y): retorna el valor de "x" elevado a la "y" potencia.
-- sqrt(x): devuelve la raiz cuadrada del valor enviado como argumento
--SET SERVEROUTPUT ON
--x number:='&Ingrese la coordenada x:';
--y number:='& Ingrese la coordenada y';
--cursor SET SERVEROUTPUT ON

--SET SERVEROUTPUT ON
---
---
declare
pca AMBULANCIA.PLACA%type;
nomc ambulancia.nombrechofer%type;
px ambulancia.cord_x%type;
py ambulancia.cord_y%type;
cursor
emergencia(x number,y number)
is select placa,nombrechofer,Sqrt(power(cord_x-x,2)) ,sqrt(power(cord_y-y,2)) from ambulancia;
begin 
open emergencia(2,4);
dbms_output.put_line('--------------------------------------------------------------------------------------------------------------------');
dbms_output.put_line('--------------------------------------------DATOS UBICACIÓN AMBULANCIAS-----------------------------------------------');
loop
fetch emergencia into pca,nomc,px,py;
exit when emergencia%notfound;
   dbms_output.put_line('Placa: ' || pca || ' -Nombre Chofer : ' || nomc || 
   ' -Posición X :' || px || ' -Posición Y : ' || py ||' -Distancia : '|| (px+py)||' -Fecha y Hora :'|| SYSTIMESTAMP );
  --insert into AMBHISTORIAL (pca,nomc,px,py,DISTANCIA,fecha) values (pca,nomc,px,py,(px+py),SYSTIMESTAMP);
   END LOOP;
   dbms_output.put_line('------------------------------------------------------TDEA------------------------------------------------------------------');
 
   CLOSE emergencia;
END;


--show error;

--select * from AMBHISTORIAL;

