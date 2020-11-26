INSERT INTO MP_MPB.OFICIOS_DB 




WITH MAIN AS (
SELECT
			UMI.MOV_MOVE_ID,
            UMI.PAY_PAYMENT_ID,
            UMI.PAY_REASON_ID,
			UMI.MOV_CREATED_DT,	
      TO_CHAR(UMI.MOV_CREATED_DT, 'DDMMYYYY') AS MOV_CREATED_DT_CALC,
			UMI.MOV_DETAIL,
      OREPLACE(OREPLACE(UMI.OFICIO_NUMBER, '/', ''), '\', '') AS OFICIO_NUMBER,
      UMI.OFICIO_CREATED_AT,
			UMI.MOV_TYPE_ID,	
			CASE WHEN UMI.MOV_DETAIL = 'withdraw' THEN 'withdraw' ELSE UMI.PAY_OPERATION_TYPE_ID END AS PAY_OPERATION_TYPE_ID,
			UMI.MOV_FINANCIAL_ENTITY_ID,	
			UMI.WIT_WITHDRAW_ID,
			UMI.MOV_AMOUNT,
			OREPLACE(CAST((CASE WHEN UMI.MOV_AMOUNT <= 0.00 THEN UMI.MOV_AMOUNT *-1 ELSE UMI.MOV_AMOUNT END) AS VARCHAR(255)), '.', '') AS MOV_AMOUNT_CALC,
			UMI.ACCOUNT_TYPE,
      OREPLACE(OREPLACE(UMI.WIT_BANK_ACC_NUMBER, '/', ''), '-', '') AS WIT_BANK_ACC_NUMBER,
      UMI.WITHDRAWAL_STATUS,
			UMI.RECEIVING_ACCOUNT_HOLDER_NAME,
			UMI.RECEIVING_ACCOUNT_HOLDER_DOC_NUMBER,
			UMI.BANK_ID,
            LEFT(OREPLACE(OREPLACE(UMI.WIT_BANK_ACC_BRANCH_ID, '/', ''), '-', ''),4) AS WIT_BANK_ACC_BRANCH_ID,
			UMI.RECEIVING_BANK_NAME,
			UMI.PAYER_BANK_NAME,
			UMI.WITHDRAWAL_METHOD,
			UMI.WITHDRAWAL_AMOUNT,
            UMI.CUS_CUST_ID,
			CI.CUS_FULL_NAME,	
			CI.CUS_CUST_DOC_NUMBER,
			CI.CUS_CUST_DOC_TYPE,
			CI.CUS_ADDRESS,
			CI.CUS_RU_SINCE_DT,
			CI.CUS_RU_SINCE_DT_MP,
			CI.CUS_CUST_STATUS_MP,
			CI.CUS_PHONE,
			CI.CUS_COUNTRY,
			CI.CUS_STATE,
			CI.CUS_CITY,
			CI.CUS_ZIP_CODE,  
			CI.CUS_CUST_ID_BUY,
			CI.CUS_FULL_NAME_BUY,
			CI.CUS_CUST_DOC_NUMBER_BUY,
			CI.CUS_CUST_DOC_TYPE_BUY,
			CI.CUS_ADDRESS_BUY,
      TO_CHAR(CI.CUS_RU_SINCE_DT_BUY, 'DDMMYYYY') AS CUS_RU_SINCE_DT_BUY,
			CI.CUS_RU_SINCE_DT_MP_BUY,
			CI.CUS_CUST_STATUS_MP_BUY,
			CI.CUS_PHONE_BUY,
			CI.CUS_COUNTRY_BUY,
			CI.CUS_STATE_BUY,
			CASE WHEN CI.CUS_STATE= 'RONDÔNIA' THEN 'RO'
						WHEN CI.CUS_STATE = 'ACRE' THEN 'AC'
						WHEN CI.CUS_STATE = 'AMAZONAS' THEN 'AM'
						WHEN CI.CUS_STATE = 'RORAIMA' THEN 'RR'
						WHEN CI.CUS_STATE = 'PARÁ' THEN 'PA'
						WHEN CI.CUS_STATE = 'AMAPÁ' THEN 'AP'
						WHEN CI.CUS_STATE = 'TOCANTINS' THEN 'TO'
						WHEN CI.CUS_STATE = 'MARANHÃO' THEN 'MA'
						WHEN CI.CUS_STATE = 'PIAUÍ' THEN 'PI'
						WHEN CI.CUS_STATE = 'CEARÁ' THEN 'CE'
						WHEN CI.CUS_STATE = 'RIO GRANDE DO NORTE' THEN 'RN'
						WHEN CI.CUS_STATE = 'PARAÍBA' THEN 'PB'
						WHEN CI.CUS_STATE = 'PERNAMBUCO' THEN 'PE'
						WHEN CI.CUS_STATE = 'ALAGOAS' THEN 'AL'
						WHEN CI.CUS_STATE = 'SERGIPE' THEN 'SE'
						WHEN CI.CUS_STATE = 'BAHIA' THEN 'BA'
						WHEN CI.CUS_STATE = 'MINAS GERAIS' THEN 'MG'
						WHEN CI.CUS_STATE = 'ESPÍRITO SANTO' THEN 'ES'
						WHEN CI.CUS_STATE = 'RIO DE JANEIRO' THEN 'RJ'
						WHEN CI.CUS_STATE = 'SÃO PAULO' THEN 'SP'
						WHEN CI.CUS_STATE = 'PARANÁ' THEN 'PR'
						WHEN CI.CUS_STATE = 'SANTA CATARINA' THEN 'SC'
						WHEN CI.CUS_STATE = 'RIO GRANDE DO SUL' THEN 'RS'
						WHEN CI.CUS_STATE = 'MATO GROSSO DO SUL' THEN 'MS'
						WHEN CI.CUS_STATE = 'MATO GROSSO' THEN 'MT'
						WHEN CI.CUS_STATE = 'GOIÁS' THEN 'GO'
						WHEN CI.CUS_STATE = 'DISTRITO FEDERAL' THEN 'DF'
			 			ELSE NULL
			 	END AS UF,
			CI.CUS_CITY_BUY,
			CI.CUS_ZIP_CODE_BUY,
			CI.CUS_CUST_ID_SEL,
			CI.CUS_FULL_NAME_SEL,
			CASE WHEN CI.CUS_CUST_DOC_NUMBER_SEL IS NULL THEN '              ' ELSE CI.CUS_CUST_DOC_NUMBER_SEL END AS CUS_CUST_DOC_NUMBER_SEL,
			CI.CUS_CUST_DOC_TYPE_SEL,
			CI.CUS_ADDRESS_SEL,
			CI.CUS_RU_SINCE_DT_SEL,
			CI.CUS_RU_SINCE_DT_MP_SEL,
			CI.CUS_CUST_STATUS_MP_SEL,
			CI.CUS_PHONE_SEL,
			CI.CUS_COUNTRY_SEL,
			CI.CUS_STATE_SEL,
			CI.CUS_CITY_SEL,
			CI.CUS_ZIP_CODE_SEL,
			CURRENT_DATE AS GENERATED_AT,
			'002' AS HAD_REPORT
FROM MP_MPB.ACC_MOV_HISTORY_REPORT UMI
LEFT JOIN MP_MPB.CUS_INFO CI ON CI.MOV_MOVE_ID = UMI.MOV_MOVE_ID
WHERE 1=1
			AND UMI.MOV_DETAIL IN ('cellphone_recharge', 'money_transfer', 'payment', 'account_fund', 'withdraw') -- queremos apenas as movimentacoes de saque e movimentacao de in/out
			AND UMI.MOV_TYPE_ID IN ('expense', 'fund', 'income') -- expense = withdraw, fund = envio e income = recebimento
			)
			
SELECT * FROM MAIN WHERE PAY_OPERATION_TYPE_ID IS NOT NULL;