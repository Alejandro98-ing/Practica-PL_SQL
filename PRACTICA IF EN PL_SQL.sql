--Ejercicio 1
SET SERVEROUTPUT ON
DECLARE
    parOimpar number:=17;
BEGIN
    IF MOD(parOimpar,2) = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Es par');
    ELSIF MOD(parOimpar,2) != 0 THEN
        DBMS_OUTPUT.PUT_LINE('Es impar');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Algo salio mal');
    END IF;
END;

--Ejercicio 2
SET SERVEROUTPUT ON
DECLARE
    TIPO_PRODUCTO char(1);
BEGIN
    TIPO_PRODUCTO := 'Z';
    
    IF TIPO_PRODUCTO = 'A' THEN
        DBMS_OUTPUT.PUT_LINE('Electrónica');
    ELSIF TIPO_PRODUCTO = 'B' THEN
        DBMS_OUTPUT.PUT_LINE('Informática');
    ELSIF TIPO_PRODUCTO = 'C' THEN
        DBMS_OUTPUT.PUT_LINE('Ropa');
    ELSIF TIPO_PRODUCTO = 'D' THEN
        DBMS_OUTPUT.PUT_LINE('Música');
    ELSIF TIPO_PRODUCTO = 'E' THEN
        DBMS_OUTPUT.PUT_LINE('Libros');
    ELSE
        DBMS_OUTPUT.PUT_LINE('El código es incorrecto');
    END IF;
END;