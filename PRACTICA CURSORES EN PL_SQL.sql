--Ejercicio 1
SET SERVEROUTPUT ON
DECLARE
    CURSOR C1 IS SELECT FIRST_NAME, LAST_NAME, SALARY FROM EMPLOYEES;
BEGIN
    FOR I IN C1 LOOP
        IF  I.FIRST_NAME = 'Steven' AND I.LAST_NAME = 'King' THEN
           -- EL CODIGO DEBE ESTAR ENTRE -20000 Y -20999
        RAISE_APPLICATION_ERROR(-20001,'EL SUELDO DEL JEFE NO SE PUEDE VER');
        ELSE
            DBMS_OUTPUT.PUT_LINE(I.FIRST_NAME||' '||I.LAST_NAME||' '||I.SALARY);
        END IF;
    END LOOP;
END;

--Ejercicio 2
DECLARE
  CURSOR C1 IS SELECT * FROM DEPARTMENTS where MANAGER_ID IS NOT NULL;
  JEFES DEPARTMENTS%ROWTYPE;
BEGIN
  OPEN C1;
  LOOP
      FETCH C1 INTO  JEFES;
      EXIT WHEN C1%NOTFOUND;
      DBMS_OUTPUT.PUT_LINE('Id del jefe: '||JEFES.MANAGER_ID);
  END LOOP;
    dbms_output.put_line('He encontrado '||c1%rowcount||' jefes');
  CLOSE C1;
END;

SET SERVEROUTPUT ON
DECLARE
    departamento DEPARTMENTS%ROWTYPE;
    jefe DEPARTMENTS.MANAGER_ID%TYPE;
    CURSOR C1 IS SELECT * FROM EMPLOYEES;
    CURSOR C2(j DEPARTMENTS.MANAGER_ID%TYPE)
    IS SELECT * FROM DEPARTMENTS WHERE MANAGER_ID=j;
begin
    for EMPLEADO in c1 loop
    open C2(EMPLEADO.employee_id) ;
    FETCH C2 into departamento;
    if c2%NOTFOUND then
        DBMS_OUTPUT.PUT_LINE(EMPLEADO.FIRST_NAME ||' no es jefe de nada');
    ELSE
        DBMS_OUTPUT.PUT_LINE(EMPLEADO.FIRST_NAME || ' es jefe del departamento '|| DEPARTAMENTO.DEPARTMENT_NAME);
    END IF;
    CLOSE C2;
    END LOOP;
END;

DECLARE
    CODIGO DEPARTMENTS.DEPARTMENT_ID%TYPE;
  CURSOR C1(COD DEPARTMENTS.DEPARTMENT_ID%TYPE) IS SELECT COUNT(*) FROM EMPLOYEES where DEPARTMENT_ID=COD;
  JEFES C1%ROWTYPE;
    numero_empleado NUMBER;
BEGIN
    CODIGO:=10;
  OPEN C1(CODIGO);
      FETCH C1 INTO  numero_empleado;
      EXIT WHEN C1%NOTFOUND;
      DBMS_OUTPUT.PUT_LINE('Id del primer jefe: '||JEFES.MANAGER_ID);
  CLOSE C1;
END;

--Ejercicio 3
SET SERVEROUTPUT ON
DECLARE
    codigo DEPARTMENTS.DEPARTMENT_ID%TYPE;
    CURSOR C1(COD DEPARTMENTS.DEPARTMENT_ID%TYPE ) IS
    SELECT COUNT(*) FROM employees
    WHERE DEPARTMENT_ID=COD;
    NUM_EMPLE NUMBER;
BEGIN
    codigo:=10;
    OPEN C1(codigo);
    FETCH C1 INTO NUM_EMPLE;
    DBMS_OUTPUT.PUT_LINE('El n�mero de empleados del departamento ' ||codigo||' es '||num_emple);
END;

--Ejercicio 4
BEGIN
     FOR emple IN(SELECT * FROM EMPLOYEES WHERE JOB_ID='ST_CLERK') LOOP
     DBMS_OUTPUT.PUT_LINE(emple.FIRST_NAME);
     END LOOP;
END;

--Ejercicio 5
SET SERVEROUTPUT ON
DECLARE
    CURSOR C1 IS SELECT * FROM EMPLOYEES for update;
BEGIN
    FOR EMPLEADO IN C1 LOOP
        IF EMPLEADO.SALARY > 8000 THEN
            UPDATE EMPLOYEES SET SALARY=SALARY+(SALARY*0.02)
            WHERE CURRENT OF C1;
        ELSE
            UPDATE EMPLOYEES SET SALARY=SALARY+(SALARY*0.03)
            WHERE CURRENT OF C1;
        END IF;
    END LOOP;
    COMMIT;
END ;