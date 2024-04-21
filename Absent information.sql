
--Login sutdent absent information--

SELECT S.STUDENT_ID, S.FIRST_NAME || ' ' || LAST_NAME Student_name, AM.ATTENDANCE_DATE, AD.DESCRIPTION
      FROM STU_AT_DETAIL AD, STU_AT_MASTER AM, STUDENTS S
      WHERE S.STUDENT_ID = AD.STUDENT_ID
      AND AD.MASTER_AT_ID = AM.MASTER_AT_ID
      AND AD.STATUS = 'A'
      AND AD.STUDENT_ID = (SELECT S.STUDENT_ID
                           FROM STUDENTS S, STU_USERS SU
                           WHERE S.STUDENT_ID = SU.STUDENT_ID
                           AND UPPER(SU.USER_NAME) = UPPER(:APP_USER))


--Count total number of absent--

SELECT COUNT(STATUS)
FROM STU_AT_DETAIL
WHERE STATUS = 'A'
AND STUDENT_ID = (SELECT S2.STUDENT_ID
                    FROM STUDENTS S2, STU_USERS SU
                    WHERE S2.STUDENT_ID = SU.STUDENT_ID
                    AND UPPER(SU.USER_NAME) = UPPER(:APP_USER))
