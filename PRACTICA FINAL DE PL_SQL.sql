--creando tabla LINEAS_FACTURA
CREATE TABLE "C##HR"."LINEAS_FACTURA" 
   (	"COD_FACTURA" NUMBER, 
	"COD_PRODUCTO" NUMBER, 
	"PVP" NUMBER, 
	"UNIDADES" NUMBER, 
	"FECHA" DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
  
--creando la tabla FACTURAS
CREATE TABLE "C##HR"."FACTURAS" 
   (	"COD_FACTURA" NUMBER(5,0), 
	"FECHA" DATE, 
	"DESCRIPCION" VARCHAR2(100 BYTE)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
  
--creacion de tabla PRODUCTOS
CREATE TABLE "C##HR"."PRODUCCTOS" 
   (	"COD_PRODUCTO" NUMBER, 
	"NOMBRE_PRODUCTO" VARCHAR2(50 BYTE), 
	"PVP" NUMBER, 
	"TOTAL_VENDIDOS" NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
  
--creacion de tabla CONTROL_LOG
CREATE TABLE "C##HR"."CONTROLL_LOG" 
   (	"COD_EMPLEADO" VARCHAR2(50), 
	"FECHA" DATE, 
	"TABLA" VARCHAR2(20 BYTE), 
	"COD_OPERACION" CHAR(1 BYTE)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
REM INSERTING into C##HR.LINEAS_FACTURA
SET DEFINE OFF;

--creacion indice unico para tabla LINEAS_FACTURA
CREATE UNIQUE INDEX "C##HR"."LINEAS_FACTURA_PK" ON "C##HR"."LINEAS_FACTURA" ("COD_FACTURA", "COD_PRODUCTO") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
  
--
ALTER TABLE "C##HR"."LINEAS_FACTURA" ADD CONSTRAINT "LINEAS_FACTURA_PK" PRIMARY KEY ("COD_FACTURA", "COD_PRODUCTO")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE;
  ALTER TABLE "C##HR"."LINEAS_FACTURA" MODIFY ("COD_PRODUCTO" NOT NULL ENABLE);
  ALTER TABLE "C##HR"."LINEAS_FACTURA" MODIFY ("COD_FACTURA" NOT NULL ENABLE);
  

REM INSERTING into C##HR.PRODUCCTOS
SET DEFINE OFF;
Insert into C##HR.PRODUCCTOS (COD_PRODUCTO,NOMBRE_PRODUCTO,PVP,TOTAL_VENDIDOS) values ('1','TORNILLO','1',null);
Insert into C##HR.PRODUCCTOS (COD_PRODUCTO,NOMBRE_PRODUCTO,PVP,TOTAL_VENDIDOS) values ('2','TUERCA','5',null);
Insert into C##HR.PRODUCCTOS (COD_PRODUCTO,NOMBRE_PRODUCTO,PVP,TOTAL_VENDIDOS) values ('3','ARANDELA','4',null);
Insert into C##HR.PRODUCCTOS (COD_PRODUCTO,NOMBRE_PRODUCTO,PVP,TOTAL_VENDIDOS) values ('4','MARTILLO','40',null);
Insert into C##HR.PRODUCCTOS (COD_PRODUCTO,NOMBRE_PRODUCTO,PVP,TOTAL_VENDIDOS) values ('5','CLAVO','1',null);
commit;
/
--creacion de paquetes
CREATE OR REPLACE PACKAGE GESTIONAR_FACTURAS IS
    PROCEDURE ALTA_FACTURA(COD_FACT NUMBER, FECHA DATE, DESCRIPCION VARCHAR2);
    PROCEDURE BAJA_FACTURA(COD_FACT NUMBER);
    PROCEDURE MOD_DESCRI(COD_FACT NUMBER, DESCRIP VARCHAR2);
    PROCEDURE MOD_FECHA(COD_FACT NUMBER, FECH DATE);
    FUNCTION NUM_FACTURAS(FECHA_INICIO DATE,FECHA_FIN DATE) RETURN NUMBER;
    FUNCTION TOTAL_FACTURA(COD_FACT NUMBER) RETURN NUMBER;
END GESTIONAR_FACTURAS;

CREATE OR REPLACE PACKAGE BODY GESTIONAR_FACTURAS IS

    FUNCTION EXISTE_FACTURA(COD_FACT NUMBER) RETURN BOOLEAN IS
        CURSOR CURSOR1 IS
        SELECT COD_FACTURA FROM FACTURAS;
    BEGIN
        FOR i IN CURSOR1 LOOP
            IF i.COD_FACTURA = COD_FACT THEN
            RETURN TRUE;
            END IF;
        END LOOP;
        RETURN FALSE;
    END;
    
    PROCEDURE ALTA_FACTURA(COD_FACT NUMBER, FECHA DATE, DESCRIPCION VARCHAR2) AS
        DEVUELTO BOOLEAN;
    BEGIN
        DEVUELTO := EXISTE_FACTURA(COD_FACT);
        IF DEVUELTO = FALSE THEN
            INSERT INTO FACTURAS VALUES(COD_FACT,FECHA,DESCRIPCION);
            DBMS_OUTPUT.PUT_LINE('INSERCION CORRECTA');
        ELSE
            DBMS_OUTPUT.PUT_LINE('LA FACTURA YA EXISTE');
        END IF;
        EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('EL CODIGO YA EXISTE (DUPLICADA)');
    END;
    
    PROCEDURE BAJA_FACTURA(COD_FACT NUMBER) AS
        DEVUELTO BOOLEAN;
        OTRO NUMBER;
    BEGIN
        SELECT COD_FACTURA INTO OTRO FROM FACTURAS
        WHERE COD_FACTURA=COD_FACT;
        DEVUELTO := EXISTE_FACTURA(OTRO);
        IF DEVUELTO = TRUE THEN
            DELETE FROM FACTURAS
            WHERE COD_FACTURA=COD_FACT; 
            DBMS_OUTPUT.PUT_LINE('FACTURA CON CODIGO: '|| COD_FACT||' BORRADA');
        END IF;
        EXCEPTION
        WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('LA FACTURA QUE DESEA DAR DE BAJA NO EXISTE');
    END;
    
    PROCEDURE MOD_DESCRI(COD_FACT NUMBER, DESCRIP VARCHAR2) AS
        DEVUELTO BOOLEAN;
    BEGIN
        DEVUELTO := EXISTE_FACTURA(COD_FACT);
        IF DEVUELTO=TRUE THEN
            UPDATE FACTURAS SET DESCRIPCION = DESCRIP
            WHERE COD_FACTURA=COD_FACT;
            DBMS_OUTPUT.PUT_LINE('LA DESCRIPCION DE LA FACTURA '||COD_FACT||' HA SIDO ACTUALIZADA');
        ELSE
            DBMS_OUTPUT.PUT_LINE('LA FACTURA NO EXISTE');
        END IF;
    END;
    
    PROCEDURE MOD_FECHA(COD_FACT NUMBER, FECH DATE) AS
    DEVUELTO BOOLEAN;
    BEGIN
        DEVUELTO := EXISTE_FACTURA(COD_FACT);
        IF DEVUELTO=TRUE THEN
            UPDATE FACTURAS SET FECHA = FECH
            WHERE COD_FACTURA=COD_FACT;
            DBMS_OUTPUT.PUT_LINE('LA FECHA DE LA FACTURA '||COD_FACT||' HA SIDO ACTUALIZADA');
        ELSE
            DBMS_OUTPUT.PUT_LINE('LA FACTURA NO EXISTE');
        END IF;
    END;
    
    FUNCTION NUM_FACTURAS (FECHA_INICIO DATE,FECHA_FIN DATE) RETURN NUMBER IS
        NUMERO_FACTURAS NUMBER;
    BEGIN
        SELECT count(*) INTO NUMERO_FACTURAS FROM FACTURAS
        WHERE FECHA BETWEEN FECHA_INICIO AND FECHA_FIN;
        RETURN NUMERO_FACTURAS;
    END; 
    
    FUNCTION TOTAL_FACTURA (COD_FACT NUMBER) RETURN NUMBER IS
        TOT_FACTURA FLOAT;
    BEGIN
        SELECT SUM(PVP*UNIDADES)INTO TOT_FACTURA FROM LINEAS_FACTURA
        WHERE COD_FACTURA=COD_FACT;
        RETURN TOT_FACTURA;
    END; 
    
END GESTIONAR_FACTURAS;
/
--prueba del procedimiento ALTA_FACTURA
set serveroutput on
DECLARE
  COD NUMBER;
  FECH DATE;
  DESCRIP VARCHAR2(100);
begin
  COD:=4;
  FECH:='16-10-2023';
  DESCRIP:='VENTA DE CLAVOS';
  GESTIONAR_FACTURAS.ALTA_FACTURA(COD,FECH,DESCRIP);
end;
/

--prueba del procedimiento BAJA_FACTURA
set serveroutput on
DECLARE
  COD NUMBER;
begin
  COD:=5;
  GESTIONAR_FACTURAS.BAJA_FACTURA(COD);
end;
/
--prueba del procedimiento MOD_DESCRI
set serveroutput on
DECLARE
  COD NUMBER;
  FECH DATE;
  DESCRIP VARCHAR2(100);
begin
  COD:=1;
  DESCRIP:='VENTA DE ARANDELAS';
  GESTIONAR_FACTURAS.MOD_DESCRI(COD,DESCRIP);
end;

--prueba del procedimiento MOD_FECHA
set serveroutput on
DECLARE
  COD NUMBER;
  FECH DATE;
begin
  COD:=1;
  FECH:='13-10-2023';
  GESTIONAR_FACTURAS.MOD_FECHA(COD,FECH);
end;
/
--prueba de la funcion NUM_FACTURAS
set serveroutput on
DECLARE
  COD NUMBER;
  FECH DATE;
  N_FACT NUMBER;
begin
  COD:=1;
  FECH:='13-10-2023';
  N_FACT:=GESTIONAR_FACTURAS.NUM_FACTURAS('13-10-2023','16-10-2023');
  DBMS_OUTPUT.PUT_LINE(N_FACT);
end;

--prueba de la funcion TOTAL_FACTURA
set serveroutput on
DECLARE
  COD NUMBER;
  TOT_FACT FLOAT;
begin
  COD:=1;
  TOT_FACT:=GESTIONAR_FACTURAS.TOTAL_FACTURA(COD);
  DBMS_OUTPUT.PUT_LINE('EL TOTAL DE LA FACTURA '||COD||' ES: '||TOT_FACT);
end;

--Creacion del paquete LINEA_FACTURAS
CREATE OR REPLACE PACKAGE LINEAS_FACTURAS IS
    PROCEDURE ALTA_LINEA(COD_FACT NUMBER, COD_PROD NUMBER,UNIDADES_P NUMBER,FECHA DATE);
    PROCEDURE BAJA_LINEA(COD_FACT NUMBER, COD_PROD NUMBER);
    PROCEDURE MOD_PRODUCTO(COD_FACT NUMBER, COD_PROD NUMBER, UNIDADES_P NUMBER);
    PROCEDURE MOD_PRODUCTO(COD_FACT NUMBER, COD_PROD NUMBER, FECH DATE);
    FUNCTION NUM_LINEAS(COD_FACT NUMBER) RETURN NUMBER;
END LINEAS_FACTURAS;

CREATE OR REPLACE PACKAGE BODY LINEAS_FACTURAS IS

    FUNCTION EXISTE_LINEA(COD_FACT NUMBER) RETURN BOOLEAN IS
        CURSOR CURSOR1 IS
        SELECT COD_FACTURA FROM LINEAS_FACTURA;
    BEGIN
        FOR i IN CURSOR1 LOOP
            IF i.COD_FACTURA = COD_FACT THEN
            RETURN TRUE;
            END IF;
        END LOOP;
        RETURN FALSE;
    END;

    FUNCTION EXISTE_PROD(COD_PR NUMBER) RETURN BOOLEAN IS
        CURSOR CURSOR2 IS
        SELECT COD_PRODUCTO FROM PRODUCCTOS;
    BEGIN
        FOR i IN CURSOR2 LOOP
            IF i.COD_PRODUCTO = COD_PR THEN
            RETURN TRUE;
            END IF;
        END LOOP;
        RETURN FALSE;
    END;
    
    PROCEDURE ALTA_LINEA(COD_FACT NUMBER, COD_PROD NUMBER,UNIDADES_P NUMBER,FECHA DATE) AS
        DEVUELTO_L BOOLEAN;
        DEVUELTO_P BOOLEAN;
        PVP_INSERT NUMBER;
    BEGIN
        SELECT PVP INTO PVP_INSERT FROM PRODUCCTOS
        WHERE COD_PRODUCTO=COD_PROD;
        DEVUELTO_L := EXISTE_LINEA(COD_FACT);
        DEVUELTO_P:=EXISTE_PROD(COD_PROD);
        IF DEVUELTO_L = FALSE AND DEVUELTO_P THEN
            INSERT INTO LINEAS_FACTURA VALUES(COD_FACT,COD_PROD,PVP_INSERT,UNIDADES_P,FECHA);
            DBMS_OUTPUT.PUT_LINE('INSERCION CORRECTA');
        ELSE
            DBMS_OUTPUT.PUT_LINE('LA LINEA YA EXISTE');
        END IF;
        EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('EL CODIGO YA EXISTE (DUPLICADA)');
    END;
    
    PROCEDURE BAJA_LINEA(COD_FACT NUMBER, COD_PROD NUMBER) AS
        DEVUELTO_L BOOLEAN;
        DEVUELTO_P BOOLEAN;
        OTRO NUMBER;
    BEGIN
        SELECT COD_FACTURA INTO OTRO FROM LINEAS_FACTURA
        WHERE COD_FACTURA=COD_FACT;
        DEVUELTO_L := EXISTE_LINEA(OTRO);
        DEVUELTO_P:=EXISTE_PROD(COD_PROD);
        IF DEVUELTO_L = TRUE AND DEVUELTO_P = TRUE THEN
            DELETE FROM LINEAS_FACTURA
            WHERE COD_FACTURA=COD_FACT; 
            DBMS_OUTPUT.PUT_LINE('LINEA CON CODIGO: '|| COD_FACT||' BORRADA');
        END IF;
        EXCEPTION
        WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('LA LINEA QUE DESEA DAR DE BAJA NO EXISTE');
    END;
    
    PROCEDURE MOD_PRODUCTO(COD_FACT NUMBER, COD_PROD NUMBER, UNIDADES_P NUMBER) AS
        DEVUELTO_L BOOLEAN;
        DEVUELTO_P BOOLEAN;
    BEGIN
        DEVUELTO_L := EXISTE_LINEA(COD_FACT);
        DEVUELTO_P:=EXISTE_PROD(COD_PROD);
        IF DEVUELTO_L = TRUE AND DEVUELTO_P = TRUE THEN
            UPDATE LINEAS_FACTURA SET UNIDADES = UNIDADES_P
            WHERE COD_FACTURA=COD_FACT;
            DBMS_OUTPUT.PUT_LINE('LA DESCRIPCION DE LA LINEA '||COD_FACT||' HA SIDO ACTUALIZADA');
        ELSE
            DBMS_OUTPUT.PUT_LINE('LA LINEA NO EXISTE');
        END IF;
    END;
    
    PROCEDURE MOD_PRODUCTO(COD_FACT NUMBER, COD_PROD NUMBER, FECH DATE) AS
    DEVUELTO_L BOOLEAN;
    DEVUELTO_P BOOLEAN;
    BEGIN
        DEVUELTO_L := EXISTE_LINEA(COD_FACT);
        DEVUELTO_P:=EXISTE_PROD(COD_PROD);
        IF DEVUELTO_L=TRUE AND DEVUELTO_P=TRUE THEN
            UPDATE LINEAS_FACTURA SET FECHA = FECH
            WHERE COD_FACTURA=COD_FACT;
            DBMS_OUTPUT.PUT_LINE('LA FECHA DE LA LINEA '||COD_FACT||' HA SIDO ACTUALIZADA');
        ELSE
            DBMS_OUTPUT.PUT_LINE('LA LINEA NO EXISTE');
        END IF;
    END;
    
    FUNCTION NUM_LINEAS(COD_FACT NUMBER) RETURN NUMBER IS
        NUMERO_LINEAS NUMBER;
    BEGIN
        SELECT count(*) INTO NUMERO_LINEAS FROM LINEAS_FACTURA
        WHERE COD_FACTURA=COD_FACT;
        RETURN NUMERO_LINEAS;
    END;    
END LINEAS_FACTURAS;
/
--prueba de procedimiento ALTA_LINEA
set serveroutput on
DECLARE
  COD_F NUMBER;
  COD_P NUMBER;
  UNID NUMBER;
  FECH DATE;
begin
  COD_F:=4;
  COD_P:=5;
  UNID:=14;
  FECH:='16-10-2023';
  LINEAS_FACTURAS.ALTA_LINEA(COD_F,COD_P,UNID,FECH);
end;
/

--prueba del procedimiento BAJA_FACTURA
set serveroutput on
DECLARE
  COD_F NUMBER;
  COD_P NUMBER;
begin
  COD_F:=3;
  COD_P:=4;
  LINEAS_FACTURAS.BAJA_LINEA(COD_F,COD_P);
end;
/
--prueba del procedimiento MOD_PRODUCTO con unidades
set serveroutput on
DECLARE
  COD_F NUMBER;
  COD_P NUMBER;
  UNI_P NUMBER;
begin
  COD_F:=4;
  COD_P:=5;
  UNI_P:=20;
  LINEAS_FACTURAS.MOD_PRODUCTO(COD_F,COD_P,UNI_P);
end;

--prueba del procedimiento MOD_PRODUCTO con fecha
set serveroutput on
DECLARE
  COD_F NUMBER;
  COD_P NUMBER;
  FECH DATE;
begin
  COD_F:=4;
  COD_P:=5;
  FECH:='12-10-2023';
  LINEAS_FACTURAS.MOD_PRODUCTO(COD_F,COD_P,FECH);
end;
/
--prueba de la funcion NUM_LINEAS
set serveroutput on
DECLARE
  COD NUMBER;
  N_FACT NUMBER;
begin
  COD:=1;
  N_FACT:=LINEAS_FACTURAS.NUM_LINEAS(COD);
  DBMS_OUTPUT.PUT_LINE(N_FACT);
end;

--creacion de Triggers
CREATE OR REPLACE TRIGGER TRIG_FACTURA
AFTER INSERT OR UPDATE OR DELETE ON FACTURAS
DECLARE
  accion VARCHAR2(10);
BEGIN
  IF INSERTING THEN
    accion := 'I';
    INSERT INTO CONTROLL_LOG VALUES(USER,SYSDATE,'FACTURAS',ACCION); 
  ELSIF UPDATING THEN
    accion := 'U';
    INSERT INTO CONTROLL_LOG VALUES(USER,SYSDATE,'FACTURAS',ACCION); 
  ELSIF DELETING THEN
    accion := 'D';
    INSERT INTO CONTROLL_LOG VALUES(USER,SYSDATE,'FACTURAS',ACCION); 
  END IF;
END;
/
INSERT INTO FACTURAS VALUES(5,'17-10-2023','VENTA DE TORNILLOS');
UPDATE FACTURAS SET DESCRIPCION='VENTA DE BROCHAS' WHERE COD_FACTURA=5;
DELETE FROM FACTURAS WHERE COD_FACTURA=5;

--creacion de trigger para tabla LINEAS_FACTURA
CREATE OR REPLACE TRIGGER TRIG_LINEAS_FACTURA
AFTER INSERT OR UPDATE OR DELETE ON LINEAS_FACTURA
DECLARE
  accion VARCHAR2(10);
BEGIN
  IF INSERTING THEN
    accion := 'I';
    INSERT INTO CONTROLL_LOG VALUES(USER,SYSDATE,'LINEAS_FACTURA',ACCION); 
  ELSIF UPDATING THEN
    accion := 'U';
    INSERT INTO CONTROLL_LOG VALUES(USER,SYSDATE,'LINEAS_FACTURA',ACCION); 
  ELSIF DELETING THEN
    accion := 'D';
    INSERT INTO CONTROLL_LOG VALUES(USER,SYSDATE,'LINEAS_FACTURA',ACCION); 
  END IF;
END;
/
INSERT INTO LINEAS_FACTURA VALUES(5,3,2,17,'17-10-2023');
UPDATE LINEAS_FACTURA SET COD_PRODUCTO=5,UNIDADES=25  WHERE COD_FACTURA=5;
DELETE FROM LINEAS_FACTURA WHERE COD_FACTURA=5;
/

--trigger para controlar la columna TOTAL_VENDIDOS de la tabla PRODUCTOS
CREATE OR REPLACE TRIGGER TAB_LINEAS_FACTURAS_PRECIO
BEFORE DELETE OR INSERT OR UPDATE ON LINEAS_FACTURA
FOR EACH ROW
DECLARE
   TOTAL_ACTUALIZAR NUMBER:=0;
BEGIN
  IF INSERTING THEN
     UPDATE PRODUCCTOS SET TOTAL_VENDIDOS=TOTAL_VENDIDOS+(:NEW.PVP*:NEW.UNIDADES)
     WHERE COD_PRODUCTO=:NEW.COD_PRODUCTO;
  END IF;
IF UPDATING THEN
    TOTAL_ACTUALIZAR:=(:OLD.PVP*:OLD.UNIDADES)-(:NEW.PVP*:NEW.UNIDADES);
    UPDATE PRODUCCTOS SET TOTAL_VENDIDOS=TOTAL_VENDIDOS+TOTAL_ACTUALIZAR
    WHERE COD_PRODUCTO=:NEW.COD_PRODUCTO;
  END IF;
  IF DELETING THEN
    UPDATE PRODUCCTOS SET TOTAL_VENDIDOS=TOTAL_VENDIDOS-(:NEW.PVP*:NEW.UNIDADES)
     WHERE COD_PRODUCTO=:NEW.COD_PRODUCTO;
  END IF;
END;
/

INSERT INTO LINEAS_FACTURA VALUES(8,4,2,5,'17-10-2023');
UPDATE LINEAS_FACTURA SET PVP=5 WHERE COD_FACTURA=9;
DELETE FROM LINEAS_FACTURA WHERE COD_PRODUCTO=4;