--○ 접속된 사용자 계정 조회
SELECT USER
FROM DUAL;
--==> SCOTT

--○ 테이블 생성(DEPT)
CREATE TABLE DEPT
( DEPTNO NUMBER(2) CONSTRAINT PK_DEPT PRIMARY KEY
, DNAME VARCHAR2(14)
, LOC VARCHAR2(13) 
);
--==> Table DEPT이(가) 생성되었습니다.

--○ 테이블 생성(EMP)
CREATE TABLE EMP
( EMPNO NUMBER(4) CONSTRAINT PK_EMP PRIMARY KEY
, ENAME VARCHAR2(10)
, JOB VARCHAR2(9)
, MGR NUMBER(4)
, HIREDATE DATE
, SAL NUMBER(7,2)
, COMM NUMBER(7,2)
, DEPTNO NUMBER(2) CONSTRAINT FK_DEPTNO REFERENCES DEPT
);
--==> Table EMP이(가) 생성되었습니다.


INSERT INTO DEPT VALUES	(10,'ACCOUNTING','NEW YORK');
INSERT INTO DEPT VALUES (20,'RESEARCH','DALLAS');
INSERT INTO DEPT VALUES	(30,'SALES','CHICAGO');
INSERT INTO DEPT VALUES	(40,'OPERATIONS','BOSTON');

INSERT INTO EMP VALUES
(7369,'SMITH','CLERK',7902,to_date('17-12-1980','dd-mm-yyyy'),800,NULL,20);
INSERT INTO EMP VALUES
(7499,'ALLEN','SALESMAN',7698,to_date('20-2-1981','dd-mm-yyyy'),1600,300,30);
INSERT INTO EMP VALUES
(7521,'WARD','SALESMAN',7698,to_date('22-2-1981','dd-mm-yyyy'),1250,500,30);
INSERT INTO EMP VALUES
(7566,'JONES','MANAGER',7839,to_date('2-4-1981','dd-mm-yyyy'),2975,NULL,20);
INSERT INTO EMP VALUES
(7654,'MARTIN','SALESMAN',7698,to_date('28-9-1981','dd-mm-yyyy'),1250,1400,30);
INSERT INTO EMP VALUES
(7698,'BLAKE','MANAGER',7839,to_date('1-5-1981','dd-mm-yyyy'),2850,NULL,30);
INSERT INTO EMP VALUES
(7782,'CLARK','MANAGER',7839,to_date('9-6-1981','dd-mm-yyyy'),2450,NULL,10);
INSERT INTO EMP VALUES
(7788,'SCOTT','ANALYST',7566,to_date('13-7-1987','dd-mm-yyyy'),3000,NULL,20);
INSERT INTO EMP VALUES
(7839,'KING','PRESIDENT',NULL,to_date('17-11-1981','dd-mm-yyyy'),5000,NULL,10);
INSERT INTO EMP VALUES
(7844,'TURNER','SALESMAN',7698,to_date('8-9-1981','dd-mm-yyyy'),1500,0,30);
INSERT INTO EMP VALUES
(7876,'ADAMS','CLERK',7788,to_date('13-7-1987','dd-mm-yyyy'),1100,NULL,20);
INSERT INTO EMP VALUES
(7900,'JAMES','CLERK',7698,to_date('3-12-1981','dd-mm-yyyy'),950,NULL,30);
INSERT INTO EMP VALUES
(7902,'FORD','ANALYST',7566,to_date('3-12-1981','dd-mm-yyyy'),3000,NULL,20);
INSERT INTO EMP VALUES
(7934,'MILLER','CLERK',7782,to_date('23-1-1982','dd-mm-yyyy'),1300,NULL,10);
--==> 1 행 이(가) 삽입되었습니다. * 14

--○ 테이블 생성(BONUS)
CREATE TABLE BONUS
( ENAME VARCHAR2(10)
, JOB VARCHAR2(9)
, SAL NUMBER
, COMM NUMBER
);
--==> Table BONUS이(가) 생성되었습니다.

--○ 테이블 생성(SALGRADE)
CREATE TABLE SALGRADE
( GRADE NUMBER
, LOSAL NUMBER
, HISAL NUMBER 
);
--==> Table SALGRADE이(가) 생성되었습니다.


INSERT INTO SALGRADE VALUES (1,700,1200);
INSERT INTO SALGRADE VALUES (2,1201,1400);
INSERT INTO SALGRADE VALUES (3,1401,2000);
INSERT INTO SALGRADE VALUES (4,2001,3000);
INSERT INTO SALGRADE VALUES (5,3001,9999);
--==> 1 행 이(가) 삽입되었습니다. * 5

--○ 커밋
COMMIT;
--==> 커밋 완료.

--○ SCOTT 계정이 갖고있는(소유하고 있는) 테이블 조회
SELECT *
FROM TAB;
/*
BONUS	TABLE
DEPT	TABLE
EMP	TABLE
SALGRADE	TABLE
*/

SELECT *
FROM USER_TABLES;
/*
DEPT	USERS			VALID	10		1	255	65536	1048576	1	2147483645
EMP	    USERS			VALID	10		1	255	65536	1048576	1	2147483645
BONUS	USERS			VALID	10		1	255	65536	1048576	1	2147483645
SALGRADE	USERS			VALID	10		1	255	65536	1048576	1	2147483645
*/

--○ 위에서 조회한 각각의 테이블들이
--   어떤 테이블스페이스에 저장되어 있는지 조회
SELECT TABLE_NAME, TABLESPACE_NAME
FROM USER_TABLES;
/*
DEPT	USERS
EMP	    USERS
BONUS	USERS
SALGRADE	USERS
*/

--○ 테이블 생성(TBL_EXAMPLE1)
CREATE TABLE TBL_EXAMPLE1
( NO   NUMBER(4)
, NAME VARCHAR2(20)
, ADDR VARCHAR2(20)
);
--==> Table TBL_EXAMPLE1이(가) 생성되었습니다.

--○ 테이블 생성(TBL_EXAMPLE2)
CREATE TABLE TBL_EXAMPLE2
( NO   NUMBER(4)
, NAME VARCHAR2(20)
, ADDR VARCHAR2(20)
) TABLESPACE TBS_EDUA;
--==> Table TBL_EXAMPLE2이(가) 생성되었습니다.

--○ TBL_EXAMPLE1 과 TBL_EXAMPLE2 테이블이
--   각각 어떤 테이블스페이스에 저장되어 있는지 조회
SELECT TABLE_NAME, TABLESPACE_NAME
FROM USER_TABLES;
/*
DEPT	        USERS
EMP	            USERS
BONUS	        USERS
SALGRADE	        USERS
TBL_EXAMPLE1	    USERS    --> TABLESPACE를 지정하지 않아 기본으로 지정한 USERS에 저장
TBL_EXAMPLE2	    TBS_EDUA
*/


------------------------------------------------------------------------------

--■■■ 관계형 데이터베이스(RDBMS) ■■■--

-- 각각의 데이터를 테이블의 형태로 연결시켜 저장해놓은 구조
-- 그리고 이들 각각의 테이블들 간의 관계를 설정하여 연결시켜 놓은 구조

/*=================================
  ※ SELECT 문의 처리(PARSING) 순서(무조건 외우기)
     
    SELECT 컬럼명  -- ⑤ ┐
    FROM 테이블명  -- ① ┘
    WHERE 조건절   -- ② +          --> + 있을 수도 없을 수도 있는 옵션명
    GROUP BY 절    -- ③ +
    HAVING 조건절  -- ④ +
    ORDER BY 절    -- ⑥ +
    
=================================*/

--○ SCOTT 소유의 테이블 조회
SELECT *
FROM TAB;
/*
BONUS	        TABLE  -> 보너스(BONUS) 데이터 테이블
DEPT	        TABLE  -> 부서(DEPARTMENTS) 데이터 테이블
EMP	            TABLE  -> 사원(EMPLOYEES) 데이터 테이블
SALGRADE	        TABLE  -> 급여(SAL) 데이터 테이블

TBL_EXAMPLE1    	TABLE
TBL_EXAMPLE2	    TABLE
*/

--○ 각 테이블의 데이터 조회
SELECT *
FROM BONUS;
--==> 조회결과 없음(조회된 데이터가 존재하지 않음-> 테이블이 없다는 것은 아님)

SELECT *
FROM DEPT;
/*
10	ACCOUNTING	NEW YORK
20	RESEARCH	    DALLAS
30	SALES	    CHICAGO
40	OPERATIONS	BOSTON
*/

SELECT *
FROM EMP;
/*
7369	SMITH	    CLERK	    7902    	80/12/17    	800		        20
7499	ALLEN	    SALESMAN    	7698	81/02/20	    1600	300	    30
7521    	WARD	        SALESMAN    	7698	81/02/22	    1250    	500	    30
7566	JONES	    MANAGER	    7839	81/04/02    	2975		        20
7654	MARTIN	    SALESMAN	    7698	81/09/28    	1250	    1400	30
7698	BLAKE	    MANAGER	    7839	81/05/01	2850		        30
7782    	CLARK	    MANAGER	    7839	81/06/09	2450		        10
7788	SCOTT	    ANALYST	    7566	87/07/13	3000		    20
7839	KING    	    PRESIDENT		    81/11/17	5000		    10
7844	TURNER	    SALESMAN	    7698	81/09/08	1500	0	    30
7876	ADAMS	    CLERK	    7788	87/07/13	1100		    20
7900	JAMES	    CLERK	    7698	81/12/03    	950		        30
7902    	FORD        	ANALYST	    7566	81/12/03	    3000		    20
7934	MILLER	    CLERK	    7782    	82/01/23	    1300		    10
*/

SELECT *
FROM EMP;
/*
7369	SMITH	    CLERK	    7902    1980-12-17    	800		        20
7499	ALLEN	    SALESMAN    	7698	1981-02-20	    1600	300	    30
7521    	WARD	        SALESMAN    	7698	1981-02-22	    1250    	500	    30
7566	JONES	    MANAGER	    7839	1981-04-02    	2975		        20
7654	MARTIN	    SALESMAN	    7698	1981-09-28    	1250	    1400	30
7698	BLAKE	    MANAGER	    7839	1981-05-01	    2850		        30
7782    	CLARK	    MANAGER	    7839	1981-06-09	    2450		        10
7788	SCOTT	    ANALYST	    7566	1987-07-13  	3000		    20
7839	KING    	    PRESIDENT		    1981-11-17  	5000		    10
7844	TURNER	    SALESMAN	    7698	1981-09-08  	1500	0	    30
7876	ADAMS	    CLERK	    7788	1987-07-13  	1100		    20
7900	JAMES	    CLERK	    7698	1981-12-03      	950		        30
7902    	FORD        	ANALYST	    7566	1981-12-03	    3000		    20
7934	MILLER	    CLERK	    7782    	1982-01-23      1300		        10
*/

SELECT *
FROM SALGRADE;
/*
1	700	    1200
2	1201    	1400
3	1401	2000
4	2001	    3000
5	3001	9999
*/

--○ DEPT 테이블에 존재하는 컬럼의 구조 확인
DESCRIBE DEPT;
/*
이름     널?       유형        널? -> 널인 상태를 수용할 수 있니?      
------ -------- ------------ 
DEPTNO NOT NULL NUMBER(2)      NOT NULL -> 비우면 안된다.
DNAME           VARCHAR2(14) 
LOC             VARCHAR2(13) 
*/

-- DEPTNO    DNAME    LOC
-- 부서번호  부서명   부서위치
-------------------------------
-- 10        인사부   서울      -> 데이터 입력 가능
-- 20                 대전      -> 데이터 입력 가능
--           개발부   경기      -> 데이터 입력 불가

--■■■ 오라클의 주요 자료형(DATA TYPE) ■■■--
/*
cf) MSSQL 서버의 정수 표현 타입
    tinyint       0 ~ 255            1Byte
    smallint      -32,768 ~ 32,767   2Byte
    int           -21억 ~ 21억       4Byte
    bigint        엄청 큼            8Byte

    MSSQL 서버의 실수 표현 타입
    float, real
    
    MSSQL 서버의 숫자 표현 타입
    decimal, numeric
    
    MSSQL 서버의 문자 표현 타입
    char, varchar, Nvarchar

※ ORACLE 은 숫자 표현 타입이 한 가지로 통일되어 있다.

1. 숫자형 NUMBER       -> -10의 38승-1 ~ 10의 38승
          NUMBER(3)    -> -999 ~ 999
          NUMBER(4)    -> -9999 ~ 9999
          NUMBER(4, 1) -> -999.9 ~ 999.9

※ ORACLE 의 문자 표현 타입

2. 문자형 CHAR       -> 고정형 크기
                        (무조건 지정된 크기 소모)
         CHAR(10)    <-- '강의장' (담기는 것은 6Byte이지만 10Byte를 소모한다.)       
         CHAR(10)    <-- '잠든김동민' (담기는 것 10Byte, 소모도 10Byte)
         CHAR(10)    <-- '오잠깬김동민' (담으려는 것이 12Byte인데 10Byte로 설정해놔서 입력 불가함)
        
        -------------------------------------------------------------------------------------------
        
         VARCHAR2    -> 가변형 크기
                        (상황에 따라 크기가 변경)
         VARCHAR2(10)    <-- '강의장' (6Byte를 소모한다. 10Byte설정해놔도 6Byte 소모 된다.)       
         VARCHAR2(10)    <-- '잠든김동민' (담기는 것 10Byte, 소모도 10Byte)
         VARCHAR2(10)    <-- '오잠깬김동민' (담으려는 것이 12Byte인데 10Byte로 설정해놔서 입력 불가함)
                                           (설정해놓은 것을 넘지는 못한다.)
                                           
        -------------------------------------------------------------------------------------------
        
        유니코드 문자(Byte로 계산하는 것이 아니라 글자수로 계산한다.)
        NCHAR     -> 유니코드 기반 고정형 크기(글자수)
        NCHAR(10) <-- 10글자
        
        NVARCHAR2 -> 유니코드 기반 가변형 크기(글자수)
        NVARCHAR2(10) <-- 10글자
        
==> 자료구조로 보자면 CHAR가 효율이 더 좋다. (CHAR를 쓸 수 있는 상황이면 CHAR 쓰는 게 좋다.)
ex) 주민등록번호 시 CHAR(13)이랑 VARCHAR(13)이라면 CHAR(13)이 더 좋다.

※ 날짜형 DATE
*/
--3.
SELECT HIREDATE
FROM EMP;
/*
1980-12-17
1981-02-20
1981-02-22
1981-04-02
1981-09-28
1981-05-01
1981-06-09
1987-07-13
1981-11-17
1981-09-08
1987-07-13
1981-12-03
1981-12-03
1982-01-23
*/
--※ 날짜 형식에 대한 세션 설정 변경
-- ALTER SESSION SET NLS_DATE_FORMAT='YY/MM/DD'; 하면 바뀜
-- 오라클을 껐다가 키면 원래로 돌아옴(지금 세션에서만 적용하는 구문임)

-- 나중에 JAVA랑 연결할때 80/12/17 11:47:20으로 나와도 놀래지말라.

DESCRIBE EMP;  --DESC 까지만 쓰기 가능
/*
이름       널?       유형           
-------- -------- ------------ 
EMPNO    NOT NULL NUMBER(4)    
ENAME             VARCHAR2(10) 
JOB               VARCHAR2(9)  
MGR               NUMBER(4)    
HIREDATE          DATE         
SAL               NUMBER(7,2)  
COMM              NUMBER(7,2)  
DEPTNO            NUMBER(2) 
*/

--※ 날짜 형식에 대한 세션 설정 변경
ALTER SESSION SET NLS_DATE_FORMAT='YYYY-MM-DD';
--==> Session이(가) 변경되었습니다.

SELECT SYSDATE
FROM DUAL;
--==> 2023-10-18

--※ 날짜 형식에 대한 세션 설정 변경
ALTER SESSION SET NLS_DATE_FORMAT='YYYY-MM-DD HH:MI:SS';
--==> Session이(가) 변경되었습니다.

SELECT SYSDATE
FROM DUAL;
--==> 2023-10-18 12:05:02

--※ 날짜 형식에 대한 세션 설정 변경
ALTER SESSION SET NLS_DATE_FORMAT='YYYY-MM-DD HH24:MI:SS';
--==> Session이(가) 변경되었습니다.

SELECT SYSDATE
FROM DUAL;
--==> 2023-10-18 12:05:53

--○ EMP 테이블에서 사원번호, 사원명, 급여, 커미션 데이터만 조회한다.
--SELECT *
--FROM EMP;
--이 문을 이용해서 데이터 이름 알기.

SELECT EMPNO, ENAME, SAL, COMM
FROM EMP;
/*
7369	SMITH	800	
7499	ALLEN	1600	300
7521    	WARD	    1250    500
7566	JONES	2975	
7654	MARTIN	1250	    1400
7698	BLAKE	2850	
7782    	CLARK	2450	
7788	SCOTT	3000	
7839	KING    	5000	
7844	TURNER	1500	0
7876	ADAMS	1100	
7900	JAMES	950	
7902    	FORD	    3000	
7934	MILLER	1300	
*/

--○ EMP 테이블에서 부서번호가 20번인 직원들의 데이터들 중
--   사원번호, 사원명, 직종, 급여, 부서번호 조회
--SELECT 사원번호, 사원명, 직종, 급여, 부서번호
--FROM EMP
--WHERE 부서번호가 20;

--SELECT EMPNO, ENAME, JOB, SAL, DEPTNO
--FROM EMP
--WHERE DEPTNO가 20;

SELECT EMPNO, ENAME, JOB, SAL, DEPTNO
FROM EMP
WHERE DEPTNO = 20;
/*
7369	SMITH	CLERK	800	    20
7566	JONES	MANAGER	2975	    20
7788	SCOTT	ANALYST	3000	20
7876	ADAMS	CLERK	1100	20
7902	    FORD	    ANALYST	3000	20
*/

SELECT EMPNO AS "사원번호", ENAME "사원명", JOB 직종명, SAL "급   여", DEPTNO 부서번호  
FROM EMP;
--==> EMPNO를 사원번호라고 부르게 함(이를 별칭이라 한다.)
--== ※ 테이블을 조회하는 과정에서
--      각 컬럼의 이름에는 별칭(ALIAS)을 부여할 수 있다.
--      기본 구문의 형식은 컬럼명 AS "별칭이름" 의 형태로 작성되며
--      이 때, AS는 생략이 가능하다.
--      또한, 별칭 이름을 감싸는 ""도 생략이 가능하지만
--      ""을 생략할 경우 별칭 내에서 공백은 사용할 수 없다.
--      공백의 등장은 해당 컬럼의 표현에 대한 종결을 의미하므로
--      별칭(ALIAS)의 이름 내부에 공백을 사용해야 할 경우
--      ""를 사용하여 별칭을 부여할 수 있도록 한다.
--  (AS 생략 가능, "" 생략 가능)
-- (""는 별칭에 대한 표현을 할때 사용(문자열 아님))
-- (SAL 급   여 -> 별칭 안에 띄어쓰기 하려고 하면 "" 생략하면 안됨)

--○ EMP 테이블에서 부서번호가 20번과 30번 직원들의 데이터들 중
--   사원번호, 사원명, 직종명, 급여, 부서번호 항목을 조회한다.
--   단, 별칭(ALIAS)를 사용한다.
/*
EMP 테이블에서                           -> FROM EMP
부서번호가 20번과 30번                   -> 조건
사원번호, 사원명, 직종명, 급여, 부서번호  -> SELECT 컬럼명
*/
SELECT EMPNO 사원번호, ENAME 사원명, JOB 직종명, SAL 급여, DEPTNO 부서번호
FROM EMP
WHERE DEPTNO = 20 OR DEPTNO = 30;          --WHERE DEPTNO = 20 || DEPTNO = 30; 하면 에러남.
/*
7369	SMITH	CLERK	    800	    20
7499	ALLEN	SALESMAN	    1600	30
7521	    WARD    	SALESMAN	    1250    	30
7566	JONES	MANAGER	    2975    	20
7654	MARTIN	SALESMAN	    1250    	30
7698	BLAKE	MANAGER	    2850    	30
7788	SCOTT	ANALYST	    3000	20
7844	TURNER	SALESMAN	    1500	30
7876	ADAMS	CLERK	    1100	20
7900	JAMES	CLERK	    950	    30
7902    	FORD    	ANALYST	    3000	20
*/

--※ 위의 구문은 IN 연산자를 활용하여
--   다음과 같이 처리할 수 있으며,
--   위 구문의 처리 결과와 같은 결과를 반환한다.
SELECT EMPNO 사원번호, ENAME 사원명, JOB 직종명, SAL 급여, DEPTNO 부서번호
FROM EMP
WHERE DEPTNO IN (20, 30);
/*
7369	SMITH	CLERK	    800     20
7499	ALLEN	SALESMAN	    1600	30
7521	    WARD    	SALESMAN	    1250	    30
7566	JONES	MANAGER	    2975	    20
7654	MARTIN	SALESMAN	    1250    	30
7698	BLAKE	MANAGER	    2850    	30
7788	SCOTT	ANALYST	    3000	20
7844	TURNER	SALESMAN	    1500	30
7876	ADAMS	CLERK	    1100	20
7900	JAMES	CLERK	    950	    30
7902    	FORD	    ANALYST	    3000	20
*/

--○ EMP 테이블에서 직종이 CLERK 인 사원들의 데이터를 모두 조회한다.
SELECT *
FROM EMP
WHERE JOB = 'CLERK';
/*
7369	SMITH	CLERK	7902	    1980-12-17 00:00:00     	800		20
7876	ADAMS	CLERK	7788	1987-07-13 00:00:00	    1100	20
7900	JAMES	CLERK	7698	1981-12-03 00:00:00	    950		30
7934	MILLER	CLERK	7782	    1982-01-23 00:00:00	    1300	10
*/

SELECT *
FROM EMP
WHERE JOB = 'clerk';
--==> 조회 결과 없음.

SELECT *
FROM EMP
WHERE JOB = 'Clerk';
--==> 조회 결과 없음.

--※ 오라클에서... 입력된 데이터의 값 만큼은...
--   반. 드. 시. 대소문자 구분을 한다.
--   (쿼리문에서는 안한다.)

--※ EMP 테이블에서 직종이 CLERK 인 사원들 중
--   20번 부서에 근무하는 사원들의
--   사원번호, 사원명, 직종명, 급여, 부서번호 항목을 조회한다.
--   ALIAS 사용~
SELECT EMPNO 사원번호, ENAME 사원명, JOB 직종명, SAL 급여, DEPTNO 부서번호
FROM EMP
WHERE JOB = 'CLERK' AND DEPTNO IN(20);
/*
7369	SMITH	CLERK	800 	20
7876	ADAMS	CLERK	1100	20
*/

--○ EMP 테이블의 구조와 데이터를 확인해서
--   이와 똑같은 데이터가 들어있는 테이블의 구조를 생성한다.
--   (팀별로... EMP1, EMP2, EMP3, EMP4)

SELECT *
FROM EMP;

CREATE TABLE EMP4
( EMPNO NUMBER(4)
, ENAME VARCHAR2(10)
, JOB VARCHAR2(9)
, MGR NUMBER(4)
, HIREDATE DATE
, SAL NUMBER(7,2)
, COMM NUMBER(7,2)
, DEPTNO NUMBER(2)
);
--==> Table EMP4이(가) 생성되었습니다.

INSERT INTO EMP4 VALUES
(7844,'TURNER','SALESMAN',7698,to_date('8-9-1981','dd-mm-yyyy'),1500,0,30);
INSERT INTO EMP4 VALUES
(7876,'ADAMS','CLERK',7788,to_date('13-7-1987','dd-mm-yyyy'),1100,NULL,20);
INSERT INTO EMP4 VALUES
(7900,'JAMES','CLERK',7698,to_date('3-12-1981','dd-mm-yyyy'),950,NULL,30);

commit;

SELECT *
FROM EMP4;

--강사님 방법--
-- 1. 복사할 대상 테이블의 구조 확인
DESCRIBE EMP;
DESC EMP;
/*
이름       널?       유형           
-------- -------- ------------ 
EMPNO    NOT NULL NUMBER(4)    
ENAME             VARCHAR2(10) 
JOB               VARCHAR2(9)  
MGR               NUMBER(4)    
HIREDATE          DATE         
SAL               NUMBER(7,2)  
COMM              NUMBER(7,2)  
DEPTNO            NUMBER(2)    
*/

-- 2. 대상 테이블의 구조에 따라 새로운 테이블 생성
CREATE TABLE EMP5
(  EMPNO     NUMBER(4)
,  ENAME     VARCHAR2(10)
,  JOB       VARCHAR2(9)
,  MGR       NUMBER(4)
,  HIREDATE  DATE
,  SAL       NUMBER(7,2)
,  COMM      NUMBER(7,2)
,  DEPTNO    NUMBER(2)
);
--==> Table EMP5이(가) 생성되었습니다.

SELECT *
FROM EMP5;

-- 3. 대상 테이블의 데이터 조회
SELECT *
FROM EMP;

-- 4. 대상 테이블의 데이터를 복사할 테이블에 입력
INSERT INTO EMP5 VALUES
(7369,'SMITH','CLERK',7902,to_date('17-12-1980','dd-mm-yyyy'),800,NULL,20);
INSERT INTO EMP5 VALUES
(7499,'ALLEN','SALESMAN',7698,to_date('20-2-1981','dd-mm-yyyy'),1600,300,30);
INSERT INTO EMP5 VALUES
(7521,'WARD','SALESMAN',7698,to_date('22-2-1981','dd-mm-yyyy'),1250,500,30);
INSERT INTO EMP5 VALUES
(7566,'JONES','MANAGER',7839,to_date('2-4-1981','dd-mm-yyyy'),2975,NULL,20);
INSERT INTO EMP5 VALUES
(7654,'MARTIN','SALESMAN',7698,to_date('28-9-1981','dd-mm-yyyy'),1250,1400,30);
INSERT INTO EMP5 VALUES
(7698,'BLAKE','MANAGER',7839,to_date('1-5-1981','dd-mm-yyyy'),2850,NULL,30);
INSERT INTO EMP5 VALUES
(7782,'CLARK','MANAGER',7839,to_date('9-6-1981','dd-mm-yyyy'),2450,NULL,10);
INSERT INTO EMP5 VALUES
(7788,'SCOTT','ANALYST',7566,to_date('13-7-1987','dd-mm-yyyy'),3000,NULL,20);
INSERT INTO EMP5 VALUES
(7839,'KING','PRESIDENT',NULL,to_date('17-11-1981','dd-mm-yyyy'),5000,NULL,10);
INSERT INTO EMP5 VALUES
(7844,'TURNER','SALESMAN',7698,to_date('8-9-1981','dd-mm-yyyy'),1500,0,30);
INSERT INTO EMP5 VALUES
(7876,'ADAMS','CLERK',7788,to_date('13-7-1987','dd-mm-yyyy'),1100,NULL,20);
INSERT INTO EMP5 VALUES
(7900,'JAMES','CLERK',7698,to_date('3-12-1981','dd-mm-yyyy'),950,NULL,30);
INSERT INTO EMP5 VALUES
(7902,'FORD','ANALYST',7566,to_date('3-12-1981','dd-mm-yyyy'),3000,NULL,20);
INSERT INTO EMP5 VALUES
(7934,'MILLER','CLERK',7782,to_date('23-1-1982','dd-mm-yyyy'),1300,NULL,10);
--1 행 이(가) 삽입되었습니다. *14

--5. 확인
SELECT *
FROM EMP5;
/*
7369	SMITH	CLERK	7902	1980-12-17 00:00:00	800		20
7499	ALLEN	SALESMAN	7698	1981-02-20 00:00:00	1600	300	30
7521    	WARD    	SALESMAN	7698	1981-02-22 00:00:00	1250	500	30
7566	JONES	MANAGER	7839	1981-04-02 00:00:00	2975		20
7654	MARTIN	SALESMAN	7698	1981-09-28 00:00:00	1250	1400	30
7698	BLAKE	MANAGER	7839	1981-05-01 00:00:00	2850		30
7782	    CLARK	MANAGER	7839	1981-06-09 00:00:00	2450		10
7788	SCOTT	ANALYST	7566	1987-07-13 00:00:00	3000		20
7839	KING    	PRESIDENT		1981-11-17 00:00:00	5000		10
7844	TURNER	SALESMAN	7698	1981-09-08 00:00:00	1500	0	30
7876	ADAMS	CLERK	7788	1987-07-13 00:00:00	1100		20
7900	JAMES	CLERK	7698	1981-12-03 00:00:00	950		30
7902	    FORD    	ANALYST	7566	1981-12-03 00:00:00	3000		20
7934	MILLER	CLERK	7782	1982-01-23 00:00:00	1300		10
*/

-- 6. 커밋
COMMIT;
--==> 커밋 완료.

SELECT *
FROM EMP5;

--※ 날짜 관련 세션 설정 변경
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD';
--==> Session이(가) 변경되었습니다.

SELECT *
FROM EMP5;

--○ 대상 테이블의 내용에 따라 테이블 생성(위에 1시간동안 팀과제 하던거 1분만에 하는 법) - TBL_EMP
CREATE TABLE TBL_EMP
AS
SELECT *
FROM EMP;
--==> Table TBL_EMP이(가) 생성되었습니다.

SELECT *
FROM TBL_EMP;
/*
7369	SMITH	CLERK	7902	1980-12-17	800		20
7499	ALLEN	SALESMAN	7698	1981-02-20	1600	300	30
7521	WARD	SALESMAN	7698	1981-02-22	1250	500	30
7566	JONES	MANAGER	7839	1981-04-02	2975		20
7654	MARTIN	SALESMAN	7698	1981-09-28	1250	1400	30
7698	BLAKE	MANAGER	7839	1981-05-01	2850		30
7782	CLARK	MANAGER	7839	1981-06-09	2450		10
7788	SCOTT	ANALYST	7566	1987-07-13	3000		20
7839	KING	PRESIDENT		1981-11-17	5000		10
7844	TURNER	SALESMAN	7698	1981-09-08	1500	0	30
7876	ADAMS	CLERK	7788	1987-07-13	1100		20
7900	JAMES	CLERK	7698	1981-12-03	950		30
7902	FORD	ANALYST	7566	1981-12-03	3000		20
7934	MILLER	CLERK	7782	1982-01-23	1300		10
*/

--○ DEPT 테이블을 복사하여 위와 같이 TBL_DEPT 테이블을 생성한다.
SELECT *
FROM DEPT;
/*
10	ACCOUNTING	NEW YORK
20	RESEARCH	DALLAS
30	SALES	CHICAGO
40	OPERATIONS	BOSTON
*/

CREATE TABLE TBL_DEPT
AS
SELECT *
FROM DEPT;
--==> Table TBL_DEPT이(가) 생성되었습니다.

SELECT *
FROM TBL_DEPT;
/*
10	ACCOUNTING	NEW YORK
20	RESEARCH	DALLAS
30	SALES	CHICAGO
40	OPERATIONS	BOSTON
*/

--○ 테이블의 커멘트 정보 확인
SELECT *
FROM USER_TAB_COMMENTS;
/*
DEPT	        TABLE
EMP	            TABLE
BONUS	        TABLE
SALGRADE	        TABLE
TBL_EXAMPLE1	    TABLE
TBL_EXAMPLE2	    TABLE
EMP5	        TABLE
EMP4	        TABLE
TBL_EMP	        TABLE
TBL_DEPT	        TABLE
*/

--○ 테이블 레벨의 커멘트 정보 입력
COMMENT ON TABLE TBL_EMP IS '사원정보';
--==> Comment이(가) 생성되었습니다.

--○ 커멘트 정보 입력 후 다시 확인
SELECT *
FROM USER_TAB_COMMENTS;
/*
TBL_DEPT        	TABLE	
TBL_EMP	        TABLE	사원정보
EMP4	        TABLE	
EMP5	        TABLE	
TBL_EXAMPLE2    	TABLE	
TBL_EXAMPLE1    	TABLE	
SALGRADE        	TABLE	
BONUS	        TABLE	
EMP	            TABLE	
DEPT        	TABLE	
*/

--○ TBL_DEPT 테이블을 대상으로 테이블 레벨의 커멘트 데이터 입력
--   -> 부서 정보
COMMENT ON TABLE TBL_DEPT IS '부서 정보';
--==> Comment이(가) 생성되었습니다.

--○ 커멘트 데이터 입력 후 확인
SELECT *
FROM USER_TAB_COMMENTS;
/*
TBL_DEPT        	TABLE	부서 정보
TBL_EMP	        TABLE	사원정보
EMP4	        TABLE	
EMP5	        TABLE	
TBL_EXAMPLE2    	TABLE	
TBL_EXAMPLE1    	TABLE	
SALGRADE	        TABLE	
BONUS	        TABLE	
EMP	            TABLE	
DEPT	        TABLE	
*/

/*
PURGE RECYCLEBIN;
--==> RECYCLEBIN이(가) 비워졌습니다.
--BIN$iEYpBEAdSX28cl3K4J/Ogw==$0	EMPNO	
--BIN$iEYpBEAdSX28cl3K4J/Ogw==$0	ENAME 이런식으로 나오는 것들 지우는 코드.
*/

--○ 컬럼(COLUMN) 레벨의 커멘트 데이터 확인
SELECT *
FROM USER_COL_COMMENTS;
/*
EMP4	JOB	
DEPT	LOC	
BONUS	COMM	
EMP5	JOB	
SALGRADE	LOSAL	
TBL_EMP	ENAME	
EMP5	EMPNO	
BIN$iEYpBEAdSX28cl3K4J/Ogw==$0	EMPNO	
BIN$iEYpBEAdSX28cl3K4J/Ogw==$0	ENAME	
EMP4	MGR	
EMP4	EMPNO	
BIN$iEYpBEAdSX28cl3K4J/Ogw==$0	DEPTNO	
EMP	DEPTNO	
SALGRADE	HISAL	
EMP	EMPNO	
EMP5	ENAME	
DEPT	DEPTNO	
DEPT	DNAME	
EMP5	COMM	
EMP4	SAL	
TBL_EMP	SAL	
TBL_EXAMPLE2	NO	
TBL_EMP	HIREDATE	
EMP4	ENAME	
BONUS	JOB	
TBL_EXAMPLE1	NO	
BIN$iEYpBEAdSX28cl3K4J/Ogw==$0	HIREDATE	
EMP	ENAME	
EMP4	COMM	
TBL_DEPT	DNAME	
TBL_DEPT	DEPTNO	
BIN$iEYpBEAdSX28cl3K4J/Ogw==$0	MGR	
EMP	JOB	
TBL_EXAMPLE2	NAME	
BONUS	SAL	
EMP	SAL	
EMP5	MGR	
EMP5	HIREDATE	
BIN$iEYpBEAdSX28cl3K4J/Ogw==$0	SAL	
EMP5	SAL	
EMP5	DEPTNO	
EMP4	HIREDATE	
TBL_EXAMPLE1	NAME	
TBL_EMP	EMPNO	
TBL_DEPT	LOC	
TBL_EMP	COMM	
EMP	COMM	
SALGRADE	GRADE	
TBL_EXAMPLE1	ADDR	
TBL_EXAMPLE2	ADDR	
EMP4	DEPTNO	
EMP	HIREDATE	
TBL_EMP	MGR	
EMP	MGR	
BIN$iEYpBEAdSX28cl3K4J/Ogw==$0	JOB	
TBL_EMP	JOB	
BIN$iEYpBEAdSX28cl3K4J/Ogw==$0	COMM	
TBL_EMP	DEPTNO	
BONUS	ENAME	
*/

--○ 컬럼(COLUMN) 레벨의 커멘트 데이터 확인
SELECT *
FROM USER_COL_COMMENTS;
/*
EMP4	JOB	
DEPT	LOC	
BONUS	COMM	
EMP5	JOB	
SALGRADE	LOSAL	
TBL_EMP	ENAME	
EMP5	EMPNO	
EMP4	MGR	
EMP4	EMPNO	
EMP	DEPTNO	
SALGRADE	HISAL	
EMP	EMPNO	
EMP5	ENAME	
DEPT	DEPTNO	
DEPT	DNAME	
EMP5	COMM	
EMP4	SAL	
TBL_EMP	SAL	
TBL_EXAMPLE2	NO	
TBL_EMP	HIREDATE	
EMP4	ENAME	
BONUS	JOB	
TBL_EXAMPLE1	NO	
EMP	ENAME	
EMP4	COMM	
TBL_DEPT	DNAME	
TBL_DEPT	DEPTNO	
EMP	JOB	
TBL_EXAMPLE2	NAME	
BONUS	SAL	
EMP	SAL	
EMP5	MGR	
EMP5	HIREDATE	
EMP5	SAL	
EMP5	DEPTNO	
EMP4	HIREDATE	
TBL_EXAMPLE1	NAME	
TBL_EMP	EMPNO	
TBL_DEPT	LOC	
TBL_EMP	COMM	
EMP	COMM	
SALGRADE	GRADE	
TBL_EXAMPLE1	ADDR	
TBL_EXAMPLE2	ADDR	
EMP4	DEPTNO	
EMP	HIREDATE	
TBL_EMP	MGR	
EMP	MGR	
TBL_EMP	JOB	
TBL_EMP	DEPTNO	
BONUS	ENAME	
*/

SELECT *
FROM TAB;
/*
TBL_EXAMPLE1 	TABLE	
BONUS	TABLE	
DEPT	TABLE	
EMP	TABLE	
EMP4	TABLE	
EMP5	TABLE	
SALGRADE	TABLE	
TBL_DEPT	TABLE	
TBL_EMP	TABLE	
TBL_EXAMPLE2	TABLE	
*/

DROP TABLE TBL_EXAMPLE1;
--==> Table TBL_EXAMPLE1이(가) 삭제되었습니다.

SELECT *
FROM TAB;
/*
BIN$mxNCJgbGSwu8m/tjV1tA8g==$0	TABLE	
BONUS	TABLE	
DEPT	TABLE	
EMP	TABLE	
EMP4	TABLE	
EMP5	TABLE	
SALGRADE	TABLE	
TBL_DEPT	TABLE	
TBL_EMP	TABLE	
TBL_EXAMPLE2	TABLE	
*/

PURGE RECYCLEBIN;
--==> RECYCLEBIN이(가) 비워졌습니다.

SELECT *
FROM TAB;
/*
BONUS	TABLE	
DEPT	TABLE	
EMP	TABLE	
EMP4	TABLE	
EMP5	TABLE	
SALGRADE	TABLE	
TBL_DEPT	TABLE	
TBL_EMP	TABLE	
TBL_EXAMPLE2	TABLE	
*/

--○ 컬럼(COLUMN) 레벨의 커멘트 데이터 확인(TBL_DEPT 테이블에 소속된 컬럼들만 조회) 
SELECT *
FROM USER_COL_COMMENTS
WHERE TABLE_NAME='TBL_DEPT';    --> 조건 추가
/*
TBL_DEPT    	DEPTNO	
TBL_DEPT    	DNAME	
TBL_DEPT	    LOC	
*/
--==COMMENT ON TABLE 테이블명 IS '커멘트';

--○ 테이블에 소속된 컬럼에 대한 커멘트 데이터 입력
COMMENT ON COLUMN TBL_DEPT.DEPTNO IS '부서 번호';
--==> Comment이(가) 생성되었습니다.
COMMENT ON COLUMN TBL_DEPT.DNAME IS '부서 이름';
--==> Comment이(가) 생성되었습니다.
COMMENT ON COLUMN TBL_DEPT.LOC IS '부서 위치';
--==> Comment이(가) 생성되었습니다.

SELECT *
FROM USER_COL_COMMENTS
WHERE TABLE_NAME='TBL_DEPT';
/*
TBL_DEPT	DEPTNO	부서 번호
TBL_DEPT	DNAME	부서 이름
TBL_DEPT	LOC	    부서 위치
*/

--○ TBL_EMP 테이블 대상으로
--   테이블에 소속된(포함된) 컬럼에 대한 커멘트 데이터 입력(설정)
DESC TBL_EMP;
-- 사원 번호, 사원 이름, 직종 이름, 관리자 사원번호, 입사일, 급여, 수당, 부서 번호

COMMENT ON COLUMN TBL_EMP.EMPNO IS '사원 번호';
COMMENT ON COLUMN TBL_EMP.ENAME IS '사원 이름';
COMMENT ON COLUMN TBL_EMP.JOB IS '직종 이름';
COMMENT ON COLUMN TBL_EMP.MGR IS '관리자 사원번호';
COMMENT ON COLUMN TBL_EMP.HIREDATE IS '입사일';
COMMENT ON COLUMN TBL_EMP.SAL IS '급여';
COMMENT ON COLUMN TBL_EMP.COMM IS '수당';
COMMENT ON COLUMN TBL_EMP.DEPTNO IS '부서 번호';
--==> Comment이(가) 생성되었습니다. *8

SELECT *
FROM USER_COL_COMMENTS
WHERE TABLE_NAME='TBL_EMP';
/*
TBL_EMP	EMPNO	사원 번호
TBL_EMP	ENAME	사원 이름
TBL_EMP	JOB	직종 이름
TBL_EMP	MGR	관리자 사원번호
TBL_EMP	HIREDATE	입사일
TBL_EMP	SAL	급여
TBL_EMP	COMM	수당
TBL_EMP	DEPTNO	부서 번호
*/

--■■■ 컬럼 구조의 추가 및 제거■■■--

SELECT *
FROM TBL_EMP;

--○ TBL_EMP 테이블에 주민등록번호 데이터를 담을 수 있는 컬럼 추가
ALTER TABLE TBL_EMP
ADD SSN CHAR(13);
--==> Table TBL_EMP이(가) 변경되었습니다.

SELECT '01026000000'
FROM DUAL;
--==> 01026000000

SELECT 01026000000
FROM DUAL;
--==> 1026000000

--○ TBL_EMP 테이블의 구조 확인
DESC TBL_EMP;
/*
이름       널? 유형           
-------- -- ------------ 
EMPNO       NUMBER(4)    
ENAME       VARCHAR2(10) 
JOB         VARCHAR2(9)  
MGR         NUMBER(4)    
HIREDATE    DATE         
SAL         NUMBER(7,2)  
COMM        NUMBER(7,2)  
DEPTNO      NUMBER(2)    
SSN         CHAR(13) 
*/--> SSN(주민등록번호) 컬럼이 정상적으로 포함(추가)된 사항을 확인

--※ 테이블 내에서 컬럼의 순서는 구조적으로 의미 없음.
SELECT *
FROM TBL_EMP;
--SSN이 마지막에 나와도 상관없다는 뜻-> 이유는 내가 원하는 것들만 볼 수 있기 때문임.

SELECT EMPNO, ENAME, SSN
FROM TBL_EMP;
/*
7369	SMITH	
7499	ALLEN	
7521	WARD	
7566	JONES	
7654	MARTIN	
7698	BLAKE	
7782	CLARK	
7788	SCOTT	
7839	KING	
7844	TURNER	
7876	ADAMS	
7900	JAMES	
7902	FORD	
7934	MILLER	
*/

--○ TBL_EMP 테이블에 추가한 SSN(주민등록번호) 컬럼 제거
ALTER TABLE TBL_EMP
DROP COLUMN SSN;
--==> Table TBL_EMP이(가) 변경되었습니다.

DESC TBL_EMP;
/*
이름       널? 유형           
-------- -- ------------ 
EMPNO       NUMBER(4)    
ENAME       VARCHAR2(10) 
JOB         VARCHAR2(9)  
MGR         NUMBER(4)    
HIREDATE    DATE         
SAL         NUMBER(7,2)  
COMM        NUMBER(7,2)  
DEPTNO      NUMBER(2)    
*/

SELECT *
FROM TBL_EMP;

--> SSN(주민등록번호) 컬럼이 정상적으로 삭제(제거) 되었음을 확인.

DELETE TBL_EMP;
--==> 14개 행 이(가) 삭제되었습니다.
--테이블이 없어진 게 아니라 데이터만 사라진것.

SELECT *
FROM TBL_EMP;
--> 테이블의 구조(뼈대, 틀)는 그대로 남아있는 상태에서
--  데이터만 모두 소실(삭제)된 상황임을 확인.

DROP TABLE TBL_EMP;
--==> Table TBL_EMP이(가) 삭제되었습니다.
--테이블 자체를 다 삭제하는 것.

SELECT *
FROM TBL_EMP;
--==> 에러 발생
-- ORA-00942: table or view does not exist

--> 테이블 자체가 구조적으로 제거된 상황

--○ 테이블 다시 복사(생성)
CREATE TABLE TBL_EMP
AS
SELECT *
FROM EMP;
--==> Table TBL_EMP이(가) 생성되었습니다.

--○ NULL의 처리
SELECT 10, 10+2, 10-2, 10*2, 10/2
FROM DUAL;
--==> 10	12	8	20	5

SELECT NULL, NULL+2, NULL-2, NULL*2, NULL/2
FROM DUAL;
--==> (null) (null) (null) (null) (null)

--※ 관찰의 결과
--   NULL은 상태의 값을 의미하며... 실제 존재하지 않는 값이기 때문에
--   이 NULL이 연산에 포함될 경우
--   그 결과는 무조건 NULL이다.


--○ TBL_EMP 테이블에서 커미션(COMM, 수당)이 NULL인 직원의
--   사원명, 직종명, 급여, 커미션 항목을 조회한다.
SELECT *
FROM TBL_EMP;

DESC TBL_EMP;
--==> COMM 부분의 유형이 NUMBER로 되어있음을 확인.

SELECT ENAME 사원명, JOB 직종명, SAL 급여, COMM 커미션
FROM TBL_EMP
WHERE COMM IS NULL;--COMM이 NULL이다.     --WHERE COMM = NULL; -> = 연산자 사용불가인 거 확인.
/*
SMITH	CLERK	800	
JONES	MANAGER	2975	
BLAKE	MANAGER	2850	
CLARK	MANAGER	2450	
SCOTT	ANALYST	3000	
KING	PRESIDENT	5000	
ADAMS	CLERK	1100	
JAMES	CLERK	950	
FORD	ANALYST	3000	
MILLER	CLERK	1300	
*/

--※ NULL은 실제 존재하는 값이 아니기 때문에
--   일반적인 연산자를 활용하여 비교할 수 없다.
--   NULL 을 대상으로 사용할 수 없는 연산자들
--   >=, <=, =, >, <, !=(오라클에서 사용가능하지만 NULL에서 불가), <>(같지 않다라는 다른 표현),
--   ^=(같지 않다라는 다른 표현)
--   자바와 다른 거 확인.

--○ TBL_EMP 테이블에서 20번 부서에 근무하지 않는 사원들의
--   사원명, 직종명, 부서번호 항목을 조회한다.
SELECT ENAME 사원명, JOB 직종명, DEPTNO 부서번호
FROM TBL_EMP
WHERE DEPTNO != 20; -- !=, <>, ^=
/*
ALLEN	SALESMAN	30
WARD    	SALESMAN	30
MARTIN	SALESMAN	30
BLAKE	MANAGER	30
CLARK	MANAGER	10
KING	PRESIDENT	10
TURNER	SALESMAN	30
JAMES	CLERK	30
MILLER	CLERK	10
*/



























