DECLARE
   CONTROL_REGIONES EXCEPTION;
   regn NUMBER;
   regt varchar2(200);
BEGIN
   regn:=201;
   regt:='ANTARTIDA';
   IF regn > 200 THEN
         RAISE CONTROL_REGIONES; --se usa en excepsciones de usuario 
    ELSE
       insert into regions values (regn,regt);
       commit;
      END IF;
EXCEPTION
  WHEN CONTROL_REGIONES THEN  
    DBMS_OUTPUT.PUT_LINE('Codigo no permitido. Debe ser inferior a 200');
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Error indefinido');
END;