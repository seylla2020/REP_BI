SELECT      DISTINCT
			COMPUTADOR_DESTINO||'-'||NUMERO_CASO AS OFICIO_NUMBER,
			DOC_NUMBER,
			RANGE_MIN,
			RANGE_MAX,
--			TO_CHAR(RANGE_MIN, 'DDMMYYYY') AS RANGE_MIN_CALC, #was not working
--			TO_CHAR(RANGE_MAX, 'DDMMYYYY') AS RANGE_MAX_CALC #was not working
			RIGHT(RANGE_MIN, 2)||RIGHT(LEFT(RANGE_MIN, 7),2)||LEFT(RANGE_MIN, 4) AS RANGE_MIN_CALC,
			RIGHT(RANGE_MAX, 2)||RIGHT(LEFT(RANGE_MAX, 7),2)||LEFT(RANGE_MAX, 4) AS RANGE_MAX_CALC
FROM MP_MPB.DOC_INPUT WHERE COMPUTADOR_DESTINO||'-'||NUMERO_CASO IN ('018-PCSP-000566-99') AND CREATED_AT = '2020-03-25';
