-- 1

DECLARE

  CURSOR c_Veiculo (cod LOC_GRUPO.CD_GRUPO%TYPE) IS
  SELECT CD_GRUPO, DS_GRUPO
  FROM LOC_GRUPO
  WHERE CD_GRUPO = cod;
  
  vCount INTEGER;
  vRegistro c_Veiculo%ROWTYPE;
  
BEGIN

    OPEN c_Veiculo(2);
  LOOP
    FETCH c_Veiculo INTO vRegistro;
    EXIT WHEN c_Veiculo%notFound;
    
  SELECT COUNT(1) INTO vCount
  FROM LOC_GRUPO
  WHERE CD_GRUPO = 2;
  
  IF (vCount = 0) THEN
    DBMS_OUTPUT.PUT_LINE('NÃO EXISTE DADOS DE GRUPO DE VEÍCULO CADASTRADO !!');  
  ELSE
    DBMS_OUTPUT.PUT_LINE('O código do grupo de veículo ' || vRegistro.CD_GRUPO || '  tem a sua descrição como ' || vRegistro.DS_GRUPO);
    END IF;
 END LOOP;
END;


-- 2

DECLARE
  CURSOR c_Depto(cod LOC_DEPTO.CD_DEPTO%type) IS
  SELECT CD_DEPTO, NM_DEPTO
  FROM LOC_DEPTO
  WHERE CD_DEPTO = cod;

  vRegistro c_Depto%ROWTYPE;
  
BEGIN

  OPEN c_Depto(10);

    FETCH c_Depto INTO vRegistro; 
    IF c_Depto%NotFound THEN
      DBMS_OUTPUT.PUT_LINE('Não existe dados de departamento cadastrado.');
    ELSE
      DBMS_OUTPUT.PUT_LINE('Departamento: ' || vRegistro.CD_DEPTO || ' - ' || vRegistro.NM_DEPTO);
    END IF;
  CLOSE c_Dados;

END;

-- 3

SET SERVEROUTPUT ON

DECLARE
  CURSOR c_Dados(COD LOC_DEPTO.CD_DEPTO%TYPE) IS
  SELECT DPTO.CD_DEPTO, DPTO.NM_DEPTO, FUNC.NM_FUNC
  FROM LOC_DEPTO DPTO
  INNER JOIN LOC_FUNCIONARIO FUNC
  ON DPTO.CD_DEPTO = FUNC.CD_DEPTO
  WHERE DPTO.CD_DEPTO = COD
  ORDER BY DPTO.CD_DEPTO ASC;
  
  v_Registro c_Dados%ROWTYPE;

BEGIN

  OPEN c_Dados(10);
  FETCH c_Dados INTO v_Registro;
  
  IF c_Dados%NOTFOUND THEN
    DBMS_OUTPUT.PUT_LINE('Não existe departamento cadastrado com este código');
  ELSE
    DBMS_OUTPUT.PUT_LINE('Código do Depto: ' || v_Registro.CD_DEPTO || '. Nome Depto: ' || v_Registro.NM_DEPTO || '. Nome Func: ' || v_Registro.NM_FUNC);
  END IF;
  CLOSE c_Dados;
  
END;

-- 4

SELECT * FROM LOC_VEICULO;
SELECT * FROM LOC_PROPRIETARIO;
SELECT * FROM LOC_GRUPO;


DECLARE
  
  CURSOR c_Dados IS
      SELECT V.NR_PLACA
            ,P.NOME_PROPRIETARIO
            ,V.TIPO_AUTOMOVEL
            ,V.MODELO
            ,V.COR
            ,G.DS_GRUPO 
      FROM LOC_VEICULO V
      
      JOIN LOC_PROPRIETARIO P
      ON V.CD_PROPRIETARIO = P.CD_PROPRIETARIO
      
      JOIN LOC_GRUPO G
      ON G.CD_GRUPO = V.CD_GRUPO
      
      WHERE G.DS_GRUPO LIKE 'Carro Básico' OR G.DS_GRUPO LIKE 'Carro com ar condicionado';
      
      v_Reg c_Dados%ROWTYPE;
      v_Count NUMBER := 0;
BEGIN

  DELETE VEICULOS_CARLOCA;
    OPEN c_Dados;
    
    LOOP
      FETCH c_Dados INTO v_Reg;
      EXIT WHEN c_Dados%NOTFOUND;
      
      INSERT INTO VEICULOS_CARLOCA VALUES v_Reg;
      v_Count := v_Count+ 1;
    END LOOP;
    CLOSE c_Dados;
    DBMS_OUTPUT.PUT_LINE('Registros Inseridos: ' || v_Count);

END;

-- 5

DECLARE
      
      CURSOR c_Dados(ddd LOC_DDD.SEQ_DDD%TYPE) IS
      SELECT SEQ_DDD, CIDADE_DDD, ESTADO_DDD
      FROM LOC_DDD
      WHERE SEQ_DDD = ddd;
      
      v_Reg c_Dados%ROWTYPE;
BEGIN

    OPEN c_Dados(015);
      FETCH c_Dados INTO v_Reg;
     IF c_Dados%NOTFOUND THEN
      DBMS_OUTPUT.PUT_LINE('Não existe este DDD cadastrado.');
     ELSE
      DBMS_OUTPUT.PUT_LINE('O DDD ' || v_Reg.SEQ_DDD || ' pertence a Cidade de ' || v_Reg.CIDADE_DDD || ' e ao Estado: ' || v_Reg.ESTADO_DDD);
     END IF;
     CLOSE c_Dados;
END;