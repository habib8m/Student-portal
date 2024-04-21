
--Student exam marks for master region--

SELECT DISTINCT EM.EXAM_NAME
FROM MARKS_LIST_M MM, EXAMS_M EM
WHERE MM.EXAM_M_ID = EM.EXAM_M_ID
AND MM.CLASS_ID IN (SELECT C.CLASS_ID
                    FROM CLASS C, ADMISSION A, STUDENTS S
                    WHERE C.CLASS_ID = A.CLASS_ID
					AND A.STUDENT_ID = S.STUDENT_ID
                    AND A.STUDENT_ID = (SELECT S.STUDENT_ID
                                        FROM STUDENTS S, STU_USERS SU
                                        WHERE S.STUDENT_ID = SU.STUDENT_ID
                                        AND UPPER(SU.USER_NAME) = UPPER(:APP_USER)))
                    
AND MM.SECTION_ID IN (SELECT SEC.SECTION_ID
                       FROM SECTIONS SEC, ADMISSION A, STUDENTS S
                       WHERE A.SECTION_ID = SEC.SECTION_ID
					   AND A.STUDENT_ID = S.STUDENT_ID
                       AND A.STUDENT_ID = (SELECT S.STUDENT_ID
                                          FROM STUDENTS S, STU_USERS SU
                                          WHERE S.STUDENT_ID = SU.STUDENT_ID
                                          AND UPPER(SU.USER_NAME) = UPPER(:APP_USER)))


--Student exam marks for detail region--

SELECT md.MARKS_LIST_M_ID, SUB.SUBJECT_NAME, MD.MARKS, MD.GRADE, MD.GRADE_POINT, MD.STATUS, EM.EXAM_NAME
FROM STUDENTS S, CLASS C, ADMISSION A, SECTIONS SEC, MARKS_LIST_M MM , MARKS_LIST_D MD, SUBJECTS SUB, EXAMS_M EM
WHERE A.CLASS_ID = C.CLASS_ID
AND A.STUDENT_ID = S.STUDENT_ID
AND A.SECTION_ID = SEC.SECTION_ID
AND MM.MARKS_LIST_M_ID = MD.MARKS_LIST_M_ID
AND MD.STUDENT_ID = S.STUDENT_ID
AND MM.EXAM_M_ID = EM.EXAM_M_ID
AND SUB.SUBJECT_ID = MM.SUBJECT_ID
AND S.STUDENT_ID = (SELECT S.STUDENT_ID
                     FROM STUDENTS S, STU_USERS SU
                     WHERE S.STUDENT_ID = SU.STUDENT_ID
                     AND UPPER(SU.USER_NAME) = UPPER(:APP_USER))
