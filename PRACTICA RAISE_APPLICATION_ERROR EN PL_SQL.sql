DECLARE
   reg_max EXCEPTION;
   regn NUMBER;
   regt varchar2(200);
BEGIN
   regn:=103;
   regt:='ASIA';
   IF regn > 100 THEN
         RAISE reg_max; --se usa en excepsciones de usuario 
    ELSE
       insert into regions values (regn,regt);
       commit;
      END IF;
EXCEPTION
  WHEN reg_max THEN  
    RAISE_APPLICATION_ERROR(-20001,'LA ID DEBE SER INFERIOR DE 100');  
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Error indefinido');
END;