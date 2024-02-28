SELECT USER
FROM DUAL;
--==> SCOTT

--�� EMP ���̺�� DEPT ���̺��� �������
--   ������ MANAGER �� CLERK �� ����鸸
--   �μ���ȣ, �μ���, �����, ������, �޿� �׸��� ��ȸ�Ѵ�.

SELECT *
FROM EMP;

SELECT *
FROM DEPT;

-- �μ���ȣ, �μ���, �����, ������, �޿�
--  DEPTNO   DNAME   ENAME   JOB    SAL
--   E,D       D       E       E      E

SELECT �μ���ȣ, �μ���, �����, ������, �޿�
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO;

SELECT DEPTNO, DNAME, ENAME, JOB, SAL
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO;
--==> �����߻�
-- ORA-00918: column ambiguously defined
-- �� ���̺� �� �ߺ��Ǵ� �÷��� ����
-- �Ҽ� ���̺��� �������(��������) �Ѵ�.

SELECT E.DEPTNO, DNAME, ENAME, JOB, SAL
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO;

SELECT D.DEPTNO, DNAME, ENAME, JOB, SAL
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO;
--==> 2���� ���̺��� �� �� �θ� ���̺��� ��ߵ�
-- DEPT���̺��� �θ� -> �� �θ��� ���� �ڽ� ��, EMP ���̺��� 10, 20, 30�� ����
-- 2���� ���� �ȿ��� DEPT �ȿ����� DEPTNO�� 1�� �ε� EMP���̺��� DEPTNO�� ��������.

SELECT E.DEPTNO, DNAME, ENAME, JOB, SAL
FROM EMP E, DEPT D
WHERE E.DEPTNO(+) = D.DEPTNO;
/*
10	ACCOUNTING	CLARK	MANAGER	2450
10	ACCOUNTING	KING	PRESIDENT	5000
10	ACCOUNTING	MILLER	CLERK	1300
20	RESEARCH	JONES	MANAGER	2975
20	RESEARCH	FORD	ANALYST	3000
20	RESEARCH	ADAMS	CLERK	1100
20	RESEARCH	SMITH	CLERK	800
20	RESEARCH	SCOTT	ANALYST	3000
30	SALES	WARD	SALESMAN	1250
30	SALES	TURNER	SALESMAN	1500
30	SALES	ALLEN	SALESMAN	1600
30	SALES	JAMES	CLERK	950
30	SALES	BLAKE	MANAGER	2850
30	SALES	MARTIN	SALESMAN	1250
(null)	OPERATIONS			            <--DEPTNO�� NULL
*/

SELECT D.DEPTNO, DNAME, ENAME, JOB, SAL
FROM EMP E, DEPT D
WHERE E.DEPTNO(+) = D.DEPTNO;
/*
10	ACCOUNTING	CLARK	MANAGER	2450
10	ACCOUNTING	KING	PRESIDENT	5000
10	ACCOUNTING	MILLER	CLERK	1300
20	RESEARCH	JONES	MANAGER	2975
20	RESEARCH	FORD	ANALYST	3000
20	RESEARCH	ADAMS	CLERK	1100
20	RESEARCH	SMITH	CLERK	800
20	RESEARCH	SCOTT	ANALYST	3000
30	SALES	WARD	SALESMAN	1250
30	SALES	TURNER	SALESMAN	1500
30	SALES	ALLEN	SALESMAN	1600
30	SALES	JAMES	CLERK	950
30	SALES	BLAKE	MANAGER	2850
30	SALES	MARTIN	SALESMAN	1250
40	OPERATIONS			                <-- DEPTNO�� 40
*/
--==> �̷���, �ڽ����̺��� �� ��� �θ����̺��� �����͸� �������´�.
--�� �� ���̺� �� �ߺ��Ǵ� �÷��� ���� �Ҽ� ���̺��� ����ϴ� ���
--   �θ� ���̺��� �÷��� ������ �� �ֵ��� ó���ؾ� �Ѵ�.

SELECT *
FROM EMP;  --> �ڽ� ���̺�

SELECT *
FROM DEPT;  --> �θ� ���̺�

SELECT D.DEPTNO, DNAME, ENAME, JOB, SAL
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO;

-- �� ���̺� ��� ���ԵǾ� �ִ� �ߺ��� �÷��� �ƴϴ���
-- �÷��� �Ҽ� ���̺��� ����� �� �� �ֱ⸦ �����Ѵ�.
-- (����Ŭ�� ���������� EMP���̺�� DEPT���̺� �����µ� ��������� ������
--  EMP���̺� ������ DEPT���̺� ���� -> EMP���̺��� DEPTNO�� ������ EMP���̺���
--  ������ �� ����)
SELECT D.DEPTNO, D.DNAME, E.ENAME, E.JOB, E.SAL
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO;

--�� SELF JOIN(�ڱ� ����)

-- EMP ���̺��� �����͸� ������ ���� ��ȸ�� �� �ֵ��� �������� �����Ѵ�.
/*
-------------------------------------------------------------------------------
 �����ȣ   �����     ������     �����ڹ�ȣ       �����ڸ�        ������������ 
-------------------------------------------------------------------------------
   7369     SMITH      CLERK         7902            FORD             ANALYST
                                    :
-------------------------------------------------------------------------------
*/
SELECT *
FROM EMP;

--���1
SELECT T.EMPNO "�����ȣ", T.ENAME "�����", T.JOB "������", T.MGR "�����ڹ�ȣ", P.ENAME "�����ڸ�", P.JOB "������������"
FROM EMP T, EMP P
WHERE T.MGR = P.EMPNO(+)
ORDER BY 1;
/*
7369	SMITH	CLERK	    7902	FORD	ANALYST
7499	ALLEN	SALESMAN	7698	BLAKE	MANAGER
7521	WARD	SALESMAN	7698	BLAKE	MANAGER
7566	JONES	MANAGER	    7839	KING	PRESIDENT
7654	MARTIN	SALESMAN	7698	BLAKE	MANAGER
7698	BLAKE	MANAGER	    7839	KING	PRESIDENT
7782	CLARK	MANAGER 	7839	KING	PRESIDENT
7788	SCOTT	ANALYST	    7566	JONES	MANAGER
7839	KING	PRESIDENT			
7844	TURNER	SALESMAN	7698	BLAKE	MANAGER
7876	ADAMS	CLERK	    7788	SCOTT	ANALYST
7900	JAMES	CLERK	    7698	BLAKE	MANAGER
7902	FORD	ANALYST	    7566	JONES	MANAGER
7934	MILLER	CLERK	    7782	CLARK	MANAGER
*/

-- ���2
SELECT T.EMPNO "�����ȣ", T.ENAME "�����", T.JOB "������", T.MGR "�����ڹ�ȣ"
    , (SELECT ENAME
        FROM EMP
        WHERE EMPNO = T.MGR) "�����ڸ�"
    , (SELECT JOB
        FROM EMP
        WHERE EMPNO = T.MGR) "������������"
FROM EMP T JOIN EMP P 
ON T.EMPNO = P.EMPNO;

-- ����� ��� 3
SELECT  EMPNO "�����ȣ", ENAME "�����", JOB "������", MGR "�����ڹ�ȣ", ENAME "�����ڸ�", JOB "������������"
FROM EMP;
/*
-------------------------------------------------------------------------------
 �����ȣ   �����     ������     �����ڹ�ȣ       �����ڸ�        ������������ 
  EMPNO      ENAME     JOB           MGR            
 ------------------------------------------- E1    
                                    EMPNO            ENAME             JOB
                                  -------------------------------------------- E2
-------------------------------------------------------------------------------
*/
/*
SELECT  E1.EMPNO "�����ȣ", E1.ENAME "�����", E1.JOB "������", E1.MGR "�����ڹ�ȣ", E2.ENAME "�����ڸ�", E2.JOB "������������"
FROM EMP E1 LEFT JOIN EMP E2
ON E1.MGR = E2.EMPNO;
*/
--���� ����
SELECT  E1.EMPNO "�����ȣ", E1.ENAME "�����", E1.JOB "������", E2.EMPNO "�����ڹ�ȣ", E2.ENAME "�����ڸ�", E2.JOB "������������"
FROM EMP E1 LEFT JOIN EMP E2
ON E1.MGR = E2.EMPNO;

--��� 4
SELECT  E1.EMPNO "�����ȣ", E1.ENAME "�����", E1.JOB "������", E2.EMPNO "�����ڹ�ȣ", E2.ENAME "�����ڸ�", E2.JOB "������������"
FROM EMP E1, EMP E2
WHERE E1.MGR = E2.EMPNO(+);





















































































































