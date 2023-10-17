--Ejercicio 1 
--bucle while
DECLARE
    x1 NUMBER := 1;
    x2 NUMBER := 1;
BEGIN
    WHILE x1 <11 LOOP
        DBMS_OUTPUT.PUT_LINE('Tabla del '||x1);
        WHILE x2 <11 LOOP
            DBMS_OUTPUT.PUT_LINE(x1||'*'||x2||'='||x1*x2);
            x2:=x2+1;
        END LOOP;
        x2:=0;
        x1:=x1+1;
    END LOOP;
END;

--bucle loop
DECLARE
    x1 NUMBER := 1;
    x2 NUMBER := 1;
BEGIN
    LOOP 
    EXIT WHEN x1 =11;
        DBMS_OUTPUT.PUT_LINE('Tabla del '||x1);
        LOOP
            DBMS_OUTPUT.PUT_LINE(x1||'*'||x2||'='||x1*x2);
            x2:=x2+1;
            EXIT WHEN x2 =11;
        END LOOP;
        x2:=0;
        x1:=x1+1;
    END LOOP;
END;

--bucle for
BEGIN
    FOR i IN 1..10 LOOP
    EXIT WHEN i=11;
        dbms_output.put_line('Tabla del '||i);
        FOR j IN 1..10 LOOP
            dbms_output.put_line(i||'*'||j||'='||i*j);
            EXIT WHEN j=11;
        END LOOP;
    END LOOP;
END;

--Ejercicio 2 y 3
DECLARE
    TEXTO VARCHAR2(100);
    reco NUMBER :=0;
    INVERTIDA VARCHAR2(100);
BEGIN
    TEXTO:=LOWER('SI FUNCIONA NO LO TOQUES XD');
    RECO:=LENGTH(TEXTO);
    WHILE RECO>0 LOOP
        INVERTIDA:=INVERTIDA||SUBSTR(TEXTO, RECO,1);
        RECO:=RECO-1;
        EXIT WHEN INSTR(RECO,LOWER('x'))=0;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('Frase original ');
    DBMS_OUTPUT.PUT_LINE(TEXTO);
    DBMS_OUTPUT.PUT_LINE('Frase truncada al encontrar X en la cadena de texto ');
    DBMS_OUTPUT.PUT_LINE(INVERTIDA);
END;

--ejercicio 4
SET SERVEROUTPUT ON
DECLARE
    NOMBRE VARCHAR2(100) := 'ALEJANDRO';
    TAM NUMBER:=LENGTH(NOMBRE);
    NOMBREASTERISCOS VARCHAR2(100);
BEGIN
    FOR i IN 1..TAM LOOP
    NOMBREASTERISCOS:=NOMBREASTERISCOS||'*';
    END LOOP;
    dbms_output.put_line(NOMBRE);
    dbms_output.put_line(NOMBREASTERISCOS);
END;

--ejercicio 5
SET SERVEROUTPUT ON
DECLARE
    inicio NUMBER := 1;
    fin NUMBER := 50;
    multiplo NUMBER := 0;
BEGIN
    WHILE inicio <= fin LOOP
        IF inicio MOD 4 = 0 THEN
            DBMS_OUTPUT.PUT_LINE('El número ' || inicio || ' es múltiplo de 4.');
        END IF;
        inicio:=inicio+1;
    END LOOP;
END;