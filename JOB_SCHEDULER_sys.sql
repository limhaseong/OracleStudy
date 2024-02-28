SELECT USER
FROM DUAL;
--==> SYS

-- 권한 부여(SYS → SCOTT)
GRANT CREATE ANY JOB TO SCOTT;
--==> Grant을(를) 성공했습니다.

GRANT EXECUTE ON DBMS_SCHEDULER TO SCOTT;
--==> Grant을(를) 성공했습니다.

GRANT EXECUTE ON DBMS_ISCHED TO SCOTT;
--==> Grant을(를) 성공했습니다.

GRANT CREATE JOB, MANAGE SCHEDULER TO SCOTT;
--==> Grant을(를) 성공했습니다.














