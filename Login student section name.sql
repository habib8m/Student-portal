
SELECT DISTINCT SEC.SECTION_NAME
FROM ROUTINE_MASTER RM, CLASS C, SECTIONS SEC
WHERE RM.CLASS_ID = C.CLASS_ID
AND SEC.SECTION_ID = RM.SECTION_ID
AND RM.CLASS_ID = C.CLASS_ID
AND C.CLASS_ID = (SELECT C.CLASS_ID
                    FROM CLASS C, ADMISSION A, STUDENTS S
                    WHERE C.CLASS_ID = A.CLASS_ID
					AND A.STUDENT_ID = S.STUDENT_ID
                    AND A.STUDENT_ID = (SELECT S.STUDENT_ID
                                        FROM STUDENTS S, STU_USERS SU
                                        WHERE S.STUDENT_ID = SU.STUDENT_ID
                                        AND UPPER(SU.USER_NAME) = UPPER(:APP_USER)))
                    
AND SEC.SECTION_ID = (SELECT SEC.SECTION_ID
                       FROM SECTIONS SEC, ADMISSION A, STUDENTS S
                       WHERE A.SECTION_ID = SEC.SECTION_ID
					   AND A.STUDENT_ID = S.STUDENT_ID
                       AND A.STUDENT_ID = (SELECT S.STUDENT_ID
                                          FROM STUDENTS S, STU_USERS SU
                                          WHERE S.STUDENT_ID = SU.STUDENT_ID
                                          AND UPPER(SU.USER_NAME) = UPPER(:APP_USER)))