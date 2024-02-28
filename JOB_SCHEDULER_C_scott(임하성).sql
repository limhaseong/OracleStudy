SELECT USER
FROM DUAL;
--==> SCOTT

--�� FINAL PROJECT �Ϻ� ���̺� ���ø�(�ְ���������, �ְ��������� ���ۼ� �˸�, �ְ��������� ���ۼ�)

ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS';
--==> Session��(��) ����Ǿ����ϴ�.
SET SERVEROUTPUT ON;

--�� �ְ��������� ���ۼ� ���̺�
CREATE TABLE WEEKREPORT_NO
( WEEKREPORTNO_SID  NUMBER                                          -- �ְ��������� ���ۼ���ȣ    
, BECOMING_DATE       DATE                                          -- ���� ����
, CONSTRAINT WEEKREPORTNO_SID_PK PRIMARY KEY(WEEKREPORTNO_SID)      -- ��������
);
--==> Table WEEKREPORTNO��(��) �����Ǿ����ϴ�.

--�� �ְ��������� ���ۼ� ������ ����(WEEKREPORTNOSEQ)
CREATE SEQUENCE WEEKREPORTNOSEQ
NOCACHE;
--==> Sequence WEEKREPORTNOSEQ��(��) �����Ǿ����ϴ�.

--�� �ְ��������� ���ۼ� ���� ������ �Է�
INSERT INTO WEEKREPORT_NO VALUES(WEEKREPORTNOSEQ.NEXTVAL, TO_DATE('2024-02-02 12:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO WEEKREPORT_NO VALUES(WEEKREPORTNOSEQ.NEXTVAL, TO_DATE('2024-02-09 12:00:00', 'YYYY-MM-DD HH24:MI:SS'));
--==> 1 �� ��(��) ���ԵǾ����ϴ�. * 2

--�� �ְ��������� ���ۼ� ���̺� ��ȸ
SELECT *
FROM WEEKREPORT_NO;
/*
7	24/04/26
8	24/05/03
*/



--�� ����Ȯ�� ���̺� ����
CREATE TABLE PART_CHECK
( PART_CODE            VARCHAR2(20)                         -- ����Ȯ���ڵ�
, PTST_NO               NUMBER   NOT NULL                   -- ������������ȣ  
, CONSTRAINT PART_CODE_PK PRIMARY KEY(PART_CODE)            -- ��������
);

--�� ����Ȯ�� ���� ������ �Է�
INSERT INTO PART_CHECK(PART_CODE, PTST_NO)
VALUES('������', 1);
INSERT INTO PART_CHECK(PART_CODE, PTST_NO)
VALUES('���ϼ�', 1);
INSERT INTO PART_CHECK(PART_CODE, PTST_NO)
VALUES('�����', 1);
INSERT INTO PART_CHECK(PART_CODE, PTST_NO)
VALUES('�ڳ���', 1);
INSERT INTO PART_CHECK(PART_CODE, PTST_NO)
VALUES('����ȯ', 1);
INSERT INTO PART_CHECK(PART_CODE, PTST_NO)
VALUES('������', 1);

--�� ����Ȯ�� ���̺� ��ȸ
SELECT *
FROM PART_CHECK;
/*
������	1
���ϼ�	1
�����	1
�ڳ���	1
����ȯ	1
������	1
*/



--�� �ְ��������� ���ۼ� �˸� ���̺�
CREATE TABLE WEEKREPORT_NTF
( WENOREPORT_SID     NUMBER                                    -- �Խù����ۼ��˸���ȣ
, READ_DATE         DATE                                       -- ������¥
, PART_CODE     VARCHAR2(20)                                   -- ����Ȯ�ι�ȣ
, WEEKREPORTNO_SID  NUMBER                                      -- �ְ�����������ۼ���ȣ
, CONSTRAINT WENOREPORT_SID_PK PRIMARY KEY(WENOREPORT_SID)      -- ��������
, CONSTRAINT WEEKREPORTNO_SID_FK FOREIGN KEY(WEEKREPORTNO_SID)  -- ��������
             REFERENCES WEEKREPORT_NO(WEEKREPORTNO_SID)
, CONSTRAINT PART_CODE_FK FOREIGN KEY(PART_CODE)                -- ��������
             REFERENCES PART_CHECK(PART_CODE)
);
--==> Table WEEKREPORT��(��) �����Ǿ����ϴ�.

--�� �ְ��������� ���ۼ� �˸� ������ ����(WEEKREPORTSEQ)
CREATE SEQUENCE WEEKREPORTSEQ
NOCACHE;
--==> Sequence WEEKREPORTSEQ��(��) �����Ǿ����ϴ�.

--�� �ְ��������� ���ۼ� �˸� ���� ������ �Է�
INSERT INTO WEEKREPORT_NTF VALUES(WEEKREPORTSEQ.NEXTVAL, TO_DATE('2024-02-02 14:00:00', 'YYYY-MM-DD HH24:MI:SS'), '���ϼ�', 1);
INSERT INTO WEEKREPORT_NTF VALUES(WEEKREPORTSEQ.NEXTVAL, TO_DATE('2024-02-18 09:30:00', 'YYYY-MM-DD HH24:MI:SS'), '������', 2);
--==> 1 �� ��(��) ���ԵǾ����ϴ�. * 2

--�� �ְ��������� ���ۼ� �˸� ���̺� ��ȸ
SELECT *
FROM WEEKREPORT_NTF;
/*
4		����ȯ	7
5		������	7
6		������	7
7		�����	7
8		���ϼ�	7
9		�ڳ���	7
10		����ȯ	8
11		������	8
12		������	8
13		�����	8
14		���ϼ�	8
15		�ڳ���	8
*/



--�� �ְ��������� ���ۼ� �˸� ���̺�
CREATE TABLE WEEKLY_REPORT
( WWR_NO            NUMBER                              -- �ְ����������ȣ
, WWR_FILE_ROUTE    VARCHAR2(50)                        -- ÷�����ϸ�
, WWR_NAME          VARCHAR2(30)    NOT NULL            -- ����
, WWR_CONTENTS      VARCHAR2(100)   NOT NULL            -- ����
, WWR_DATE          DATE            DEFAULT SYSDATE     -- �ۼ���
, PART_CODE         VARCHAR(30)     NOT NULL            -- �ۼ���    
, CONSTRAINT WWR_NO_PK PRIMARY KEY(WWR_NO)
, CONSTRAINT PART_CODES_FK FOREIGN KEY(PART_CODE)                -- ��������
             REFERENCES PART_CHECK(PART_CODE)
);
--==> Table WEEKLY_REPORT��(��) �����Ǿ����ϴ�.

--�� �ְ��������� ���ۼ� �˸� ������ ����(WEEKLY_REPORTSEQ)
CREATE SEQUENCE WEEKLY_REPORTSEQ
NOCACHE;
--==> Sequence WEEKLY_REPORTSEQ��(��) �����Ǿ����ϴ�.

--�� �ְ��������� ���ۼ� �˸� ���� ������ �Է�
INSERT INTO WEEKLY_REPORT VALUES(WEEKLY_REPORTSEQ.NEXTVAL, '����', '�ڹ� ȸ�Ƿ�', 'ȸ�Ƿ��� �����', TO_DATE('2024-02-20 14:00:00', 'YYYY-MM-DD HH24:MI:SS'), '���ϼ�');
INSERT INTO WEEKLY_REPORT VALUES(WEEKLY_REPORTSEQ.NEXTVAL, '����', '�ڹ� ȸ�Ƿ�2', 'ȸ�Ƿ��� �����ؾ���', TO_DATE('2024-02-18 14:00:00', 'YYYY-MM-DD HH24:MI:SS'), '������');
--==> 1 �� ��(��) ���ԵǾ����ϴ�. * 2

--�� �ְ��������� ���ۼ� �˸� ���̺� ��ȸ
SELECT *
FROM WEEKLY_REPORT;
/*
1	����	�ڹ� ȸ�Ƿ�	ȸ�Ƿ��� �����	24/02/20	���ϼ�
2	����	�ڹ� ȸ�Ƿ�2	ȸ�Ƿ��� �����ؾ���	24/02/18	������
*/

--�� �� ��ȸ
CREATE OR REPLACE VIEW NOT_UNWRT
AS
SELECT PART_CODE
FROM PART_CHECK
WHERE PART_CODE NOT IN (
SELECT PART_CODE
FROM WEEKLY_REPORT
WHERE WWR_DATE BETWEEN TRUNC(SYSDATE) - 4 AND TRUNC(SYSDATE));

--�� �� ��ȸ
SELECT * FROM NOT_UNWRT;
/*
����ȯ
������
�����
�ڳ���
*/

--�� Ŀ��
COMMIT;
--==> Ŀ�� �Ϸ�.

--�� ���ν��� ����(PRC_WEEKREPORTNO) - COSOR �̿�
CREATE OR REPLACE PROCEDURE PRC_WEREPORT_NO
IS
    -- ����� ���� ����
    V_PART_CHECK_NAME   WEEKREPORT_NTF.PART_CODE%TYPE;            -- ����Ȯ�� ��ȣ ���� ����
    V_WEEKREPORTNOSEQ   WEEKREPORT_NO.WEEKREPORTNO_SID%TYPE;       -- ������ ������ ���� ����
    
    -- Ŀ�� ����
    CURSOR CURS
    IS
    SELECT * FROM NOT_UNWRT;
    
BEGIN
    
    -- �ְ��������� ���ۼ� ���
    V_WEEKREPORTNOSEQ := WEEKREPORTNOSEQ.NEXTVAL;
    
    INSERT INTO WEEKREPORT_NO VALUES(V_WEEKREPORTNOSEQ, SYSDATE);
    
    OPEN CURS;      -- Ŀ�� ����
    
    LOOP
        FETCH CURS INTO V_PART_CHECK_NAME;
        EXIT WHEN CURS%NOTFOUND;
        
    INSERT INTO WEEKREPORT_NTF(WENOREPORT_SID, PART_CODE, WEEKREPORTNO_SID) VALUES(WEEKREPORTSEQ.NEXTVAL, V_PART_CHECK_NAME, V_WEEKREPORTNOSEQ);
    
    END LOOP;
    
    CLOSE CURS;     -- CLOSE Ŀ��
    
    COMMIT;
END;
--==> Procedure PRC_TEST��(��) �����ϵǾ����ϴ�.

--------------------------------------------------------------------------------
-- �ڵ�ȭ ���� ����

--A ���
BEGIN
    DBMS_SCHEDULER.CREATE_JOB
    ( JOB_NAME => 'WEREPORT_JOBS'                                           -- �ְ��������� ���ۼ� ��
    , START_DATE => TRUNC(SYSDATE) + 13/24                                  -- ����(�ݿ���) ���� 1��
    , REPEAT_INTERVAL => 'FREQ=WEEKLY; BYDAY=FRI'                           -- ���� �ݿ��ϸ��� ����
    , END_DATE => NULL
    , JOB_TYPE => 'PLSQL_BLOCK'
    , JOB_ACTION => 'BEGIN PRC_WEREPORT_NO; END;'                           -- ���� ����Ǿ�� �ϴ� ������
    , COMMENTS => '�ݿ��Ͽ� 1���� 09�ÿ� �˸���¥ ����'                      -- �ΰ�����
    );
    
    DBMS_SCHEDULER.ENABLE('WEREPORT_JOBS');
END;
--==> PL/SQL ���ν����� ���������� �Ϸ�Ǿ����ϴ�.


--�� �����ٷ� �� ��� ���� Ȯ��
SELECT *
FROM USER_SCHEDULER_JOBS
WHERE JOB_NAME = 'WEREPORT_JOBS';
--==> WEREPORT_JOBS		REGULAR	SCOTT					PLSQL_BLOCK	BEGIN PRC_WEREPORT_NO; END;	0			CALENDAR	24/03/08 13:00:00.000000000 +09:00	FREQ=WEEKLY; BYDAY=FRI									DEFAULT_JOB_CLASS	TRUE	TRUE	FALSE	SCHEDULED	3	3		2		0	24/05/03 13:00:00.114000000 +09:00	+00 00:00:00.015000	24/05/10 13:00:00.100000000 +09:00			OFF	FALSE	TRUE		FALSE	1	NLS_LANGUAGE='KOREAN' NLS_TERRITORY='KOREA' NLS_CURRENCY='��' NLS_ISO_CURRENCY='KOREA' NLS_NUMERIC_CHARACTERS='.,' NLS_CALENDAR='GREGORIAN' NLS_DATE_FORMAT='YYYY-MM-DD HH24:MI:SS' NLS_DATE_LANGUAGE='KOREAN' NLS_SORT='BINARY' NLS_TIME_FORMAT='HH24:MI:SSXFF' NLS_TIMESTAMP_FORMAT='RR/MM/DD HH24:MI:SSXFF' NLS_TIME_TZ_FORMAT='HH24:MI:SSXFF TZR' NLS_TIMESTAMP_TZ_FORMAT='RR/MM/DD HH24:MI:SSXFF TZR' NLS_DUAL_CURRENCY='��' NLS_COMP='BINARY' NLS_LENGTH_SEMANTICS='BYTE' NLS_NCHAR_CONV_EXCP='FALSE'		1						FALSE	FALSE	�ݿ��Ͽ� 1���� 09�ÿ� �˸���¥ ����	133168

--�� ������ �ð��� �����ٷ� ���� ���������� ����Ǿ����� Ȯ��
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

--�� �ְ��������� ���ۼ� ���̺� ��ȸ
SELECT *
FROM WEEKREPORT_NO;
/*
7	24/04/26
8	24/05/03
*/

--�� �ְ��������� ���ۼ� �˸� ���̺� ��ȸ
SELECT *
FROM WEEKREPORT_NTF;
/*
4		����ȯ	7
5		������	7
6		������	7
7		�����	7
8		���ϼ�	7
9		�ڳ���	7
10		����ȯ	8
11		������	8
12		������	8
13		�����	8
14		���ϼ�	8
15		�ڳ���	8
*/

-----------------------------------------------------------------------------------------------------------------

--�� ���̺� ���� ó�� ����
DROP TABLE WEEKLY_REPORT;
DROP TABLE WEEKREPORT_NTF;
DROP TABLE WEEKREPORT_NO;
DROP TABLE PART_CHECK;

--�� ������ ����
DROP SEQUENCE WEEKREPORTNOSEQ;
DROP SEQUENCE WEEKREPORTSEQ;
DROP SEQUENCE WEEKLY_REPORTSEQ;

--�� ���ν���
DROP PROCEDURE PRC_WEREPORT_NO;

--�� ���� ó�� ����(���α׷� ����)
EXECUTE DBMS_SCHEDULER.DROP_PROGRAM('WEEKREPORTNO_PRG', FALSE);
--�� ���� ó�� ����(�����ٷ� ����)
EXECUTE DBMS_SCHEDULER.DROP_SCHEDULE('SCHEDULE_WEEKREPORTNO', FALSE);
--�� ���� ó�� ����(�� ����)
EXECUTE DBMS_SCHEDULER.DROP_JOB('WEREPORT_JOBS', FALSE);