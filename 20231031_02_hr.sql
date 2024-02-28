SELECT USER
FROM DUAL;
--==> HR

SELECT *
FROM TAB;

--PURGE RECYCLEBIN;

SELECT *
FROM EMPLOYEES2;

--PURGE RECYCLEBIN;

--■■■ 팀 별 실습 수행 과제 ■■■--

-- 제출 파일명 : 20231031_03_hr(2팀_임하성).sql
-- 20231031_03_hr(2팀_임하성) 수행후기.txt

-- HR 샘플스키마 ERD 를 이용한 테이블 재구성

-- 팀별로...HR 샘플스키마에 있는 기본 테이블(7개)
-- COUNTRIES / DEPARTMENTS / EMPLOYEES / JOBS / JOB_HISTORY / LOCATIONS / REGIONS
-- 을 똑~~~~~~~ 같이 새로 구성한다.

-- 단, 생성하는 테이블의 이름은 테이블명+팀번호
-- COUNTRIES2 - 25 / DEPARTMENTS2 - 27 / EMPLOYEES2 - 107 / JOBS2 - 19 / JOB_HISTORY2 - 10 / LOCATIONS2 - 23 / REGIONS2 - 4

-- 1. 기존 대상 테이블들의 정보 수집
-- 컬럼명, 컬럼, 데이터 타입, 제약조건, 제약조건 이름

-- 2. 테이블 생성(컬럼이름, 자료형, DEFAULT표현식, NOT NULL 등...)

-- 3. 제약조건 설정(PK, U, FK, CK, ...)

-- 4. 데이터 입력(CREATE AS 사용 노노)

DESC JOBS;
/*
이름         널?       유형           
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