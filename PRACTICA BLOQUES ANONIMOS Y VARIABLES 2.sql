SET SERVEROUTPUT ON
DECLARE 
    x3 CONSTANT NUMBER:=7;
    x1 INTEGER(5);
    x2 INTEGER(5);
BEGIN
    X1:=15;
    x2:=10;
    x3:=9;
    DBMS_OUTPUT.PUT_LINE('EL RESULTADO DE LA SUMA ES: ');
    DBMS_OUTPUT.PUT_LINE(x1+x2+x3);    
END;

SET SERVEROUTPUT ON
DECLARE 
    nombre VARCHAR(15);
    edad NUMBER;
    fecha_nacimiento DATE;
    
BEGIN
    nombre:='ALEJANDRO LOPEZ';
    edad:=25;
    fecha_nacimiento:='04/03/1998';
    DBMS_OUTPUT.PUT_LINE(nombre);
    DBMS_OUTPUT.PUT_LINE(edad);
    DBMS_OUTPUT.PUT_LINE(fecha_nacimiento);
END;

SET SERVEROUTPUT ON
DECLARE 
    nombre VARCHAR(15);
    edad NUMBER;
    fecha_nacimiento DATE;
    
BEGIN
    nombre:='ALEJANDRO LOPEZ';
    edad:=25;
    fecha_nacimiento:='04/03/1998';
    DBMS_OUTPUT.PUT_LINE('Nombre: ' || nombre || ' Edad: ' || TO_CHAR(edad) || ' Fecha de Nacimiento: ' || TO_CHAR(fecha_nacimiento));
END;