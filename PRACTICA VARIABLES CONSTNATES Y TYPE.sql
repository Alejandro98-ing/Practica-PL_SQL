SET SERVEROUTPUT ON
DECLARE
    impuesto CONSTANT FLOAT:=0.21;
    precio NUMBER(5,2);
    resultado precio%TYPE;
BEGIN
    precio:=25;
    resultado:=precio*impuesto;
    DBMS_OUTPUT.PUT_LINE('El impuesto del producto es: ');
    DBMS_OUTPUT.PUT_LINE(resultado);
END;