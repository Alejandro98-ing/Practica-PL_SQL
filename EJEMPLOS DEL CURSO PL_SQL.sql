--Variables booleanas
DECLARE
    B1 BOOLEAN;
BEGIN
    B1:=TRUE;
    B1:=FALSE;
    B1:=NULL;
END;

--%TYPE
DECLARE
    X NUMBER;
    Z X%TYPE;
    EMPLE EMPLOYEES.SALARY%TYPE;
BEGIN
    EMPLE:=100;
END;

--Operadores
DECLARE
    X NUMBER:=5;
    Z X%TYPE:=10;
    A VARCHAR(100):='EXAMPLE';
    D DATE:='10-01-1990';
BEGIN
    DBMS_OUTPUT.PUT_LINE(SYSDATE);
    DBMS_OUTPUT.PUT_LINE(SYSDATE+1);
END;

--Bloques anidados
SET SERVEROUTPUT ON
BEGIN
    DBMS_OUTPUT.PUT_LINE('EN EL PRIMER BLOQUE');
    DECLARE
        x NUMBER:=10;
    BEGIN
        DBMS_OUTPUT.PUT_LINE(x);
    END;
END;

--Ámbito de variables en bloques anidados
SET SERVEROUTPUT ON

DECLARE
    x NUMBER := 20; --GLOBAL
    z NUMBER := 30;
    y NUMBER :=50;
BEGIN
    DBMS_OUTPUT.PUT_LINE('X:='||x);
    DECLARE
        x NUMBER:=10; --LOCAL
        z NUMBER:=100;
        y NUMBER:=200;
    BEGIN
        DBMS_OUTPUT.PUT_LINE('X:='||x);
        DBMS_OUTPUT.PUT_LINE('Z:='||z);
    END;
    DBMS_OUTPUT.PUT_LINE('Y:='||y);
END;

--Uso de funciones SQL dentro de PL/SQL
SET SERVEROUTPUT ON
DECLARE
    x VARCHAR2(50);
    mayus VARCHAR2(100);
    FECHA DATE;
    z NUMBER:= 100.80;
BEGIN
    x:='Ejemplo';
     DBMS_OUTPUT.PUT_LINE(SUBSTR(x,1,3));
     mayus:=UPPER(x);
     DBMS_OUTPUT.PUT_LINE(mayus);
     FECHA:=SYSDATE;
     DBMS_OUTPUT.PUT_LINE(FECHA);
     DBMS_OUTPUT.PUT_LINE(FLOOR(z));
END;

--Operadores logicos y relacionales
SET SERVEROUTPUT ON
DECLARE
    sales number:=20000;
    bonus number:=0;
BEGIN
    IF sales > 50000 THEN
        bonus := 1500;
    ELSIF sales > 35000 THEN
        bonus := 500;
    ELSIF sales > 20000 THEN
        bonus := 150;
    ELSE
        bonus := 100;
    END IF;
    
    DBMS_OUTPUT.PUT_LINE('Sales = ' || sales || ', bonus =' || bonus || '.');
END;

--Comando CASE
DECLARE
    v1 CHAR(1);
BEGIN
    v1 := 'B';
    
    CASE v1
        WHEN 'A' THEN DBMS_OUTPUT.PUT_LINE('Excellent');
        WHEN 'B' THEN DBMS_OUTPUT.PUT_LINE('Very Good');
        WHEN 'C' THEN DBMS_OUTPUT.PUT_LINE('Good');
        WHEN 'D' THEN DBMS_OUTPUT.PUT_LINE('Fair');
        WHEN 'E' THEN DBMS_OUTPUT.PUT_LINE('Foor');
        ELSE DBMS_OUTPUT.PUT_LINE('No such value');
    END CASE;
END;

DECLARE
    bonus NUMBER;
BEGIN
    bonus := 100;
    
    CASE
        WHEN bonus >500  THEN DBMS_OUTPUT.PUT_LINE('Excellent');
        WHEN bonus <=500 and bonus >250 THEN DBMS_OUTPUT.PUT_LINE('Very Good');
        WHEN bonus <=500 and bonus >100 THEN DBMS_OUTPUT.PUT_LINE('Good');
        ELSE DBMS_OUTPUT.PUT_LINE('POOR¡¡¡¡');
    END CASE;
END;

--Bucle Loop
DECLARE
    x NUMBER := 1;
BEGIN
    LOOP
    DBMS_OUTPUT.PUT_LINE(x);
    x := x+1;
    /*IF  x = 11
        THEN EXIT;
    END IF;*/
    EXIT WHEN x=11;
    END LOOP;
END;

--Loops anidados
DECLARE
    s PLS_INTEGER :=0;
    i PLS_INTEGER :=0;
    j PLS_INTEGER;
BEGIN
    <<parent>>
    LOOP
    --Print parent
    i := i+1;
    j := 100;
    DBMS_OUTPUT.PUT_LINE('Parent:'||i);
    <<child>>
        LOOP
            --Print child
            EXIT parent WHEN (i>3);
            DBMS_OUTPUT.PUT_LINE('Child:'||j);
            j:=j+1;
            EXIT child WHEN (j>105);
        END LOOP child;
    END LOOP parent;
    DBMS_OUTPUT.PUT_LINE('FINISH!!!');
END;

--Comando CONTINUE
DECLARE
    x NUMBER :=0;
BEGIN
    LOOP
    DBMS_OUTPUT.PUT_LINE('LOOP: x = '|| TO_CHAR(x));
    x := x+1;
    /*IF x < 3 THEN
        CONTINUE;
    END IF;*/
    CONTINUE WHEN x < 3; 
    DBMS_OUTPUT.PUT_LINE('DESPUES DE CONTINUE: x = '|| TO_CHAR(x));
    EXIT WHEN x = 5;
    END LOOP ;
    DBMS_OUTPUT.PUT_LINE(' DESPUES DEL LOOP: x = '||TO_CHAR(x));
END;

--Bucle FOR
SET SERVEROUTPUT ON
BEGIN
    FOR i IN 1..10 LOOP
        dbms_output.put_line(i);
    END LOOP;
END;

SET SERVEROUTPUT ON
BEGIN
    FOR i IN REVERSE 5..15 LOOP
        dbms_output.put_line(i);
        EXIT WHEN i=10;
    END LOOP;
END;

SET SERVEROUTPUT ON
DECLARE
    i VARCHAR2(100) := 'AAAA';
BEGIN
    FOR i IN REVERSE 5..15 LOOP
        dbms_output.put_line(i);
        EXIT WHEN i=10;
    END LOOP;
    dbms_output.put_line(i);
END;

--Bucle WHILE
DECLARE
    done BOOLEAN := FALSE;
    x NUMBER :=0;
BEGIN
    WHILE x <10 LOOP
        DBMS_OUTPUT.PUT_LINE(x);
        x:=x+1;
        EXIT WHEN x=5;
    END LOOP;
    WHILE done LOOP
        DBMS_OUTPUT.PUT_LINE('No imprimas esto.');
        done := TRUE;
    END LOOP;
    
    WHILE NOT done LOOP
        DBMS_OUTPUT.PUT_LINE('He pasado por aqui');
        done := TRUE;
    END LOOP;
END;

--Comando GOTO
DECLARE
    p VARCHAR2(30);
    n PLS_INTEGER :=5;
BEGIN
    FOR j in 2..ROUND(SQRT(n)) LOOP
        IF n MOD j = 0 THEN
            p := ' no es número primo';
            GOTO  print_now;
        END IF;
    END LOOP;
    
    p := ' Es un número primo';
    
    <<print_now>>
    DBMS_OUTPUT.PUT_LINE(TO_CHAR(n) || p);
END;

--SECCION 7
--SQL EN PL/SQL
SET SERVEROUTPUT ON
DECLARE
    SALARIO NUMBER;
    NOMBRE EMPLOYEES.FIRST_NAME%TYPE;
BEGIN
    SELECT --SOLO PUEDE DEVOLVER UNA FILA
        SALARY, FIRST_NAME INTO SALARIO, NOMBRE
    FROM
        EMPLOYEES
    WHERE
        EMPLOYEE_ID = 100;
        DBMS_OUTPUT.PUT_LINE(SALARIO);
        DBMS_OUTPUT.PUT_LINE(NOMBRE);
END;

--%ROWTYPE
SET SERVEROUTPUT ON
DECLARE
    SALARIO NUMBER;
    NOMBRE EMPLOYEES.FIRST_NAME%TYPE;
    EMPLEADO EMPLOYEES%ROWTYPE;
BEGIN
    SELECT
       * INTO EMPLEADO
    FROM
        EMPLOYEES
    WHERE
        EMPLOYEE_ID = 100;
        DBMS_OUTPUT.PUT_LINE(EMPLEADO.SALARY);
        DBMS_OUTPUT.PUT_LINE(EMPLEADO.FIRST_NAME);
END;

--PRACTICA CON SELECT INTO
SET SERVEROUTPUT ON
DECLARE
    salario_maximo NUMBER;
BEGIN
    SELECT
    MAX(SALARY) INTO salario_maximo
    FROM
    EMPLOYEES
    WHERE
    DEPARTMENT_ID=100;
    DBMS_OUTPUT.PUT_LINE(salario_maximo);
END;

--INSERTS
DECLARE
    COL1 TEST.C1%TYPE;
BEGIN
    COL1:=20;
    INSERT INTO TEST(C1,C2) VALUES (COL1, 'BBBB');
    COMMIT;
END;

--UPDATES
DECLARE
    T TEST.C1%TYPE;
BEGIN
    T:=10;
    UPDATE TEST SET C2='CCCC' WHERE C1=T;
    COMMIT;
END;

--DELETES
DECLARE
    T TEST.C1%TYPE;
BEGIN
    T:=20;
    DELETE FROM TEST WHERE C1=T;
    COMMIT;
END;

--Introducciones a las excepciones
SET SERVEROUTPUT ON
DECLARE
    EMPL EMPLOYEES%ROWTYPE;
BEGIN
    SELECT --SOLO PUEDE DEVOLVER UNA FILA
        * INTO EMPL
    FROM
        EMPLOYEES
    WHERE
        EMPLOYEE_ID = 100;
        DBMS_OUTPUT.PUT_LINE(EMPL.FIRST_NAME);
END;

--Sintaxis de las excepciones
SET SERVEROUTPUT ON
DECLARE
    EMPL EMPLOYEES%ROWTYPE;
BEGIN
    SELECT --SOLO PUEDE DEVOLVER UNA FILA
        * INTO EMPL
    FROM
        EMPLOYEES
    WHERE
        EMPLOYEE_ID = 100;
        DBMS_OUTPUT.PUT_LINE(EMPL.FIRST_NAME);
    EXCEPTION
        WHEN EX1 THEN
            NULL;
        WHEN EX2 THEN
            NULL;
        WHEN OTHERS THEN
            NULL;
END;

--Excepciones predefinidas
SET SERVEROUTPUT ON
DECLARE
    EMPL EMPLOYEES%ROWTYPE;
BEGIN
    SELECT --SOLO PUEDE DEVOLVER UNA FILA
        * INTO EMPL
    FROM
        EMPLOYEES
    WHERE
        EMPLOYEE_ID > 1;
        DBMS_OUTPUT.PUT_LINE(EMPL.FIRST_NAME);
    EXCEPTION
--NO_DATA_FOUND--cuando select no encuentra fila
--TOO_MANY_ROWS--cuando la qwery muestra mas de una fila 
--ZERO_DIVICE--cuando se intenta dividir por cero
--DUP_VAL_ON_INDEX--cuando la clave ya existe
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('ERROR, EMPLEADO INEXISTENTE');
        WHEN TOO_MANY_ROWS THEN
            DBMS_OUTPUT.PUT_LINE('ERROR, DEMASIADOS EMPLEADO');
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('ERROR INDEFINIDO');
END;

--Excepciones no predefinidas
SET SERVEROUTPUT ON
DECLARE
    MI_EXCEP EXCEPTION;
    PRAGMA EXCEPTION_INIT(MI_EXCEP,-937);
    V1 NUMBER;
    V2 NUMBER;
BEGIN
    SELECT --SOLO PUEDE DEVOLVER UNA FILA
        EMPLOYEE_ID, SUM(SALARY) INTO V1,V2
        FROM
        EMPLOYEES;
        DBMS_OUTPUT.PUT_LINE('V1');
    EXCEPTION
        WHEN MI_EXCEP THEN
            DBMS_OUTPUT.PUT_LINE('FUNCION DE GRUPO INCORRECTA');
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('ERROR INDEFINIDO');
END;

--SQLCODE Y SQLERRM
SET SERVEROUTPUT ON
DECLARE
    EMPL EMPLOYEES%ROWTYPE;
    CODE NUMBER;
    MESSAGE VARCHAR2(100);
BEGIN
    SELECT --SOLO PUEDE DEVOLVER UNA FILA
        * INTO EMPL
        FROM
        EMPLOYEES;
        DBMS_OUTPUT.PUT_LINE(EMPL.SALARY);
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE(SQLCODE);
            DBMS_OUTPUT.PUT_LINE(SQLERRM);
            CODE:=SQLCODE;
            MESSAGE:=SQLERRM;
            INSERT INTO ERRORS VALUES (CODE,MESSAGE);
            COMMIT;
END;

--Controlar SQL a través de excepciones
DECLARE
    REG REGIONS%ROWTYPE;
    REG_CONTROL REGIONS.REGION_ID%TYPE;
BEGIN
    REG.REGION_ID:=100;
    REG.REGION_NAME:='AFRICA';
    SELECT REGION_ID INTO REG_CONTROL FROM REGIONS
    WHERE REGION_ID=REG.REGION_ID;
    DBMS_OUTPUT.PUT_LINE('LA REGION YA EXISTE');
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        INSERT INTO REGIONS VALUES (REG.REGION_ID,REG.REGION_NAME);
        COMMIT;
END;

--Excepciones personalizadas por el desarrollador
DECLARE
   reg_max EXCEPTION;
   regn NUMBER;
   regt varchar2(200);
BEGIN
   regn:=99;
   regt:='ASIA';
   IF regn > 100 THEN
         RAISE reg_max; --se usa en excepsciones de usuario 
    ELSE
       insert into regions values (regn,regt);
       commit;
      END IF;
EXCEPTION
  WHEN reg_max THEN  
    DBMS_OUTPUT.PUT_LINE('La region no puede ser mayor de 100.');
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Error indefinido');
END;

--Ambito de las excepciones
DECLARE
   regn NUMBER;
   regt varchar2(200);
BEGIN
   regn:=102;
   regt:='ASIA';
   DECLARE
   reg_max EXCEPTION;
   BEGIN
   IF regn > 100 THEN
         RAISE reg_max; --se usa en excepsciones de usuario 
    ELSE
       insert into regions values (regn,regt);
       commit;
      END IF;
      EXCEPTION
      WHEN reg_max THEN  
      DBMS_OUTPUT.PUT_LINE('La region no puede ser mayor de 100. BLOQUE HIJO');
      END;
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Error indefinido');
END;

--Comando RAISE_APPLICATION_ERROR
DECLARE   
   regn NUMBER;
   regt varchar2(200);
BEGIN
   regn:=101;
   regt:='ASIA';
   iF regn > 100 THEN
       -- EL CODIGO DEBE ESTAR ENTRE -20000 Y -20999
       RAISE_APPLICATION_ERROR(-20001,'LA ID NO PUEDE SER MAYOR DE 100');  
    ELSE
       insert into regions values (regn,regt);
       commit;
    END IF;
END;

--PL/SQL Records
SET SERVEROUTPUT ON
DECLARE
    TYPE empleado IS RECORD
    (nombre VARCHAR2(100),
    salario NUMBER,
    fecha employees.hire_date%type,
    datos employees%rowtype);
    
    emple1 empleado;
    emple2 empleado;
BEGIN
    SELECT * INTO EMPLE1.DATOS
    FROM EMPLOYEES WHERE EMPLOYEE_ID=100;
    EMPLE1.NOMBRE:=EMPLE1.DATOS.FIRST_NAME||' '||EMPLE1.DATOS.LAST_NAME;
    EMPLE1.SALARIO:=EMPLE1.DATOS.SALARY*0.80;
    EMPLE1.FECHA:=EMPLE1.DATOS.HIRE_DATE;
        DBMS_OUTPUT.PUT_LINE(EMPLE1.NOMBRE);
        DBMS_OUTPUT.PUT_LINE(EMPLE1.SALARIO);
        DBMS_OUTPUT.PUT_LINE(EMPLE1.FECHA);
        DBMS_OUTPUT.PUT_LINE(EMPLE1.DATOS.FIRST_NAME);
        emple2:=emple1;
        DBMS_OUTPUT.PUT_LINE(EMPLE2.NOMBRE);
END;
/

--INSERTS Y UPDATES CON PLP/SQL RECORDS
CREATE TABLE REGIONES AS SELECT * FROM REGIONS WHERE REGION_ID=0;
/
--INSERT
DECLARE
    REG1 REGIONS%ROWTYPE;
BEGIN
    SELECT * INTO REG1 FROM REGIONS WHERE REGION_ID=1;
    
    INSERT INTO REGIONES VALUES REG1;
END;

--UPDATE
DECLARE
    REG1 REGIONS%ROWTYPE;
BEGIN
    REG1.REGION_ID:=1;
    REG1.REGION_NAME:='AUSTRALIA';
    
    UPDATE REGIONES SET ROW=REG1 WHERE REGION_ID=1;
END;

--cursores
--Atributos implícitos
BEGIN
    UPDATE TEST SET C2='PPPP' WHERE C1=100;
    DBMS_OUTPUT.PUT_LINE(SQL%ROWCOUNT);
    IF SQL%FOUND THEN
       DBMS_OUTPUT.PUT_LINE('ENCONTRADO');
       END IF;
       IF SQL%NOTFOUND THEN
       DBMS_OUTPUT.PUT_LINE('NO ENCONTRADO');
       END IF;
END;

--creación de cursor
SET SERVEROUTPUT ON
DECLARE
    CURSOR C1 IS SELECT * FROM REGIONS;
    V1 REGIONS%ROWTYPE;
BEGIN
    OPEN C1;
    FETCH C1 INTO V1;
    DBMS_OUTPUT.PUT_LINE(V1.REGION_NAME);
    FETCH C1 INTO V1;
    DBMS_OUTPUT.PUT_LINE(V1.REGION_NAME);
    CLOSE C1;
END;

--Recorrer un cursor con el bucle loop
SET SERVEROUTPUT ON
DECLARE
    CURSOR C1 IS SELECT * FROM REGIONS;
    V1 REGIONS%ROWTYPE;
BEGIN
    OPEN C1;
    LOOP
        FETCH C1 INTO V1;
        EXIT WHEN C1%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(V1.REGION_NAME);
    END LOOP;
    CLOSE C1;
END;

--Recorrer un cursor con el bucle for
SET SERVEROUTPUT ON
DECLARE
    CURSOR C1 IS SELECT * FROM REGIONS;
    V1 REGIONS%ROWTYPE;
BEGIN
    FOR I IN C1 LOOP
        DBMS_OUTPUT.PUT_LINE(I.REGION_NAME);
    END LOOP;
END;

--Bucle for con subconsultas
SET SERVEROUTPUT ON
BEGIN
    FOR I IN (SELECT * FROM REGIONS) LOOP
        DBMS_OUTPUT.PUT_LINE(I.REGION_NAME);
    END LOOP;
END;

--Cursores con parámetros
DECLARE
  CURSOR C1(SAL number) IS SELECT * FROM employees
  where SALARY> SAL;
  empl EMPLOYEES%ROWTYPE;
BEGIN
  OPEN C1(10000);
  LOOP
      FETCH C1 INTO  empl;
      EXIT WHEN C1%NOTFOUND;
      DBMS_OUTPUT.PUT_LINE(empl.first_name||' '||empl.salary);
  END LOOP;
  dbms_output.put_line('He encontrado '||c1%rowcount||' empleados');
  CLOSE C1;
END;

--Updates y deletes con where current of
DECLARE
 empl employees%rowtype;
  CURSOR cur IS SELECT * FROM employees FOR UPDATE;
BEGIN
  OPEN cur;
  LOOP
    FETCH cur INTO empl;
    EXIT   WHEN cur%notfound;
    IF EMPL.COMMISSION_PCT IS NOT NULL THEN
       UPDATE employees SET SALARY=SALARY*1.10 WHERE CURRENT OF cur;
    ELSE
        UPDATE employees SET SALARY=SALARY*1.15 WHERE CURRENT OF cur;
    END IF;
  END LOOP;
 
  CLOSE cur;
END;
/

--Introduccion a procedimientos y funciones
/*
    1-CREAR EL OBJETO
        CODIGO FUENTE
        CODIGO PSEUDO-COMPILADO
    2-INVOCAR EN CUALQUIER MOMENTO (SQL)
*/

--crear un procedimiento
CREATE OR REPLACE PROCEDURE PR1
IS
    X NUMBER:=10;
BEGIN
    DBMS_OUTPUT.PUT_LINE(X);
END;
/

--Ejecutar un procedimiento
SET SERVEROUTPUT ON
BEGIN
    PR1;
END;
/
--O
EXECUTE PR1;
/
--Crear procedimiento con SqlDeveloper
--Ver codigo fuente de procedimientos y funciones
SELECT * FROM USER_OBJECTS
WHERE OBJECT_TYPE='PROCEDURE';
/

--Parametros tipo IN
CREATE OR REPLACE PROCEDURE CALC_TAX 
(EMPL IN EMPLOYEES.EMPLOYEE_ID%TYPE,
    T1 IN NUMBER)
IS
  TAX NUMBER:=0;
  SAL NUMBER:=0;
BEGIN
   IF T1 <0 OR T1 > 60 THEN 
      RAISE_APPLICATION_ERROR(-20000,'EL PORCENTAJE DEBE ESTAR ENTRE 0 Y 60');
    END IF;
   SELECT SALARY INTO SAL FROM EMPLOYEES    WHERE EMPLOYEE_ID=EMPL;
   --T1:=0;
   TAX:=SAL*T1/100;
   DBMS_OUTPUT.PUT_line('SALARY:'||SAL);
   DBMS_OUTPUT.PUT_line('TAX:'||TAX);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_line('NO EXISTE EL EMPLEADO');
END;
/

set serveroutput on
DECLARE
  A NUMBER;
  B NUMBER;
begin
  A:=120;
  B:=5;
  calc_tax(A,B);
end;
/
 --Parametros de tipo OUT
 create or replace PROCEDURE CALC_TAX_OUT 
(EMPL IN EMPLOYEES.EMPLOYEE_ID%TYPE,
    T1 IN NUMBER,
    R1 OUT NUMBER)
IS
  --TAX NUMBER:=0;
  SAL NUMBER:=0;
BEGIN
   IF T1 <0 OR T1 > 60 THEN 
      RAISE_APPLICATION_ERROR(-20000,'EL PORCENTAJE DEBE ESTAR ENTRE 0 Y 60');
    END IF;    
   SELECT SALARY INTO SAL FROM EMPLOYEES    WHERE EMPLOYEE_ID=EMPL;
   --T1:=0;
   R1:=SAL*T1/100;
   DBMS_OUTPUT.PUT_line('SALARY:'||SAL);
  -- DBMS_OUTPUT.PUT_line('TAX:'||TAX);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
       DBMS_OUTPUT.PUT_line('NO EXISTE EL EMPLEADO');
END;