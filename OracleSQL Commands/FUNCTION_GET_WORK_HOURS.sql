CREATE OR REPLACE FUNCTION PRL_GET_WORK_HOURS(
OP_ID_ IN NUMBER,
OP_INFO_CODE_ IN VARCHAR2,
EMP_NO_ IN VARCHAR2,
ACCOUNT_DATE_ IN VARCHAR2) RETURN NUMBER
IS
WORK_HOURS_ NUMBER(10,5);
CURSOR GET_HOURS IS
SELECT WORK_HOURS FROM 
IFSAPP.OP_RESULT 
WHERE OP_ID = OP_ID_ AND UPPER(OP_INFO_CODE) = UPPER(OP_INFO_CODE_) AND 
ACCOUNT_DATE = ACCOUNT_DATE_ and EMP_NO = EMP_NO_;
BEGIN
OPEN GET_HOURS;
FETCH GET_HOURS INTO WORK_HOURS_;
CLOSE GET_HOURS;
RETURN nvl(WORK_HOURS_,0);
END;

--GRANT EXECUTE ON PRL_GET_WORK_HOURS TO IFSINFO WITH GRANT OPTION;