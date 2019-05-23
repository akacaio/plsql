set serveroutput on;

DECLARE		
			a	number(2);
      b number(2);
BEGIN		
			FOR	a	in	0	..	10	LOOP		
      IF MOD(a, 2) != 0 THEN
            FOR b in 0 .. 10 LOOP
            dbms_output.put_line('Resultado: ' || a || 'x' || b || '=' || a * b);
            END	LOOP;	
            END IF;
      END	LOOP;		
END;


-- 2
DECLARE
  graus number(5) := 10;    
  converter number(5);
BEGIN
  converter := (graus - 32) * (5/9);
  DBMS_OUTPUT.PUT_LINE('Temperatura ' || converter);
END;

-- 3

DECLARE
  nm varchar2(200) := 'Caio';
  idade number(2) := 19;
BEGIN
  IF LENGTH(nm) < 3 THEN
  DBMS_OUTPUT.PUT_LINE('Nome Inválido');
  ELSIF idade < 18 THEN
  DBMS_OUTPUT.PUT_LINE('Idade incompatível');
  ELSE
  DBMS_OUTPUT.PUT_LINE('Nome: ' || nm || ' - Idade: ' || idade);
  END IF;
END;
  
-- 4

DECLARE
  dt date;
  mes varchar(200);
  dia varchar(200);
  ano varchar(200);
BEGIN
  dt := TO_DATE('20-09-1989','DD-MM-YYYY');
  mes := DATENAME(month, dt);
  dia := DATENAME(day, dt);
  ano := DATENAME(year, dt);
  DBMS_OUTPUT.PUT_LINE(dia || mes || ano);
END;
  
