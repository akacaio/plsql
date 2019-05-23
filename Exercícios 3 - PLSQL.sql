DECLARE
  cod_grupo loc_grupo.cd_grupo%type := '&cod';
  nm_cat loc_grupo.ds_grupo%type;
  
BEGIN
  SELECT CD_GRUPO, DS_GRUPO
  INTO cod_grupo, nm_cat
  FROM LOC_GRUPO
  WHERE cd_grupo = cod_grupo;

DBMS_OUTPUT.PUT_LINE('O código do grupo de veículo ' || cod_grupo || '  tem a sua descrição como ' || nm_cat);

END;


DECLARE
  CURSOR dpto(cod loc_depto.cd_depto%type) IS
  SELECT CD_DEPTO, NM_DEPTO
  FROM LOC_DEPTO
  WHERE CD_DEPTO = cod;
  
  v_collect dpto%rowtype;
  
BEGIN
  OPEN dpto;
    LOOP
    FETCH dpto IN v_collect;
    EXIT WHEN dpto%notfound;
  END LOOP;  
END;
