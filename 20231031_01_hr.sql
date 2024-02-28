SELECT USER
FROM DUAL;
--==> HR

--■■■ CHECK(CK:C) ■■■--

-- 1. 컬럼에서 허용 가능한 데이터의 범위나 조건을 지정하기 위한 제약조건.
--    컬럼에 입력되는 데이터를 검사하여 조건에 맞는 데이터만 입력될 수 있도록 한다.
--    또한, 컬럼에서 수정되는 데이터를 검사하여 조건에 맞는 데이터로 수정되는 것만
--    허용하는 기능을 수행하게 된다.

-- 2. 형식 및 구조
--  ① 컬럼 레벨의 형식
--     컬럼명 데이터 타입 [CONSTRAINT CONSTRAINT명] CHECK(컬럼 조건)

--  ② 테이블 레벨의 형식
--     컬럼명 데이터 타입,
--     컬럼명 데이터 타입,
--     CONSTRAINT CONSTRAINT명 CHECK(컬럼 조건)

--○ CK 지정 실습(① 컬럼 레벨의 형식)
-- 테이블 생성
CREATE TABLE TBL_TEST8
( COL1 NUMBER(5)        PRIMARY KEY
, COL2 VARCHAR2(30)
, COL3 NUMBER(3)        CHECK(COL3 BETWEEN 0 AND 100)
);
--==> Table TBL_TEST8이(가) 생성되었습니다.

-- 데이터 입력
INSERT INTO TBL_TEST8(COL1, COL2, COL3) VALUES(1, '박범구', 100);
--==> 1 행 이(가) 삽입되었습니다.

INSERT INTO TBL_TEST8(COL1, COL2, COL3) VALUES(1, '엄재용', 100);
--==> 에러 발생
-- ORA-00001: unique constraint (HR.SYS_C007032) violated

INSERT INTO TBL_TEST8(COL1, COL2, COL3) VALUES(2, '엄재용', 101);
--==> 에러 발생
-- ORA-02290: check constraint (HR.SYS_C007031) violated

INSERT INTO TBL_TEST8(COL1, COL2, COL3) VALUES(3, '엄재용', -1);
--==> 에러 발생
-- ORA-02290: check constraint (HR.SYS_C007031) violated

-- 확인
SELECT *
FROM TBL_TEST8;
/*
1	박범구	100
2	엄재용	100
*/

-- 커밋
COMMIT;
--==> 커밋 완료

-- 제약조건 확인
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_TEST8';
/*
HR	SYS_C007031	TBL_TEST8	C	COL3	COL3 BETWEEN 0 AND 100	
HR	SYS_C007032	TBL_TEST8	P	COL1		
*/


--○ CK 지정 실습(② 테이블 레벨의 형식)
-- 테이블 생성
CREATE TABLE TBL_TEST9
( COL1 NUMBER(5)
, COL2 VARCHAR2(30)
, COL3 NUMBER(3)
, CONSTRAINT TEST9_COL1_PK PRIMARY KEY(COL1)
, CONSTRAINT TEST9_COL3_CK CHECK(COL3 BETWEEN 0 AND 100)
);
--==> Table TBL_TEST9이(가) 생성되었습니다.

-- 데이터 입력
INSERT INTO TBL_TEST9(COL1, COL2, COL3) VALUES(1, '박범구', 100);
--==> 1 행 이(가) 삽입되었습니다.

INSERT INTO TBL_TEST9(COL1, COL2, COL3) VALUES(1, '엄재용', 100);
--==> 에러 발생
-- ORA-00001: unique constraint (HR.SYS_C007032) violated

INSERT INTO TBL_TEST9(COL1, COL2, COL3) VALUES(2, '엄재용', 101);
--==> 에러 발생
-- ORA-02290: check constraint (HR.SYS_C007031) violated

INSERT INTO TBL_TEST9(COL1, COL2, COL3) VALUES(2, '엄재용', -1);

INSERT INTO TBL_TEST9(COL1, COL2, COL3) VALUES(2, '엄재용', 80);

-- 확인
SELECT *
FROM TBL_TEST9;
/*
1	박범구	100
2	엄재용	80
*/

-- 커밋
COMMIT;
--==> 커밋 완료

-- 제약조건 확인
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_TEST9';
/*
HR	TEST9_COL3_CK	TBL_TEST9	C	COL3	COL3 BETWEEN 0 AND 100	
HR	TEST9_COL1_PK	TBL_TEST9	P	COL1		
*/

--○ CK 지정 실습(③ 테이블 생성 이후 제약조건 추가)
-- 테이블 생성
CREATE TABLE TBL_TEST10
( COL1 NUMBER(5)
, COL2 VARCHAR2(30)
, COL3 NUMBER(3)
);
--==> Table TBL_TEST10이(가) 생성되었습니다.

-- 제약조건 확인
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_TEST10';
--==> 조회 결과 없음

-- 제약조건 추가
ALTER TABLE TBL_TEST10
ADD ( CONSTRAINT TEST10_COL1_PK PRIMARY KEY(COL1)
    , CONSTRAINT TEST10_COL3_CK CHECK(COL3 BETWEEN 0 AND 100));
--==> Table TBL_TEST10이(가) 변경되었습니다.

-- 제약조건 확인
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_TEST10';
/*
HR	TEST10_COL1_PK	TBL_TEST10	P	COL1		
HR	TEST10_COL3_CK	TBL_TEST10	C	COL3	COL3 BETWEEN 0 AND 100	
*/

-- 테이블 생성
CREATE TABLE TBL_TESTMEMBER
( SID   NUMBER
, NAME  VARCHAR2(30)
, SSN   CHAR(14)       --입력형태 -> 'YYMMDD-NNNNNNN'
, TEL   VARCHAR2(40)
);
--==> Table TBL_TESTMEMBER이(가) 생성되었습니다.

--○ TBL_TESTMEMBER 테이블의 SSN 컬럼(주민등록번호 컬럼)에서
--   데이터 입력이나 수정 시, 성별이 유효한 테이터만 입력될 수 있도록
--   체크 제약조건을 추가할 수 있도록 한다.
--   (-> 주민번호 특정 자리에 입력 가능한 데이터를 1, 2, 3, 4만 가능하도록 처리)
--   또한, SID 컬럼에는 PRIMARY KEY 제약조건을 설정할 수 있도록 한다.

-- 제약조건 추가
ALTER TABLE TBL_TESTMEMBER
ADD ( CONSTRAINT TBL_TESTMEMBER_SID_PK PRIMARY KEY(SID)
    , CONSTRAINT TBL_TESTMEMBER_SSN_CK CHECK(SUBSTR(SSN,8,1) BETWEEN 1 AND 4));
--==> Table TBL_TESTMEMBER이(가) 변경되었습니다.

/* 방법2
ALTER TABLE TBL_TESTMEMBER
ADD ( CONSTRAINT TBL_TESTMEMBER_SID_PK PRIMARY KEY(SID)
    , CONSTRAINT TBL_TESTMEMBER_SSN_CK CHECK(SUBSTR(SSN,8,1) IN ('1', '2', '3', '4'));
*/


-- 제약조건 확인
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_TESTMEMBER';
/*
HR	TBL_TESTMEMBER_SID_PK	TBL_TESTMEMBER	P	SID		
HR	TBL_TESTMEMBER_SSN_CK	TBL_TESTMEMBER	C	SSN	SUBSTR(SSN,8,1) BETWEEN 1 AND 4	
*/

-- 삭제하려면
--DROP CONSTRAINT TBL_TESTMEMBER_SSN_CK;

DROP TABLE TBL_TESTMEMBER;

-- 데이터 입력 테스트
INSERT INTO TBL_TESTMEMBER(SID, NAME, SSN, TEL)
VALUES(1, '이윤수', '950106-1234567', '010-1111-1111');

INSERT INTO TBL_TESTMEMBER(SID, NAME, SSN, TEL)
VALUES(2, '박나영', '990208-1234567', '010-2222-2222');

INSERT INTO TBL_TESTMEMBER(SID, NAME, SSN, TEL)
VALUES(3, '최혜인', '070811-4234567', '010-3333-3333');

INSERT INTO TBL_TESTMEMBER(SID, NAME, SSN, TEL)
VALUES(4, '길현욱', '090211-3234567', '010-4444-4444');

INSERT INTO TBL_TESTMEMBER(SID, NAME, SSN, TEL)
VALUES(5, '정현욱', '000220-5234567', '010-5555-5555');
--==> 에러 발생
-- ORA-02290: check constraint (HR.TBL_TESTMEMBER_SSN_CK) violated

INSERT INTO TBL_TESTMEMBER(SID, NAME, SSN, TEL)
VALUES(5, '정현욱', '000220-6234567', '010-5555-5555');
--==> 에러 발생
-- ORA-02290: check constraint (HR.TBL_TESTMEMBER_SSN_CK) violated

-- 확인
SELECT *
FROM TBL_TESTMEMBER;
/*
1	이윤수	950106-1234567	010-1111-1111
2	박나영	990208-1234567	010-2222-2222
3	최혜인	070811-4234567	010-3333-3333
4	길현욱	090211-3234567	010-4444-4444
*/

-- 커밋
COMMIT;
--==> 커밋 완료.

--------------------------------------------------------------------------------

--■■■ FOREIGN KEY(FK:F:R) ■■■--

-- 1. 참조 키(R) 또는 외래 키(FK:F)는 두 테이블의 데이터 간 연결을 설정하고
--    강제 적용시키는데 사용되는 말이다.
--    한 테이블의 기본 키 값이 있는 열을
--    다른 테이블에 추가하면 테이블 간 연결을 설정할 수 있다.
--    이 때, 두 번째 테이블에 추가되는 열이 외래키가 된다.

-- 2. 부모 테이블(참조받는 컬럼이 포함된 테이블)이 먼저 생성된 후
--    자식 테이블(참조하는 컬럼이 포함된 테이블)이 생성되어야 한다.
--    이 때, 자식 테이블에 FOREIGN KEY 제약조건이 설정된다.

-- 3. 형식 및 구조
-- ① 컬럼 레벨의 형식
--    컬럼명 데이터타입 [CONSTRAINT CONSTRAINT명]
--                      REFERENCES 참조테이블명(참조컬럼명)
--                      [ON DELETE CASCADE | ON DELETE SET NULL] -> 추가 옵션

-- ② 테이블 레벨의 형식
--    컬럼명 데이터 타입,
--    컬럼명 데이터 타입,
--    CONSTRAINT CONSTRAINT명 FOREIGN KEY(컬럼명)
--               REFERENCES 참조테이블명(참조컬럼명)
--               [ON DELETE CASCADE | ON DELETE SET NULL] -> 추가 옵션

--※ FOREIGN KEY 제약조건을 설정하는 실습을 진행하기 위해서는
--   부모 테이블의 생성 작업을 먼저 수행해야 한다.
--   그리고 이 때, 부모 테이블에는 반드시 PK 또는 UK 제약조건이
--   설정된 컬럼이 존재해야 한다.

-- 부모 테이블 생성
CREATE TABLE TBL_JOBS
( JIKWI_ID      NUMBER
, JIKWI_NAME    VARCHAR2(30)
, CONSTRAINT JOBS_ID_PK PRIMARY KEY(JIKWI_ID)
);
--==> Table TBL_JOBS이(가) 생성되었습니다.

-- 부모 테이블에 데이터 입력
INSERT INTO TBL_JOBS(JIKWI_ID, JIKWI_NAME) VALUES(1, '사원');
INSERT INTO TBL_JOBS(JIKWI_ID, JIKWI_NAME) VALUES(2, '대리');
INSERT INTO TBL_JOBS(JIKWI_ID, JIKWI_NAME) VALUES(3, '과장');
INSERT INTO TBL_JOBS(JIKWI_ID, JIKWI_NAME) VALUES(4, '부장');
--==> 1 행 이(가) 삽입되었습니다.

--확인
SELECT *
FROM TBL_JOBS;
/*
1	사원
2	대리
3	과장
4	부장
*/

-- 커밋
COMMIT;
--==> 커밋 완료.

--○ FK 지정 실습(① 컬럼 레벨의 형식)
-- 테이블 생성
CREATE TABLE TBL_EMP1
( SID       NUMBER          PRIMARY KEY
, NAME      VARCHAR2(30)
, JIKWI_ID  NUMBER          REFERENCES TBL_JOBS(JIKWI_ID)
);
--==> Table TBL_EMP1이(가) 생성되었습니다.
-- FOREIGN KEY를 입력하지 않는다, JIKWI_ID = 부모테이블의 JIKWI_ID, TBL_JOBS.JIKWI_ID가 아니다. 주의

-- 제약조건 확인
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_EMP1';
/*
HR	SYS_C007040	TBL_EMP1	P	SID		
HR	SYS_C007041	TBL_EMP1	R	JIKWI_ID		NO ACTION
*/

-- 데이터 입력
INSERT INTO TBL_EMP1(SID, NAME, JIKWI_ID) VALUES(1, '노은하', 1);

INSERT INTO TBL_EMP1(SID, NAME, JIKWI_ID) VALUES(2, '박가영', 2);

INSERT INTO TBL_EMP1(SID, NAME, JIKWI_ID) VALUES(3, '채다선', 3);

INSERT INTO TBL_EMP1(SID, NAME, JIKWI_ID) VALUES(4, '김수환', 4);

INSERT INTO TBL_EMP1(SID, NAME, JIKWI_ID) VALUES(5, '김다슬', 5);
--==> 에러 발생
-- ORA-02291: integrity constraint (HR.SYS_C007041) violated - parent key not found

INSERT INTO TBL_EMP1(SID, NAME, JIKWI_ID) VALUES(5, '김다슬', 1);

INSERT INTO TBL_EMP1(SID, NAME) VALUES(6, '오수경');

--==> 확인
SELECT *
FROM TBL_EMP1;
/*
1	노은하	1
2	박가영	2
3	채다선	3
4	김수환	4
5	김다슬	1
6	오수경	(null)
*/

COMMIT;
--==> 커밋 완료.

--○ FK 지정 실습(② 테이블 레벨의 형식)
--테이블 생성
CREATE TABLE TBL_EMP2
( SID       NUMBER
, NAME      VARCHAR2(30)
, JIKWI_ID  NUMBER
, CONSTRAINT EMP2_SID_PK PRIMARY KEY(SID)
, CONSTRAINT EMP2_JIKWI_ID_FK FOREIGN KEY(JIKWI_ID)
              REFERENCES TBL_JOBS(JIKWI_ID)
);
--==> Table TBL_EMP2이(가) 생성되었습니다.
-- FOREIGN KEY(JIKWI_ID) 에서의 JIKWI_ID는 EMP2의 직위 아이디
-- REFERENCES TBL_JOBS(JIKWI_ID) 에서의 JIKWI_ID는 JOBS의 직위 아이디.

-- 제약조건 확인
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_EMP2';
/*
HR	EMP2_SID_PK	TBL_EMP2	P	SID		
HR	EMP2_JIKWI_ID_FK	TBL_EMP2	R	JIKWI_ID		NO ACTION
*/

--○ FK 지정 실습(③ 테이블 생성 이후 제약조건 추가)
CREATE TABLE TBL_EMP3
( SID       NUMBER
, NAME      VARCHAR2(30)
, JIKWI_ID  NUMBER
);
--==> Table TBL_EMP3이(가) 생성되었습니다.

-- 제약조건 추가
ALTER TABLE TBL_EMP3
ADD ( CONSTRAINT EMP3_SID_PK PRIMARY KEY(SID)
    , CONSTRAINT EMP3_JIKWI_ID_FK FOREIGN KEY(JIKWI_ID)
                REFERENCES TBL_JOBS(JIKWI_ID) );
--==> Table TBL_EMP3이(가) 변경되었습니다.

-- 제약조건 제거
ALTER TABLE TBL_EMP3
DROP CONSTRAINT EMP3_JIKWI_ID_FK;
--==> Table TBL_EMP3이(가) 변경되었습니다.

-- 제약조건 확인
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_EMP3';
--==> HR	EMP3_SID_PK	TBL_EMP3	P	SID		

-- 다시 제약조건 추가
ALTER TABLE TBL_EMP3
ADD CONSTRAINT EMP3_JIKWI_ID_FK FOREIGN KEY(JIKWI_ID)
                REFERENCES TBL_JOBS(JIKWI_ID);
--==> Table TBL_EMP3이(가) 변경되었습니다.

-- 제약조건 확인
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_EMP3';
/*
HR	EMP3_SID_PK	TBL_EMP3	P	SID		
HR	EMP3_JIKWI_ID_FK	TBL_EMP3	R	JIKWI_ID		NO ACTION
*/

-- 4. FOREIGN KEY 생성 시 주의사항
--    참조하고자 하는 부모 테이블을 먼저 생성해야 한다.
--    참조하고자 하는 컬럼이 PRIMARY KEY 또는 UNIQUE 제약조건이 설정되어 있어야 한다.
--    테이블 사이에 PRIMARY KEY 와 FOREIGN KEY 가 정의되어 있으면
--    PRIMARY KEY 제약조건이 설정된 데이터 삭제 시
--    FOREIGN KEY 컬럼에 그 값이 입력되어 있는 경우 삭제되지 않는다.
--    (즉, 자식 테이블에 참조하는 레코드가 존재할 경우
--    부모 테이블의 참조받는 해당 레코드는 삭제할 수 없다는 것이다.)
--    단, FK 설정 과정에서 ON DELETE CASCADE 나 ON DELETE SET NULL 옵션을
--    사용하여 설정한 경우에는 삭제가 가능하다.
--    또한, 부모 테이블을 제거하기 위해서는 자식 테이블을 먼저 제거해야 한다.


-- 부모 테이블
SELECT *
FROM TBL_JOBS;
/*
1	사원
2	대리
3	과장
4	부장
*/

-- 자식 테이블
SELECT *
FROM TBL_EMP1;
/*
1	노은하	1
2	박가영	2
3	채다선	3
4	김수환	4
5	김다슬	1
6	오수경	
*/

-- 부모 테이블 제거 시도
DROP TABLE TBL_JOBS;
--==> 에러 발생
-- ORA-02449: unique/primary keys in table referenced by foreign keys

-- 부모 테이블의 부장 직위 데이터 삭제 시도
SELECT *
FROM TBL_JOBS
WHERE JIKWI_ID=4;

DELETE
FROM TBL_JOBS
WHERE JIKWI_ID=4;
--==> 에러 발생
-- ORA-02292: integrity constraint (HR.SYS_C007041) violated - child record found

-- 김수환 부장의 직위를 사원으로 변경
UPDATE TBL_EMP1
SET JIKWI_ID=1
WHERE SID = 4;
--==> 1 행 이(가) 업데이트되었습니다.

-- 확인
SELECT *
FROM TBL_EMP1;
/*
1	노은하	1
2	박가영	2
3	채다선	3
4	김수환	1
5	김다슬	1
6	오수경	
*/

-- 커밋
COMMIT;
--==> 커밋 완료.

-- 부모 테이블(TBL_JOBS)의 부장 데이터를 참조하고 있는
-- 자식 테이블(TBL_EMP1)의 데이터가 존재하지 않는 상황

-- 이와 같은 상황에서 부모 테이블(TBL_JOBS)의
-- 부장 데이터 삭제
DELETE
FROM TBL_JOBS
WHERE JIKWI_ID=4;
--==> 1 행 이(가) 삭제되었습니다.

-- 확인
SELECT *
FROM TBL_JOBS;
/*
1	사원
2	대리
3	과장
*/

COMMIT;
--==> 커밋 완료.

--※ 부모 테이블의 데이터를 자유롭게(?) 삭제하기 위해서는
--   ON DELETE CASCADE 옵션 지정이 필요하다.

-- TBL_EMP1 테이블(자식 테이블)에서 FK 제약조건을 제거한 후
-- CASCADE 옵션을 포함하여 다시 FK 제약조건을 설정한다.
-- 제약조건 확인
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_EMP1';

-- 제약조건 제거
ALTER TABLE TBL_EMP1
DROP CONSTRAINT SYS_C007041;
--==> Table TBL_EMP1이(가) 변경되었습니다.

-- ON DELETE CASCADE 옵션이 포함된 내용으로 제약조건 다시 지정
ALTER TABLE TBL_EMP1
ADD CONSTRAINT EMP1_JIKWI_ID_FK FOREIGN KEY(JIKWI_ID)
                REFERENCES TBL_JOBS(JIKWI_ID)
                ON DELETE CASCADE;
--==> Table TBL_EMP1이(가) 변경되었습니다.

-- 제약조건 생성 이후 다시 확인
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_EMP1';
/*
HR	SYS_C007040	TBL_EMP1	P	SID		
HR	EMP1_JIKWI_ID_FK	TBL_EMP1	R	JIKWI_ID		CASCADE
*/

--※ CASCADE 옵션을 지정한 후에는
--   참조받고 있는 부모 테이블의 데이터를
--   언제든지 자유롭게 삭제하는 것이 가능하다.
--   단, ... 부모 테이블의 데이터가 삭제될 경우...
--   이를 참조하는 자식 테이블(모든 자식 테이블)의 데이터도 모~~~~~~~~~두 함께 삭제된다.

-- 부모 테이블
SELECT *
FROM TBL_JOBS;
/*
1	사원
2	대리
3	과장
*/

-- 자식 테이블
SELECT *
FROM TBL_EMP1;
/*
1	노은하	1
2	박가영	2
3	채다선	3
4	김수환	1
5	김다슬	1
6	오수경	
*/

-- 부모 테이블(TBL_JOBS)에서 과장 데이터 삭제
SELECT *
FROM TBL_JOBS
WHERE JIKWI_ID=3;

DELETE
FROM TBL_JOBS
WHERE JIKWI_ID=3;
--==> 1 행 이(가) 삭제되었습니다.

-- 부모 테이블
SELECT *
FROM TBL_JOBS;
/*
1	사원
2	대리
*/

-- 자식 테이블
SELECT *
FROM TBL_EMP1;
/*
1	노은하	1
2	박가영	2
4	김수환	1
5	김다슬	1
6	오수경	
*/

-- 부모 테이블(TBL_JOBS)에서 사원 데이터 삭제
SELECT *
FROM TBL_JOBS
WHERE JIKWI_ID=1;

DELETE
FROM TBL_JOBS
WHERE JIKWI_ID=1;
--==> 1 행 이(가) 삭제되었습니다.

-- 부모 테이블
SELECT *
FROM TBL_JOBS;
/*
2	대리
*/

-- 자식 테이블
SELECT *
FROM TBL_EMP1;
/*
2	박가영	2
6	오수경	
*/

DROP TABLE TBL_EMP2;
--==> Table TBL_EMP2이(가) 삭제되었습니다.

DROP TABLE TBL_EMP3;
--==> Table TBL_EMP3이(가) 삭제되었습니다.

DROP TABLE TBL_JOBS;
--==> 에러 발생
-- ORA-02449: unique/primary keys in table referenced by foreign keys
-- TBL_EMP1이 남아 있음

DROP TABLE TBL_EMP1;
--==> Table TBL_EMP1이(가) 삭제되었습니다.

DROP TABLE TBL_JOBS;
--==> Table TBL_JOBS이(가) 삭제되었습니다.

--■■■ NOT NULL(NN:CK:C) ■■■--

-- 1. 테이블에서 지정한 컬럼의 데이터가 NULL 인 상태를 갖지 못하도록 하는 제약조건.

-- 2. 형식 및 구조
-- ① 컬럼 레벨의 형식 -> DEFAULT라고 생각
--  컬럼명 데이터 타입 [CONSTRAINT CONSTRAINT명] NOT NULL

-- ② 테이블 레벨의 형식
--  컬럼명 데이터타입,
--  컬럼명 데이터타입,
--  CONSTRAINT CONSTRAINT명 CHECK(컬럼명 IS NOT NULL)

-- 3. 기존에 생성되어 있는 테이블에 NOT NULL 제약조건을 추가할 경우
--    ADD보다 MODIFY절이 더 많이 사용된다.
--    ALTER TABLE 테이블명
--    MODIFY 컬럼명 데이터타입 NOT NULL;

-- 4. 기존 테이블에 데이터가 이미 들어있지 않은 컬럼(-> NULL인 상태)을
--    NOT NULL 제약조건을 갖도록 수정하는 경우에는 에러 발생한다.

--○ NOT NULL 지정 실습(① 컬럼 레벨의 형식)
-- 테이블 생성
CREATE TABLE TBL_TEST11
( COL1      NUMBER(5)   PRIMARY KEY
, COL2      VARCHAR2(30) NOT NULL
);
--==> Table TBL_TEST11이(가) 생성되었습니다.

-- 데이터 입력
INSERT INTO TBL_TEST11(COL1, COL2) VALUES(1,'TEST');

INSERT INTO TBL_TEST11(COL1, COL2) VALUES(2,'ABCD');

INSERT INTO TBL_TEST11(COL1, COL2) VALUES(3,NULL);
--==> 에러 발생
-- ORA-01400: cannot insert NULL into ("HR"."TBL_TEST11"."COL2")

INSERT INTO TBL_TEST11(COL1) VALUES(4);
--==> 에러 발생
-- ORA-01400: cannot insert NULL into ("HR"."TBL_TEST11"."COL2")

-- 확인
SELECT *
FROM TBL_TEST11;
/*
1	TEST
2	ABCD
*/

--제약조건 확인
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME ='TBL_TEST11';
/*
HR	SYS_C007048	TBL_TEST11	C	COL2	"COL2" IS NOT NULL	
HR	SYS_C007049	TBL_TEST11	P	COL1		
*/

--○ NOT NULL 지정 실습(② 테이블 레벨의 형식)
CREATE TABLE TBL_TEST12
( COL1      NUMBER(5)
, COL2      VARCHAR2(30)
, CONSTRAINT TEST12_COL1_PK PRIMARY KEY(COL1)
, CONSTRAINT TEST12_COL2_NN CHECK(COL2 IS NOT NULL)
);
--==> Table TBL_TEST12이(가) 생성되었습니다.

--제약조건 확인
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME ='TBL_TEST12';
/*
HR	TEST12_COL2_NN	TBL_TEST12	C	COL2	COL2 IS NOT NULL	
HR	TEST12_COL1_PK	TBL_TEST12	P	COL1		
*/

--○ NOT NULL 지정 실습(③ 테이블 생성 이후 제약조건 추가)
CREATE TABLE TBL_TEST13
( COL1      NUMBER(5)
, COL2      VARCHAR2(30)
);
--==> Table TBL_TEST13이(가) 생성되었습니다.

--제약조건 확인
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME ='TBL_TEST13';
--==> 조회 결과 없음

-- 제약조건 추가
ALTER TABLE TBL_TEST13
ADD ( CONSTRAINT TEST13_COL1_PK PRIMARY KEY(COL1)
    , CONSTRAINT TEST13_COL2_NN CHECK(COL2 IS NOT NULL));
--==> Table TBL_TEST13이(가) 변경되었습니다.

--제약조건 확인
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME ='TBL_TEST13';
/*
HR	TEST13_COL1_PK	TBL_TEST13	P	COL1		
HR	TEST13_COL2_NN	TBL_TEST13	C	COL2	COL2 IS NOT NULL	
*/

-- 조별 시 참고
--※ NOT NULL 제약조건만 TBL_TEST13 테이블의 COL2 에 추가하는 경우
--   다음과 같은 방법을 사용하는 것도 가능하다.
ALTER TABLE TBL_TEST13
MODIFY COL2 NOT NULL;
--==> Table TBL_TEST13이(가) 변경되었습니다.

--제약조건 확인
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME ='TBL_TEST13';
/*
HR	TEST13_COL1_PK	TBL_TEST13	P	COL1		
HR	TEST13_COL2_NN	TBL_TEST13	C	COL2	COL2 IS NOT NULL	
HR	SYS_C007054	TBL_TEST13	C	COL2	"COL2" IS NOT NULL	
*/

-- 컬럼 레벨에서 NOT NULL 제약조건을 지정한 테이블(TBL_TEST11)
DESC TBL_TEST11;
/*
이름   널?       유형           
---- -------- ------------ 
COL1 NOT NULL NUMBER(5)    
COL2 NOT NULL VARCHAR2(30) 
*/

-- 테이블 레벨에서 NOT NULL 제약조건을 지정한 테이블(TBL_TEST12)
DESC TBL_TEST12;
/*
이름   널?       유형           
---- -------- ------------ 
COL1 NOT NULL NUMBER(5)    
COL2          VARCHAR2(30)
*/

-- 테이블 생성 이후 ADD 를 통해 NOT NULL 제약조건을 추가하였으며
-- 여기에 더하여, MODIFY 절을 통해 NOT NULL 제약조건을 추가한 테이블(TBL_TEST13)
DESC TBL_TEST13;
/*
이름   널?       유형           
---- -------- ------------ 
COL1 NOT NULL NUMBER(5)    
COL2 NOT NULL VARCHAR2(30) 
*/
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME IN ('TBL_TEST11', 'TBL_TEST12', 'TBL_TEST13');
/*
HR	SYS_C007048 	TBL_TEST11	C	COL2	"COL2" IS NOT NULL	
HR	SYS_C007049	    TBL_TEST11	P	COL1		

HR	TEST12_COL2_NN	TBL_TEST12	C	COL2	COL2 IS NOT NULL	
HR	TEST12_COL1_PK	TBL_TEST12	P	COL1		

HR	TEST13_COL1_PK	TBL_TEST13	P	COL1		
HR	TEST13_COL2_NN	TBL_TEST13	C	COL2	COL2 IS NOT NULL	
HR	SYS_C007054	    TBL_TEST13	C	COL2	"COL2" IS NOT NULL	
*/

--■■■ DEFAULT 표현식 ■■■--

-- 1. INSERT 와 UPDATE 문에서
--    특정 값이 아닌 기본 값을 입력하도록 처리할 수 있다.

-- 2. 형식 및 구조
--    컬럼명 데이터타입 DEFAULT 기본값

-- 3. INSERT 명령 시 해당 컬럼에 입력될 값을 할당하지 않거나
--    DEFAULT 키워드를 활용하여 기본으로 설정된 값을 입력하도록 할 수 있다.

-- 4. DEFAULT 키워드와 다른 제약(NOT NULL 등) 표기가 함께 사용되어야 하는 경우
--    DEFAULT 키워드를 먼저 표기(작성)할 것을 권장한다.

--○ DEFAULT 표현식 적용 실습
-- 테이블 생성
CREATE TABLE TBL_BBS                             -- 게시판 테이블 생성
( SID       NUMBER          PRIMARY KEY         -- 게시물 번호 -> 식별자 -> 자동 증가
, NAME      VARCHAR2(20)                         -- 게시물 작성자
, CONTENTS  VARCHAR2(200)                        -- 게시물 내용
, WRITEDAY  DATE            DEFAULT SYSDATE      -- 게시물 작성일
, COUNTS    NUMBER          DEFAULT 0            -- 게시물 조회수
, COMMENTS  NUMBER          DEFAULT 0            -- 게시물 댓글 갯수
);
--==> Table TBL_BBS이(가) 생성되었습니다.

--※ SID 를 자동 증가 값으로 운영하려면 시퀀스 객체가 필요하다.
--   자동으로 입력되는 컬럼은 사용자의 입력 항목에서 제외시킬 수 있다.

-- 시퀀스 생성
CREATE SEQUENCE SEQ_BBS
NOCACHE;
--==> Sequence SEQ_BBS이(가) 생성되었습니다.

-- 날짜 관련 세션 설정 변경
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS';
--==> Session이(가) 변경되었습니다.

-- 게시물 작성
INSERT INTO TBL_BBS(SID, NAME, CONTENTS, WRITEDAY, COUNTS, COMMENTS)
VALUES(SEQ_BBS.NEXTVAL, '김사슬', '오라클 DEFAULT 표현식을 실습중입니다.'
        , TO_DATE('2023-10-31 14:39:10', 'YYYY-MM-DD HH24:MI:SS'), 0 , 0);
--==> 1 행 이(가) 삽입되었습니다.

INSERT INTO TBL_BBS(SID, NAME, CONTENTS, WRITEDAY, COUNTS, COMMENTS)
VALUES(SEQ_BBS.NEXTVAL, '김사슬', '오라클 DEFAULT 표현식을 실습중입니다.', SYSDATE, 0 , 0);
--==> 1 행 이(가) 삽입되었습니다.

INSERT INTO TBL_BBS(SID, NAME, CONTENTS, WRITEDAY, COUNTS, COMMENTS)
VALUES(SEQ_BBS.NEXTVAL, '노은하', '계속 실습중입니다.', DEFAULT, 0 , 0);
--==> 1 행 이(가) 삽입되었습니다.

INSERT INTO TBL_BBS(SID, NAME, CONTENTS, WRITEDAY, COUNTS, COMMENTS)
VALUES(SEQ_BBS.NEXTVAL, '문정환', '열심히 실습중입니다.', DEFAULT, DEFAULT, DEFAULT);
--==> 1 행 이(가) 삽입되었습니다.

INSERT INTO TBL_BBS(SID, NAME, CONTENTS)
VALUES(SEQ_BBS.NEXTVAL, '이윤수', '무진장 실습중입니다.');
--==> 1 행 이(가) 삽입되었습니다.

SELECT *
FROM TBL_BBS;
/*
1	김사슬	오라클 DEFAULT 표현식을 실습중입니다.	2023-10-31 14:39:10	0	0
2	김사슬	오라클 DEFAULT 표현식을 실습중입니다.	2023-10-31 14:45:12	0	0
3	노은하	계속 실습중입니다.	                    2023-10-31 14:46:14	0	0
4	문정환	열심히 실습중입니다.	                    2023-10-31 14:47:10	0	0
5	이윤수	무진장 실습중입니다.                 	2023-10-31 14:48:05	0	0
*/

--○ DEFAULT 표현식 조회(확인)
SELECT *
FROM USER_TAB_COLUMNS
WHERE TABLE_NAME='TBL_BBS';
--DATA_DEFAULT를 통해 확인 가능
/*
TBL_BBS	SID	NUMBER			22			N	1													NO	NO		0		NO	YES	NONE
TBL_BBS	NAME	VARCHAR2			20			Y	2											CHAR_CS	20	NO	NO		20	B	NO	YES	NONE
TBL_BBS	CONTENTS	VARCHAR2			200			Y	3											CHAR_CS	200	NO	NO		200	B	NO	YES	NONE
TBL_BBS	WRITEDAY	DATE			7			Y	4	8	"SYSDATE
"											NO	NO		0		NO	YES	NONE
TBL_BBS	COUNTS	NUMBER			22			Y	5	2	"0
"											NO	NO		0		NO	YES	NONE
TBL_BBS	COMMENTS	NUMBER			22			Y	6	2	"0
"											NO	NO		0		NO	YES	NONE
*/

--○ 테이블 생성 이후 DEFAULT 표현식 추가 / 변경
ALTER TABLE 테이블명
MODIFY 컬럼명 [자료형(생략가능)] DEFAULT 기본값;

--○ 기존의 DEFAULT 표현식 제거
ALTER TABLE 테이블명
MODIFY 컬럼명 [자료형] DEFAULT NULL;

COMMIT;
--==> 커밋 완료.






















