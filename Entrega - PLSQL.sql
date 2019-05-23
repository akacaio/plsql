---- EX1

DECLARE
  v_Codigo NUMBER := 100;
  v_Properties LOC_PROPRIETARIO%rowType;
BEGIN
  SELECT CD_PROPRIETARIO,
         NOME_PROPRIETARIO, 
         TP_PROPRIETARIO
  INTO v_Properties.CD_PROPRIETARIO, v_Properties.NOME_PROPRIETARIO, v_Properties.TP_PROPRIETARIO
  FROM LOC_PROPRIETARIO
  WHERE CD_PROPRIETARIO = v_Codigo;
  
    IF v_Properties.TP_PROPRIETARIO = 'F' THEN 
       v_Properties.TP_PROPRIETARIO := 'P';
      ELSE v_Properties.TP_PROPRIETARIO := 'J';
    END IF;
    DBMS_OUTPUT.PUT_LINE('O proprietário ' || v_Properties.CD_PROPRIETARIO || ' - ' ||
                          v_Properties.NOME_PROPRIETARIO || ' é ' ||
                          v_Properties.TP_PROPRIETARIO);
  
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      DBMS_OUTPUT.PUT_LINE('Não existem dados de proprietário cadastrado!!');
END;

------ EX2

DECLARE
  v_placa loc_veiculo.nr_placa%type := 'CZR9988';
  cursor c_result is
  SELECT v.NR_PLACA as placa,
       p.NOME_PROPRIETARIO as proprietario,
       v.MODELO as modelo,
       v.COR as cor
  FROM LOC_VEICULO v
  JOIN LOC_PROPRIETARIO p 
  ON p.CD_PROPRIETARIO = v.CD_PROPRIETARIO
  WHERE v.NR_PLACA = v_placa;

  v_Result  c_result%rowtype;
BEGIN
  OPEN c_result;
  LOOP
    FETCH c_result INTO v_Result;
    EXIT WHEN c_result%notfound;
  END LOOP;
  CLOSE c_result;
  
  IF v_Result.placa IS NOT NULL THEN
      DBMS_OUTPUT.PUT_LINE('O veículo de placa ' || v_Result.placa 
      || ' pertence ao proprietário ' || v_Result.proprietario || ' é do modelo '
      || v_Result.modelo || ' e tem a cor ' || v_Result.cor || '.');
  ELSE
    DBMS_OUTPUT.PUT_LINE('Não existe dados de veiculos cadastrado!!');
  END IF;
END;

--- EX3

DECLARE
  v_proprietario loc_veiculo.cd_proprietario%type := 21122;
  cursor c_result is
  SELECT v.NR_PLACA as placa,
       p.NOME_PROPRIETARIO as proprietario,
       v.MODELO as modelo,
       v.COR as cor
  FROM LOC_VEICULO v
  JOIN LOC_PROPRIETARIO p 
  ON p.CD_PROPRIETARIO = v.CD_PROPRIETARIO
  WHERE v.CD_PROPRIETARIO = v_proprietario;

  v_Result  c_result%rowtype;
BEGIN
  OPEN c_result;
  LOOP
    FETCH c_result INTO v_Result;
    IF c_result%notfound THEN
      EXIT;
    ELSE 
       DBMS_OUTPUT.PUT_LINE('O veículo de placa ' || v_Result.placa 
      || ' pertence ao proprietário ' || v_Result.proprietario || ' é do modelo '
      || v_Result.modelo || ' e tem a cor ' || v_Result.cor || '.');
    END IF;
  END LOOP;
  
  CLOSE c_result;
  
  IF v_Result.placa IS NULL THEN
     DBMS_OUTPUT.PUT_LINE('Não existe dados de veiculos cadastrado!!');
  END IF;
END;
