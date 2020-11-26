SELECT
			DISTINCT
			COMPUTADOR_DESTINO||'-'||NUMERO_CASO AS OFICIO_NUMBER,
			EMAIL_CASO,
			DATA_OFICIO,
			NUMERO_PROCESSO,
			NOME_TRIBUNAL,
			NOME_MAGISTRADO,
			CARGO_MAGISTRADO
FROM MP_MPB.DOC_INPUT WHERE CREATED_AT = (SELECT MAX(CREATED_AT) FROM MP_MPB.DOC_INPUT);

