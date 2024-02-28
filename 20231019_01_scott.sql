SELECT USER
FROM DUAL;
--==> SCOTT


--�� TBL_EMP ���̺����� 20�� �μ��� �ٹ����� �ʴ� �������
--   �����, ������, �μ���ȣ �׸��� ��ȸ�Ѵ�.
SELECT �����, ������, �μ���ȣ
FROM TBL_EMP
WHERE 20�� �μ��� �ٹ����� �ʴ�;

SELECT ENAME "�����", JOB "������", DEPTNO "�μ���ȣ"
FROM TBL_EMP
WHERE 20�� �μ��� �ٹ����� �ʴ�;

SELECT ENAME "�����", JOB "������", DEPTNO "�μ���ȣ"
FROM TBL_EMP
WHERE �μ���ȣ�� 20�� �ƴϴ�;

SELECT ENAME "�����", JOB "������", DEPTNO "�μ���ȣ"
FROM TBL_EMP
WHERE DEPTNO != 20;
/*
ALLEN	SALESMAN	30
WARD	SALESMAN	30
MARTIN	SALESMAN	30
BLAKE	MANAGER	30
CLARK	MANAGER	10
KING	PRESIDENT	10
TURNER	SALESMAN	30
JAMES	CLERK	30
MILLER	CLERK	10
*/

SELECT ENAME "�����", JOB "������", DEPTNO "�μ���ȣ"
FROM TBL_EMP
WHERE DEPTNO <> 20;
/*
ALLEN	SALESMAN	30
WARD	SALESMAN	30
MARTIN	SALESMAN	30
BLAKE	MANAGER	30
CLARK	MANAGER	10
KING	PRESIDENT	10
TURNER	SALESMAN	30
JAMES	CLERK	30
MILLER	CLERK	10
*/

SELECT ENAME "�����", JOB "������", DEPTNO "�μ���ȣ"
FROM TBL_EMP
WHERE DEPTNO ^= 20;
/*
ALLEN	SALESMAN	30
WARD	SALESMAN	30
MARTIN	SALESMAN	30
BLAKE	MANAGER	30
CLARK	MANAGER	10
KING	PRESIDENT	10
TURNER	SALESMAN	30
JAMES	CLERK	30
MILLER	CLERK	10
*/

--�� TBL_EMP ���̺����� Ŀ�̼��� NULL�� �ƴ� ��������
--   �����, ������, �޿�, Ŀ�̼� �׸��� ��ȸ�Ѵ�.
SELECT ENAME "�����", JOB "������", SAL "�޿�", COMM "Ŀ�̼�"
FROM TBL_EMP
WHERE COMM IS NOT NULL;          -- !=, <>, ^= ��� �Ұ�.
/*
ALLEN	SALESMAN	    1600	300
WARD	    SALESMAN    	1250    	500
MARTIN	SALESMAN	    1250	    1400
TURNER	SALESMAN    	1500	0
*/

-- && AND, || OR, ! NOT

SELECT ENAME "�����", JOB "������", SAL "�޿�", COMM "Ŀ�̼�"
FROM TBL_EMP
WHERE NOT COMM IS NULL; 
/*
ALLEN	SALESMAN    	1600	300
WARD	    SALESMAN	    1250    	500
MARTIN	SALESMAN	    1250	    1400
TURNER	SALESMAN	    1500	0
*/

--�� TBL_EMP ���̺����� ��� �������
--   �����ȣ, �����, �޿�, Ŀ�̼�, ���� �׸��� ��ȸ�Ѵ�.
--   ��, �޿�(SAL)�� �ſ� �����Ѵ�.
--   ����, ����(COMM)�� �� 1ȸ �����ϸ�, ���� ������ ���Եȴ�.
SELECT *
FROM TBL_EMP;

SELECT EMPNO "�����ȣ", ENAME "�����", SAL "�޿�", COMM "����", SAL*12+COMM "����"
FROM TBL_EMP;
/*
7369	SMITH	800		
7499	ALLEN	1600	300	19500
7521	WARD	1250	500	15500
7566	JONES	2975		
7654	MARTIN	1250	1400	16400
7698	BLAKE	2850		
7782	CLARK	2450		
7788	SCOTT	3000		
7839	KING	5000		
7844	TURNER	1500	0	18000
7876	ADAMS	1100		
7900	JAMES	950		
7902	FORD	3000		
7934	MILLER	1300		
*/

--�� ����� ���---------------------------------------------------------
--TBL_EMP ���̺����� ��� ������� ��� ���� WHERE ���� ��� ��� ���ڴٴ� ��.
SELECT *
FROM TBL_EMP;

SELECT EMPNO "�����ȣ", ENAME "�����", SAL "�޿�", COMM "Ŀ�̼�", �޿�*12 "����"
FROM TBL_EMP;

SELECT EMPNO "�����ȣ", ENAME "�����", SAL "�޿�", COMM "Ŀ�̼�", SAL*12 "����"
FROM TBL_EMP;

SELECT EMPNO "�����ȣ", ENAME "�����", SAL "�޿�", COMM "Ŀ�̼�", (SAL*12)+COMM "����"
FROM TBL_EMP;



--�� ����Ŭ�� �Լ� NVL() => NULL ó���ϴ� �Լ�
SELECT NULL "COL1", NVL(NULL,10) "COL2", NVL(5, 10) "COL3"
FROM DUAL;
--==> (null) 	10	5
-- ù ��° �Ķ���� ���� NULL�̸�, �� ��° �Ķ���� ���� ��ȯ�Ѵ�.
-- ù ��° �Ķ���� ���� NULL�� �ƴϸ�, �� ���� �״�� ��ȯ�Ѵ�.

SELECT ENAME "�����", COMM "����"
FROM TBL_EMP;

SELECT ENAME "�����", NVL(COMM, 1234) "����"
FROM TBL_EMP;

SELECT EMPNO "�����ȣ", ENAME "�����", SAL "�޿�", COMM "����", (SAL*12)+NVL(COMM,0) "����"
FROM TBL_EMP;
/*
7369	SMITH	800		        9600
7499	ALLEN	1600	300	    19500
7521    	WARD	    1250    	500	    15500
7566	JONES	2975		        35700
7654	MARTIN	1250	    1400	16400
7698	BLAKE	2850		        34200
7782    	CLARK	2450		        29400
7788	SCOTT	3000		    36000
7839	KING	    5000		    60000
7844	TURNER	1500	0	    18000
7876	ADAMS	1100		    13200
7900	JAMES	950		        11400
7902    	FORD    	3000		    36000
7934	MILLER	1300		    15600
*/

SELECT EMPNO "�����ȣ", ENAME "�����", SAL "�޿�", COMM "����", NVL(SAL*12+COMM, SAL*12) "����"
FROM TBL_EMP;
/*
7369	SMITH	800		        9600
7499	ALLEN	1600	300	    19500
7521    	WARD	    1250	    500	    15500
7566	JONES	2975		        35700
7654	MARTIN	1250    	1400	16400
7698	BLAKE	2850		        34200
7782	    CLARK	2450		        29400
7788	SCOTT	3000	    	36000
7839	KING    	5000	    	60000
7844	TURNER	1500	0   	18000
7876	ADAMS	1100		    13200
7900	JAMES	950		        11400
7902	    FORD	    3000	    	36000
7934	MILLER	1300	    	15600
*/

--�� NVL2()
--> ù ��° �Ķ���� ���� NULL�� �ƴ� ���, �� ��° �Ķ���� ���� ��ȯ�ϰ�
--  ù ���� �Ķ���� ���� NULL�� ���, �� ���� �Ķ���� ���� ��ȯ�Ѵ�.
SELECT ENAME"�����", NVL2(COMM, 'û��÷�', '���÷�') "���� Ȯ��"
FROM TBL_EMP;
/*
SMITH	���÷�
ALLEN	û��÷�
WARD	    û��÷�
JONES	���÷�
MARTIN	û��÷�
BLAKE	���÷�
CLARK	���÷�
SCOTT	���÷�
KING	    ���÷�
TURNER	û��÷�
ADAMS	���÷�
JAMES	���÷�
FORD	    ���÷�
MILLER	���÷�
*/

SELECT EMPNO "�����ȣ", ENAME "�����", SAL "�޿�", COMM "����", NVL2(COMM, SAL*12+COMM, SAL*12) "����"
FROM TBL_EMP;
/*
7369	SMITH	800		        9600
7499	ALLEN	1600	300	    19500
7521    	WARD	    1250    	500	    15500
7566	JONES	2975		        35700
7654	MARTIN	1250    	1400	16400
7698	BLAKE	2850		        34200
7782	    CLARK	2450		        29400
7788	SCOTT	3000		    36000
7839	KING    	5000		    60000
7844	TURNER	1500	0	    18000
7876	ADAMS	1100		    13200
7900	JAMES	950		        11400
7902	    FORD	    3000		    36000
7934	MILLER	1300		    15600
*/

SELECT EMPNO "�����ȣ", ENAME "�����", SAL "�޿�", COMM "����", SAL*12+NVL2(COMM, COMM, 0) "����"
FROM TBL_EMP;
/*
7369	SMITH	800		        9600
7499	ALLEN	1600	300	    19500
7521    	WARD	    1250    	500	    15500
7566	JONES	2975		        35700
7654	MARTIN	1250    	1400	16400
7698	BLAKE	2850		        34200
7782	    CLARK	2450		        29400
7788	SCOTT	3000		    36000
7839	KING    	5000		    60000
7844	TURNER	1500	0	    18000
7876	ADAMS	1100		    13200
7900	JAMES	950		        11400
7902	    FORD	    3000		    36000
7934	MILLER	1300		    15600
*/

--�� COALESCE()
--> �Ű����� ������ ���� ���·� �����ϰ� Ȱ���Ѵ�.
--  �� �տ� �ִ� �Ű��������� ���ʷ� NULL ���� �ƴ��� Ȯ���Ͽ�
--  NULL �� �ƴ� ��� �� ���� ��ȯ�ϰ�,
--  NULL �� ��쿡�� �� ���� �Ű������� ���� ��ȯ�Ѵ�.
--  NVL() �̳� NVL2() �� ������ ��
--  ��~~~�� ����� ���� ������ �� �ִٴ� Ư¡�� ���´�.
SELECT NULL "COL1", COALESCE(NULL, NULL, NULL, 40) "COL2"
            , COALESCE(NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 100) "COL3"
            , COALESCE(NULL, NULL, 30, NULL, NULL, 60) "COL4"
            , COALESCE(10, NULL, NULL, NULL, NULL, 50) "COL5"
FROM DUAL;
--==> (null) 	40	100	30	10

--�� �ǽ��� ���� ������ �߰� �Է�
INSERT INTO TBL_EMP(EMPNO, ENAME, JOB, MGR, HIREDATE, DEPTNO)
VALUES(8000, '�����', 'SALESMAN', 7369, SYSDATE, 10);
--==> 1 �� ��(��) ���ԵǾ����ϴ�.

INSERT INTO TBL_EMP(EMPNO, ENAME, JOB, MGR, HIREDATE, DEPTNO, COMM)
VALUES(8001, '�ټ���', 'SALESMAN', 7369, SYSDATE, 10, 10);
--==> 1 �� ��(��) ���ԵǾ����ϴ�.

SELECT *
FROM TBL_EMP;
/*
8000	�����	SALESMAN    	7369	2023-10-19  (null)  (null)	10
8001	�ټ���	SALESMAN	    7369	2023-10-19  (null)	   10	10
*/

--�� Ŀ��
COMMIT;
--==> Ŀ�� �Ϸ�.

--�� TBL_EMP ���̺����� ��� �������
--   �����ȣ, �����, �޿�, Ŀ�̼�, ���� �׸��� ��ȸ�Ѵ�.
--   ��, �޿�(SAL)�� �ſ� �����Ѵ�.
--   ����, ����(COMM)�� �� 1ȸ �����ϸ�, ���� ������ ���Եȴ�.
SELECT EMPNO"�����ȣ", ENAME"�����", SAL"�޿�", COMM"Ŀ�̼�"
    , NVL2(SAL,SAL,0)*12+NVL2(COMM,COMM,0)"����"
FROM TBL_EMP;
/*
7369	SMITH	800		        9600
7499	ALLEN	1600	300	    19500
7521    	WARD    	1250    	500	    15500
7566	JONES	2975		        35700
7654	MARTIN	1250	    1400	16400
7698	BLAKE	2850		        34200
7782	    CLARK	2450		        29400
7788	SCOTT	3000		    36000
7839	KING	    5000		    60000
7844	TURNER	1500	0	    18000
7876	ADAMS	1100		    13200
7900	JAMES	950		        11400
7902	    FORD	    3000		    36000
7934	MILLER	1300		    15600
8000	�����			        0
8001	�ټ���		    10	    10
*/

SELECT EMPNO"�����ȣ", ENAME"�����", SAL"�޿�", COMM"Ŀ�̼�"
    , NVL(SAL,0)*12+NVL(COMM,0)"����"
FROM TBL_EMP;
/*
7369	SMITH	800		        9600
7499	ALLEN	1600	300	    19500
7521    	WARD    	1250    	500	    15500
7566	JONES	2975		        35700
7654	MARTIN	1250	    1400	16400
7698	BLAKE	2850		        34200
7782	    CLARK	2450		        29400
7788	SCOTT	3000		    36000
7839	KING	    5000		    60000
7844	TURNER	1500	0	    18000
7876	ADAMS	1100		    13200
7900	JAMES	950		        11400
7902	    FORD	    3000		    36000
7934	MILLER	1300		    15600
8000	�����			        0
8001	�ټ���		    10	    10
*/
SELECT EMPNO"�����ȣ", ENAME"�����", SAL"�޿�", COMM"Ŀ�̼�"
    , COALESCE(SAL*12+COMM, SAL*12, COMM, 0)"����"
FROM TBL_EMP;
/*
7369	SMITH	800		        9600
7499	ALLEN	1600	300	    19500
7521    	WARD    	1250    	500	    15500
7566	JONES	2975		        35700
7654	MARTIN	1250	    1400	16400
7698	BLAKE	2850		        34200
7782	    CLARK	2450		        29400
7788	SCOTT	3000		    36000
7839	KING	    5000		    60000
7844	TURNER	1500	0	    18000
7876	ADAMS	1100		    13200
7900	JAMES	950		        11400
7902	    FORD	    3000		    36000
7934	MILLER	1300		    15600
8000	�����			        0
8001	�ټ���		    10	    10
*/

--�� ��¥�� ���� ���� ���� ����
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH:MI:SS';
--==> Session��(��) ����Ǿ����ϴ�.

--�� �÷��� �÷��� ����(����)
SELECT 1, 2
FROM DUAL;

SELECT 1 + 2
FROM DUAL;

SELECT '������', '������'
FROM DUAL;

SELECT '������' + '������'
FROM DUAL;
--==> ���� �߻�
-- ORA-01722: invalid number

SELECT '������' || '������'
FROM DUAL;
--==> �����̼�����

SELECT ENAME, JOB
FROM TBL_EMP;

SELECT ENAME || JOB
FROM TBL_EMP;
/*
SMITHCLERK
ALLENSALESMAN
WARDSALESMAN
JONESMANAGER
MARTINSALESMAN
BLAKEMANAGER
CLARKMANAGER
SCOTTANALYST
KINGPRESIDENT
TURNERSALESMAN
ADAMSCLERK
JAMESCLERK
FORDANALYST
MILLERCLERK
�����SALESMAN
�ټ���SALESMAN
*/

SELECT '�����̴�', SYSDATE, '�� ����', 500, '���� ���Ѵ�.'
FROM DUAL;
--==> �����̴�	2023-10-19 10:41:09	�� ����	500	���� ���Ѵ�.
--    -------   ------------------- ------- --- ------------
--    ����Ÿ��         ��¥Ÿ��       ����   ����     ����

--�� ���� ��¥ �� �ð��� ��ȯ�ϴ� �Լ�
SELECT SYSDATE, CURRENT_DATE, LOCALTIMESTAMP
FROM DUAL;
--==> 2023-10-19 10:43:15	2023-10-19 10:43:15	23/10/19 10:43:15.000000000

SELECT '�����̴� ' || SYSDATE || '�� ���� ' || 500 || '���� ���Ѵ�.'
FROM DUAL;
--==> �����̴� 2023-10-19 10:44:52�� ���� 500���� ���Ѵ�.

--�� ����Ŭ������ ���� Ÿ���� ���·� ��(TYPE)�� ��ȯ�ϴ� ������ ���� ����
--   || �� ������ �ָ� ������ �÷��� �÷�(���� �ٸ� ������ ������)��
--   �����ϴ� ���� �����ϴ�.
--   cf) MSSQL ������ ��� �����͸� ���ڿ��� CONVERT �ؾ� �Ѵ�.(����Ŭ�� �̷��� ���ص� �ȴ�.)

--�� ��¥ ���� ���� ���� ����
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD';
--==> Session��(��) ����Ǿ����ϴ�.

--�� TBL_EMP ���̺��� �����͸� Ȱ���Ͽ�
--   ������ ���� ����� ���� �� �ֵ��� �������� �����Ѵ�.
--   SMITH�� ���� ������ 9600�ε� ��� ������ 19200�̴�.
--   ALLEN�� ���� ������ 19500�ε� ��� ������ 39000�̴�.
--                      :
--                      :
--   �ټ����� ���� ������ 10�ε� ��� ������ 20�̴�.
--   ��, ���ڵ帶�� ���� ���� ������ �� �÷��� ��� ��ȸ�� �� �ֵ��� ó���Ѵ�.
SELECT ENAME || '�� ���� ������ ' 
       || (NVL(SAL,0)*12+NVL(COMM,0)) --COALESCE(SAL*12+COMM, SAL*12, COMM, 0), (NVL2(SAL,SAL,0)*12+NVL2(COMM,COMM,0))
       || '�ε� ��� ������ '  
       || (NVL(SAL,0)*12+NVL(COMM,0))*2 --COALESCE(SAL*12+COMM, SAL*12, COMM, 0)*2, (NVL2(SAL,SAL,0)*12+NVL2(COMM,COMM,0))*2
       || '�̴�.'                                      
FROM TBL_EMP;
/*
SMITH�� ���� ������ 9600�ε� ��� ������ 19200�̴�.
ALLEN�� ���� ������ 19500�ε� ��� ������ 39000�̴�.
WARD�� ���� ������ 15500�ε� ��� ������ 31000�̴�.
JONES�� ���� ������ 35700�ε� ��� ������ 71400�̴�.
MARTIN�� ���� ������ 16400�ε� ��� ������ 32800�̴�.
BLAKE�� ���� ������ 34200�ε� ��� ������ 68400�̴�.
CLARK�� ���� ������ 29400�ε� ��� ������ 58800�̴�.
SCOTT�� ���� ������ 36000�ε� ��� ������ 72000�̴�.
KING�� ���� ������ 60000�ε� ��� ������ 120000�̴�.
TURNER�� ���� ������ 18000�ε� ��� ������ 36000�̴�.
ADAMS�� ���� ������ 13200�ε� ��� ������ 26400�̴�.
JAMES�� ���� ������ 11400�ε� ��� ������ 22800�̴�.
FORD�� ���� ������ 36000�ε� ��� ������ 72000�̴�.
MILLER�� ���� ������ 15600�ε� ��� ������ 31200�̴�.
������� ���� ������ 0�ε� ��� ������ 0�̴�.
�ټ����� ���� ������ 10�ε� ��� ������ 20�̴�.
*/

--�� TBL_EMP ���̺��� �����͸� Ȱ���Ͽ�
--   ������ ���� ����� ���� �� �ֵ��� �������� �����Ѵ�.
--   SMITH's �Ի����� 1980-12-17�̴�. �׸��� �޿��� 800�̴�.
--   ALLEN's �Ի����� 1981-02-20�̴�. �׸��� �޿��� 1600�̴�.
--                          :
--                          :
--   �ټ���'s �Ի����� 2023-1019�̴�. �׸��� �޿��� 0�̴�.
--   ��, ���ڵ帶�� ���� ���� ������ �� �÷��� ��� ��ȸ�� �� �ֵ��� ó���Ѵ�.
DESC TBL_EMP;

SELECT ENAME
       || '''s�� �Ի����� ' 
       || HIREDATE || '�̴�.' 
       || ' �׸��� �޿��� ' 
       || COALESCE(SAL, 0) --NVL(SAL, 0), NVL2(SAL, SAL, 0)
       || '�̴�.'
FROM TBL_EMP;

--�� ���ڿ��� ��Ÿ���� Ȧ����ǥ ���̿��� (���۰� ��)
--   Ȧ����ǥ �� �밡 Ȧ����ǥ �ϳ�(���۽�Ʈ����)�� �ǹ��Ѵ�.
--   ��, Ȧ����ǥ �ϳ�(')�� ���ڿ��� ������ ��Ÿ����,
--   Ȧ����ǥ �ΰ�('')�� ���ڿ� ���� �ȿ��� ���۽�Ʈ���Ǹ� ��Ÿ����,
--   �ٽ� �������� �����ϴ� Ȧ����ǥ �ϳ�(')�� ���ڿ� ������ ���Ḧ �ǹ��ϰ� �Ǵ� ���̴�.
/*
SMITH's�� �Ի����� 1980-12-17�̴�. �׸��� �޿��� 800�̴�.
ALLEN's�� �Ի����� 1981-02-20�̴�. �׸��� �޿��� 1600�̴�.
WARD's�� �Ի����� 1981-02-22�̴�. �׸��� �޿��� 1250�̴�.
JONES's�� �Ի����� 1981-04-02�̴�. �׸��� �޿��� 2975�̴�.
MARTIN's�� �Ի����� 1981-09-28�̴�. �׸��� �޿��� 1250�̴�.
BLAKE's�� �Ի����� 1981-05-01�̴�. �׸��� �޿��� 2850�̴�.
CLARK's�� �Ի����� 1981-06-09�̴�. �׸��� �޿��� 2450�̴�.
SCOTT's�� �Ի����� 1987-07-13�̴�. �׸��� �޿��� 3000�̴�.
KING's�� �Ի����� 1981-11-17�̴�. �׸��� �޿��� 5000�̴�.
TURNER's�� �Ի����� 1981-09-08�̴�. �׸��� �޿��� 1500�̴�.
ADAMS's�� �Ի����� 1987-07-13�̴�. �׸��� �޿��� 1100�̴�.
JAMES's�� �Ի����� 1981-12-03�̴�. �׸��� �޿��� 950�̴�.
FORD's�� �Ի����� 1981-12-03�̴�. �׸��� �޿��� 3000�̴�.
MILLER's�� �Ի����� 1982-01-23�̴�. �׸��� �޿��� 1300�̴�.
�����'s�� �Ի����� 2023-10-19�̴�. �׸��� �޿��� 0�̴�.
�ټ���'s�� �Ի����� 2023-10-19�̴�. �׸��� �޿��� 0�̴�.
*/

SELECT *
FROM TBL_EMP
WHERE JOB = 'SALESMAN';
/*
7499	ALLEN	SALESMAN    	7698	1981-02-20	    1600	300 	30
7521    	WARD	    SALESMAN    	7698	1981-02-22	    1250    	500	    30
7654	MARTIN	SALESMAN    	7698	1981-09-28	    1250	    1400	30
7844	TURNER	SALESMAN    	7698	1981-09-08	    1500	0	    30
8000	�����	SALESMAN    	7369	2023-10-19			            10
8001	�ټ���	SALESMAN    	7369	2023-10-19		        10	    10
*/

SELECT *
FROM TBL_EMP
WHERE JOB = 'salesman';
--==> ��ȸ ��� ����.

SELECT *
FROM TBL_EMP
WHERE JOB = 'SalesmAn';
--==> ��ȸ ��� ����.

--�� UPPER(), LOWER(), INITCAP()
SELECT 'oRACle' "COL1"
    , UPPER('oRACle') "COL2"
    , LOWER('oRACle') "COL3"
    , INITCAP('oRACle') "COL4"
FROM DUAL;
--==> oRACle	ORACLE	oracle	Oracle
-- UPPER() �� ��� �빮�ڷ� ��ȯ
-- LOWER() �� ��� �ҹ��ڷ� ��ȯ
-- INITCAP() �� ù ���ڸ� �빮�ڷ� �ϰ� �������� ��� �ҹ��ڷ� ��ȯ�Ͽ� ��ȯ

--�� �ǽ��� ���� �߰� ������ �Է�
INSERT INTO TBL_EMP(EMPNO, ENAME, JOB, MGR, HIREDATE, DEPTNO, COMM)
VALUES(8002, '�Ӷ���', 'salesman', 7369, SYSDATE, 20, 100);
--==> 1 �� ��(��) ���ԵǾ����ϴ�.

--��Ȯ��
SELECT *
FROM TBL_EMP;
--==> 8002	�Ӷ���	salesman	7369	2023-10-19		100	20

--�� Ŀ��
COMMIT;
--Ŀ�� �Ϸ�.

--�� TBL_EMP ���̺��� ������� �������(�������)��
--   �����ȣ, �����, �������� ��ȸ�Ѵ�.
--   ����, �˻����� sALeSmAN�� �������� �˻��� �����ϴ���
--   �ش� ������� ��ȸ�� �� �ֵ��� �������� �����Ѵ�.
SELECT EMPNO"�����ȣ", ENAME"�����", JOB "������"
FROM TBL_EMP
WHERE JOB = 'sALeSmAN';
--==> ��ȸ ��� ����.

SELECT EMPNO"�����ȣ", ENAME"�����", JOB "������"
FROM TBL_EMP
WHERE JOB = UPPER('sALeSmAN');    --== WHERE JOB = UPPER('SALESMAN');�� ���� ����
/*
7499	ALLEN	SALESMAN
7521    	WARD	    SALESMAN
7654	MARTIN	SALESMAN
7844	TURNER	SALESMAN
8000	�����	SALESMAN
8001	�ټ���	SALESMAN
*/

SELECT EMPNO"�����ȣ", ENAME"�����", JOB "������"
FROM TBL_EMP
WHERE JOB = LOWER('sALeSmAN');
--==> 8002	�Ӷ���	salesman

SELECT EMPNO"�����ȣ", ENAME"�����", JOB "������"
FROM TBL_EMP
WHERE JOB = UPPER('sALeSmAN') 
    OR JOB = LOWER('sALeSmAN');
/*
7499	ALLEN	SALESMAN
7521    	WARD	    SALESMAN
7654	MARTIN	SALESMAN
7844	TURNER	SALESMAN
8000	�����	SALESMAN
8001	�ټ���	SALESMAN
8002	    �Ӷ���	salesman
*/

SELECT EMPNO"�����ȣ", ENAME"�����", JOB "������"
FROM TBL_EMP
WHERE UPPER(JOB) = UPPER('sALeSmAN');
/*
7499	ALLEN	SALESMAN
7521	    WARD    	SALESMAN
7654	MARTIN	SALESMAN
7844	TURNER	SALESMAN
8000	�����	SALESMAN
8001	�ټ���	SALESMAN
8002	    �Ӷ���	salesman
*/

SELECT EMPNO"�����ȣ", ENAME"�����", JOB "������"
FROM TBL_EMP
WHERE LOWER(JOB) = LOWER('sALeSmAN');
/*
7499	ALLEN	SALESMAN
7521	    WARD    	SALESMAN
7654	MARTIN	SALESMAN
7844	TURNER	SALESMAN
8000	�����	SALESMAN
8001	�ټ���	SALESMAN
8002	    �Ӷ���	salesman
*/

SELECT EMPNO"�����ȣ", ENAME"�����", JOB "������"
FROM TBL_EMP
WHERE INITCAP(JOB) = INITCAP('sALeSmAN');
/*
7499	ALLEN	SALESMAN
7521	    WARD    	SALESMAN
7654	MARTIN	SALESMAN
7844	TURNER	SALESMAN
8000	�����	SALESMAN
8001	�ټ���	SALESMAN
8002	    �Ӷ���	salesman
*/

--�� TBL_EMP ���̺����� �Ի����� 1981�� 9�� 28�� �Ի��� ������
--   �����, ������, �Ի��� �׸��� ��ȸ�Ѵ�.
SELECT *
FROM TBL_EMP;

SELECT �����, ������, �Ի���
FROM TBL_EMP
WHERE �Ի����� 1981�� 9�� 28��;

SELECT ENAME "�����", JOB "������", HIREDATE "�Ի���"
FROM TBL_EMP
WHERE HIREDATE = '1981-09-28';   --'1981-09-28' ����Ÿ��, 1981 ����Ÿ���ε� HIREDATE�� DATEŸ��
--                                  ����� ������ ������ ����Ŭ���� �ڵ����� ����ȯ ���־��� ����.
--                                  ��, �̷��� �ڵ� ����ȯ�� ���ִ� ���� �� ���ٰ��̶�� ���� ����.
--==> MARTIN 	SALESMAN 	1981-09-28

DESC TBL_EMP;

--�� ����� ��--

--�� TO_DATE()
SELECT ENAME "�����", JOB "������", HIREDATE "�Ի���"
FROM TBL_EMP
WHERE HIREDATE = TO_DATE('1981-09-28', 'YYYY-MM-DD');
--              TO_DATE('1981-09-28', 'YYYY-MM-DD') = ��¥(DATE)Ÿ��
--                       1981-09-28                 = �����ϴ� ����Ÿ��
--                      '1981-09-28'                = ����Ÿ��
--==> MARTIN	    SALESMAN	    1981-09-28

--�� TBL_EMP ���̺����� �Ի����� 1981�� 9�� 28�� ����
--   �Ի��� ������ �����, ������, �Ի��� �׸��� ��ȸ�Ѵ�.
SELECT �����, ������, �Ի���
FROM TBL_EMP
WHERE �Ի����� 1981�� 9�� 28�� ����;

SELECT ENAME "�����", JOB "������", HIREDATE "�Ի���"
FROM TBL_EMP
WHERE HIREDATE >= TO_DATE('1981-09-28', 'YYYY-MM-DD');
/*
MARTIN	SALESMAN    	1981-09-28
SCOTT	ANALYST	    1987-07-13
KING    	PRESIDENT	1981-11-17
ADAMS	CLERK	    1987-07-13
JAMES	CLERK	    1981-12-03
FORD    	ANALYST	    1981-12-03
MILLER	CLERK	    1982-01-23
�����	SALESMAN	    2023-10-19
�ټ���	SALESMAN	    2023-10-19
�Ӷ���	salesman	    2023-10-19
*/

--�� ����Ŭ������ ��¥ �������� ũ�� �񱳰� �����ϴ�.
--   ����Ŭ������ ��¥ �����Ϳ� ���� ũ�� �� ��
--   ���ź��� �̷��� �� ū ������ �����Ѵ�.

--�� TBL_EMP ���̺����� �Ի����� 1981�� 4�� 2�� ����
--   1981�� 9�� 28�� ���̿� �Ի��� ��������
--   �����, ������, �Ի��� �׸��� ��ȸ�Ѵ�.(�ش��� ����)
SELECT �����, ������, �Ի���
FROM TBL_EMP
WHERE �Ի����� 1981�� 4�� 2�� ���� 1981�� 9�� 28�� ����;

SELECT ENAME "�����", JOB "������", HIREDATE "�Ի���"
FROM TBL_EMP
WHERE �Ի���>=1981�� 4�� 2��
    AND �Ի��� <= 1981�� 9�� 28��;

SELECT ENAME "�����", JOB "������", HIREDATE "�Ի���"
FROM TBL_EMP
WHERE HIREDATE >= TO_DATE('1981-04-02', 'YYYY-MM-DD')
    AND HIREDATE <= TO_DATE('1981-09-28', 'YYYY-MM-DD');
/*
JONES	MANAGER	1981-04-02
MARTIN	SALESMAN	1981-09-28
BLAKE	MANAGER	1981-05-01
CLARK	MANAGER	1981-06-09
TURNER	SALESMAN	1981-09-08
*/

--�� BETWEEN �� AND ��
SELECT ENAME "�����", JOB "������", HIREDATE "�Ի���"
FROM TBL_EMP
WHERE HIREDATE BETWEEN TO_DATE('1981-04-02', 'YYYY-MM-DD')
                   AND TO_DATE('1981-09-28', 'YYYY-MM-DD');
/*
JONES	MANAGER	1981-04-02
MARTIN	SALESMAN	1981-09-28
BLAKE	MANAGER	1981-05-01
CLARK	MANAGER	1981-06-09
TURNER	SALESMAN	1981-09-08
*/

--�� TBL_EMP ���̺����� �޿�(SAL)�� 2450 ���� 3000������ �������� ��� ��ȸ�Ѵ�.
SELECT *
FROM TBL_EMP
WHERE SAL BETWEEN 2450 AND 3000;
/*
7566	JONES	MANAGER	7839	1981-04-02	2975		20
7698	BLAKE	MANAGER	7839	1981-05-01	2850		30
7782	    CLARK	MANAGER	7839	1981-06-09	2450		10
7788	SCOTT	ANALYST	7566	1987-07-13	3000	20
7902    	FORD    	ANALYST	7566	1981-12-03	3000	20
*/

--�� TBL_EMP ���̺����� �������� �̸���
--   'C'�� �����ϴ� �̸����� 'S'�� �����ϴ� �̸��� ���
--   ��� �׸��� ��ȸ�Ѵ�.
SELECT *
FROM TBL_EMP
WHERE ENAME BETWEEN 'C' AND 'S'; 
--S�� �����ϴ� ������� ���� ������ ���ڴ� ������ �迭 �������� �Ѵ�.
--��, �������� ������ S�ڿ� SMITH�� SCOTT�� �ֱ⶧���� �������� �ʴ´�.
/*
7566	JONES	MANAGER	    7839	1981-04-02	2975		        20
7654	MARTIN	SALESMAN	    7698	1981-09-28	1250    	1400	30
7782	    CLARK	MANAGER	    7839	1981-06-09	2450		        10
7839	KING    	PRESIDENT		    1981-11-17	5000		    10
7900	JAMES	CLERK	    7698	1981-12-03	950		        30
7902	    FORD    	ANALYST	    7566	1981-12-03	3000		    20
7934	MILLER	CLERK	    7782    	1982-01-23	1300		    10
*/

--DATE--
--------------��------------------------------��--------------------------
--         1981-04-02                     1981-09-28
--����--
--------------��------------------------------��--------------------------
--           2450                            3000
--����--
--------------��------------------------------��--------------------------
--           'C'                              'S'

SELECT *
FROM TBL_EMP
WHERE ENAME BETWEEN 'C' AND 's'; --�ƽ�Ű �ڵ� ������� �빮�ڰ� ���� �ҹ��ڰ� �ڿ� ������ ������ �̷��� �ϸ� ��ȸ�ȴ�.
/*
7369	SMITH	CLERK	7902    	1980-12-17	800		        20
7521    	WARD    	SALESMAN	7698	1981-02-22	1250	    500	    30
7566	JONES	MANAGER	7839	1981-04-02	2975		        20
7654	MARTIN	SALESMAN	7698	1981-09-28	1250	    1400	30
7782    	CLARK	MANAGER	7839	1981-06-09	2450		        10
7788	SCOTT	ANALYST	7566	1987-07-13	3000		    20
7839	KING    	PRESIDENT		1981-11-17	5000		    10
7844	TURNER	SALESMAN	7698	1981-09-08	1500	0	    30
7900	JAMES	CLERK	7698	1981-12-03	950		        30
7902	    FORD	    ANALYST	7566	1981-12-03	3000		    20
7934	MILLER	CLERK	7782	    1982-01-23	1300		    10
*/

--�� BETWEEN �� AND �� �� ��¥��, ������, ������ ������ ��ο� ����ȴ�.
--   ��, �������� ��� �ƽ�Ű�ڵ� ������ ������ ������(������ �迭)
--   �빮�ڰ� ���ʿ� ��ġ�ϰ�, �չ��ڰ� ���ʿ� ��ġ�Ѵ�.
--   ����, BETWEEN �� AND �� �� �ش� ������ ����Ǵ� ��������
--   ����Ŭ ���������δ� �ε�ȣ �������� ���·� �ٲ�� ���� ó���ȴ�.

--�� ASCII()
--   �Ű������� �Ѱܹ��� �ش� ������ �ƽ�Ű �ڵ� ���� ��ȯ�Ѵ�.
SELECT ASCII('A') "COL1"
    ,  ASCII('B') "COL2"
    ,  ASCII('a') "COL3"
    ,  ASCII('b') "COL4"
FROM DUAL;
--==> 65	66	97	98

SELECT ENAME, JOB, SAL
FROM TBL_EMP
WHERE JOB = 'SALESMAN'
    OR JOB = 'CLERK';
--���� ����.
SELECT ENAME, JOB, SAL
FROM TBL_EMP
WHERE JOB IN ('SALESMAN', 'CLERK');
--���� ����.
SELECT ENAME, JOB, SAL
FROM TBL_EMP
WHERE JOB =ANY ('SALESMAN', 'CLERK');
/*
SMITH	CLERK	    800
ALLEN	SALESMAN	    1600
WARD    	SALESMAN	    1250
MARTIN	SALESMAN	    1250
TURNER	SALESMAN	    1500
ADAMS	CLERK	    1100
JAMES	CLERK	    950
MILLER	CLERK	    1300
�����	SALESMAN	
�ټ���	SALESMAN	
*/

--�� ���� 3���� ������ �������� ��� ���� ����� ��ȯ�Ѵ�.
--   ������, �� ���� ������(OR)�� ���� ������ ó���ȴ�.(���� �� �ȵ�����...)
--   ���� �޸𸮿� ���� ������ �ƴ϶� CPU�� ���� �����̹Ƿ�
--   �� �κб��� �����Ͽ� �������� �����ϰ� �Ǵ� ���� ���� �ʴ�.
--   -> IN�� =ANY�� �� ��Ȳ���� ��� ���� ������ ȿ���� ������.
--      �̵� ��δ� ���������� OR ������ ����Ǿ� ���� ó���ȴ�.

-----------------------------------------------------------------------------

--�� �߰� �ǽ� ���̺� ����(TBL_SAWON)
CREATE TABLE TBL_SAWON
( SANO      NUMBER(4)
, SANAME    VARCHAR2(30)
, JUBUN     CHAR(13)
, HIREDATE  DATE        DEFAULT SYSDATE
, SAL       NUMBER(10)
);
--==> Table TBL_SAWON��(��) �����Ǿ����ϴ�.

SELECT *
FROM TBL_SAWON;
--==> ��ȸ ��� ����

DESC TBL_SAWON
/*
�̸�       ��? ����           
-------- -- ------------ 
SANO        NUMBER(4)    
SANAME      VARCHAR2(30) 
JUBUN       CHAR(13)     
HIREDATE    DATE         
SAL         NUMBER(10)   
*/

--�� ������ ���̺��� ������ �Է�(TBL_SAWON)
INSERT INTO TBL_SAWON(SANO, SANAME, JUBUN, HIREDATE, SAL)
VALUES(1001, '������', '9710171234567', TO_DATE('2005-01-03', 'YYYY-MM--DD'), 3000);

INSERT INTO TBL_SAWON(SANO, SANAME, JUBUN, HIREDATE, SAL)
VALUES(1002, '�ڰ���', '9511182234567', TO_DATE('1999-11-23', 'YYYY-MM--DD'), 4000);

INSERT INTO TBL_SAWON(SANO, SANAME, JUBUN, HIREDATE, SAL)
VALUES(1003, '�ڳ���', '9902082234567', TO_DATE('2006-08-10', 'YYYY-MM--DD'), 4000);

INSERT INTO TBL_SAWON(SANO, SANAME, JUBUN, HIREDATE, SAL)
VALUES(1004, '������', '9708112234567', TO_DATE('2010-05-06', 'YYYY-MM--DD'), 5000);

INSERT INTO TBL_SAWON(SANO, SANAME, JUBUN, HIREDATE, SAL)
VALUES(1005, '������', '0502034234567', TO_DATE('2015-10-19', 'YYYY-MM--DD'), 1000);

INSERT INTO TBL_SAWON(SANO, SANAME, JUBUN, HIREDATE, SAL)
VALUES(1006, '������', '0609304234567', TO_DATE('2012-06-17', 'YYYY-MM--DD'), 1000);

INSERT INTO TBL_SAWON(SANO, SANAME, JUBUN, HIREDATE, SAL)
VALUES(1007, '�μ���', '6510102234567', TO_DATE('1999-08-22', 'YYYY-MM--DD'), 2000);

INSERT INTO TBL_SAWON(SANO, SANAME, JUBUN, HIREDATE, SAL)
VALUES(1008, '������', '6909101234567', TO_DATE('1998-01-10', 'YYYY-MM--DD'), 2000);

INSERT INTO TBL_SAWON(SANO, SANAME, JUBUN, HIREDATE, SAL)
VALUES(1009, '���̰�', '0505053234567', TO_DATE('2011-05-06', 'YYYY-MM--DD'), 1500);

INSERT INTO TBL_SAWON(SANO, SANAME, JUBUN, HIREDATE, SAL)
VALUES(1010, '������', '6611112234567', TO_DATE('2000-01-16', 'YYYY-MM--DD'), 1300);

INSERT INTO TBL_SAWON(SANO, SANAME, JUBUN, HIREDATE, SAL)
VALUES(1011, '������', '9501061234567', TO_DATE('2009-09-19', 'YYYY-MM--DD'), 4000);

INSERT INTO TBL_SAWON(SANO, SANAME, JUBUN, HIREDATE, SAL)
VALUES(1012, '���켱', '0606064234567', TO_DATE('2011-11-11', 'YYYY-MM--DD'), 2000);

INSERT INTO TBL_SAWON(SANO, SANAME, JUBUN, HIREDATE, SAL)
VALUES(1013, '����', '6511111234567', TO_DATE('1999-11-11', 'YYYY-MM--DD'), 2000);

INSERT INTO TBL_SAWON(SANO, SANAME, JUBUN, HIREDATE, SAL)
VALUES(1014, '������', '9904171234567', TO_DATE('2009-11-11', 'YYYY-MM--DD'), 2000);

INSERT INTO TBL_SAWON(SANO, SANAME, JUBUN, HIREDATE, SAL)
VALUES(1015, '���ù�', '0202023234567', TO_DATE('2010-10-10', 'YYYY-MM--DD'), 2300);
--==> 1 �� ��(��) ���ԵǾ����ϴ�. * 15

--�� Ȯ��
SELECT *
FROM TBL_SAWON;
/*
1001	������	9710171234567	2005-01-03	3000
1002    	�ڰ���	9511182234567	1999-11-23	4000
1003	�ڳ���	9902082234567	2006-08-10	4000
1004	������	9708112234567	2010-05-06	5000
1005	������	0502034234567	2015-10-19	1000
1006	������	0609304234567	2012-06-17	1000
1007	�μ���	6510102234567	1999-08-22	2000
1008	������	6909101234567	1998-01-10	2000
1009	���̰�	0505053234567	2011-05-06	1500
1010	������	6611112234567	2000-01-16	1300
1011	������	9501061234567	2009-09-19	4000
1012	    ���켱	0606064234567	2011-11-11	2000
1013	����  	6511111234567	1999-11-11	2000
1014	������	9904171234567	2009-11-11	2000
1015	���ù�	0202023234567	2010-10-10	2300
*/

--�� ������ �Է� �߸������� �ٲٴ� ��
--UPDATE TBL_SAWON
--SET HIREDATE = '2012-06-17'
--WHERE SANO = 1006;

--�� Ŀ��
COMMIT;
--==> Ŀ�� �Ϸ�.

--�� TBL_SAWON ���̺����� '������' ����� �����͸� ��ȸ�Ѵ�.
SELECT *
FROM TBL_SAWON
WHERE SANAME = '������';
--==> 1014	������	9904171234567	2009-11-11	2000

SELECT *
FROM TBL_SAWON
WHERE SANAME LIKE '������';
--==> 1014	������	9904171234567	2009-11-11	2000

--�� LIKE : ���� -> �����ϴٰ� �ƴ�
--          �λ� -> ~�� ����, ~ó������ ����

--�� WILD CARD(CHARACTER) -> %
--   LIKE�� �Բ� ���Ǵ� (%)�� ��� ���ڸ� �ǹ��ϰ�
--   LIKE�� �Բ� ���Ǵ� (_)�� �ƹ� ���� �� ���� �ǹ��Ѵ�.

--�� TBL_SAWON ���̺����� ������ '��'���� �����
--   �����, �ֹι�ȣ, �޿� �׸��� ��ȸ�Ѵ�.
SELECT �����, �ֹι�ȣ, �޿�
FROM TBL_SAWON
WHERE ������ '��'��;

SELECT SANAME, JUBUN, SAL
FROM TBL_SAWON
WHERE SANAME = '��';
--==> ��ȸ ��� ����.

SELECT SANAME, JUBUN, SAL
FROM TBL_SAWON
WHERE SANAME = '��__';
--==> ��ȸ ��� ����.

SELECT SANAME, JUBUN, SAL
FROM TBL_SAWON
WHERE SANAME LIKE '��__';
--==> ������	9710171234567	3000

SELECT SANAME, JUBUN, SAL
FROM TBL_SAWON
WHERE SANAME LIKE '��%';
--==> ������	9710171234567	3000

--�� TBL_SAWON ���̺����� ������ '��' ���� �����
--   �����, �ֹι�ȣ, �޿� �׸��� ��ȸ�Ѵ�.
SELECT SANAME, JUBUN, SAL
FROM TBL_SAWON
WHERE SANAME LIKE '��%';     -- '��__';
/*
������	0609304234567	1000
���̰�	0505053234567	1500
������	9501061234567	4000
������	9904171234567	2000
*/

--�� TBL_SAWON ���̺����� ����� �̸��� �� ���� ������ �����
--   �����, �ֹι�ȣ, �޿� �׸��� ��ȸ�Ѵ�.
SELECT SANAME, JUBUN, SAL
FROM TBL_SAWON
WHERE SANAME LIKE '__��';     -- '%��'; -> �׳� '��'�� ã��
--==> �ڰ���	9511182234567	4000
--==> �ڳ���	9902082234567	4000

--�� TBL_SAWON ���̺����� ����� �̸��� '��'��� ���ڰ�
--   �ϳ��� ���ԵǾ� �ִٸ� �� �����
--   �����ȣ, �����, �޿��׸��� ��ȸ�Ѵ�.
SELECT SANO, SANAME, SAL
FROM TBL_SAWON
WHERE SANAME LIKE '%��%';
/*
1005	������	1000
1006	������	1000
1007	�μ���	2000
1009	���̰�	1500
1011	������	4000
1014	������	2000
*/

--�� TBL_SAWON ���̺����� ����� �̸��� '��'��� ���ڰ�
--   �� �� ����ִ� ����� �����ȣ, �����, �޿��׸��� ��ȸ�Ѵ�.
SELECT SANO, SANAME, SAL
FROM TBL_SAWON
WHERE SANAME LIKE '%��%��%';
/*
1006	������	1000
1009	���̰�	1500
*/

--�� TBL_SAWON ���̺����� ����� �̸��� '��'��� ���ڰ�
--   �������� �� �� ����ִ� �����
--   �����ȣ, �����, �޿��׸��� ��ȸ�Ѵ�.
SELECT SANO, SANAME, SAL
FROM TBL_SAWON
WHERE SANAME LIKE '%����%';
--==> 1009	���̰�	1500

--�� TBL_SAWON ���̺����� ����� �̸��� �� ��° ���ڰ� '��"�� �����
--   �����ȣ, �����, �޿� �׸��� ��ȸ�Ѵ�.
SELECT SANO, SANAME, SAL
FROM TBL_SAWON
WHERE SANAME LIKE '_��%';  --'_��_' = �̷��� ���� 3���ڰ� �ƴ� 4���� 5���ڸ� �ȳ���.
/*
1001	������	3000
1004	������	5000
*/

--�� TBL_SAWON ���̺����� ������ '��'���� �����
--   �����ȣ, �����, �ֹι�ȣ, �޿� �׸��� ��ȸ�Ѵ�.
SELECT *
FROM TBL_SAWON;

SELECT SANO, SANAME, JUBUN, SAL
FROM TBL_SAWON
WHERE SANAME LIKE '��%';
/*
1008	������	6909101234567	2000
1010	������	6611112234567	1300
1012	    ���켱	0606064234567	2000
*/
--�� �����ͺ��̽� ���� ��������
--   ���� �̸��� �и��Ͽ� ó���� ���� ��ȹ�� �ִٸ�
--   (���� ������ �ƴϴ���...)
--   ���̺����� �� �÷��� �̸� �÷��� �и��Ͽ� �����ؾ� �Ѵ�.
-- ���� �̸��� �и��Ǿ� ���� ������ �� ������ ã�� �� ����
-- ������ ���� ������ �������� �𸣱� ����.
-- ���߿� ���� �и��ϴ� ������ �ִٸ� FIRSTNAME, LASTNAME���� ������ �� �� �ֵ��� �Ѵ�.

--�� TBL_SAWON ���̺����� ����������
--   �����, �ֹι�ȣ, �޿� �׸��� ��ȸ�Ѵ�.
SELECT SANAME, JUBUN, SAL
FROM TBL_SAWON
WHERE JUBUN LIKE '______2%' OR JUBUN LIKE '______4%';
/*
�ڰ���	9511182234567	4000
�ڳ���	9902082234567	4000
������	9708112234567	5000
������	0502034234567	1000
������	0609304234567	1000
�μ���	6510102234567	2000
������	6611112234567	1300
���켱	0606064234567	2000
*/

DESC TBL_SAWON;
/*
�̸�       ��? ����           
-------- -- ------------ 
SANO        NUMBER(4)    
SANAME      VARCHAR2(30) 
JUBUN       CHAR(13)     
HIREDATE    DATE         
SAL         NUMBER(10) 
*/

--�۰���� ���--
SELECT �����, �ֹι�ȣ, �޿�
FROM TBL_SAWON
WHERE ������ ����;

SELECT SANAME, JUBUN, SAL
FROM TBL_SAWON
WHERE �ֹι�ȣ 7��° �ڸ� 1���� 2
   OR �ֹι�ȣ 7��° �ڸ� 1���� 4;

SELECT SANAME, JUBUN, SAL
FROM TBL_SAWON
WHERE JUBUN LIKE '______2%'
   OR JUBUN LIKE '______4%';
/*
�ڰ���	9511182234567	4000
�ڳ���	9902082234567	4000
������	9708112234567	5000
������	0502034234567	1000
������	0609304234567	1000
�μ���	6510102234567	2000
������	6611112234567	1300
���켱	0606064234567	2000
*/

--�� �ǽ� ���̺� ����(TBL_WATCH)
CREATE TABLE TBL_WATCH
( WATCH_NAME        VARCHAR2(20)
, BIGO              VARCHAR2(100)
);
--==> Table TBL_WATCH��(��) �����Ǿ����ϴ�.

--�� ������ �Է�
INSERT INTO TBL_WATCH(WATCH_NAME, BIGO)
VALUES('�ݽð�', '���� 99.99% ������ �ְ��� �ð�');

INSERT INTO TBL_WATCH(WATCH_NAME, BIGO)
VALUES('���ð�', '���������� 99.99���� ȹ���� �ְ��� �ð�');
--==> 1 �� ��(��) ���ԵǾ����ϴ�. * 2

SELECT *
FROM TBL_WATCH;
-- �ݽð�	���� 99.99% ������ �ְ��� �ð�
-- ���ð�	���������� 99.99���� ȹ���� �ְ��� �ð�

--�� Ŀ��
COMMIT;
--==> Ŀ�� �Ϸ�.

--�� TBL_WATCH ���̺��� BIGO(���) �÷���
--   99.99%��� ���ڰ� ���Ե�(����ִ�) ��(���ڵ�)��
--   �����͸� ��ȸ�Ѵ�.
SELECT *
FROM TBL_WATCH
WHERE BIGO LIKE '%99.99%';
/*
�ݽð�	���� 99.99% ������ �ְ��� �ð�
���ð�	���������� 99.99���� ȹ���� �ְ��� �ð�
*/

--�� ESCAPE(\,$,#,@�� �̵� �߿� �� �� ���� �� �ƹ��ų� ����)
SELECT *
FROM TBL_WATCH
WHERE BIGO LIKE '%99.99\%%' ESCAPE '\';
--==> �ݽð�	���� 99.99% ������ �ְ��� �ð�

SELECT *
FROM TBL_WATCH
WHERE BIGO LIKE '___99.99%';
--==> �ݽð�	���� 99.99% ������ �ְ��� �ð�

--�� ESCAPE �� ���� ������ ���� �� ���ڸ� ���ϵ�ī�忡�� Ż����Ѷ�...
--   �Ϲ������� ��� �󵵰� ���� Ư������(Ư����ȣ)�� ����Ѵ�.

------------------------------------------------------------------------------

--���� COMMIT / ROLLBACK ����--
SELECT *
FROM TBL_DEPT;
/*
10	ACCOUNTING	NEW YORK
20	RESEARCH    	DALLAS
30	SALES	    CHICAGO
40	OPERATIONS	BOSTON
*/

--�� ������ �Է�
INSERT INTO TBL_DEPT VALUES(50,'���ߺ�','����');
--==> 1 �� ��(��) ���ԵǾ����ϴ�.
--> ������� �ϸ� ������ ��ȸ�� ���̱� ������ �ϵ��ũ�ȿ� �� ���� �ƴ�.
--  ��, �޸� �� �ö� �� ���̴�.
SELECT *
FROM TBL_DEPT;
/*
10	ACCOUNTING	NEW YORK
20	RESEARCH	    DALLAS
30	SALES	    CHICAGO
40	OPERATIONS	BOSTON
50	���ߺ�	    ����
*/

--==> 50�� ���ߺ� ����
--    �� �����ʹ� TBL_DEPT ���̺��� ����Ǿ� �ִ�
--    �ϵ��ũ�� ���������� ����Ǿ� ����� ���� �ƴϴ�.
--    �޸�(RAM) �� �Էµ� ���̴�.

--�� �ѹ�
ROLLBACK;
--==> �ѹ� �Ϸ�.
-- �̴� �޸𸮻� �ö� ���� ����ϴ� ����.

--�� �ٽ� Ȯ��
SELECT *
FROM TBL_DEPT;
/*
10	ACCOUNTING	NEW YORK
20	RESEARCH    	DALLAS
30	SALES	    CHICAGO
40	OPERATIONS	BOSTON
*/
--==> 50 ���ߺ� ���� ...�� ���� �����Ͱ� �ҽǵǾ����� Ȯ��(�������� ����)

--�� �ٽ� ������ �Է�
INSERT INTO TBL_DEPT VALUES(50,'���ߺ�','����');
--==> 1 �� ��(��) ���ԵǾ����ϴ�.

--�� �ٽ� Ȯ��
SELECT *
FROM TBL_DEPT;
/*
10	ACCOUNTING	NEW YORK
20	RESEARCH	    DALLAS
30	SALES	    CHICAGO
40	OPERATIONS	BOSTON
50	���ߺ�	    ����
*/

-- 50 ���ߺ� ����...
-- �� �����ʹ� TBL_DEPT ���̺��� ����Ǿ� �ִ� �ϵ��ũ�� ����� ���� �ƴ϶�
-- �޸�(RAM) �� �Էµ� ���̴�.
-- �̸�... ���� �ϵ��ũ�� ���������� ����� ��Ȳ�� Ȯ���ϱ� ���ؼ���
-- COMMIT�� �����ؾ� �Ѵ�.

--�� Ŀ��
COMMIT;
--==> Ŀ�� �Ϸ�.
--�ϵ� ��ũ �ȿ� �����ϴ� ����.

--�� Ŀ�� ���� �ٽ� Ȯ��
SELECT *
FROM TBL_DEPT;
/*
10	ACCOUNTING	NEW YORK
20	RESEARCH	    DALLAS
30	SALES	    CHICAGO
40	OPERATIONS	BOSTON
50	���ߺ�	    ����
*/

--�� �ѹ�
ROLLBACK;
--==> �ѹ� �Ϸ�.

--�� �ѹ� ���Ŀ� �ٽ� Ȯ��
SELECT *
FROM TBL_DEPT;
/*
10	ACCOUNTING	NEW YORK
20	RESEARCH    	DALLAS
30	SALES	    CHICAGO
40	OPERATIONS	BOSTON
50	���ߺ�	    ����
*/
-- �̹� �ϵ��ũ �� �ö����Ƿ� �������� �ʰ� �״�� ����Ǿ� ������ Ȯ���� �� �ִ�.
--==> �ѹ�(ROLLBACK)�� ������������ �ұ��ϰ�
--    50 ���ߺ� ����...�� �� �����ʹ� �ҽǵ��� �ʾ����� Ȯ��.

--�� COMMIT �� ������ ���ķ� DML(INSERT, UPDATE, DELETE, (����merger)) ������ ����
--   ����� �����͸� ����� �� �ִ� ���ϻ�...
--   DML ������ ����� �� COMMIT�� �����ϰ����� ROLLBACK�� �����غ���
--   �ƹ� �ҿ��� ����.

--�� ������ ����(UPDATE -> TBL_DEPT)
UPDATE TBL_DEPT                    --��
SET DNAME = '������', LOC = '���'  --��
WHERE DEPTNO = 50;                 --��  ���� �� ��Ű��.

/*
UPDATE TBL_DEPT                    
SET DNAME = '������', LOC = '���' 
-- �� 2�ٸ� �־ ������Ʈ�� �Ǿ� �����µ� �׷��� ������ ��û ŭ.
-- ����, �� ���� ���Ѽ� �ۼ��ϴ� ������ �����ߵ�.
*/

--CREATE, ALTER ���� ���� AUTO COMMIT�� ��.