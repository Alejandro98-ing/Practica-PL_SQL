--Ejercicio 1
DECLARE
    COD_DEPARTAMENTO DEPARTMENTS.DEPARTMENT_ID%TYPE;
    --NUEVO_COD_DEP DEPARTMENTS.DEPARTMENT_ID%TYPE;
BEGIN
    SELECT
    MAX(DEPARTMENT_ID) INTO COD_DEPARTAMENTO
    FROM DEPARTMENTS;
    --nuevo_cod_dep:=COD_DEPARTAMENTO+1;
    INSERT INTO DEPARTMENTS(DEPARTMENT_ID,
    DEPARTMENT_NAME,MANAGER_ID,LOCATION_ID) 
    VALUES ((COD_DEPARTAMENTO+1),
    'INFORMATICA', 100, 1000);
    COMMIT;
END;

--Ejercicio 2
DECLARE
    ID_DEP DEPARTMENTS.DEPARTMENT_ID%TYPE;
BEGIN
    ID_DEP:=271;
    UPDATE DEPARTMENTS SET LOCATION_ID='1700' WHERE DEPARTMENT_ID=ID_DEP;
    COMMIT;
END;

--Ejercicio 3
DECLARE
    ID_DEP DEPARTMENTS.DEPARTMENT_ID%TYPE;
BEGIN
    ID_DEP:=271;
    DELETE FROM DEPARTMENTS WHERE DEPARTMENT_ID=ID_DEP;
    COMMIT;
END;