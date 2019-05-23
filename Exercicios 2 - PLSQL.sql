set serveroutput on;

-- 1
 
 
-- 2
BEGIN 
  for CONTADOR in 1..20 LOOP
  if MOD(CONTADOR,2) = 0 THEN
    DBMS_OUTPUT.PUT_LINE(CONTADOR);
END IF;
END LOOP;
END;

-- 3
DECLARE
    dataCollect  USER_OBJECTS%ROWTYPE;
BEGIN
    SELECT *
      INTO dataCollect
      FROM USER_OBJECTS
     WHERE CREATED = (SELECT MIN(CREATED) FROM USER_OBJECTS) AND ROWNUM = 1;
     
    DBMS_OUTPUT.PUT_LINE('Nome: ' || dataCollect.OBJECT_NAME);
    DBMS_OUTPUT.PUT_LINE('Tipo: ' || dataCollect.OBJECT_TYPE);
    DBMS_OUTPUT.PUT_LINE('Criação da Tabela: ' || TO_CHAR(dataCollect.CREATED, 'DD "de" MONTH "de" YYYY "Horário: " HH24":"MI":"SS'));
END;

-- 4
DECLARE
    v_Data varchar2(100) := '%Data';
    v_Conv varchar2(100);
BEGIN
    v_Conv := TO_CHAR(TO_DATE(v_DATA,'DD/MM/YYYY'), 'DAY');
    DBMS_OUTPUT.PUT_LINE('Dia da semana: ' || v_Conv);
END;

-- 5
DECLARE
    v_Object varchar2(100) := UPPER('&Objeto');
    v_Data varchar2(100);
BEGIN
    SELECT CREATED
    INTO v_Data
    FROM USER_OBJECTS
    WHERE OBJECT_TYPE = v_Object AND ROWNUM = 1;
    
    IF MOD(TO_CHAR(TO_DATE(v_Data, 'DD-MM-YYYY'),'D'),2) = 0 THEN
    DBMS_OUTPUT.PUT_LINE('Data em não conformidade');
    ELSE
    DBMS_OUTPUT.PUT_LINE('Tabela criada no dia: ' || v_Data);
    END IF;
END;

-- 6
DECLARE
    v_Palavra varchar2(100) := '&Word';
    v_Spaces NUMBER;
    v_QtPalavras NUMBER;
BEGIN
        IF LENGTH(v_Palavra) < 5 THEN
                DBMS_OUTPUT.PUT_LINE('Palavra inválida.');
        ELSIF SUBSTR(v_Palavra, 0, (LENGTH(v_Palavra))/2) = ' ' THEN
                DBMS_OUTPUT.PUT_LINE('Palavra inválida.');
        ELSE
            SELECT LENGTH(TRIM(v_Palavra)) - LENGTH(REPLACE(TRIM(v_Palavra),' ',''))
            INTO v_Spaces
            FROM DUAL;
        
            SELECT LENGTH(TRIM(v_Palavra)) - LENGTH(REPLACE(TRIM(v_Palavra),' ','')) + 1
            INTO v_QtPalavras
            FROM DUAL;

        dbms_output.put_line('Quantidade de caracteres: ' || LENGTH(v_Palavra));
        dbms_output.put_line('Quantidade de espaços: ' || v_Spaces);
        dbms_output.put_line('Quantidade de palavras: ' || v_QtPalavras);
        dbms_output.put_line('Primeiro nome: ' || SUBSTR(v_Palavra,0,INSTR(v_Palavra,' ',1)-1));
        dbms_output.put_line('Último nome: ' || SUBSTR(v_Palavra,INSTR(v_Palavra,' ',-1)+1,LENGTH(v_Palavra)));
    END IF;
END;
    
    
 -- 7
 
 
 -- 8
 DECLARE
    v_InitDate varchar2(100) := '&iDate';
    v_EndDate varchar2(100) := '&eDate';
    v_Result NUMBER;
BEGIN
    SELECT COUNT(*) 
    INTO v_Result
    FROM USER_TABLES
    WHERE LAST_ANALYZED BETWEEN TO_DATE(v_InitDate,'DD/MM/YYYY') AND TO_DATE(v_EndDate,'DD/MM/YYYY');
    DBMS_OUTPUT.PUT_LINE ('Quantidade de tabelas criadas no período de ' || v_InitDate || ' até ' || v_EndDate || ': ' ||  v_Result);
END;

-- 9
DECLARE
    v_Tabela varchar(30) := UPPER('TB_CLIENTE');
    v_Join NUMBER;
BEGIN
    SELECT COUNT(INDEX_NAME)
    INTO v_Join
    FROM USER_INDEXES UI
    JOIN USER_TABLES UT
    ON UI.TABLE_NAME = UT.TABLE_NAME
    WHERE UI.TABLE_NAME = v_Tabela;
    
        DBMS_OUTPUT.PUT_LINE('A tabela ' || v_Tabela || ' possui ' || v_Join || ' índices.');
END;
