
--Student calss routine for routine master region--

SELECT RM.ROUTINE_M_ID, C.CLASS_NAME, SEC.SECTION_NAME, D.DAY, R.ROOM_NUMBER
FROM ROUTINE_MASTER RM, CLASS C, SECTIONS SEC, DAY_OF_WEEK D, CLASSROOMS R
WHERE RM.CLASS_ID = C.CLASS_ID
AND SEC.SECTION_ID = RM.SECTION_ID
AND RM.DAY_ID = D.DAY_ID
AND RM.CLASSROOM_ID = R.CLASSROOM_ID
AND RM.CLASS_ID = C.CLASS_ID
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


--Student class routine for detail region--

SELECT RD.ROUTINE_M_ID, CL.CLASS_TIME, S.SUBJECT_NAME, E.FIRST_NAME||' '||E.LAST_NAME TEACHER_NAME
FROM CLASS_SLOT CL, ROUTINE_DETAIL RD, SUBJECTS S, EMPLOYEES E, ROUTINE_MASTER RM
WHERE CL.SLOT_ID = RD.SLOT_ID
AND S.SUBJECT_ID = RD.SUBJECT_ID
AND E.EMPLOYEE_ID = RD.TEACHER_ID
AND RD.ROUTINE_M_ID = RM.ROUTINE_M_ID
--AND RM.ROUTINE_M_ID = :ROUTINE_M_ID

                                         
