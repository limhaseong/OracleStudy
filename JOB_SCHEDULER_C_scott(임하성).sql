SELECT USER
FROM DUAL;
--==> SCOTT

--○ FINAL PROJECT 일부 테이블 샘플링(주간업무보고, 주간업무보고 미작성 알림, 주간업무보고 미작성)

ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS';
--==> Session이(가) 변경되었습니다.
SET SERVEROUTPUT ON;

--○ 주간업무보고 미작성 테이블
CREATE TABLE WEEKREPORT_NO
( WEEKREPORTNO_SID  NUMBER                                          -- 주간업무보고 미작성번호    
, BECOMING_DATE       DATE                                          -- 생성 일자
, CONSTRAINT WEEKREPORTNO_SID_PK PRIMARY KEY(WEEKREPORTNO_SID)      -- 제약조건
);
--==> Table WEEKREPORTNO이(가) 생성되었습니다.

--○ 주간업무보고 미작성 시퀀스 생성(WEEKREPORTNOSEQ)
CREATE SEQUENCE WEEKREPORTNOSEQ
NOCACHE;
--==> Sequence WEEKREPORTNOSEQ이(가) 생성되었습니다.

--○ 주간업무보고 미작성 샘플 데이터 입력
INSERT INTO WEEKREPORT_NO VALUES(WEEKREPORTNOSEQ.NEXTVAL, TO_DATE('2024-02-02 12:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO WEEKREPORT_NO VALUES(WEEKREPORTNOSEQ.NEXTVAL, TO_DATE('2024-02-09 12:00:00', 'YYYY-MM-DD HH24:MI:SS'));
--==> 1 행 이(가) 삽입되었습니다. * 2

--○ 주간업무보고 미작성 테이블 조회
SELECT *
FROM WEEKREPORT_NO;
/*
7	24/04/26
8	24/05/03
*/



--○ 참여확인 테이블 생성
CREATE TABLE PART_CHECK
( PART_CODE            VARCHAR2(20)                         -- 참여확인코드
, PTST_NO               NUMBER   NOT NULL                   -- 팀참여지원번호  
, CONSTRAINT PART_CODE_PK PRIMARY KEY(PART_CODE)            -- 제약조건
);

--○ 참여확인 샘플 데이터 입력
INSERT INTO PART_CHECK(PART_CODE, PTST_NO)
VALUES('이주형', 1);
INSERT INTO PART_CHECK(PART_CODE, PTST_NO)
VALUES('임하성', 1);
INSERT INTO PART_CHECK(PART_CODE, PTST_NO)
VALUES('엄재용', 1);
INSERT INTO PART_CHECK(PART_CODE, PTST_NO)
VALUES('박나영', 1);
INSERT INTO PART_CHECK(PART_CODE, PTST_NO)
VALUES('문정환', 1);
INSERT INTO PART_CHECK(PART_CODE, PTST_NO)
VALUES('오수경', 1);

--○ 참여확인 테이블 조회
SELECT *
FROM PART_CHECK;
/*
이주형	1
임하성	1
엄재용	1
박나영	1
문정환	1
오수경	1
*/



--○ 주간업무보고 미작성 알림 테이블
CREATE TABLE WEEKREPORT_NTF
( WENOREPORT_SID     NUMBER                                    -- 게시물미작성알림번호
, READ_DATE         DATE                                       -- 읽은날짜
, PART_CODE     VARCHAR2(20)                                   -- 참여확인번호
, WEEKREPORTNO_SID  NUMBER                                      -- 주간업무보고미작성번호
, CONSTRAINT WENOREPORT_SID_PK PRIMARY KEY(WENOREPORT_SID)      -- 제약조건
, CONSTRAINT WEEKREPORTNO_SID_FK FOREIGN KEY(WEEKREPORTNO_SID)  -- 제약조건
             REFERENCES WEEKREPORT_NO(WEEKREPORTNO_SID)
, CONSTRAINT PART_CODE_FK FOREIGN KEY(PART_CODE)                -- 제약조건
             REFERENCES PART_CHECK(PART_CODE)
);
--==> Table WEEKREPORT이(가) 생성되었습니다.

--○ 주간업무보고 미작성 알림 시퀀스 생성(WEEKREPORTSEQ)
CREATE SEQUENCE WEEKREPORTSEQ
NOCACHE;
--==> Sequence WEEKREPORTSEQ이(가) 생성되었습니다.

--○ 주간업무보고 미작성 알림 샘플 데이터 입력
INSERT INTO WEEKREPORT_NTF VALUES(WEEKREPORTSEQ.NEXTVAL, TO_DATE('2024-02-02 14:00:00', 'YYYY-MM-DD HH24:MI:SS'), '임하성', 1);
INSERT INTO WEEKREPORT_NTF VALUES(WEEKREPORTSEQ.NEXTVAL, TO_DATE('2024-02-18 09:30:00', 'YYYY-MM-DD HH24:MI:SS'), '이주형', 2);
--==> 1 행 이(가) 삽입되었습니다. * 2

--○ 주간업무보고 미작성 알림 테이블 조회
SELECT *
FROM WEEKREPORT_NTF;
/*
4		문정환	7
5		오수경	7
6		이주형	7
7		엄재용	7
8		임하성	7
9		박나영	7
10		문정환	8
11		오수경	8
12		이주형	8
13		엄재용	8
14		임하성	8
15		박나영	8
*/



--○ 주간업무보고 미작성 알림 테이블
CREATE TABLE WEEKLY_REPORT
( WWR_NO            NUMBER                              -- 주간업무보고번호
, WWR_FILE_ROUTE    VARCHAR2(50)                        -- 첨부파일명
, WWR_NAME          VARCHAR2(30)    NOT NULL            -- 제목
, WWR_CONTENTS      VARCHAR2(100)   NOT NULL            -- 내용
, WWR_DATE          DATE            DEFAULT SYSDATE     -- 작성일
, PART_CODE         VARCHAR(30)     NOT NULL            -- 작성자    
, CONSTRAINT WWR_NO_PK PRIMARY KEY(WWR_NO)
, CONSTRAINT PART_CODES_FK FOREIGN KEY(PART_CODE)                -- 제약조건
             REFERENCES PART_CHECK(PART_CODE)
);
--==> Table WEEKLY_REPORT이(가) 생성되었습니다.

--○ 주간업무보고 미작성 알림 시퀀스 생성(WEEKLY_REPORTSEQ)
CREATE SEQUENCE WEEKLY_REPORTSEQ
NOCACHE;
--==> Sequence WEEKLY_REPORTSEQ이(가) 생성되었습니다.

--○ 주간업무보고 미작성 알림 샘플 데이터 입력
INSERT INTO WEEKLY_REPORT VALUES(WEEKLY_REPORTSEQ.NEXTVAL, '감자', '자바 회의록', '회의록을 써야지', TO_DATE('2024-02-20 14:00:00', 'YYYY-MM-DD HH24:MI:SS'), '임하성');
INSERT INTO WEEKLY_REPORT VALUES(WEEKLY_REPORTSEQ.NEXTVAL, '고구마', '자바 회의록2', '회의록을 수정해야지', TO_DATE('2024-02-18 14:00:00', 'YYYY-MM-DD HH24:MI:SS'), '이주형');
--==> 1 행 이(가) 삽입되었습니다. * 2

--○ 주간업무보고 미작성 알림 테이블 조회
SELECT *
FROM WEEKLY_REPORT;
/*
1	감자	자바 회의록	회의록을 써야지	24/02/20	임하성
2	고구마	자바 회의록2	회의록을 수정해야지	24/02/18	이주형
*/

--○ 뷰 조회
CREATE OR REPLACE VIEW NOT_UNWRT
AS
SELECT PART_CODE
FROM PART_CHECK
WHERE PART_CODE NOT IN (
SELECT PART_CODE
FROM WEEKLY_REPORT
WHERE WWR_DATE BETWEEN TRUNC(SYSDATE) - 4 AND TRUNC(SYSDATE));

--○ 뷰 조회
SELECT * FROM NOT_UNWRT;
/*
문정환
오수경
엄재용
박나영
*/

--○ 커밋
COMMIT;
--==> 커밋 완료.

--○ 프로시저 구성(PRC_WEEKREPORTNO) - COSOR 이용
CREATE OR REPLACE PROCEDURE PRC_WEREPORT_NO
IS
    -- 사용할 변수 설정
    V_PART_CHECK_NAME   WEEKREPORT_NTF.PART_CODE%TYPE;            -- 참여확인 번호 담을 변수
    V_WEEKREPORTNOSEQ   WEEKREPORT_NO.WEEKREPORTNO_SID%TYPE;       -- 생성된 시퀀스 담을 변수
    
    -- 커서 생성
    CURSOR CURS
    IS
    SELECT * FROM NOT_UNWRT;
    
BEGIN
    
    -- 주간업무보고 미작성 등록
    V_WEEKREPORTNOSEQ := WEEKREPORTNOSEQ.NEXTVAL;
    
    INSERT INTO WEEKREPORT_NO VALUES(V_WEEKREPORTNOSEQ, SYSDATE);
    
    OPEN CURS;      -- 커서 오픈
    
    LOOP
        FETCH CURS INTO V_PART_CHECK_NAME;
        EXIT WHEN CURS%NOTFOUND;
        
    INSERT INTO WEEKREPORT_NTF(WENOREPORT_SID, PART_CODE, WEEKREPORTNO_SID) VALUES(WEEKREPORTSEQ.NEXTVAL, V_PART_CHECK_NAME, V_WEEKREPORTNOSEQ);
    
    END LOOP;
    
    CLOSE CURS;     -- CLOSE 커서
    
    COMMIT;
END;
--==> Procedure PRC_TEST이(가) 컴파일되었습니다.

--------------------------------------------------------------------------------
-- 자동화 업무 수행

--A 방법
BEGIN
    DBMS_SCHEDULER.CREATE_JOB
    ( JOB_NAME => 'WEREPORT_JOBS'                                           -- 주간업무보고 미작성 잡
    , START_DATE => TRUNC(SYSDATE) + 13/24                                  -- 오늘(금요일) 오후 1시
    , REPEAT_INTERVAL => 'FREQ=WEEKLY; BYDAY=FRI'                           -- 매주 금요일마다 실행
    , END_DATE => NULL
    , JOB_TYPE => 'PLSQL_BLOCK'
    , JOB_ACTION => 'BEGIN PRC_WEREPORT_NO; END;'                           -- 실제 실행되어야 하는 쿼리문
    , COMMENTS => '금요일에 1번씩 09시에 알림날짜 생성'                      -- 부가설명
    );
    
    DBMS_SCHEDULER.ENABLE('WEREPORT_JOBS');
END;
--==> PL/SQL 프로시저가 성공적으로 완료되었습니다.


--○ 스케줄러 잡 등록 내역 확인
SELECT *
FROM USER_SCHEDULER_JOBS
WHERE JOB_NAME = 'WEREPORT_JOBS';
--==> WEREPORT_JOBS		REGULAR	SCOTT					PLSQL_BLOCK	BEGIN PRC_WEREPORT_NO; END;	0			CALENDAR	24/03/08 13:00:00.000000000 +09:00	FREQ=WEEKLY; BYDAY=FRI									DEFAULT_JOB_CLASS	TRUE	TRUE	FALSE	SCHEDULED	3	3		2		0	24/05/03 13:00:00.114000000 +09:00	+00 00:00:00.015000	24/05/10 13:00:00.100000000 +09:00			OFF	FALSE	TRUE		FALSE	1	NLS_LANGUAGE='KOREAN' NLS_TERRITORY='KOREA' NLS_CURRENCY='￦' NLS_ISO_CURRENCY='KOREA' NLS_NUMERIC_CHARACTERS='.,' NLS_CALENDAR='GREGORIAN' NLS_DATE_FORMAT='YYYY-MM-DD HH24:MI:SS' NLS_DATE_LANGUAGE='KOREAN' NLS_SORT='BINARY' NLS_TIME_FORMAT='HH24:MI:SSXFF' NLS_TIMESTAMP_FORMAT='RR/MM/DD HH24:MI:SSXFF' NLS_TIME_TZ_FORMAT='HH24:MI:SSXFF TZR' NLS_TIMESTAMP_TZ_FORMAT='RR/MM/DD HH24:MI:SSXFF TZR' NLS_DUAL_CURRENCY='￦' NLS_COMP='BINARY' NLS_LENGTH_SEMANTICS='BYTE' NLS_NCHAR_CONV_EXCP='FALSE'		1						FALSE	FALSE	금요일에 1번씩 09시에 알림날짜 생성	133168

--○ 지정한 시간에 스케줄러 잡이 정상적으로 실행되었는지 확인
SELECT *
FROM USER_SCHEDULER_JOB_LOG
WHERE JOB_NAME = 'WEREPORT_JOBS';		
/*
2741	24/05/03 13:00:00.129000000 +09:00	SCOTT	WEREPORT_JOBS		DEFAULT_JOB_CLASS	RUN	SUCCEEDED								
2715	24/04/26 12:59:44.108000000 +09:00	SCOTT	WEREPORT_JOBS		DEFAULT_JOB_CLASS	RUN	FAILED								
2726	24/04/26 13:00:00.104000000 +09:00	SCOTT	WEREPORT_JOBS		DEFAULT_JOB_CLASS	RUN	FAILED								
*/

SELECT *
FROM USER_SCHEDULER_JOB_RUN_DETAILS
WHERE JOB_NAME = 'WEREPORT_JOBS';
/*
2741	24/05/03 13:00:00.129000000 +09:00	SCOTT	WEREPORT_JOBS		SUCCEEDED	0	24/05/03 13:00:00.100000000 +09:00	24/05/03 13:00:00.114000000 +09:00	+00 00:00:00.000000	1	34,123	7000	+00 00:00:00.010000					
2715	24/04/26 12:59:44.108000000 +09:00	SCOTT	WEREPORT_JOBS		FAILED	2291	24/03/15 13:00:00.900000000 +09:00	24/04/26 12:59:44.092000000 +09:00	+00 00:00:00.000000	1	82,67	17828	+00 00:00:00.000000					"ORA-02291: integrity constraint (SCOTT.WEEKREPORTNO_SID_FK) violated - parent key not found
ORA-06512: at "SCOTT.PRC_WEREPORT_NO", line 25
ORA-06512: at line 1
"
2726	24/04/26 13:00:00.104000000 +09:00	SCOTT	WEREPORT_JOBS		FAILED	2291	24/04/26 13:00:00.100000000 +09:00	24/04/26 13:00:00.104000000 +09:00	+00 00:00:00.000000	1	114,7	13096	+00 00:00:00.000000					"ORA-02291: integrity constraint (SCOTT.WEEKREPORTNO_SID_FK) violated - parent key not found
ORA-06512: at "SCOTT.PRC_WEREPORT_NO", line 25
ORA-06512: at line 1
"
*/

--○ 주간업무보고 미작성 테이블 조회
SELECT *
FROM WEEKREPORT_NO;
/*
7	24/04/26
8	24/05/03
*/

--○ 주간업무보고 미작성 알림 테이블 조회
SELECT *
FROM WEEKREPORT_NTF;
/*
4		문정환	7
5		오수경	7
6		이주형	7
7		엄재용	7
8		임하성	7
9		박나영	7
10		문정환	8
11		오수경	8
12		이주형	8
13		엄재용	8
14		임하성	8
15		박나영	8
*/

-----------------------------------------------------------------------------------------------------------------

--※ 테이블 삭제 처리 구문
DROP TABLE WEEKLY_REPORT;
DROP TABLE WEEKREPORT_NTF;
DROP TABLE WEEKREPORT_NO;
DROP TABLE PART_CHECK;

--※ 시퀀스 삭제
DROP SEQUENCE WEEKREPORTNOSEQ;
DROP SEQUENCE WEEKREPORTSEQ;
DROP SEQUENCE WEEKLY_REPORTSEQ;

--※ 프로시저
DROP PROCEDURE PRC_WEREPORT_NO;

--※ 삭제 처리 구문(프로그램 삭제)
EXECUTE DBMS_SCHEDULER.DROP_PROGRAM('WEEKREPORTNO_PRG', FALSE);
--※ 삭제 처리 구문(스케줄러 삭제)
EXECUTE DBMS_SCHEDULER.DROP_SCHEDULE('SCHEDULE_WEEKREPORTNO', FALSE);
--※ 삭제 처리 구문(잡 삭제)
EXECUTE DBMS_SCHEDULER.DROP_JOB('WEREPORT_JOBS', FALSE);