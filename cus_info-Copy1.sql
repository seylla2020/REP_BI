CALL MP_MPB.DROP_TABLE_IF_EXISTS('MP_MPB','CUS_INFO',MSG);
CREATE MULTISET TABLE MP_MPB.CUS_INFO AS (
WITH MAIN AS (
SELECT
			M.MOV_MOVE_ID,
			M.MOV_DETAIL,
			M.MOV_TYPE_ID,
			CASE WHEN MOV_DETAIL = 'withdraw' THEN 'withdraw' ELSE M.PAY_OPERATION_TYPE_ID END AS PAY_OPERATION_TYPE_ID_CALC,
			COALESCE(M.CUS_CUST_ID_BUY, M.CUS_CUST_ID) 						AS CUS_CUST_ID_BUY,
			COALESCE(M.CUS_CUST_ID_SEL, M.CUS_CUST_ID) 						AS CUS_CUST_ID_SEL
FROM MP_MPB.ACC_MOV_HISTORY_REPORT M
WHERE 1=1
			AND MOV_DETAIL IN ('cellphone_recharge', 'money_transfer', 'payment', 'account_fund', 'withdraw') -- queremos apenas as movimentacoes de saque e movimentacao de in/out
			AND MOV_TYPE_ID IN ('expense', 'fund', 'income') -- expense = withdraw, fund = envio e income = recebimento
			AND PAY_OPERATION_TYPE_ID_CALC IS NOT NULL

)
SELECT
			M.MOV_MOVE_ID,
			M.MOV_DETAIL,
			M.MOV_TYPE_ID,
			M.PAY_OPERATION_TYPE_ID_CALC AS PAY_OPERATION_TYPE_ID,
			M.CUS_CUST_ID_BUY,
			CASE WHEN C.CUS_FIRST_NAME IS NULL THEN COALESCE(C.CUS_FIRST_NAME, C.CUS_LAST_NAME) 
					 ELSE C.CUS_FIRST_NAME || ' ' || C.CUS_LAST_NAME 
			END	AS CUS_FULL_NAME_BUY,	
			C.CUS_CUST_DOC_NUMBER 																AS CUS_CUST_DOC_NUMBER_BUY,
			C.CUS_CUST_DOC_TYPE																		AS CUS_CUST_DOC_TYPE_BUY,
			C.CUS_ADDRESS																					AS CUS_ADDRESS_BUY,
			C.CUS_RU_SINCE_DT																			AS CUS_RU_SINCE_DT_BUY,
			C.CUS_RU_SINCE_DT_MP                                  AS CUS_RU_SINCE_DT_MP_BUY,
			C.CUS_CUST_STATUS_MP                                  AS CUS_CUST_STATUS_MP_BUY,
			COALESCE(C.CUS_PHONE1, C.CUS_CELULAR) 								AS CUS_PHONE_BUY,
			C.CUS_COUNTRY 																				AS CUS_COUNTRY_BUY,
			C.CUS_STATE                                           AS CUS_STATE_BUY,
			C.CUS_CITY																						AS CUS_CITY_BUY,
			C.CUS_ZIP_CODE																				AS CUS_ZIP_CODE_BUY,
			M.CUS_CUST_ID_SEL,
			CASE WHEN CC.CUS_FIRST_NAME IS NULL THEN COALESCE(CC.CUS_FIRST_NAME, CC.CUS_LAST_NAME) 
					 ELSE CC.CUS_FIRST_NAME || ' ' || CC.CUS_LAST_NAME 
			END	AS CUS_FULL_NAME_SEL,	
			CC.CUS_CUST_DOC_NUMBER 																AS CUS_CUST_DOC_NUMBER_SEL,
			CC.CUS_CUST_DOC_TYPE																	AS CUS_CUST_DOC_TYPE_SEL,
			CC.CUS_ADDRESS																				AS CUS_ADDRESS_SEL,
			CC.CUS_RU_SINCE_DT																		AS CUS_RU_SINCE_DT_SEL,
			CC.CUS_RU_SINCE_DT_MP                                 AS CUS_RU_SINCE_DT_MP_SEL,
			CC.CUS_CUST_STATUS_MP                                 AS CUS_CUST_STATUS_MP_SEL,
			COALESCE(CC.CUS_PHONE1, CC.CUS_CELULAR) 							AS CUS_PHONE_SEL,
			CC.CUS_COUNTRY 																				AS CUS_COUNTRY_SEL,
			CC.CUS_STATE                                          AS CUS_STATE_SEL,
			CC.CUS_CITY																						AS CUS_CITY_SEL,
			CC.CUS_ZIP_CODE																				AS CUS_ZIP_CODE_SEL
FROM MAIN AS M
LEFT JOIN WHOWNER.LK_CUS_CUSTOMERS_DATA C ON C.CUS_CUST_ID = M.CUS_CUST_ID_BUY AND C.SIT_SITE_ID_CUS = 'MLB'
LEFT JOIN WHOWNER.LK_CUS_CUSTOMERS_DATA CC ON CC.CUS_CUST_ID = M.CUS_CUST_ID_SEL AND CC.SIT_SITE_ID_CUS = 'MLB'
) WITH DATA PRIMARY INDEX(CUS_CUST_ID_SEL, CUS_CUST_ID_BUY, CUS_CUST_DOC_NUMBER_BUY, CUS_CUST_DOC_NUMBER_SEL);
