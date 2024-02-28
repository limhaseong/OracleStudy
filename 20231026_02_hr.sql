SELECT USER
FROM DUAL;
--==> HR

--○ 세 개 이상의 테이블 조인(JOIN, 결합)
-- 관계가 명확하다면 여러개 테이블 조인 가능

-- 형식 1. (SQL 1992 CODE)
SELECT 테이벌명1.컬럼명, 테이블명2.컬럼명, 테이블명3.컬럼명
FROM 테이블명1, 테이블명2, 테이블명3
WHERE 테이블명1.컬럼명1 = 테이블명2.컬럼명1
    AND 테이블명2.컬럼명2 = 테이블명3.컬럼명2;


-- 형식 2. (SQL 1999 CODE)
SELECT 테이블명1.컬럼명, 테이블명2.컬럼명, 테이블명3.컬럼명
FROM 테이블명1 JOIN 테이블명2
ON 테이블명1.컬럼명1 = 테이블명2.컬럼명1
    JOIN 테이블명3
    ON 테이블명2.컬럼명2 = 테이블명3.컬럼명2;

--○ HR 계정 소유의 테이블 또는 뷰 목록 조회
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

--○ HR.JOBS, HR.EMPLOYEES, HR.DEPARTMENTS 테이블을 대상으로
--   직원들의 데이터를
--   FIRST_NAME, LAST_NAME, JOB_TITLE, DEPARTMENT_NAME 항목으로 조회한다.

SELECT *
FROM HR.JOBS;
-- JOB_ID --> 관계 컬럼
SELECT *
FROM HR.EMPLOYEES;
-- JOB_ID --> 관계 컬럼
SELECT *
FROM HR.DEPARTMENTS;
-- DEPARTMENT_ID  --> 관계 컬럼

-- 방법1
SELECT H.FIRST_NAME, H.LAST_NAME, R.JOB_TITLE, S.DEPARTMENT_NAME
FROM HR.EMPLOYEES H, HR.JOBS R, HR.DEPARTMENTS S
WHERE H.JOB_ID = R.JOB_ID
   AND H.DEPARTMENT_ID = S.DEPARTMENT_ID(+);

-- 방법2
SELECT H.FIRST_NAME, H.LAST_NAME, R.JOB_TITLE, S.DEPARTMENT_NAME
FROM HR.EMPLOYEES H JOIN HR.JOBS R
ON H.JOB_ID = R.JOB_ID
    LEFT JOIN HR.DEPARTMENTS S
    ON H.DEPARTMENT_ID = S.DEPARTMENT_ID;

-- 강사님 방법3 (1999 CODE)
-- FIRST_NAME, LAST_NAME, JOB_TITLE, DEPARTMENT_NAME
--    E           E          J             D
SELECT E.FIRST_NAME, E.LAST_NAME, D.DEPARTMENT_NAME
FROM EMPLOYEES E JOIN DEPARTMENTS D
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID;

SELECT COUNT(*)
FROM EMPLOYEES E JOIN DEPARTMENTS D
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID;
--==> 106   -> 1개가 누락됐음을 알 수 있다.

SELECT *
FROM EMPLOYEES;
-- 178	Kimberely	Grant	KGRANT	011.44.1644.429263	2007-05-24	SA_REP	7000	0.15	149	
--> DEPARTMENT_ID가 NULL이라 누락됨

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

--○ EMPLOYEES, DEPARTMENTS, JOBS, LOCATIONS, COUNTRIES, REGIONS 테이블을 대상으로
--   직원들의 데이터를 다음과 같이 조회한다.
--   FIRST_NAME, LAST_NAME, JOB_TITLE, DEPARTMENT_NAME, CITY, COUNTRY_NAME, REGION_NAME
/*
                            REGIONS      ┐
                                         │ REGION_ID
                       ┌   COUNTRIES    ┘
            COUNTRY_ID │
                       └   LOCATIONS    ┐
                                         │ LOCATION_ID
                       ┌   DEPARTMENTS  ┘
        DEPARTMENT_ID  │
                       ├   EMPLOYEES
               JOB_ID  │ 
                       └   JOBS
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

-- 방법1
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
                
-- 방법2
SELECT E.FIRST_NAME, E.LAST_NAME, J.JOB_TITLE, D.DEPARTMENT_NAME, L.CITY, C.COUNTRY_NAME, R.REGION_NAME
FROM EMPLOYEES E, DEPARTMENTS D, JOBS J, LOCATIONS L, COUNTRIES C, REGIONS R
WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID(+)
AND J.JOB_ID = E.JOB_ID(+)
AND D.LOCATION_ID = L.LOCATION_ID(+)
AND L.COUNTRY_ID = C.COUNTRY_ID(+)
AND C.REGION_ID = R.REGION_ID(+);























































































