create or replace TYPE PRODUCTO  AS OBJECT (

--Atributos
codigo number,
nombre varchar2(100),
precio number,

--Métodos
MEMBER FUNCTION ver_producto RETURN VARCHAR2 ,
MEMBER FUNCTION ver_precio  RETURN NUMBER,
MEMBER PROCEDURE cambiar_precio(pvp number)
);

create or replace TYPE body PRODUCTO  AS 
MEMBER FUNCTION ver_producto RETURN VARCHAR2 as 
begin
    return nombre||' '||precio;

end ver_producto;

MEMBER FUNCTION ver_precio  RETURN NUMBER as
begin
  return precio;
end ver_precio;

MEMBER PROCEDURE cambiar_precio(pvp number) as
begin
  precio:=pvp;
end cambiar_precio;
end;
/

create or replace type comestibles under producto(
caducidad date,
MEMBER FUNCTION ver_caducidad RETURN VARCHAR2
);
/


create or replace type body comestibles as 
MEMBER FUNCTION ver_caducidad RETURN VARCHAR2 as
begin
return caducidad;
end;
end;
/

declare
 v1 comestibles:=comestibles(900,'tornillos',20,sysdate());
begin
 dbms_output.put_line(v1.ver_precio());
 dbms_output.put_line(v1.ver_precio(10));
 dbms_output.put_line(v1.ver_caducidad);
 
 end;
 /
 
CREATE TABLE TIENDA
(CODIGO NUMBER,
ESTANTERIA NUMBER,
PRODUCTO PRODUCTO);

DESC TIENDA;

INSERT INTO TIENDA VALUES(1,1,PRODUCTO(1,'limon','90'));

SELECT * FROM TIENDA;

SELECT T.PRODUCTO.PRECIO FROM TIENDA T;

SELECT T.PRODUCTO.VER_PRODUCTO() FROM TIENDA T;