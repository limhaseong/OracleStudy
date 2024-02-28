SELECT USER
FROM DUAL;
--==> SCOTT

--○ EMP 테이블과 DEPT 테이블을 대상으로
--   직종이 MANAGER 와 CLERK 인 사원들만
--   부서번호, 부서명, 사원명, 직종명, 급여 항목을 조회한다.

SELECT *
FROM EMP;

SELECT *
FROM DEPT;

-- 부서번호, 부서명, 사원명, 직종명, 급여
--  DEPTNO   DNAME   ENAME   JOB    SAL
--   E,D       D       E       E      E

SELECT 부서번호, 부서명, 사원명, 직종명, 급여
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO;

SELECT DEPTNO, DNAME, ENAME, JOB, SAL
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO;
--==> 에러발생
-- ORA-00918: column ambiguously defined
-- 두 테이블 간 중복되는 컬럼에 대한
-- 소속 테이블을 정해줘야(명시해줘야) 한다.

SELECT E.DEPTNO, DNAME, ENAME, JOB, SAL
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO;

SELECT D.DEPTNO, DNAME, ENAME, JOB, SAL
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO;
--==> 2개의 테이블을 쓸 땐 부모 테이블을 써야됨
-- DEPT테이블이 부모 -> 한 부모의 여러 자식 즉, EMP 테이블에는 10, 20, 30이 많음
-- 2개의 관계 안에서 DEPT 안에서는 DEPTNO가 1개 인데 EMP테이블에는 DEPTNO가 여러개임.

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
(null)	OPERATIONS			            <--DEPTNO가 NULL
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
40	OPERATIONS			                <-- DEPTNO가 40
*/
--==> 이렇듯, 자식테이블을 쓸 경우 부모테이블의 데이터를 못가져온다.
--※ 두 테이블 간 중복되는 컬럼에 대해 소속 테이블을 명시하는 경우
--   부모 테이블의 컬럼을 참조할 수 있도록 처리해야 한다.

SELECT *
FROM EMP;  --> 자식 테이블

SELECT *
FROM DEPT;  --> 부모 테이블

SELECT D.DEPTNO, DNAME, ENAME, JOB, SAL
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO;

-- 두 테이블에 모두 포함되어 있는 중복된 컬럼이 아니더라도
-- 컬럼의 소속 테이블을 명시해 줄 수 있기를 권장한다.
-- (오라클은 내부적으로 EMP테이블과 DEPT테이블도 가보는데 명시해주지 않으면
--  EMP테이블도 가보고 DEPT테이블도 가봄 -> EMP테이블에서 DEPTNO가 있으면 EMP테이블꺼를
--  가져올 수 있음)
SELECT D.DEPTNO, D.DNAME, E.ENAME, E.JOB, E.SAL
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO;

--○ SELF JOIN(자기 조인)

-- EMP 테이블의 데이터를 다음과 같이 조회할 수 있도록 쿼리문을 구성한다.
/*
-------------------------------------------------------------------------------
 사원번호   사원명     직종명     관리자번호       관리자명        관리자직종명 
-------------------------------------------------------------------------------
   7369     SMITH      CLERK         7902            FORD             ANALYST
                                    :
-------------------------------------------------------------------------------
*/
SELECT *
FROM EMP;

--방법1
SELECT T.EMPNO "사원번호", T.ENAME "사원명", T.JOB "직종명", T.MGR "관리자번호", P.ENAME "관리자명", P.JOB "관리자직종명"
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

-- 방법2
SELECT T.EMPNO "사원번호", T.ENAME "사원명", T.JOB "직종명", T.MGR "관리자번호"
    , (SELECT ENAME
        FROM EMP
        WHERE EMPNO = T.MGR) "관리자명"
    , (SELECT JOB
        FROM EMP
        WHERE EMPNO = T.MGR) "관리자직종명"
FROM EMP T JOIN EMP P 
ON T.EMPNO = P.EMPNO;

-- 강사님 방법 3
SELECT  EMPNO "사원번호", ENAME "사원명", JOB "직종명", MGR "관리자번호", ENAME "관리자명", JOB "관리자직종명"
FROM EMP;
/*
-------------------------------------------------------------------------------
 사원번호   사원명     직종명     관리자번호       관리자명        관리자직종명 
  EMPNO      ENAME     JOB           MGR            
 ------------------------------------------- E1    
                                    EMPNO            ENAME             JOB
                                  -------------------------------------------- E2
-------------------------------------------------------------------------------
*/
/*
SELECT  E1.EMPNO "사원번호", E1.ENAME "사원명", E1.JOB "직종명", E1.MGR "관리자번호", E2.ENAME "관리자명", E2.JOB "관리자직종명"
FROM EMP E1 LEFT JOIN EMP E2
ON E1.MGR = E2.EMPNO;
*/
--위와 같음
SELECT  E1.EMPNO "사원번호", E1.ENAME "사원명", E1.JOB "직종명", E2.EMPNO "관리자번호", E2.ENAME "관리자명", E2.JOB "관리자직종명"
FROM EMP E1 LEFT JOIN EMP E2
ON E1.MGR = E2.EMPNO;

--방법 4
SELECT  E1.EMPNO "사원번호", E1.ENAME "사원명", E1.JOB "직종명", E2.EMPNO "관리자번호", E2.ENAME "관리자명", E2.JOB "관리자직종명"
FROM EMP E1, EMP E2
WHERE E1.MGR = E2.EMPNO(+);





















































































































