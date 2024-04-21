
--Paid months--

SELECT M.MONTH, CF.TOTAL
FROM MONTH M, CLASS_FEE CF
WHERE M.M_ID = CF.M_ID
AND CF.CLASS_ID = (SELECT C.CLASS_ID
                    FROM CLASS C, ADMISSION A, STUDENTS S
                    WHERE C.CLASS_ID = A.CLASS_ID
					AND A.STUDENT_ID = S.STUDENT_ID
                    AND A.STUDENT_ID = (SELECT S.STUDENT_ID
                                        FROM STUDENTS S, STU_USERS SU
                                        WHERE S.STUDENT_ID = SU.STUDENT_ID
                                        AND UPPER(SU.USER_NAME) = UPPER(:APP_USER)))
AND CF.CLASS_FEE_ID IN (SELECT CD.CLASS_FEE_ID
                        FROM COLLECTION_D CD, COLLECTION_M CM, STUDENTS S
                        WHERE CD.COLLECTION_M_ID = CM.COLLECTION_M_ID
                        AND S.STUDENT_ID = CM.STUDENT_ID
                        AND S.STUDENT_ID = (SELECT S.STUDENT_ID
                                       		FROM STUDENTS S, STU_USERS SU
                                            WHERE S.STUDENT_ID = SU.STUDENT_ID
                                            AND UPPER(SU.USER_NAME) = UPPER(:APP_USER)))
ORDER BY M.M_ID   


--Un-paid months--

SELECT M.MONTH, CF.TOTAL
FROM MONTH M, CLASS_FEE CF
WHERE M.M_ID = CF.M_ID
AND CF.CLASS_ID = (SELECT C.CLASS_ID
                    FROM CLASS C, ADMISSION A, STUDENTS S
                    WHERE C.CLASS_ID = A.CLASS_ID
					AND A.STUDENT_ID = S.STUDENT_ID
                    AND A.STUDENT_ID = (SELECT S.STUDENT_ID
                                        FROM STUDENTS S, STU_USERS SU
                                        WHERE S.STUDENT_ID = SU.STUDENT_ID
                                        AND UPPER(SU.USER_NAME) = UPPER(:APP_USER)))
AND CF.CLASS_FEE_ID NOT IN (SELECT CD.CLASS_FEE_ID
                        FROM COLLECTION_D CD, COLLECTION_M CM, STUDENTS S
                        WHERE CD.COLLECTION_M_ID = CM.COLLECTION_M_ID
                        AND S.STUDENT_ID = CM.STUDENT_ID
                        AND S.STUDENT_ID = (SELECT S.STUDENT_ID
                                       		FROM STUDENTS S, STU_USERS SU
                                            WHERE S.STUDENT_ID = SU.STUDENT_ID
                                            AND UPPER(SU.USER_NAME) = UPPER(:APP_USER)))
ORDER BY M.M_ID   


--Find transaction wise deu amount--

SELECT 10||CM.COLLECTION_M_ID PAYMENT_NO, cm.COLLECTION_DATE, NVL(CM.DUE, 0) Due
FROM COLLECTION_M CM
WHERE CM.STUDENT_ID = (SELECT S2.STUDENT_ID
                    FROM STUDENTS S2, STU_USERS SU
                    WHERE S2.STUDENT_ID = SU.STUDENT_ID
                    AND UPPER(SU.USER_NAME) = UPPER(:APP_USER))
ORDER BY 1
