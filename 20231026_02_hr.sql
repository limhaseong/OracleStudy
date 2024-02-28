SELECT USER
FROM DUAL;
--==> HR

--�� �� �� �̻��� ���̺� ����(JOIN, ����)
-- ���谡 ��Ȯ�ϴٸ� ������ ���̺� ���� ����

-- ���� 1. (SQL 1992 CODE)
SELECT ���̹���1.�÷���, ���̺��2.�÷���, ���̺��3.�÷���
FROM ���̺��1, ���̺��2, ���̺��3
WHERE ���̺��1.�÷���1 = ���̺��2.�÷���1
    AND ���̺��2.�÷���2 = ���̺��3.�÷���2;


-- ���� 2. (SQL 1999 CODE)
SELECT ���̺��1.�÷���, ���̺��2.�÷���, ���̺��3.�÷���
FROM ���̺��1 JOIN ���̺��2
ON ���̺��1.�÷���1 = ���̺��2.�÷���1
    JOIN ���̺��3
    ON ���̺��2.�÷���2 = ���̺��3.�÷���2;

--�� HR ���� ������ ���̺� �Ǵ� �� ��� ��ȸ
SELECT *
FROM TAB;
/*
COUNTRIES	        TABLE	
DEPARTMENTS	        TABLE	
EMPLOYEES	        TABLE	
EMP_DETAILS_VIEW	VIEW	
JOBS	            TABLE	
JOB_HISTORY     	TABLE	
LOCATIONS	        TABLE	
REGIONS	            TABLE	
*/

--�� HR.JOBS, HR.EMPLOYEES, HR.DEPARTMENTS ���̺��� �������
--   �������� �����͸�
--   FIRST_NAME, LAST_NAME, JOB_TITLE, DEPARTMENT_NAME �׸����� ��ȸ�Ѵ�.

SELECT *
FROM HR.JOBS;
-- JOB_ID --> ���� �÷�
SELECT *
FROM HR.EMPLOYEES;
-- JOB_ID --> ���� �÷�
SELECT *
FROM HR.DEPARTMENTS;
-- DEPARTMENT_ID  --> ���� �÷�

-- ���1
SELECT H.FIRST_NAME, H.LAST_NAME, R.JOB_TITLE, S.DEPARTMENT_NAME
FROM HR.EMPLOYEES H, HR.JOBS R, HR.DEPARTMENTS S
WHERE H.JOB_ID = R.JOB_ID
   AND H.DEPARTMENT_ID = S.DEPARTMENT_ID(+);

-- ���2
SELECT H.FIRST_NAME, H.LAST_NAME, R.JOB_TITLE, S.DEPARTMENT_NAME
FROM HR.EMPLOYEES H JOIN HR.JOBS R
ON H.JOB_ID = R.JOB_ID
    LEFT JOIN HR.DEPARTMENTS S
    ON H.DEPARTMENT_ID = S.DEPARTMENT_ID;

-- ����� ���3 (1999 CODE)
-- FIRST_NAME, LAST_NAME, JOB_TITLE, DEPARTMENT_NAME
--    E           E          J             D
SELECT E.FIRST_NAME, E.LAST_NAME, D.DEPARTMENT_NAME
FROM EMPLOYEES E JOIN DEPARTMENTS D
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID;

SELECT COUNT(*)
FROM EMPLOYEES E JOIN DEPARTMENTS D
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID;
--==> 106   -> 1���� ���������� �� �� �ִ�.

SELECT *
FROM EMPLOYEES;
-- 178	Kimberely	Grant	KGRANT	011.44.1644.429263	2007-05-24	SA_REP	7000	0.15	149	
--> DEPARTMENT_ID�� NULL�̶� ������

SELECT COUNT(*)
FROM EMPLOYEES E LEFT JOIN DEPARTMENTS D
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID;
--==> 107

SELECT E.FIRST_NAME, E.LAST_NAME, D.DEPARTMENT_NAME
FROM EMPLOYEES E LEFT JOIN DEPARTMENTS D
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID;

SELECT E.FIRST_NAME, E.LAST_NAME, J.JOB_TITLE, D.DEPARTMENT_NAME
FROM EMPLOYEES E LEFT JOIN DEPARTMENTS D
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
    JOIN JOBS J
    ON E.JOB_ID = J.JOB_ID;

---------------------------------------------------------------------------

--�� EMPLOYEES, DEPARTMENTS, JOBS, LOCATIONS, COUNTRIES, REGIONS ���̺��� �������
--   �������� �����͸� ������ ���� ��ȸ�Ѵ�.
--   FIRST_NAME, LAST_NAME, JOB_TITLE, DEPARTMENT_NAME, CITY, COUNTRY_NAME, REGION_NAME
/*
                            REGIONS      ��
                                         �� REGION_ID
                       ��   COUNTRIES    ��
            COUNTRY_ID ��
                       ��   LOCATIONS    ��
                                         �� LOCATION_ID
                       ��   DEPARTMENTS  ��
        DEPARTMENT_ID  ��
                       ��   EMPLOYEES
               JOB_ID  �� 
                       ��   JOBS
*/
SELECT *
FROM EMPLOYEES;
SELECT *
FROM DEPARTMENTS;
SELECT *
FROM JOBS;
SELECT *
FROM LOCATIONS;
SELECT *
FROM COUNTRIES;
SELECT *
FROM REGIONS;

-- ���1
SELECT E.FIRST_NAME, E.LAST_NAME, J.JOB_TITLE, D.DEPARTMENT_NAME, L.CITY, C.COUNTRY_NAME, R.REGION_NAME
FROM EMPLOYEES E LEFT JOIN DEPARTMENTS D
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
    JOIN JOBS J
    ON E.JOB_ID = J.JOB_ID
        LEFT JOIN LOCATIONS L
        ON D.LOCATION_ID = L.LOCATION_ID
            LEFT JOIN COUNTRIES C
            ON L.COUNTRY_ID = C.COUNTRY_ID
                LEFT JOIN REGIONS R
                ON C.REGION_ID = R.REGION_ID;
                
-- ���2
SELECT E.FIRST_NAME, E.LAST_NAME, J.JOB_TITLE, D.DEPARTMENT_NAME, L.CITY, C.COUNTRY_NAME, R.REGION_NAME
FROM EMPLOYEES E, DEPARTMENTS D, JOBS J, LOCATIONS L, COUNTRIES C, REGIONS R
WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID(+)
AND J.JOB_ID = E.JOB_ID(+)
AND D.LOCATION_ID = L.LOCATION_ID(+)
AND L.COUNTRY_ID = C.COUNTRY_ID(+)
AND C.REGION_ID = R.REGION_ID(+);























































































