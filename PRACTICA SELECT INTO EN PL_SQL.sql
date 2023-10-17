--Ejercicio 1
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

--Ejercicio 2
SET SERVEROUTPUT ON
DECLARE
    tipo_trabajo VARCHAR(50);
BEGIN
    SELECT
    JOB_ID INTO tipo_trabajo
    FROM
    EMPLOYEES
    WHERE
    EMPLOYEE_ID=100;
    DBMS_OUTPUT.PUT_LINE(tipo_trabajo);
END;

--Ejercicio 3
SET SERVEROUTPUT ON
DECLARE
    department_cod DEPARTMENTS.DEPARTMENT_ID%TYPE:=10;
    nombre_departamento DEPARTMENTS.DEPARTMENT_NAME%TYPE;
    numero_empleados NUMBER;
BEGIN
    SELECT
    DEPARTMENT_NAME INTO nombre_departamento
    FROM DEPARTMENTS
    WHERE DEPARTMENTS.DEPARTMENT_ID=department_cod;
    
    SELECT
    COUNT(EMPLOYEE_ID) INTO numero_empleados
    FROM EMPLOYEES
    WHERE EMPLOYEES.DEPARTMENT_ID=department_cod;
    DBMS_OUTPUT.PUT_LINE('Nombre del departamento: '||nombre_departamento);
    DBMS_OUTPUT.PUT_LINE('Numero de empleados que tiene: '||numero_empleados);
END;

--Ejercicio 4
SET SERVEROUTPUT ON
DECLARE
    salario_maximo NUMBER;
    salario_minimo NUMBER;
BEGIN
    SELECT
    MAX(MAX_SALARY) INTO salario_maximo
    FROM JOBS;
    
    SELECT
    COUNT(MIN_SALARY) INTO salario_minimo
    FROM JOBS;
    DBMS_OUTPUT.PUT_LINE('Salario máximo de la empresa: $'||salario_maximo);
    DBMS_OUTPUT.PUT_LINE('Salario mínimo de la empresa: $'||salario_minimo);
    DBMS_OUTPUT.PUT_LINE('Diferiencia entre los salarios: $'|| (salario_maximo-salario_minimo));
END;