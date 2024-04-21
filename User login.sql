
--User login security check--

FUNCTION user_auth (p_username in VARCHAR2, p_password in VARCHAR2)
RETURN BOOLEAN
is
v_user NUMBER := 0;
BEGIN
SELECT 1 INTO v_user
FROM STU_USERS
WHERE UPPER(USER_NAME) = UPPER(p_username)
AND PASSWORD = p_password
AND STATUS = 'Active';
RETURN true;
-- EXCEPTION
-- WHEN no_data_found THEN
-- RETURN false;
END;
