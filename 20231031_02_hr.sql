SELECT USER
FROM DUAL;
--==> HR

SELECT *
FROM TAB;

--PURGE RECYCLEBIN;

SELECT *
FROM EMPLOYEES2;

--PURGE RECYCLEBIN;

--���� �� �� �ǽ� ���� ���� ����--

-- ���� ���ϸ� : 20231031_03_hr(2��_���ϼ�).sql
-- 20231031_03_hr(2��_���ϼ�) �����ı�.txt

-- HR ���ý�Ű�� ERD �� �̿��� ���̺� �籸��

-- ������...HR ���ý�Ű���� �ִ� �⺻ ���̺�(7��)
-- COUNTRIES / DEPARTMENTS / EMPLOYEES / JOBS / JOB_HISTORY / LOCATIONS / REGIONS
-- �� ��~~~~~~~ ���� ���� �����Ѵ�.

-- ��, �����ϴ� ���̺��� �̸��� ���̺��+����ȣ
-- COUNTRIES2 - 25 / DEPARTMENTS2 - 27 / EMPLOYEES2 - 107 / JOBS2 - 19 / JOB_HISTORY2 - 10 / LOCATIONS2 - 23 / REGIONS2 - 4

-- 1. ���� ��� ���̺���� ���� ����
-- �÷���, �÷�, ������ Ÿ��, ��������, �������� �̸�

-- 2. ���̺� ����(�÷��̸�, �ڷ���, DEFAULTǥ����, NOT NULL ��...)

-- 3. �������� ����(PK, U, FK, CK, ...)

-- 4. ������ �Է�(CREATE AS ��� ���)

DESC JOBS;
/*
�̸�         ��?       ����           
---------- -------- ------------ 
JOB_ID     NOT NULL VARCHAR2(10) 
JOB_TITLE  NOT NULL VARCHAR2(35) 
MIN_SALARY          NUMBER(6)    
MAX_SALARY          NUMBER(6)
*/

SELECT *
FROM JOBS;

SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'JOBS';
/*
HR	JOB_TITLE_NN	JOBS	C	JOB_TITLE	"JOB_TITLE" IS NOT NULL	
HR	JOB_ID_PK	    JOBS	P	JOB_ID		
*/

DESC EMPLOYEES;

SELECT *
FROM LOCATIONS2;

SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'LOCATIONS2';

SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'EMPLOYEES';

SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'JOB_HISTORY';

SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'LOCATIONS';