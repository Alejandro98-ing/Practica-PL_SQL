--ejercicio 1
SET SERVEROUTPUT ON
DECLARE
    nombre VARCHAR2(50);
    apellido1 VARCHAR2(50);
    apellido2 VARCHAR2(50);
BEGIN
    nombre:='Alejandro';
    apellido1:='López';
    apellido2:='Clímaco';
     DBMS_OUTPUT.PUT_LINE(UPPER(SUBSTR(nombre,1,1))||'.'||UPPER(SUBSTR(apellido1,1,1))||'.'||UPPER(SUBSTR(apellido2,1,1)));
END;

--ejercicio 2
SET SERVEROUTPUT ON
DECLARE
    diaNacimiento DATE;
BEGIN
    diaNacimiento:='04/03/1998';
     DBMS_OUTPUT.PUT_LINE(TO_CHAR(diaNacimiento,'Day'));
END;