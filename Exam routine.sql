
--Student exam routine for exam routien region--

SELECT EM.EXAM_M_ID, EM.EXAM_NAME, C.CLASS_NAME, SEC.SECTION_NAME
FROM EXAMS_M EM, CLASS C, SECTIONS SEC
WHERE C.CLASS_ID = EM.CLASS_ID
AND SEC.SECTION_ID = EM.SECTION_ID
AND C.CLASS_ID IN (SELECT C.CLASS_ID
                    FROM CLASS C, ADMISSION A, STUDENTS S
                    WHERE C.CLASS_ID = A.CLASS_ID
                    AND A.STUDENT_ID = (SELECT S.STUDENT_ID
                                        FROM STUDENTS S, STU_USERS SU
                                        WHERE S.STUDENT_ID = SU.STUDENT_ID
                                        AND UPPER(SU.USER_NAME) = UPPER(:APP_USER)))
AND SEC.SECTION_ID IN (SELECT SEC.SECTION_ID
                       FROM SECTIONS SEC, ADMISSION A, STUDENTS S
                       WHERE A.SECTION_ID = SEC.SECTION_ID
                       AND A.STUDENT_ID = (SELECT S.STUDENT_ID
                                          FROM STUDENTS S, STU_USERS SU
                                          WHERE S.STUDENT_ID = SU.STUDENT_ID
                                          AND UPPER(SU.USER_NAME) = UPPER(:APP_USER)))
--ORDER BY EM.EXAM_M_ID, C.CLASS_ID


--Student exam routine for exam routien detail region--

SELECT ED.EXAM_M_ID, ED.EXAM_DATE, CS.CLASS_TIME, S.SUBJECT_NAME, E.FIRST_NAME||' '||E.LAST_NAME EXAMINER
FROM EXAMS_D ED, CLASS_SLOT CS, SUBJECTS S, EMPLOYEES E
WHERE ED.SLOT_ID = CS.SLOT_ID
AND S.SUBJECT_ID = ED.SUBJECT_ID
AND E.EMPLOYEE_ID = ED.EXAMINER_ID

