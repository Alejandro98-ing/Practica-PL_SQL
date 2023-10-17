SET SERVEROUTPUT ON
DECLARE
    usuario VARCHAR(40);
BEGIN
    usuario := USER;
    CASE usuario
        WHEN 'SYS'  THEN DBMS_OUTPUT.PUT_LINE('Eres un superadministrador');
        WHEN 'SYSTEM' THEN DBMS_OUTPUT.PUT_LINE('Eres un administrador normal');
        WHEN 'C##HR' THEN DBMS_OUTPUT.PUT_LINE('Eres de recursos humanos');
        ELSE DBMS_OUTPUT.PUT_LINE('Usuario no autorizado');
    END CASE;
    DBMS_OUTPUT.PUT_LINE(usuario);
END;