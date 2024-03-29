SELECT USER
FROM DUAL;
--==> SCOTT

--■■■ FUNCTION(함수) ■■■--

-- 1. 함수란 하나 이상의 PL/SQL 문으로 구성된 서브루틴으로
--    코드를 다시 사용할 수 있도록 캡슐화 하는데 사용된다.
--    오라클에서는 오라클에 정의된 기본 제공 함수를 사용하거나
--    직접 스토어드 함수를 만들 수 있다. (-> 사용자 정의 함수)
--    이 사용자 정의 함수는 시스템 함수처럼 쿼리에서 호출하거나
--    저장 프로시저처럼 EXECUTE 문을 통해 실행 할 수 있다.

-- 2. 형식 및 구조
/*
CREATE [OR REPLACE] FUNCTION 함수명
[( 매개변수명1 자료형
 , 매개변수명2 자료형
)]
RETURN 데이터타입
IS
    -- 주요 변수 선언
BEGIN
    -- 실행문;
    ...
    RETURN(값);
    
    [EXCEPTION]
        -- 예외 처리 구문;
END;
*/

-- ※ 사용자 정의 함수(스트어드 함수)는
--    IN 파라미터(입력 매개변수)만 사용할 수 있으며
--    반드시 반환될 값의 데이터타입을 RETURN 문에 선언해야 하고,
--    FUNCTION은 반드시 단일 값만 반환한다.

--○ TBL_INSA 테이블 전용 성별 확인 함수 정의(생성)
--   --------------------
--   매개변수 구조(형태)를 '771212-1022432' 이런 형태로 넘겨받겠다는 뜻 -> 'YYMMDD-NNNNNNN' 의 형태로 받겠다.(다른 곳에서도 쓸 수 있게끔)
-- 함수명 : FN_GENDER()
--                   ↑ 주민등록번호 -> '771212-1022432'

CREATE OR REPLACE FUNCTION FN_GENDER(V_SSN VARCHAR2)  -- 매개변수 : 자리수(길이) 지정 안함.     --V_SSN VARCHAR2 변수 선언이지만 마지막에 ; 안붙음
RETURN VARCHAR2                                         -- 반환자료형 : 자리수(길이) 지정 안함.
IS
    -- 선언부 -> 주요 변수 선언 및 초기화
    V_RESULT VARCHAR2(20);
BEGIN
    -- 실행부 -> 연산 및 처리(그리고 결과값 반환)
    IF ( SUBSTR(V_SSN, 8, 1) IN ('1', '3') )
        THEN V_RESULT := '남자';
    ELSIF ( SUBSTR(V_SSN, 8, 1) IN ('2', '4') )
        THEN V_RESULT := '여자';
    ELSE
        V_RESULT := '성별확인불가';
    END IF;
    
    -- 결과값 반환 (꼭 써줘야됨)
    RETURN V_RESULT;
END;


--○ 임의의 정수 두 개를 매개변수(입력 파라미터)로 넘겨받아 -> (A,B)
--   A의 B승의 값을 반환하는 사용자 정의 함수를 작성한다.
--   단, 기존의 오라클 내장 함수를 이용하지 않고, 반복문을 활용하여 작성한다.
--   함수명 : FN_POW()
/*
사용 예)
SELECT FN_POW(10,3)
FROM DUAL;
--==> 1000
*/
--방법1
CREATE OR REPLACE FUNCTION FN_POW(A NUMBER, B NUMBER)
RETURN NUMBER
IS
    C NUMBER;
    RESULT NUMBER :=1;
BEGIN
    FOR C IN 1..B LOOP
    RESULT := (RESULT * A);
    
    END LOOP;
    RETURN RESULT;
END;

--강사님 방법
CREATE OR REPLACE FUNCTION FN_POW(A NUMBER, B NUMBER)
RETURN NUMBER
IS
    V_NUM NUMBER;           -- 루프변수
    V_RESULT NUMBER := 1;   -- 반환 결과값 변수 -> 1로 초기화 (누적곱)
BEGIN
    -- 반복문 구성
    FOR V_NUM IN 1..B LOOP
        V_RESULT := V_RESULT * A;  --> 자바에서는 V_RESULT *= A
    END LOOP;
    -- 최종 결과값 반환
    RETURN V_RESULT;
END;

--○ TBL_INSA 테이블의 급여 계산 전용 함수를 정의한다.
--   급여는 기본급*12+수당 기반으로 연산을 수행한다.
--   함수명 : FN_PAY(기본급, 수당)
-- 방법1
CREATE OR REPLACE FUNCTION FN_PAY(V_BASICPAY NUMBER, V_SUDANG NUMBER)
RETURN NUMBER
IS
    V_RESULT NUMBER;
BEGIN
    V_RESULT := (V_BASICPAY*12)+V_SUDANG;
    
    RETURN V_RESULT;
END;

--강사님 방법 2
CREATE OR REPLACE FUNCTION FN_PAY(VBASICPAY NUMBER, VSUDANG NUMBER)
RETURN NUMBER
IS
    -- 주요 변수 선언
    VRESULT NUMBER;
BEGIN
    -- 연산 및 처리
    VRESULT := (NVL(VBASICPAY,0)*12)+ NVL(VSUDANG,0); -- NULL이 있다면 그것도 고려해서 함수를 짜야됨
    
    --최종 결과값 반환
    RETURN VRESULT;
END;

--○ TBL_INSA 테이블에서
--   입사일을 기준으로 현재까지의 근무년수를 반환하는 함수를 정의한다.
--   단, 근무년수는 소수점 이하 한자리까지 계산한다.
--   함수명 : FN_WORKYEAR(입사일)
-- 방법1
CREATE OR REPLACE FUNCTION FN_WORKYEAR(VIBSADATE DATE)
RETURN VARCHAR2
IS
    VYEAR NUMBER;
    VMONTH NUMBER;
    VRESULT VARCHAR2(30);
BEGIN
    VYEAR := TRUNC(MONTHS_BETWEEN(SYSDATE, VIBSADATE) /12);
    VMONTH := TRUNC(MONTHS_BETWEEN(SYSDATE, VIBSADATE)) - TRUNC(MONTHS_BETWEEN(SYSDATE, VIBSADATE) /12) *12;
    
    IF VMONTH = 0
        THEN VRESULT := VYEAR || '년';
    ELSE
        VRESULT := VYEAR || '년' || ' ' || VMONTH || '개월';
    END IF;
    
    RETURN VRESULT;
END;

-- 강사님 방법2
--1
SELECT MONTHS_BETWEEN(SYSDATE, TO_DATE('1998-10-11', 'YYYY-MM-DD')) / 12 "RESULT"
FROM DUAL;
--==> 25.06313380500796495420151334129828753483

--2
SELECT TRUNC(MONTHS_BETWEEN(SYSDATE, TO_DATE('1998-10-11', 'YYYY-MM-DD'))/12)||'년'
    || TRUNC(MOD(MONTHS_BETWEEN(SYSDATE, TO_DATE('1998-10-11', 'YYYY-MM-DD')), 12)) || '개월'
FROM DUAL;
--==> 25년0개월


CREATE OR REPLACE FUNCTION FN_WORKYEAR(VIBSADATE DATE)
RETURN VARCHAR2
IS
    VRESULT VARCHAR2(30);
BEGIN
    VRESULT := TRUNC(MONTHS_BETWEEN(SYSDATE, VIBSADATE)/12)||'년'
    || TRUNC(MOD(MONTHS_BETWEEN(SYSDATE, VIBSADATE), 12)) || '개월';
    
    RETURN VRESULT;
END;

---------------------------------------------------------------------------------

--※ 참고

--1. INSERT, UPDATE, DELETE, (MERGE)
--==> DML(Data Manipulation Language
-- COMMIT / ROLLBACK 이 필요하다.

--2. CREATE, DROP, ALTER, (TRUNCATE)
--==> DDL(Data Definition Language)
-- 실행하면 자동으로 COMMIT 된다.

--3. GRANT, REVOKE
--==> DCL(Data Control Language)
-- 실행하면 자동으로 COMMIT 된다.

--4. COMMIT, ROLLBACK
--==> TCL(Transaction Control Language)

-- 정적 pl/sql문 -> DML문, TCL문만 사용 가능하다.
-- 동적 pl/sql문 -> DML문, DCL문, TCL문 사용 가능하다.

---------------------------------------------------------------------------------

--■■■ PROCEDURE(프로시저) ■■■-

-- 1. PL/SQL 에서 가장 대표적인 구조인 스토어드 프로시저는
--    개발자가 자주 작성해야 하는 업무의 흐름을
--    미리 작성하여 데이터베이스 내에 저장해 두었다가
--    필요할 때 마다 호출하여 실행할 수 있도록 처리해 주는 구문이다.

-- 2. 형식 및 구조
/*
CREATE [OR REPLACE] PROCEDURE 프로시저명
[( 매개변수 IN 데이터타입
 , 매개변수 OUT 데이터타입
 , 매개변수 INOUT 데이터타입
)]
IS
    [--주요 변수 선언]
BEGIN
    --실행구문;
    ...
    
    [EXCEPTION
        --예외 처리 구문;]
END;
*/

--※ FUNCTION 과 비교했을 때 (RETURN 반환자료형) 부분이 존재하지 않으며
--   RETURN 문 자체도 존재하지 않고,
--   프로시저 실행 시 넘겨주게 되는 매개변수의 종류는
--   IN(입력), OUT(출력), INOUT(입출력)으로 구분된다.

-- 3. 실행(호출)
/*
EXE[CUTE] 프로시저명[(인수1, 인수2, ...)]
*/

--※ 프로시저 실습을 위한 테이블 생성은...
--   20231103_02_scott.sql 파일 참조~

--○ 프로시저 생성
-- 프로시저명 : PRC_STUDENT_INSERT(아이디, 패스워드, 이름, 전화, 주소)

CREATE OR REPLACE PROCEDURE PRC_STUDENT_INSERT 
( 아이디
, 패스워드
, 이름
, 전화
, 주소
)
IS
BEGIN
END;

CREATE OR REPLACE PROCEDURE PRC_STUDENT_INSERT 
( V_ID      IN TBL_IDPW.ID%TYPE
, V_PW      IN TBL_IDPW.PW%TYPE
, V_NAME    IN TBL_STUDENTS.NAME%TYPE
, V_TEL     IN TBL_STUDENTS.TEL%TYPE
, V_ADDR    IN TBL_STUDENTS.ADDR%TYPE
)
IS
BEGIN
    -- TBL_IDPW 테이블에 데이터 입력 -> INSERT
    INSERT INTO TBL_IDPW(ID, PW)
    VALUES(V_ID, V_PW);
    
    -- TBL_STUDENTS 테이블에 데이터 입력 -> INSERT
    INSERT INTO TBL_STUDENTS(ID, NAME, TEL, ADDR)
    VALUES(V_ID, V_NAME, V_TEL, V_ADDR);
    
    -- 커밋
    COMMIT;
END;
--==> Procedure PRC_STUDENT_INSERT이(가) 컴파일되었습니다.


--※ 프로시저 실습을 위한 테이블 생성은...
--   20231103_02_scott.sql 파일 참조~

--○ 데이터 입력 시 특정 항목의 데이터만 입력하면
--   내부적으로 다른 추가항목에 대한 처리가 함께 이루어질 수 있도록 하는
--   프로시저를 작성한다.(생성한다.)
--   프로시저명 : PRC_SUNGJUK_INSERT()
/*
문제 인식)
현재 TBL_SUNGJUK 테이블은
HAKBUN, NAME, KOR, ENG, MAT, TOT, AVG, GRADE        
(학번, 이름, 국어점수, 영어점수, 수학점수, 총점, 평균, 등급)
컬럼으로 구성되어 있다.
이 테이블을 대상으로 특정 항목(학번, 이름, 국어점수, 영어점수, 수학점수)만 입력하면
추가 항목(총점, 평균, 등급)은 알아서 처리될 수 있도록 프로시저를 구성하라는 것이다.

실행 예)
EXEC PRC_SUNGJUK_INSERT(1, '김다슬', 90, 80, 70);
-> 이와 같은 프로시저 호출로 처리된 결과

학번   이름   국어점수  영어점수  수학점수   총점   평균    등급
1,   '김다슬',  90,         80,      70      240     80       B
*/
-- 방법1
CREATE OR REPLACE PROCEDURE PRC_SUNGJUK_INSERT 
( VHAKBUN      IN TBL_SUNGJUK.HAKBUN%TYPE
, VNAME        IN TBL_SUNGJUK.NAME%TYPE
, VKOR         IN TBL_SUNGJUK.KOR%TYPE
, VENG         IN TBL_SUNGJUK.ENG%TYPE
, VMAT         IN TBL_SUNGJUK.MAT%TYPE
)
IS
    VTOT TBL_SUNGJUK.TOT%TYPE := (VKOR+VENG+VMAT);
    VAVG TBL_SUNGJUK.AVG%TYPE := (VKOR+VENG+VMAT)/3;
    VGRADE TBL_SUNGJUK.GRADE%TYPE;
BEGIN
    IF VAVG >=90 THEN VGRADE := 'A';
    ELSIF VAVG >=80 THEN VGRADE := 'B';
    ELSIF VAVG >=70 THEN VGRADE := 'C';
    ELSIF VAVG >=60 THEN VGRADE := 'D';
    ELSIF VAVG >=50 THEN VGRADE := 'E';
    ELSE VGRADE := 'F';
    END IF;
    
    -- TBL_SUNGJUK 테이블에 데이터 입력 -> INSERT
    INSERT INTO TBL_SUNGJUK(HAKBUN, NAME, KOR, ENG, MAT, TOT, AVG, GRADE)
    VALUES(VHAKBUN, VNAME, VKOR, VENG, VMAT, VTOT, VAVG, VGRADE);
    
    -- 커밋
    COMMIT;
END;
--==> Procedure PRC_SUNGJUK_INSERT이(가) 컴파일되었습니다.

--강사님 방법
CREATE OR REPLACE PROCEDURE PRC_SUNGJUK_INSERT 
( V_HAKBUN      IN TBL_SUNGJUK.HAKBUN%TYPE  --> 입력매개변수
, V_NAME        IN TBL_SUNGJUK.NAME%TYPE    -->  입력매개변수
, V_KOR         IN TBL_SUNGJUK.KOR%TYPE     -->  입력매개변수
, V_ENG         IN TBL_SUNGJUK.ENG%TYPE     -->  입력매개변수
, V_MAT         IN TBL_SUNGJUK.MAT%TYPE     --> 입력매개변수
)
IS
    -- 선언부
    -- INSERT 쿼리문을 수행하기 위해 필요한 추가 변수 구성
    V_TOT       TBL_SUNGJUK.TOT%TYPE;
    V_AVG       TBL_SUNGJUK.AVG%TYPE;
    V_GRADE     TBL_SUNGJUK.GRADE%TYPE;
BEGIN
    -- 실행부
    -- 선언부에 추가로 선언한 주요 변수들에 값을 담아내야 한다.
    V_TOT := V_KOR + V_ENG + VMAT;
    V_AVG := V_TOT/3;
    IF V_AVG >= 90
        THEN V_GRADE := 'A';
    ELSIF V_AVG >= 80
        THEN V_GRADE := 'B';
    ELSIF V_AVG >= 70
        THEN V_GRADE := 'C';
    ELSIF V_AVG >= 60
        THEN V_GRADE := 'D';
    ELSE
        V_GRADE := 'F';
    END IF;
    
    -- TBL_SUNGJUK 테이블에 데이터 입력 -> INSERT 쿼리문 수행
    INSERT INTO TBL_SUNGJUK(HAKBUN, NAME, KOR, ENG, MAT, TOT, AVG, GRADE)
    VALUES(V_HAKBUN, V_NAME, V_KOR, V_ENG, V_MAT, V_TOT, V_AVG, V_GRADE);
    
    -- 커밋
    COMMIT;
END;

--○ TBL_SUNGJUK 테이블에서 특정 학생의 점수
--   (학번, 국어점수, 영어점수, 수학점수) 데이터 수정 시
--   총점, 평균, 등급까지 함께 수정되는 프로시저를 생성한다.
--   프로시저명 : PRC_SUNGJUK_UPDATE
/*
실행 예)
EXEC PRC_SUNGJUK_UPDATE(2, 50, 50, 50);

-> 이와 같은 프로시저 호출로 처리된 결과

학번   이름   국어점수  영어점수  수학점수   총점   평균    등급
1,   '김다슬',  90,         80,      70      240     80       B
2,   '노은하',  50,         50,      50      150     50       F
*/
--방법1
CREATE OR REPLACE PROCEDURE PRC_SUNGJUK_UPDATE
( V_HAKBUN      IN TBL_SUNGJUK.HAKBUN%TYPE  --> 입력매개변수
, V_KOR         IN TBL_SUNGJUK.KOR%TYPE     -->  입력매개변수
, V_ENG         IN TBL_SUNGJUK.ENG%TYPE     -->  입력매개변수
, V_MAT         IN TBL_SUNGJUK.MAT%TYPE     --> 입력매개변수
)
IS
    -- 선언부
    -- INSERT 쿼리문을 수행하기 위해 필요한 추가 변수 구성
    V_TOT       TBL_SUNGJUK.TOT%TYPE;
    V_AVG       TBL_SUNGJUK.AVG%TYPE;
    V_GRADE     TBL_SUNGJUK.GRADE%TYPE;
BEGIN
    -- 실행부
    -- 선언부에 추가로 선언한 주요 변수들에 값을 담아내야 한다.
    V_TOT := V_KOR + V_ENG + V_MAT;
    V_AVG := V_TOT/3;
    
    IF V_AVG >= 90
        THEN V_GRADE := 'A';
    ELSIF V_AVG >= 80
        THEN V_GRADE := 'B';
    ELSIF V_AVG >= 70
        THEN V_GRADE := 'C';
    ELSIF V_AVG >= 60
        THEN V_GRADE := 'D';
    ELSE
        V_GRADE := 'F';
    END IF;
    
    --UPDATE에는 INSERT 구문 빠짐
    UPDATE TBL_SUNGJUK
    SET KOR = V_KOR, ENG = V_ENG, MAT = V_MAT, TOT=V_TOT, AVG = V_AVG, GRADE=V_GRADE
    WHERE HAKBUN = V_HAKBUN;
    
    -- 커밋
    COMMIT;
END;

--강사님 방법2
CREATE OR REPLACE PROCEDURE PRC_SUNGJUK_UPDATE
( V_HAKBUN      IN TBL_SUNGJUK.HAKBUN%TYPE
, V_KOR         IN TBL_SUNGJUK.KOR%TYPE
, V_ENG         IN TBL_SUNGJUK.ENG%TYPE
, V_MAT         IN TBL_SUNGJUK.MAT%TYPE
)
IS
    -- 선언부
    -- UPDATE 쿼리문을 수행하기 위해 필요한 추가 변수 구성
    V_TOT       TBL_SUNGJUK.TOT%TYPE;
    V_AVG       TBL_SUNGJUK.AVG%TYPE;
    V_GRADE     TBL_SUNGJUK.GRADE%TYPE;
BEGIN
    -- 실행부
    V_TOT := V_KOR + V_ENG + V_MAT;
    V_AVG := V_TOT/3;
    
    IF V_AVG >= 90
        THEN V_GRADE := 'A';
    ELSIF V_AVG >= 80
        THEN V_GRADE := 'B';
    ELSIF V_AVG >= 70
        THEN V_GRADE := 'C';
    ELSIF V_AVG >= 60
        THEN V_GRADE := 'D';
    ELSE
        V_GRADE := 'F';
    END IF;
    
    -- UPDATE 쿼리문 수행
    UPDATE TBL_SUNGJUK
    SET  KOR = V_KOR, ENG = V_ENG, MAT = V_MAT, TOT=V_TOT, AVG = V_AVG, GRADE=V_GRADE
    WHERE HAKBUN = V_HAKBUN;
    
    -- 커밋
    COMMIT;
END;


--○ TBL_STUDENTS 테이블에서 전화번호와 주소 데이터를 수정하는(변경하는)
--   프로시저를 작성한다.
--   단, ID와 PW가 일치하는 경우에만 수정을 진행할 수 있도록 처리한다.
--   프로시저명 : PRC_STUDENT_UPDATE()
/*
실행 예)
EXEC PRC_STUDENT_UPDATE('moon', 'java000$', '010-9999-9999', '강원도 횡성');
--==> 데이터 수정 X

EXEC PRC_STUDENT_UPDATE('moon', 'java006$', '010-9999-9999', '강원도 횡성');
--==> 데이터 수정 O
*/

CREATE OR REPLACE PROCEDURE PRC_STUDENT_UPDATE
( V_ID      IN TBL_IDPW.ID%TYPE
, V_PW      IN TBL_IDPW.PW%TYPE
, V_TEL     IN TBL_STUDENTS.TEL%TYPE
, V_ADDR    IN TBL_STUDENTS.ADDR%TYPE
)
IS
BEGIN
    -- UPDATE 쿼리문 수행
    UPDATE TBL_STUDENTS
    SET TEL = V_TEL, ADDR = V_ADDR
    WHERE ID = V_ID AND V_PW = (SELECT PW
                                 FROM TBL_IDPW
                                 WHERE ID =V_ID);
    -- 커밋
    COMMIT;
END;












































