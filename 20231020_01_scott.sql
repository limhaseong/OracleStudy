SELECT USER
FROM DUAL;
--==> SCOTT

--�� ������ ����(UPDATE -> TBL_DEPT)
UPDATE TBL_DEPT                    --��
SET DNAME = '������', LOC = '���'  --��
WHERE DEPTNO = 50;                 --��  ���� �� ��Ű��.
--==> 1 �� ��(��) ������Ʈ�Ǿ����ϴ�.

--�� Ȯ��
SELECT *
FROM TBL_DEPT;
/*
10	ACCOUNTING	NEW YORK
20	RESEARCH    	DALLAS
30	SALES	    CHICAGO
40	OPERATIONS	BOSTON
50	������	    ���
*/

--�� �ѹ�
ROLLBACK;
--==> �ѹ� �Ϸ�.

--�� �ٽ� Ȯ��
SELECT *
FROM TBL_DEPT;
/*
10	ACCOUNTING	NEW YORK
20	RESEARCH    	DALLAS
30	SALES	    CHICAGO
40	OPERATIONS	BOSTON
50	���ߺ�	    ����
*/

--�� ������ ����
UPDATE TBL_DEPT
SET DNAME = '������', LOC = '��õ'
WHERE DEPTNO = 50;
--==> 1 �� ��(��) ������Ʈ�Ǿ����ϴ�.

--�� �ٽ� Ȯ��
SELECT *
FROM TBL_DEPT;
/*
10	ACCOUNTING	NEW YORK
20	RESEARCH    	DALLAS
30	SALES	    CHICAGO
40	OPERATIONS	BOSTON
50	������	    ��õ  
*/

--�� Ŀ��
COMMIT;
--==> Ŀ�� �Ϸ�.

--�� �ѹ�
ROLLBACK;
--==> �ѹ� �Ϸ�.

--�� �ٽ� Ȯ��
SELECT *
FROM TBL_DEPT;
/*
10	ACCOUNTING	NEW YORK
20	RESEARCH    	DALLAS
30	SALES	    CHICAGO
40	OPERATIONS	BOSTON
50	������	    ��õ  
*/

--�� ������ ����(DELETE -> TBL_DEPT)
DELETE TBL_DEPT
WHERE DEPTNO = 50;
--> �̷��� �ᵵ �����Ͱ� ���� ��. ������ �츮�� ���� �����͸� Ȯ�� �ϰ� �����ϱ�� �Ѵ�.
--�Ʒ� ������ �����Ѵ�.

-- ù ��°
SELECT *
FROM TBL_DEPT
WHERE DEPTNO = 50;
--==>50	������	��õ
-- ���⸦ Ȯ�� �Ŀ� ������ �����Ͱ� �´ٸ� SELECT�� DELETE�� �ٲ۴�.

-- �� ��°
DELETE
FROM TBL_DEPT
WHERE DEPTNO = 50;
--==> 1 �� ��(��) �����Ǿ����ϴ�.

SELECT *
FROM TBL_DEPT;
/*
10	ACCOUNTING	NEW YORK
20	RESEARCH    	DALLAS
30	SALES	    CHICAGO
40	OPERATIONS	BOSTON
*/
--> ���⼭ �ѹ��ϸ� ������ ������ �ٽ� ����

--�� Ŀ��
COMMIT;
--==> Ŀ�� �Ϸ�.
--> ���⼭ �ѹ��ϸ� ������ ������ �� ���ƿ�.

----------------------------------------------------------------------------

--���� ORDER BY ��(����) ����--

SELECT ENAME "�����", DEPTNO "�μ���ȣ", JOB "������", SAL "�޿�"
    , SAL * 12 + NVL (COMM,0) "����"
FROM EMP;
/*
SMITH	20	CLERK	    800	    9600
ALLEN	30	SALESMAN	    1600	19500
WARD    	30	SALESMAN	    1250    	15500
JONES	20	MANAGER	    2975    	35700
MARTIN	30	SALESMAN    	1250    	16400
BLAKE	30	MANAGER	    2850    	34200
CLARK	10	MANAGER	    2450	    29400
SCOTT	20	ANALYST	    3000	36000
KING    	10	PRESIDENT	5000	60000
TURNER	30	SALESMAN	    1500	18000
ADAMS	20	CLERK	    1100	13200
JAMES	30	CLERK	    950	    11400
FORD    	20	ANALYST	    3000	36000
MILLER	10	CLERK	    1300	15600
*/

SELECT ENAME "�����", DEPTNO "�μ���ȣ", JOB "������", SAL "�޿�"
    , SAL * 12 + NVL (COMM,0) "����"
FROM EMP
ORDER BY DEPTNO ASC;        -- DEPTNO -> ���� ���� = �μ���ȣ
                            -- ASC    -> ���� ���� = ��������
/*
CLARK	10	MANAGER	    2450	    29400
KING    	10	PRESIDENT	5000	60000
MILLER	10	CLERK	    1300	15600
JONES	20	MANAGER	    2975	    35700
FORD    	20	ANALYST	    3000	36000
ADAMS	20	CLERK	    1100	13200
SMITH	20	CLERK	    800	    9600
SCOTT	20	ANALYST	    3000	36000
WARD    	30	SALESMAN    	1250	    15500
TURNER	30	SALESMAN	    1500	18000
ALLEN	30	SALESMAN    	1600	19500
JAMES	30	CLERK	    950	    11400
BLAKE	30	MANAGER     	2850    	34200
MARTIN	30	SALESMAN	    1250    	16400
*/

SELECT ENAME "�����", DEPTNO "�μ���ȣ", JOB "������", SAL "�޿�"
    , SAL * 12 + NVL (COMM,0) "����"
FROM EMP
ORDER BY DEPTNO;      -- �������� �����϶��� ASC �� ������ �� ����.
--> ASC -> ���� ���� = �������� --> ���� ����.

SELECT ENAME "�����", DEPTNO "�μ���ȣ", JOB "������", SAL "�޿�"
    , SAL * 12 + NVL (COMM,0) "����"
FROM EMP
ORDER BY DEPTNO DESC;       -- DEPTNO -> ���� ���� = �μ���ȣ
                            -- DESC   -> ���� ���� = ��������
                            -- DESC = ����Ȯ���Ҷ��� ���� Ű����
                            --        (��� ��ġ�� �����Ŀ� ���� �ǹ̰� �޶���)
/*
BLAKE	30	MANAGER	    2850	    34200
TURNER	30	SALESMAN	    1500	18000
ALLEN	30	SALESMAN	    1600	19500
MARTIN	30	SALESMAN    	1250	    16400
WARD	    30	SALESMAN	    1250	    15500
JAMES	30	CLERK	    950	    11400
SCOTT	20	ANALYST	    3000	36000
JONES	20	MANAGER	    2975    	35700
SMITH	20	CLERK	    800	    9600
ADAMS	20	CLERK	    1100	13200
FORD    	20	ANALYST	    3000	36000
KING	    10	PRESIDENT	5000	60000
MILLER	10	CLERK	    1300	15600
CLARK	10	MANAGER	    2450    	29400
*/

SELECT ENAME "�����", DEPTNO "�μ���ȣ", JOB "������", SAL "�޿�"
    , SAL * 12 + NVL (COMM,0) "����"
FROM EMP
ORDER BY ���� DESC;
-- SELECT�� �̹� ó���� �����̹Ƿ� �����̶�� �ص� �����ϴ�.
-- SELECT�� ó���Ͽ� ORDER BY�� � ��Ī�� ������ �� �˰� �ִ�.
/*
KING    	10	PRESIDENT	5000	60000
FORD    	20	ANALYST	    3000	36000
SCOTT	20	ANALYST	    3000	36000
JONES	20	MANAGER	    2975	    35700
BLAKE	30	MANAGER	    2850    	34200
CLARK	10	MANAGER	    2450    	29400
ALLEN	30	SALESMAN	    1600	19500
TURNER	30	SALESMAN	    1500	18000
MARTIN	30	SALESMAN	    1250	    16400
MILLER	10	CLERK	    1300	15600
WARD    	30	SALESMAN	    1250    	15500
ADAMS	20	CLERK	    1100	13200
JAMES	30	CLERK	    950	    11400
SMITH	20	CLERK	    800	    9600
*/

SELECT *
FROM EMP;

SELECT ENAME "�����", DEPTNO "�μ���ȣ", JOB "������", SAL "�޿�"
    , SAL * 12 + NVL (COMM,0) "����"
FROM EMP
ORDER BY 2; --> �μ���ȣ ��������
--> EMP ���̺��� ���� �ִ� ���̺��� ������ �÷� ����(2 -> ENAME, �����)�� �ƴ϶�
--  SELECT ó�� �Ǵ� �� ��° �÷�(2 -> DEPTNO, �μ���ȣ) �� �������� ����
--  ASC�� ������ ���� -> �������� ����
--  ����Ŭ������ �⺻ �ε����� �ڹٿ� �޸� 1���� ����
--  ����������...���� ORDER BY 2 ������ -> ORDER BY DEPTNO ASC�̴�.
-- (SELECT �ȿ��� 2��°�� ������ �����϶�� ��.)
-- (�ڹٿ����� ���ڸ� 0���� ���������� ���⼭�� 1���� �������� Ȯ��.)
/*
CLARK	10	MANAGER	    2450    	29400
KING    	10	PRESIDENT	5000	60000
MILLER	10	CLERK	    1300	15600
JONES	20	MANAGER	    2975	    35700
FORD	    20	ANALYST	    3000	36000
ADAMS	20	CLERK	    1100	13200
SMITH	20	CLERK	    800	    9600
SCOTT	20	ANALYST	    3000	36000
WARD	    30	SALESMAN	    1250	    15500
TURNER	30	SALESMAN    	1500	18000
ALLEN	30	SALESMAN    	1600	19500
JAMES	30	CLERK	    950	    11400
BLAKE	30	MANAGER	    2850	    34200
MARTIN	30	SALESMAN	    1250	    16400
*/

SELECT ENAME "�����", DEPTNO "�μ���ȣ", JOB "������", SAL "�޿�"
    , SAL * 12 + NVL (COMM,0) "����"
FROM EMP
ORDER BY 2, 4;
--> �μ���ȣ(1��), �޿�(2��) ���� �������� ����
-- 1�������� DEPTNO�� ������ �ϰ� 2�������� SAL�� ������ �� ��.
/*
MILLER	10	CLERK	    1300	15600
CLARK	10	MANAGER	    2450    	29400
KING    	10	PRESIDENT	5000	60000
SMITH	20	CLERK	    800	    9600
ADAMS	20	CLERK	    1100	13200
JONES	20	MANAGER	    2975    	35700
SCOTT	20	ANALYST	    3000	36000
FORD    	20	ANALYST	    3000	36000
JAMES	30	CLERK	    950	    11400
MARTIN	30	SALESMAN	    1250	    16400
WARD    	30	SALESMAN	    1250    	15500
TURNER	30	SALESMAN	    1500	18000
ALLEN	30	SALESMAN	    1600	19500
BLAKE	30	MANAGER	    2850	    34200
*/

SELECT ENAME, DEPTNO, JOB, SAL
FROM EMP
ORDER BY 2, 3, 4 DESC;
-- �� 2      -> DEPTNO(�μ���ȣ) ���� �������� ����
-- �� 3      -> JOB(������) ���� �������� ����
-- �� 4 DESC -> SAL(�޿�) ���� ��������(DESC) ����
--> �� 3�� ���� ����
-- DEPTNO(1��) - ��������
-- JOB(2��)    - ��������
-- SAL(3��)    - ��������
/*
MILLER	10	CLERK	    1300
CLARK	10	MANAGER	    2450
KING	    10	PRESIDENT	5000
SCOTT	20	ANALYST	    3000
FORD    	20	ANALYST	    3000
ADAMS	20	CLERK	    1100
SMITH	20	CLERK	    800
JONES	20	MANAGER	    2975
JAMES	30	CLERK	    950
BLAKE	30	MANAGER	    2850
ALLEN	30	SALESMAN	    1600
TURNER	30	SALESMAN	    1500
MARTIN	30	SALESMAN	    1250
WARD    	30	SALESMAN	    1250
*/
--> SAL�� ���������� �ƴ� �� �ƴѰ�? �� ���ߵ�.
-- �տ��� �̹� ���ĵ� �� �ȿ��� ������ �ٽ� �ϴ� ����

--�� CONCAT()
SELECT ENAME || JOB "COL1"
    , CONCAT(ENAME, JOB) "COL2"
FROM EMP;
/*
SMITHCLERK	    SMITHCLERK
ALLENSALESMAN	ALLENSALESMAN
WARDSALESMAN    	WARDSALESMAN
JONESMANAGER	    JONESMANAGER
MARTINSALESMAN	MARTINSALESMAN
BLAKEMANAGER	    BLAKEMANAGER
CLARKMANAGER	    CLARKMANAGER
SCOTTANALYST    	SCOTTANALYST
KINGPRESIDENT	KINGPRESIDENT
TURNERSALESMAN	TURNERSALESMAN
ADAMSCLERK	    ADAMSCLERK
JAMESCLERK	    JAMESCLERK
FORDANALYST	    FORDANALYST
MILLERCLERK	    MILLERCLERK
*/

-- ���ڿ� ������� ������ ������ �����ϴ� �Լ� CONCAT()
-- ������ 2���� ���ڿ��� ���ս�ų �� �ִ�.

SELECT '����' || '����ϸ�' || ' ������' "COL1"
    , CONCAT('����', '����ϸ�', '������') "COL2"
FROM DUAL;
--==> ���� �߻�.
-- ORA-00909: invalid number of arguments

-- �����, ������, �μ���ȣ �����Բ�
-- CONCAT() Ȱ���ϱ�

SELECT CONCAT(ENAME,CONCAT(JOB,DEPTNO))
FROM EMP;
/*
SMITHCLERK20
ALLENSALESMAN30
WARDSALESMAN30
JONESMANAGER20
MARTINSALESMAN30
BLAKEMANAGER30
CLARKMANAGER10
SCOTTANALYST20
KINGPRESIDENT10
TURNERSALESMAN30
ADAMSCLERK20
JAMESCLERK30
FORDANALYST20
MILLERCLERK10
*/

--> �������� �� ��ȯ�� �Ͼ�� ������ �����ϰ� �ȴ�.
--  CONCAT() �� ���ڿ��� ���ڿ��� ���ս����ִ� �Լ�������
--  ���������� ���ڳ� ��¥�� ���ڷ� ��ȯ���ִ� ������ ���ԵǾ� �ִ�.

/*
�ڹٿ����� substring()
obj.substring()
---
���ڿ� -> ���ڿ�.substring(n , m);
                         -------
                        ���ڿ��� n���� m-1 ����...(���ؽ��� 0����)
*/

--�� SUBSTR() ���� ���/ SUBSTRB() ����Ʈ ���
--> ���ڿ��� �����ϴ� ����� ���� �Լ�
SELECT ENAME "COL1"
    , SUBSTR(ENAME, 1, 2) "COL2"
FROM EMP;
-- ù ��° �Ķ���� ���� ��� ���ڿ�(������ ���, TARGET)
-- �� ��° �Ķ���� ���� ������ �����ϴ� ��ġ(�ε���, START) -> �ε����� 1���� ����.
-- �� ��° �Ķ���� ���� ������ ���ڿ��� ����(����, COUNT) -> ���� ��.. ���ڿ� ���� �������� �Ѵ�.
-- (1���� 2���� ��, �ι�° �Ķ���ʹ� ����, ����° �Ķ���ʹ� ������.)
/*
SMITH	SM
ALLEN	AL
WARD	    WA
JONES	JO
MARTIN	MA
BLAKE	BL
CLARK	CL
SCOTT	SC
KING	    KI
TURNER	TU
ADAMS	AD
JAMES	JA
FORD    	FO
MILLER	MI
*/

SELECT ENAME "COL1"
    , SUBSTR(ENAME, 3,2) "COL2"
    , SUBSTR(ENAME, 3,5) "COL3"
    , SUBSTR(ENAME, 3) "COL4"
    , SUBSTR(ENAME, 6,1) "COL5"
FROM EMP;
/*
SMITH	IT	ITH	    ITH	
ALLEN	LE	LEN	    LEN	
WARD    	RD	RD	    RD	
JONES	NE	NES	    NES	
MARTIN	RT	RTIN	    RTIN	    N
BLAKE	AK	AKE	    AKE	
CLARK	AR	ARK	    ARK	
SCOTT	OT	OTT	    OTT	
KING    	NG	NG	    NG	
TURNER	RN	RNER    	RNER    	R
ADAMS	AM	AMS	    AMS	
JAMES	ME	MES	    MES	
FORD    	RD	RD	    RD	
MILLER	LL	LLER    	LLER    	R
*/

--�� TBL_SAWON ���̺��� ������ ������ �����
--   �����ȣ, �����, �ֹι�ȣ, �޿� �׸��� ��ȸ�Ѵ�.
--   ��, SUMSTR() �Լ��� Ȱ���Ͽ� ó���� �� �ֵ��� �Ѵ�.

SELECT *
FROM TBL_SAWON;

SELECT SANO �����ȣ, SANAME �����, JUBUN �ֹι�ȣ, SAL �޿�
FROM TBL_SAWON
WHERE SUBSTR(JUBUN, 7, 1) = 1 OR SUBSTR(JUBUN, 7, 1) = 3;
--==> �� ���� ����Ŭ�� ����ȯ�� ������ ����. ������� �ذ��� ��� ����.
/*
1001	������	9710171234567	3000
1008	������	6909101234567	2000
1009	���̰�	0505053234567	1500
1011	������	9501061234567	4000
1013	����  	6511111234567	2000
1014	������	9904171234567	2000
1015	���ù�	0202023234567	2300
*/

--���洩�� ���
SELECT SANO �����ȣ, SANAME �����, JUBUN �ֹι�ȣ, SAL �޿�
FROM TBL_SAWON
WHERE SUBSTR(JUBUN, 7, 1) IN (1,3);

--����� ���
SELECT �����ȣ, �����, �ֹι�ȣ, �޿�
FROM TBL_SAWON
WHERE ������ ����;

SELECT SANO, SANAME, JUBUN, SAL
FROM TBL_SAWON
WHERE JUBUN 7��° �ڸ� 1���� '1'
   OR JUBUN 7��° �ڸ� 1���� '3';

SELECT SANO, SANAME, JUBUN, SAL
FROM TBL_SAWON
WHERE SUBSTR (JUBUN, 7, 1) = '1'
   OR SUBSTR (JUBUN, 7, 1) = '3';

--���� ���� ���������� �ٸ� ���.
SELECT SANO, SANAME, JUBUN, SAL
FROM TBL_SAWON
WHERE SUBSTR (JUBUN, 7, 1) IN ('1','3');
/*
1001	������	9710171234567	3000
1008	������	6909101234567	2000
1009	���̰�	0505053234567	1500
1011	������	9501061234567	4000
1013	����  	6511111234567	2000
1014	������	9904171234567	2000
1015	���ù�	0202023234567	2300
*/

--�� LENGTH() ���� �� / LENGTHB() ����Ʈ ��
SELECT ENAME "COL1"
    , LENGTH(ENAME) "COL2"
    , LENGTHB(ENAME) "COL3"
FROM EMP;
/*
SMITH	5	5
ALLEN	5	5
WARD    	4	4
JONES	5	5
MARTIN	6	6
BLAKE	5	5
CLARK	5	5
SCOTT	5	5
KING    	4	4
TURNER	6	6
ADAMS	5	5
JAMES	5	5
FORD	    4	4
MILLER	6	6
*/

--�� INSTR()
SELECT 'ORACLE ORAHOME BIORA' "COL1"
    , INSTR('ORACLE ORAHOME BIORA', 'ORA', 1, 1) "COL2"  -- 1
    , INSTR('ORACLE ORAHOME BIORA', 'ORA', 1, 2) "COL3"  -- 8
    , INSTR('ORACLE ORAHOME BIORA', 'ORA', 2, 1) "COL4"  -- 8
    , INSTR('ORACLE ORAHOME BIORA', 'ORA', 2) "COL5"     -- 8
    , INSTR('ORACLE ORAHOME BIORA', 'ORA', 2, 3) "COL6"  -- 0(��ã�� ��)
FROM DUAL;
--==> ORACLE ORAHOME BIORA	1	8	8	8	0
--> ù ��° �Ķ���� ���� �ش��ϴ� ���ڿ����� (��� ���ڿ�, TARGET)
--> �� ��° �Ķ���� ���� ���� �Ѱ��� ���ڿ��� �����ϴ� ��ġ�� ã�ƶ�.
--> �� ��° �Ķ���� ���� ã�� �����ϴ� (��ĵ�� �����ϴ�) ��ġ
--> �� ��° �Ķ���� ���� �� ��° �����ϴ� ���� ã�� �������� ���� ����.(1�� ��� ������ ��������.)

-- ��, INSTR('ORACLE ORAHOME BIORA', 'ORA', 2, 1) "COL4" �̰ɷ� ���ڸ�
-- ORACLE ORAHOME BIORA ���⼭ ORA �� ���ڿ��� �����ϴ� ��ġ�� ã�ƶ��ε�
-- ����° �Ķ���Ϳ� ���� �� ��° �ε���(R)���� ã����� ���ε�
-- ������ �����ϴ� ���� ORAHOME ������ ORA�̹Ƿ� 8�� ����
-- INSTR('ORACLE ORAHOME BIORA', 'ORA', 2, 3) "COL6" �̰Ŵ� 
-- ORACLE ORAHOME BIORA ���� ORA�� ã����� ���ε�
-- 2��° �ε����� ���� 3��° ������ ORA�� ã����� ���ε� ORAHOME������ ORA 1��°,
-- BIORA������ ORA 2��°�� 3��°�� �����Ƿ� 0 ����.

SELECT '���ǿ���Ŭ �����ο��� �մϴ�.' "COL1"
    , INSTR('���ǿ���Ŭ �����ο��� �մϴ�.', '����', 1) "COL2"   -- 3
    , INSTR('���ǿ���Ŭ �����ο��� �մϴ�.', '����', 2) "COL3"   -- 3
    , INSTR('���ǿ���Ŭ �����ο��� �մϴ�.', '����', 10) "COL4"  -- 10
    , INSTR('���ǿ���Ŭ �����ο��� �մϴ�.', '����', 11) "COL5"  -- 0
FROM DUAL;
--==> ���ǿ���Ŭ �����ο��� �մϴ�.	3	3	10	0
-- ������ �Ķ���� ���� ������ ���·� ��� -> ������ �Ķ���� = 1

--�� REVERSE()
SELECT 'ORACLE' "COL1"
    , REVERSE('ORACLE') "COL2"
    , REVERSE('����Ŭ') "COL3"
FROM DUAL;
--==> ORACLE	 ELCARO ???
-- ��� ���ڿ��� �Ųٷ� ��ȯ�Ѵ�.
-- ��, �ѱ��� �ȵȴ�.

--�� �ǽ� ���̺� ����(TBL_FILES)
CREATE TABLE TBL_FILES
( FILENO        NUMBER(3)
, FILENAME      VARCHAR2(100)
);
--==> Table TBL_FILES��(��) �����Ǿ����ϴ�.

--�� ������ �Է�(TBL_FILES)
INSERT INTO TBL_FILES VALUES(1, 'C:\AAA\BBB\CCC\SALES.DOC');
INSERT INTO TBL_FILES VALUES(2, 'C:\AAA\PANMAE.XXLS');
INSERT INTO TBL_FILES VALUES(3, 'D:\RESEARCH.PPT');
INSERT INTO TBL_FILES VALUES(4, 'C:\DOCUMENTS\STUDY.HWP');
INSERT INTO TBL_FILES VALUES(5, 'C:\DOCUMENTS\TEMP\HOMEWORK\SQL.TXT');
INSERT INTO TBL_FILES VALUES(6, 'C:\SHARE\F\TEST\FLOWER.PNG');
INSERT INTO TBL_FILES VALUES(7, 'E:\STUDY\ORACLE\20231020_01_SCOTT.SQL');
--==> 1 �� ��(��) ���ԵǾ����ϴ�. * 7

--�� Ȯ��
SELECT *
FROM TBL_FILES;
/*
1	C:\AAA\BBB\CCC\SALES.DOC
2	C:\AAA\PANMAE.XXLS
3	D:\RESEARCH.PPT
4	C:\DOCUMENTS\STUDY.HWP
5	C:\DOCUMENTS\TEMP\HOMEWORK\SQL.TXT
6	C:\SHARE\F\TEST\FLOWER.PNG
7	E:\STUDY\ORACLE\20231020_01_SCOTT.SQL
*/

--�� Ŀ��
COMMIT;
--==> Ŀ�� �Ϸ�.

SELECT FILENO "���Ϲ�ȣ"
    , FILENAME "���ϸ�"
FROM TBL_FILES;
/*
------- ----------------------------------------------------------------------
���Ϲ�ȣ ���ϸ�
------- ----------------------------------------------------------------------
    1	C:\AAA\BBB\CCC\SALES.DOC  --4
    2	C:\AAA\PANMAE.XXLS        --2
    3	D:\RESEARCH.PPT           --1
    4	C:\DOCUMENTS\STUDY.HWP    --2
    5	C:\DOCUMENTS\TEMP\HOMEWORK\SQL.TXT --4
    6	C:\SHARE\F\TEST\FLOWER.PNG   --4
    7  	E:\STUDY\ORACLE\20231020_01_SCOTT.SQL  --3
------- ----------------------------------------------------------------------
*/

--�� TBL_FILES ���̺��� ��ȸ�Ͽ�
--   ������ ���� ����� ���� �� �ֵ��� �������� �����Ѵ�.
/*
------- ----------------------------------------------------------------------
���Ϲ�ȣ ���ϸ�
------- ----------------------------------------------------------------------
    1	SALES.DOC
    2	PANMAE.XXLS
    3	RESEARCH.PPT
    4	STUDY.HWP
    5	SQL.TXT
    6	FLOWER.PNG
    7  	20231020_01_SCOTT.SQL
------- ----------------------------------------------------------------------
*/
 SUBSTR(ENAME, 1, 2) "COL2"
--��� 1
SELECT FILENO "���Ϲ�ȣ"
    , REVERSE ( SUBSTR (REVERSE (FILENAME),1, INSTR(REVERSE(FILENAME), '\',1,1)-1)) "���ϸ�"
FROM TBL_FILES;

--��� 2
SELECT FILENO "���Ϲ�ȣ"
    , SUBSTR (FILENAME,INSTR(FILENAME, '\', -1,1)+1) "���ϸ�"
FROM TBL_FILES;

--��� 3
SELECT FILENO "���Ϲ�ȣ"
    , SUBSTR (FILENAME,LENGTH(FILENAME)-INSTR(REVERSE(FILENAME), '\',1,1)+2) "���ϸ�"
FROM TBL_FILES;

--��� 4

SELECT FILENO "���Ϲ�ȣ"
    , FILENAME "���ϸ�"
FROM TBL_FILES
WHERE FILENO = 1;

SELECT FILENO "���Ϲ�ȣ"
    , FILENAME "����������ϸ�"
    , SUBSTR(FILENAME, 16, 9) "���ϸ�"
FROM TBL_FILES
WHERE FILENO = 1;
--==> 1	C:\AAA\BBB\CCC\SALES.DOC    	SALES.DOC

SELECT FILENO "���Ϲ�ȣ"
    , FILENAME "����������ϸ�"
    , SUBSTR(FILENAME, 16, 9) "���ϸ�"
FROM TBL_FILES;
/*
1	C:\AAA\BBB\CCC\SALES.DOC	                SALES.DOC
2	C:\AAA\PANMAE.XXLS	                    XLS
3	D:\RESEARCH.PPT	                        (null)
4	C:\DOCUMENTS\STUDY.HWP	                UDY.HWP
5	C:\DOCUMENTS\TEMP\HOMEWORK\SQL.TXT	    MP\HOMEWO
6	C:\SHARE\F\TEST\FLOWER.PNG	            \FLOWER.P
7	E:\STUDY\ORACLE\20231020_01_SCOTT.SQL	\20231020
*/

SELECT FILENO "���Ϲ�ȣ"
    , FILENAME "����������ϸ�"
    , REVERSE(FILENAME) "�Ųٷΰ�����ϸ�"
    , SUBSTR(����ڿ�, ���������ġ(�������س��� ������ 1), ���� '\'�� ���� ��ġ���� -1) "�Ųٷ����ϸ�"
FROM TBL_FILES;

SELECT FILENO "���Ϲ�ȣ"
    , FILENAME "����������ϸ�"
    , REVERSE(FILENAME) "�Ųٷΰ�����ϸ�"
    , SUBSTR(REVERSE(FILENAME), 1, INSTR(REVERSE(FILENAME),'\', 1) -1) "�Ųٷ����ϸ�"
    , REVERSE(SUBSTR(REVERSE(FILENAME), 1, INSTR(REVERSE(FILENAME),'\', 1) -1)) "���ϸ�"
FROM TBL_FILES;
/*
1	COD.SELAS               \CCC\BBB\AAA\:C             --> ���� (\) ������ġ = 10  - 1~9 ����
2	SLXX.EAMNAP             \AAA\:C                     --> ���� (\) ������ġ = 12  - 1~11 ����
3	TPP.HCRAESER            \:D                         --> ���� (\) ������ġ = 13  - 1~12 ����
4	PWH.YDUTS               \STNEMUCOD\:C               --> ���� (\) ������ġ = 10  - 1~9 ����
5	TXT.LQS                 \KROWEMOH\PMET\STNEMUCOD\:C --> ���� (\) ������ġ = 8   - 1~7 ����
6	GNP.REWOLF              \TSET\F\ERAHS\:C            --> ���� (\) ������ġ = 10  - 1~9 ����
7	LQS.TTOCS_10_02013202   \ELCARO\YDUTS\:E            --> ���� (\) ������ġ = 21  - 1~21 ����
*/

/*
1	C:\AAA\BBB\CCC\SALES.DOC	                COD.SELAS\CCC\BBB\AAA\:C	                COD.SELAS	            SALES.DOC
2	C:\AAA\PANMAE.XXLS	                    SLXX.EAMNAP\AAA\:C	                    SLXX.EAMNAP	            PANMAE.XXLS
3	D:\RESEARCH.PPT	                        TPP.HCRAESER\:D	                        TPP.HCRAESER	            RESEARCH.PPT
4	C:\DOCUMENTS\STUDY.HWP	                PWH.YDUTS\STNEMUCOD\:C	                PWH.YDUTS	            STUDY.HWP
5	C:\DOCUMENTS\TEMP\HOMEWORK\SQL.TXT	    TXT.LQS\KROWEMOH\PMET\STNEMUCOD\:C	    TXT.LQS	                SQL.TXT
6	C:\SHARE\F\TEST\FLOWER.PNG	            GNP.REWOLF\TSET\F\ERAHS\:C	            GNP.REWOLF	            FLOWER.PNG
7	E:\STUDY\ORACLE\20231020_01_SCOTT.SQL	LQS.TTOCS_10_02013202\ELCARO\YDUTS\:E	LQS.TTOCS_10_02013202	20231020_01_SCOTT.SQL
*/

--==>
/*
1	SALES.DOC
2	PANMAE.XXLS
3	RESEARCH.PPT
4	STUDY.HWP
5	SQL.TXT
6	FLOWER.PNG
7	20231020_01_SCOTT.SQL
*/

--> PAD �Լ��� ������ �Ǹ� 2��° �Ķ���� ���� ���� ����.
--�� LPAD()
--> Byte �� Ȯ���Ͽ� ����(LEFT)���� ���ڷ� ä��� ����� ���� �Լ�
SELECT 'ORACLE' "COL1"
    , LPAD('ORACLE', 10, '*') "COL2"
FROM DUAL;
--==> ORACLE 	****ORACLE
--> �� 10Byte ������ Ȯ���Ѵ�.                --> �� ��° �Ķ���� ���� ����...
--  �� Ȯ���� ������ 'ORACLE' ���ڿ��� ��´�. --> ù ��° �Ķ���� ���� ����...
--  �� �����ִ� Byte ������ �������� ���� �� ��° �Ķ���� ������ ä���.(�� ��° �Ķ���͸� ���� ������ ä���.)
--  �� �̷��� ������ ���� ������� ��ȯ�Ѵ�.

--�� RPAD()
--> Byte �� Ȯ���Ͽ� ������(RIGHT)���� ���ڷ� ä��� ����� ���� �Լ�
SELECT 'ORACLE' "COL1"
    , RPAD('ORACLE', 10, '*') "COL2"
FROM DUAL;
--==> ORACLE 	ORACLE****
--> �� 10Byte ������ Ȯ���Ѵ�.                --> �� ��° �Ķ���� ���� ����...
--  �� Ȯ���� ������ 'ORACLE' ���ڿ��� ��´�. --> ù ��° �Ķ���� ���� ����...
--  �� �����ִ� Byte ������ ���������� ���� �� ��° �Ķ���� ������ ä���.(�� ��° �Ķ���͸� ���� ������ ä���.)
--  �� �̷��� ������ ���� ������� ��ȯ�Ѵ�.

--�� LTRIM()
SELECT 'ORAORAORAORACLEORACLE' "COL1"             -- ���� ���� ���� ����Ŭ ����Ŭ
    , LTRIM('ORAORAORAORACLEORACLE', 'ORA') "COL2" -- ���ʺ��� �� ��° �Ķ���� ���ȿ� �ִ� �͵��� ����(O ����, R ����, A ����)
    , LTRIM('AAAAAAAAAORACLEORACLE', 'ORA') "COL3"
    , LTRIM('ORAORAoRAORACLEORACLE', 'ORA') "COL4"
    , LTRIM('ORAORA ORAORACLEORACLE', 'ORA') "COL5"
    , LTRIM('                ORACLE', ' ') "COL6" --���� ���� ����
    , LTRIM('                ORACLE') "COL7"      -- ���� ���Ŷ�� �� ��° �Ķ���� ���� ����
FROM DUAL;
/*
ORAORAORAORACLEORACLE
CLEORACLE	
CLEORACLE   
oRAORACLEORACLE  
 ORAORACLEORACLE  
ORACLE	
ORACLE
*/
--> ù ��° �Ķ���� ���� �ش��ϴ� ���ڿ��� �������
--  �������� ���������� �����ϴ� �� ��° �Ķ���� ������ ������ ���ڿ�
--  ���� ���ڰ� ������ ��� �̸� �����ϰ� ���� ������� ��ȯ�Ѵ�.
--  ��, �ϼ������� ó������ �ʴ´�.(�ϳ��� �ϳ��� ������)

SELECT LTRIM('���̽��̱�����̽ű����̱��̱���̱��', '�����') "COL1"
FROM DUAL;
--==> ���̱��

--�� RTRIM()
--> ù ��° �Ķ���� ���� �ش��ϴ� ���ڿ��� �������
--  ���������� ���������� �����ϴ� �� ��° �Ķ���� ������ ������ ���ڿ�
--  ���� ���ڰ� ������ ��� �̸� �����ϰ� ���� ������� ��ȯ�Ѵ�.
--  ��, �ϼ������� ó������ �ʴ´�.(�ϳ��� �ϳ��� ������)

--�� TRANSLATE()
--> 1 : 1 �� �ٲ��ش�.
SELECT TRANSLATE('MY ORACLE SERVER'
                    ,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
                    , 'abcdefghijklmnopqrstuvwxyz') "COL1"
FROM DUAL;
--==> my oracle server

SELECT TRANSLATE('010-9322-9643'
                    , '0123456789'
                    , '�����̻�����ĥ�ȱ�') "COL1"
FROM DUAL;
--==> ���ϰ�-��������-�������

--�� REPLACE()
SELECT REPLACE ('MY ORACLE SERVER ORAHOME', 'ORA', '����') "COL1"
FROM DUAL;
--==> MY ����CLE SERVER ����HOME

---------------------------------------------------------------------------

--�� ROUND() �ݿø��� ó���� �ִ� �Լ�
SELECT 48.678 "COL1"           --> 48.678
    , ROUND(48.678, 2) "COL2"  --> 48.68  -- �Ҽ��� ���� ��°�ڸ����� ǥ�� -> �� ��° �Ķ����
    , ROUND(48.674, 2) "COL3"  --> 48.67
    , ROUND(48.674, 1) "COL4"  --> 48.7
    , ROUND(48.684, 0) "COL5"  --> 49
    , ROUND(48.684) "COL6"     --> 49  -- �� ��° �Ķ���� ���� 0�� ��� ��������
    , ROUND(48.684,-1) "COL7"  --> 50  
    , ROUND(48.684,-2) "COL8"  --> 0
    , ROUND(48.684,-3) "COL9"  --> 0
FROM DUAL;

--�� TRUNC() ������ ó���� �ִ� �Լ�
SELECT 48.678 "COL1"           --> 48.678
    , TRUNC(48.678, 2) "COL2"  --> 48.67   -- �Ҽ��� ���� ��°�ڸ����� ǥ�� -> �� ��° �Ķ����
    , TRUNC(48.674, 2) "COL3"  --> 48.67
    , TRUNC(48.674, 1) "COL4"  --> 48.6
    , TRUNC(48.684, 0) "COL5"  --> 48
    , TRUNC(48.684) "COL6"     --> 48      -- �� ��° �Ķ���� ���� 0�� ��� ��������
    , TRUNC(48.684,-1) "COL7"  --> 40
    , TRUNC(48.684,-2) "COL8"  --> 0
    , TRUNC(48.684,-3) "COL9"  --> 0
FROM DUAL;

--�� MOD() �������� ��ȯ�ϴ� �Լ� -> %(�ڹ�)
SELECT MOD(5,2) "COL1"
FROM DUAL;
--> 5�� 2�� ���� ������ ����� ��ȯ
--==> 1

--�� POWER() ������ ����� ��ȯ�ϴ� �Լ�
SELECT POWER(5,3) "COL1"
FROM DUAL;
--> 5�� 3���� ��������� ��ȯ
--==> 125

--�� SQRT() ��Ʈ ������� ��ȯ�ϴ� �Լ�
SELECT SQRT(2) "COL1"
FROM DUAL;
--> ��Ʈ 2�� ���� ����� ��ȯ
--==> 1.41421356237309504880168872420969807857

--�� LOG() �α� �Լ�
--   (����Ŭ, MSSQL �� ���α�, �ڿ��α� ��� �����Ѵ�.)

-- LN() �ڿ��α�
SELECT LN(95) "COL1"
FROM DUAL;
--==> 4.55387689160054083460978676511404117675

SELECT LOG(10, 100) "COL1"
    , LOG(10,20) "COL2"
FROM DUAL;
--==> 2	1.30102999566398119521373889472449302677

--�� �ﰢ�Լ�
SELECT SIN(1), COS(1), TAN(1)
FROM DUAL;
/*
0.8414709848078965066525023216302989996233
0.5403023058681397174009366074429766037354
1.55740772465490223050697480745836017308
*/
--> ���� ����, �ڽ���, ź��Ʈ ������� ��ȯ�Ѵ�.

--�� �ﰢ�Լ��� ���Լ�(���� : -1 ~ 1)
SELECT ASIN(0.5), ACOS(0.5), ATAN(0.5)
FROM DUAL;
/*
0.52359877559829887307710723054658381405
1.04719755119659774615421446109316762805
0.4636476090008061162142562314612144020295
*/

--�� SIGN() ����, ��ȣ, Ư¡
--> ���� ������� ����̸� 1 ��ȯ, 0�̸� 0 ��ȯ, ������ -1 �� ��ȯ�Ѵ�.
SELECT SIGN(5-2) "COL1"
    , SIGN(5-5) "COL2"
    , SIGN(5-7) "COL3"
FROM DUAL;
--==> 1	0	-1
--> �����̳� ������ �����Ͽ� ���� �� ������ ������ ��Ÿ�� �� ���� ���ȴ�.

--�� ASCII(), CHR() -> ���� ����(����)�ϴ� �Լ�
SELECT ASCII('A') "COL1"
    , CHR(65) "COL2"
FROM DUAL;
--==> 65	A
-- ASCII() : �Ű������� �Ѱܹ��� ������ �ƽ�Ű�ڵ� ���� ��ȯ�Ѵ�.
-- CHR()   : �Ű������� �Ѱܹ��� �ƽ�Ű�ڵ� ������ �ش� ���ڸ� ��ȯ�Ѵ�.

----------------------------------------------------------------------------

--�� ��¥ ���� ���� ���� ����
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS';
--==> Session��(��) ����Ǿ����ϴ�.

--�� ��¥ ������ �⺻ ������ �ϼ�(DAY) �̴�.
SELECT SYSDATE "COL1"      -- 2023-10-20 15:38:42
    , SYSDATE + 1 "COL2"    -- 2023-10-21 15:38:42
    , SYSDATE -2 "COL3"     -- 2023-10-18 15:38:42
    , SYSDATE +30 "COL4"    -- 2023-11-19 15:38:42
FROM DUAL;

--�� �ð� ���� ����
SELECT SYSDATE "COL1"       -- 2023-10-20 15:41:44
    , SYSDATE + 1/24 "COL2" -- 2023-10-20 16:41:44
    , SYSDATE - 2/24 "COL3" -- 2023-10-20 13:41:44
FROM DUAL;

--�� ���� �ð���... ���� �ð� �������� 1�� 2�ð� 3�� 4�� �ĸ� ��ȸ�Ѵ�.
/*
-------------------- ---------------------------
���� �ð�             ���� �� �ð�
-------------------- ---------------------------
2023-10-20 15:41:44  2023-10-21 17:44:48
*/

-- ��� 1
SELECT SYSDATE "���� �ð�"
    , SYSDATE + 1 + (2/24) + (3/24/60) + (4/24/60/60) "���� �� �ð�"
FROM DUAL;
--==> 2023-10-20 15:48:03
--    2023-10-21 17:51:07

-- ��� 2
SELECT SYSDATE "����ð�"
    , SYSDATE + 1 + (2/24) + (3/(24*60)) + (4/(24*60*60)) "���� �� �ð�"
FROM DUAL;
/*
2023-10-20 16:05:19
2023-10-21 18:08:23
*/

-- ��� 3
SELECT SYSDATE "����ð�"
    , SYSDATE + ((1*24*60*60) + (2*60*60) + (3*60) + 4) / (24*60*60) "���� �� �ð�"
FROM DUAL;
/*
2023-10-20 16:07:54
2023-10-21 18:10:58
*/

--�� ��¥ - ��¥ = �ϼ�
SELECT TO_DATE('2024-03-19', 'YYYY-MM-DD') - TO_DATE('2023-08-22', 'YYYY-MM-DD') "COL1"
FROM DUAL;
--==> 210

--�� ������ Ÿ���� ��ȯ
SELECT TO_DATE('2023-10-20', 'YYYY-MM-DD') "COL1"
FROM DUAL;
--==> 2023-10-20 00:00:00

SELECT TO_DATE('2023-10-32', 'YYYY-MM-DD') "COL1"
FROM DUAL;
--==> ���� �߻�
-- ORA-01847: day of month must be between 1 and last day of month

SELECT TO_DATE('2023-02-29', 'YYYY-MM-DD') "COL1"
FROM DUAL;
--==> ���� �߻�
-- ORA-01839: date not valid for month specified

SELECT TO_DATE('2023-13-20', 'YYYY-MM-DD') "COL1"
FROM DUAL;
--==> ���� �߻�
-- ORA-01843: not a valid month

--�� TO_DATE() �Լ��� ���� ���� Ÿ���� ��¥ Ÿ������ ��ȯ�� �����ϴ� ��������
--   ���������� �ش� ��¥�� ���� ��ȿ�� �˻簡 �̷������.
-- (��¥ Ÿ�Կ��� ��ȿ�� ��¥ Ÿ������ �ƴ��� �Ǵ��Ѵ�.)

--�� ADD_MONTHS() ���� ���� ���ϰų� ���ִ� �Լ�
SELECT SYSDATE "COL1"
    , ADD_MONTHS(SYSDATE, 2) "COL2"
    , ADD_MONTHS(SYSDATE, 3) "COL3"
    , ADD_MONTHS(SYSDATE, -2) "COL4"
    , ADD_MONTHS(SYSDATE, -3) "COL5"
FROM DUAL;
/*
2023-10-20 16:18:56	-> ����
2023-12-20 16:18:56	-> 2���� ��
2024-01-20 16:18:56	-> 3���� ��
2023-08-20 16:18:56	-> 2���� ��
2023-07-20 16:18:56 -> 3���� ��
*/

--�� MONTHS_BETWEEN()
--> ù ��° ���ڰ����� �� ��° ���ڰ��� �� ���� ���� ��ȯ�Ѵ�.
SELECT MONTHS_BETWEEN(SYSDATE, TO_DATE('2002-05-31', 'YYYY-MM-DD')) "COL1"
FROM DUAL;
--==> 256.667168832138590203106332138590203106

--> ���� ���� ���̸� ��ȯ�ϴ� �Լ�
--  ������� ��ȣ�� -(����) �� ��ȯ�Ǿ��� ��쿡��
--  ù ��° ���ڰ��� �ش��ϴ� ��¥����
--  �� ��° ���ڰ��� �ش��ϴ� ��¥�� �̷� ��� �ǹ̷� Ȯ���� �� �ִ�.

--�� NEXT_DAY()
SELECT NEXT_DAY(SYSDATE, '��') "COL1"
    , NEXT_DAY(SYSDATE, '��') "COL2"
FROM DUAL;
--2023-10-21 16:25:11
--2023-10-23 16:25:11

-- ���� ������ ���ƿ��� ������ ��¥�� �˷���.

--�� �߰� ���� ���� ����
ALTER SESSION SET NLS_DATE_LANGUAGE = 'ENGLISH';
--==> Session��(��) ����Ǿ����ϴ�.

SELECT NEXT_DAY(SYSDATE, '��') "COL1"
    , NEXT_DAY(SYSDATE, '��') "COL2"
FROM DUAL;
--==> ���� �߻�
-- ORA-01846: not a valid day of the week

SELECT NEXT_DAY(SYSDATE, 'SAT') "COL1"
    , NEXT_DAY(SYSDATE, 'MON') "COL2"
FROM DUAL;
--==> 2023-10-21 16:28:33
--2023-10-23 16:28:33

--�� �߰� ���� ���� ����
ALTER SESSION SET NLS_DATE_LANGUAGE = 'KOREAN';
--==> Session��(��) ����Ǿ����ϴ�.

ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD';
--==> Session��(��) ����Ǿ����ϴ�.

--�� LAST_DAY()
--> �ش� ��¥�� ���ԵǾ� �ִ� �� ���� ������ ���� ��ȯ�Ѵ�.
SELECT SYSDATE "COL1"
    , LAST_DAY(SYSDATE) "COL2"
    , LAST_DAY(TO_DATE('2023-02-12', 'YYYY-MM-DD')) "COL3"
    , LAST_DAY(TO_DATE('2020-02-12', 'YYYY-MM-DD')) "COL4"
FROM DUAL;
--==> 2023-10-20	2023-10-31  2023-02-28	2020-02-29

--�� ���úη�... ��ȯ�̰� ���뿡 �ٽ� ��������....
--   ���� �Ⱓ�� 22������ �Ѵ�.

-- 1. ���� ���ڸ� ���Ѵ�.
-- 2. �Ϸ� ���ڲ��� 3�� �Ļ縦 �ؾ� �Ѵٰ� �����ϸ�...
--    ��ȯ�̰� �� ���� �Ծ�� ���� �����ٱ�...
--��� 1
-- 1. ���� ���ڸ� ���Ѵ�.
SELECT ADD_MONTHS(SYSDATE,22)
FROM DUAL;

-- 2. �Ϸ� ���ڲ��� 3�� �Ļ縦 �ؾ� �Ѵٰ� �����ϸ�...
--    ��ȯ�̰� �� ���� �Ծ�� ���� �����ٱ�...

-- �����Ⱓ * 3
-- --------
-- (�������� - ��������)
-- (�������� - ��������) * 3
SELECT (ADD_MONTHS(SYSDATE, 22) - SYSDATE) * 3
FROM DUAL;

--��� 2
SELECT ADD_MONTHS(SYSDATE, 22) "���� ����"
    , (TO_DATE('2025-08-20', 'YYYY-MM-DD') - TO_DATE('2023-10-20', 'YYYY-MM-DD')) * 3 "��"
FROM DUAL;
--==> 2025-08-20	2010

--��� 3
SELECT ADD_MONTHS(SYSDATE, 22) "���� ����"
    , (ADD_MONTHS(SYSDATE, 22) - SYSDATE)*3 "��"
FROM DUAL;

--�� ��¥ ���� ���� ���� ����
ALTER SESSION SET NLS_DATE_FORMAT= 'YYYY-MM-DD HH24:MI:SS';
--==> Session��(��) ����Ǿ����ϴ�.

--�� ���� ��¥ �� �ð����� ����
--   ������(2024-03-19 18:00:00)����
--   ���� �Ⱓ��...������ ���� ���·� ��ȸ�� �� �ֵ��� �������� �����Ѵ�.
/*
-------------------    -------------------    ---    ----   ---   ---
����ð�               ������                  ��    �ð�    ��    ��
-------------------    -------------------    ---    ----   ---   ---
2023-10-20 17:09:10    2024-03-19 18:00:00    140       0    49    50
-------------------    -------------------    ---    ----   ---   ---
*/

SELECT SYSDATE "���� �ð�"
    , TO_DATE('2024-03-19 18:00:00', 'YYYY-MM-DD HH24:MI:SS') "������"
    , TRUNC(TO_DATE('2024-03-19 18:00:00', 'YYYY-MM-DD HH24:MI:SS') - SYSDATE) "��"
    , MOD(TRUNC((TO_DATE('2024-03-19 18:00:00', 'YYYY-MM-DD HH24:MI:SS') - SYSDATE) * 24*60*60/60/60),24) "�ð�"
    , TRUNC(MOD((TO_DATE('2024-03-19 18:00:00', 'YYYY-MM-DD HH24:MI:SS') - SYSDATE) *24*60*60/60 ,60)) "��"
    , TRUNC(MOD((TO_DATE('2024-03-19 18:00:00', 'YYYY-MM-DD HH24:MI:SS') - SYSDATE) *24*60*60 ,60)) "��"
FROM DUAL;






























