SELECT USER
FROM DUAL;
--==> SCOTT

--○ TBL_EMP 테이블에서 수당(커미션, COMM)이 가장 많은 사원의
--   사원번호, 사원명, 부서번호, 직종명, 커미션 항목을 조회한다.
-- 방법 1
SELECT EMPNO "사원번호", ENAME "사원명", DEPTNO "부서번호", JOB "직종명", COMM "수당"
FROM TBL_EMP
WHERE COMM = (SELECT MAX(COMM)
                FROM TBL_EMP);

-- 방법 2
SELECT EMPNO "사원번호", ENAME "사원명", DEPTNO "부서번호", JOB "직종명", COMM "수당"
FROM TBL_EMP
WHERE COMM >=ALL (SELECT MAX(COMM)
                FROM TBL_EMP);
                
-- 강사님 방법
SELECT EMPNO "사원번호", ENAME "사원명", DEPTNO "부서번호", JOB "직종명", COMM "수당"
FROM TBL_EMP
WHERE COMM이 가장 많은 사원;

SELECT EMPNO "사원번호", ENAME "사원명", DEPTNO "부서번호", JOB "직종명", COMM "수당"
FROM TBL_EMP
WHERE COMM = 모든 직원들 중 최고 커미션;

-- 모든 직원들 중 최고 커미션
SELECT MAX(COMM)
FROM TBL_EMP;

SELECT EMPNO "사원번호", ENAME "사원명", DEPTNO "부서번호", JOB "직종명", COMM "수당"
FROM TBL_EMP
WHERE COMM = (SELECT MAX(COMM)
                FROM TBL_EMP);

-- 강사님 방법 2
SELECT EMPNO "사원번호", ENAME "사원명", DEPTNO "부서번호", JOB "직종명", COMM "수당"
FROM TBL_EMP
WHERE COMM >=ALL (SELECT COMM
                FROM TBL_EMP);
--==> 조회 결과 없음(구문이 이상한 거 아님)
-- NULL들이 포함되어 있음 -> MAX함수는 자동적으로 NULL을 처리함

SELECT EMPNO "사원번호", ENAME "사원명", DEPTNO "부서번호", JOB "직종명", COMM "수당"
FROM TBL_EMP
WHERE COMM >=ALL (NULL, 300, 500, NULL, 1400, NULL, NULL, NULL, NULL, 0);
--> 조회 결과 없음 - NULL처리를 못함

SELECT EMPNO "사원번호", ENAME "사원명", DEPTNO "부서번호", JOB "직종명", COMM "수당"
FROM TBL_EMP
WHERE COMM >=ALL (SELECT NVL(COMM,0)
                FROM TBL_EMP);

-- 강사님 방법 3
SELECT EMPNO "사원번호", ENAME "사원명", DEPTNO "부서번호", JOB "직종명", COMM "수당"
FROM TBL_EMP
WHERE COMM >=ALL (SELECT COMM
                FROM TBL_EMP
                WHERE COMM IS NOT NULL);
--==> 7654	MARTIN	30	SALESMAN	1400

-- 강사님 방법4
SELECT EMPNO "사원번호", ENAME "사원명", DEPTNO "부서번호", JOB "직종명", COMM "수당"
FROM TBL_EMP
WHERE COMM >=ALL (300,500,1400,0,10,10);


--○ DISTINCT() 중복 행(레코드)을 제거하는 함수

-- TBL_EMP 테이블에서 관리자로 등록된 사원의
-- 사원번호, 사원명, 직종명을 조회한다.
SELECT *
FROM TBL_EMP;

--강사님 방법 1
SELECT EMPNO, ENAME, JOB
FROM TBL_EMP
WHERE 사원번호 = MGR로 등록된 사원;

SELECT EMPNO, ENAME, JOB
FROM TBL_EMP
WHERE EMPNO IN (7902, 7698, 7698, 7839, 7698, 7839, 7566, NULL, 7698, 7788, 7698, 7566, 7782,7566, 7698);
/*
7566	JONES	MANAGER
7698	BLAKE	MANAGER
7782	CLARK	MANAGER
7788	SCOTT	ANALYST
7839	KING	PRESIDENT
7902	FORD	ANALYST
*/
-- 강사님 방법 2
SELECT EMPNO, ENAME, JOB
FROM TBL_EMP
WHERE EMPNO IN (SELECT MGR
                FROM TBL_EMP);
/*
7902	FORD	ANALYST
7698	BLAKE	MANAGER
7839	KING	PRESIDENT
7566	JONES	MANAGER
7788	SCOTT	ANALYST
7782	CLARK	MANAGER
*/

-- 강사님 방법 3
SELECT EMPNO, ENAME, JOB
FROM TBL_EMP
WHERE EMPNO IN (7902, 7698, 7839, 7566, NULL, 7788, 7782);

SELECT DISTINCT(MGR)
FROM TBL_EMP;
/*
7839

7782
7698
7902
7566
7788
*/

SELECT EMPNO, ENAME, JOB
FROM TBL_EMP
WHERE EMPNO IN (SELECT DISTINCT(MGR)
                FROM TBL_EMP);
/*
7902	FORD	ANALYST
7698	BLAKE	MANAGER
7839	KING	PRESIDENT
7566	JONES	MANAGER
7788	SCOTT	ANALYST
7782	CLARK	MANAGER
*/

SELECT DISTINCT(JOB)
FROM TBL_EMP;
/*
CLERK
SALESMAN
PRESIDENT
MANAGER
ANALYST
*/

SELECT DISTINCT(DEPTNO)
FROM TBL_EMP;
/*
30

20
10
*/

------------------------------------------------------------------------

SELECT *
FROM TBL_SAWON;
/*
1001	강혜성	9710171234567	2005-01-03	3000
1002	박가영	9511182234567	1999-11-23	4000
1003	박나영	9902082234567	2006-08-10	4000
1004	최혜인	9708112234567	2010-05-06	5000
1005	아이유	0502034234567	2015-10-19	1000
1006	이하이	0609304234567	2012-06-17	1000
1007	인순이	6510102234567	1999-08-22	2000
1008	선동열	6909101234567	1998-01-10	2000
1009	이이경	0505053234567	2011-05-06	1500
1010	선우용녀	6611112234567	2000-01-16	1300
1011	이윤수	9501061234567	2009-09-19	4000
1012	선우선	0606064234567	2011-11-11	2000
1013	남진	6511111234567	1999-11-11	2000
1014	이주형	9904171234567	2009-11-11	2000
1015	남궁민	0202023234567	2010-10-10	2300
*/

--○ TBL_SAWON 테이블 백업(데이터 위주) -> 각 테이블 간의 관계나 제약조건 등은 제외한 상태
CREATE TABLE TBL_SAWONBACKUP
AS
SELECT *
FROM TBL_SAWON;
--==> Table TBL_SAWONBACKUP이(가) 생성되었습니다.
-- TBL_SAWON 테이블의 데이터들만 백업을 수행
-- 즉, 다른 이름의 테이블로 저장해 둔 상황

--○ 데이터 수정
UPDATE TBL_SAWON
SET SANAME='똘똘이';
COMMIT;
--==> 15개 행 이(가) 업데이트되었습니다.
--==> 커밋 완료.

-- UPDATE 다음 SET 사용 금지(UPDATE와 SET 만 있어도 데이터 수정 가능)

SELECT *
FROM TBL_SAWON;
/*
1001	똘똘이	9710171234567	2005-01-03	3000
1002	똘똘이	9511182234567	1999-11-23	4000
1003	똘똘이	9902082234567	2006-08-10	4000
1004	똘똘이	9708112234567	2010-05-06	5000
1005	똘똘이	0502034234567	2015-10-19	1000
1006	똘똘이	0609304234567	2012-06-17	1000
1007	똘똘이	6510102234567	1999-08-22	2000
1008	똘똘이	6909101234567	1998-01-10	2000
1009	똘똘이	0505053234567	2011-05-06	1500
1010	똘똘이	6611112234567	2000-01-16	1300
1011	똘똘이	9501061234567	2009-09-19	4000
1012	똘똘이	0606064234567	2011-11-11	2000
1013	똘똘이	6511111234567	1999-11-11	2000
1014	똘똘이	9904171234567	2009-11-11	2000
1015	똘똘이	0202023234567	2010-10-10	2300
*/

ROLLBACK;
--> 롤백 완료-> 안됨.

-- 방법 1
SELECT *
FROM TBL_SAWONBACKUP;

SELECT *
FROM TBL_SAWON;

UPDATE TBL_SAWON
SET SANAME=(SELECT SANAME
            FROM TBL_SAWONBACKUP
            WHERE TBL_SAWON.SANO = TBL_SAWONBACKUP.SANO);

--강사님 방법 2
UPDATE TBL_SAWON
SET SANAME = (SAWONBACKUP 테이블 각각의 SANAME)
WHERE SANAME = '똘똘이';

UPDATE TBL_SAWON
SET SANAME = (SELECT SANAME
                FROM TBL_SAWONBACKUP
                WHERE SANO = TBL_SAWON.SANO)
WHERE SANAME = '똘똘이';

--○ 커밋
COMMIT;
--==> 커밋 완료. 



































































































































































































































































