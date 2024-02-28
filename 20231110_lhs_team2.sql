--���� ���� ���̺� ���� ����--
CREATE TABLE SUBJECTS
( SUB_CODE VARCHAR2(20) 
, SUB_NAME VARCHAR2(30)  CONSTRAINT SUB_NAME_NN NOT NULL
, CONSTRAINT SUBJECTS_SUB_CODE_PK PRIMARY KEY(SUB_CODE)
);


--���� ���ǽ� ���̺� ���� ����--
CREATE TABLE CLASSROOMS
( ROOM_CODE         VARCHAR2(20)
, ROOM_NAME         VARCHAR2(20)  CONSTRAINT CLASSROOMS_NAME_NN NOT NULL
, ROOM_EXPLANATION  VARCHAR2(100)
, CONSTRAINT CLASSROOMS_CODE_PK PRIMARY KEY(ROOM_CODE)
);


--���� ���� ���̺� ���� ����--
CREATE TABLE COURSES
( CRS_CODE  VARCHAR2(20)    
, CRS_NAME  VARCHAR2(100)    CONSTRAINT CRS_NAME_NN NOT NULL
, CONSTRAINT COURSES_CRS_CODE_PK PRIMARY KEY(CRS_CODE)
);


--���� ���� ���̺� ���� ����--
CREATE TABLE BOOKS
( BK_CODE           VARCHAR2(20)
, BK_NAME           VARCHAR2(100)    CONSTRAINT BOOKS_BK_NAME_NN NOT NULL
, BK_PRICE          NUMBER(6)        CONSTRAINT BOOKS_BK_PRICE_NN NOT NULL
, BK_EXPLANATION    VARCHAR2(100)
, CONSTRAINT BOOKS_BK_CODE_PK PRIMARY KEY(BK_CODE)
);


--���� �ߵ�Ż������ ���̺� ���� ����--
CREATE TABLE DROP_REASONS
( DO_REASON_CODE           VARCHAR2(20)
, DO_REASON                VARCHAR2(50)     CONSTRAINT REASONS_DO_REASON_NN NOT NULL
, CONSTRAINT REASON_DO_REASON_CODE_PK PRIMARY KEY(DO_REASON_CODE)
);


--���� ���� ���̺� ���� ����--
CREATE TABLE PROFESSORS
( PF_CODE   VARCHAR2(20)    
, PF_ID     VARCHAR2(20)    CONSTRAINT PF_ID_NN NOT NULL
, PF_PW     VARCHAR2(20)    CONSTRAINT PF_PW_NN NOT NULL
, PF_NAME   VARCHAR2(20)    CONSTRAINT PF_NAME_NN NOT NULL
, PF_SSN    VARCHAR(14)     CONSTRAINT PF_SSN_NN NOT NULL
, PF_DATE   DATE            DEFAULT SYSDATE
, CONSTRAINT PROFESSORS_PF_CODE_PK PRIMARY KEY(PF_CODE)
, CONSTRAINT PROFESSORS_PF_ID_UK UNIQUE(PF_ID)
, CONSTRAINT PROFESSORS_PF_PW_UK CHECK (LENGTH(PF_PW) >= 7 AND LENGTH(PF_PW) <= 20)
);


--���� ������ ���̺� ���� ����--
CREATE TABLE ADMINS
( AD_CODE   VARCHAR2(20)    
, AD_ID     VARCHAR2(20)    CONSTRAINT AD_ID_NN NOT NULL
, AD_PW     VARCHAR2(20)    CONSTRAINT AD_PW_NN NOT NULL
, AD_DATE   DATE            DEFAULT SYSDATE
, CONSTRAINT ADMINS_AD_CODE_PK PRIMARY KEY(AD_CODE)
, CONSTRAINT ADMINS_AD_ID_UK   UNIQUE(AD_ID)
, CONSTRAINT ADMINS_AD_PW_UK CHECK (LENGTH(AD_PW) >= 7 AND LENGTH(AD_PW) <= 20) 
);


--���� �л� ���̺� ���� ����--
CREATE TABLE STUDENTS
( ST_CODE  VARCHAR2(20)
, ST_ID    VARCHAR2(20) CONSTRAINT ST_ID_NN NOT NULL
, ST_PW    VARCHAR2(20) CONSTRAINT ST_PW_NN NOT NULL
, ST_NAME  VARCHAR2(20) CONSTRAINT ST_NAME_NN NOT NULL
, ST_SSN   VARCHAR(14)  CONSTRAINT ST_SSN_NN NOT NULL
, ST_DATE  DATE         DEFAULT SYSDATE
, CONSTRAINT STUDENTS_ST_CODE_PK PRIMARY KEY(ST_CODE)
, CONSTRAINT STUDENTS_ST_ID_UK  UNIQUE(ST_ID)
, CONSTRAINT STUDENTS_ST_PW_CK CHECK (LENGTH(ST_PW) >= 7 AND LENGTH(ST_PW) <= 20)
);


--���� �������� ���̺����� ����--
CREATE TABLE OPEN_COURSES
( OCRS_CODE         VARCHAR2(20)
, CRS_CODE          VARCHAR2(20)
, PF_CODE             VARCHAR2(20)
, ROOM_CODE         VARCHAR2(20)
, START_DATE        DATE    CONSTRAINT COURSES_START_DATE_NN NOT NULL
, END_DATE          DATE    CONSTRAINT COURSES_END_DATE_NN NOT NULL
, CONSTRAINT OCRS_OCRS_CODE_PK PRIMARY KEY(OCRS_CODE)
, CONSTRAINT OCRS_CRS_CODE_FK FOREIGN KEY(CRS_CODE) REFERENCES COURSES(CRS_CODE)
, CONSTRAINT OCRS_PF_ID_FK FOREIGN KEY(PF_CODE) REFERENCES PROFESSORS(PF_CODE)
, CONSTRAINT OCRS_ROOM_CODE_FK FOREIGN KEY(ROOM_CODE) REFERENCES CLASSROOMS(ROOM_CODE)
);


--���� ������û ���̺����� ����--
CREATE TABLE COURSE_REGISTRATIONS
( REG_CODE          VARCHAR2(20)
, ST_CODE           VARCHAR2(20)
, OCRS_CODE         VARCHAR2(20)
, REG_DATE          DATE        DEFAULT SYSDATE
, CONSTRAINT COURSE_REG_REG_CODE_PK PRIMARY KEY(REG_CODE)

, CONSTRAINT COURSE_REG_ST_CODE_FK  FOREIGN KEY(ST_CODE)
        REFERENCES STUDENTS(ST_CODE)
        
, CONSTRAINT COURSE_REG_OCRS_CODE_FK  FOREIGN KEY(OCRS_CODE)
        REFERENCES OPEN_COURSES(OCRS_CODE)
);


--���� �ߵ�Ż�� ���̺����� ����--
CREATE TABLE DROP_OUT_LISTS
( DO_CODE           VARCHAR2(20)   
, REG_CODE          VARCHAR2(20) 
, DO_REASON_CODE    VARCHAR2(20) 
, DO_DATE           DATE DEFAULT SYSDATE
, CONSTRAINT DO_LISTS_DO_CODE_PK PRIMARY KEY(DO_CODE)
, CONSTRAINT DO_LISTS_REG_CODE_FK FOREIGN KEY(REG_CODE)
                REFERENCES COURSE_REGISTRATIONS(REG_CODE)
, CONSTRAINT DO_LISTS_DO_REASON_CODE_FK FOREIGN KEY(DO_REASON_CODE)
                REFERENCES DROP_REASONS(DO_REASON_CODE)
);


--���� �������� ���̺����� ����--
CREATE TABLE OPEN_SUBJECTS
( OSUB_CODE             VARCHAR(20)
, OCRS_CODE             VARCHAR(20)
, SUB_CODE              VARCHAR(20) 
, BK_CODE               VARCHAR(20)
, SUB_START_DATE        DATE        CONSTRAINT OPEN_SUBJECTS_SSD_NN NOT NULL
, SUB_END_DATE          DATE        CONSTRAINT OPEN_SUBJECTS_SED_NN NOT NULL
, ATTENDANCE_SCORE      NUMBER(3)   CONSTRAINT OPEN_SUBJECTS_AS_NN NOT NULL
, WRITTEN_SCORE         NUMBER(3)   CONSTRAINT OPEN_SUBJECTS_WS_NN NOT NULL
, PRACTICAL_SCORE       NUMBER(3)   CONSTRAINT OPEN_SUBJECTS_PS_NN NOT NULL
, CONSTRAINT OPEN_SUBJECTS_OSUB_CODE_PK PRIMARY KEY(OSUB_CODE)
, CONSTRAINT ATTENDANCE_SCORE CHECK(ATTENDANCE_SCORE BETWEEN 0 AND 100)
, CONSTRAINT WRITTEN_SCORE CHECK(WRITTEN_SCORE BETWEEN 0 AND 100)
, CONSTRAINT PRACTICAL_SCORE CHECK(PRACTICAL_SCORE BETWEEN 0 AND 100)
, CONSTRAINT OCRS_CODE_FK FOREIGN KEY(OCRS_CODE) REFERENCES OPEN_COURSES(OCRS_CODE)
, CONSTRAINT SUB_CODE_FK FOREIGN KEY(SUB_CODE) REFERENCES SUBJECTS(SUB_CODE)
, CONSTRAINT BK_CODE_FK FOREIGN KEY(BK_CODE) REFERENCES BOOKS(BK_CODE)
);


--���� ���� ���̺� ���� ����--
CREATE TABLE SCORES
( SCORE_CODE            VARCHAR2(20)
, REG_CODE              VARCHAR2(20)
, OSUB_CODE             VARCHAR2(20)
, ATTENDANCE_SCORE      NUMBER(3)   CONSTRAINT ATTENDANCE_SCORE_NN NOT NULL
, WRITTEN_SCORE         NUMBER(3)   CONSTRAINT WRITTEN_SCORE_NN NOT NULL
, PRACTICAL_SCORE       NUMBER(3)   CONSTRAINT PRACTICAL_SCORE_NN NOT NULL
, TEST_DATE             DATE        CONSTRAINT TEST_DATE_NN NOT NULL
, CONSTRAINT SCORES_SCORE_CODE_PK PRIMARY KEY(SCORE_CODE)
, CONSTRAINT SCORES_REG_CODE_FK FOREIGN KEY(REG_CODE)
             REFERENCES COURSE_REGISTRATIONS(REG_CODE)
, CONSTRAINT SCORES_OSUB_CODE_FK FOREIGN KEY(OSUB_CODE)
             REFERENCES OPEN_SUBJECTS(OSUB_CODE)
, CONSTRAINT SCORES_ATTENDANCE_SCORE_CK CHECK (ATTENDANCE_SCORE BETWEEN 0 AND 100)
, CONSTRAINT SCORES_WRITTEN_SCORE_CK CHECK (WRITTEN_SCORE BETWEEN 0 AND 100)
, CONSTRAINT SCORES_PRACTICAL_SCORE_CK CHECK (PRACTICAL_SCORE BETWEEN 0 AND 100)
);

-- Ȯ��
SELECT *
FROM TAB;

DESC STUDENTS;

SELECT *
FROM USER_CONSTRAINTS
WHERE TABLE_NAME = 'STUDENTS';

SELECT *
FROM PROFESSORS;

--���� �л� ������ �Է� ����--
INSERT INTO STUDENTS(ST_CODE, ST_ID, ST_PW, ST_NAME, ST_SSN)
VALUES('ST001', 'MOON', '1022432', '������', '071212-1022432');

INSERT INTO STUDENTS(ST_CODE, ST_ID, ST_PW, ST_NAME, ST_SSN)
VALUES('ST002', 'OHOH', '1544236', '����ȯ', '901007-1544236');

INSERT INTO STUDENTS(ST_CODE, ST_ID, ST_PW, ST_NAME, ST_SSN)
VALUES('ST003', 'KIM', '1788896', '����', '990304-1788896');

INSERT INTO STUDENTS(ST_CODE, ST_ID, ST_PW, ST_NAME, ST_SSN)
VALUES('ST004', 'BON', '1566789', '�ź���', '811112-1566789');

INSERT INTO STUDENTS(ST_CODE, ST_ID, ST_PW, ST_NAME, ST_SSN)
VALUES('ST005', 'SOOOYEON', '2312547', '���ҿ�', '970922-2312547');

INSERT INTO STUDENTS(ST_CODE, ST_ID, ST_PW, ST_NAME, ST_SSN)
VALUES('ST006', 'MINA', '2978541', '�̹ξ�', '980505-2978541');

INSERT INTO STUDENTS(ST_CODE, ST_ID, ST_PW, ST_NAME, ST_SSN)
VALUES('ST007', 'JANG', '2362514', '�彽��', '921011-2362514');

INSERT INTO STUDENTS(ST_CODE, ST_ID, ST_PW, ST_NAME, ST_SSN)
VALUES('ST008', 'SONNY', '1552147', '�����', '990810-1552147');

INSERT INTO STUDENTS(ST_CODE, ST_ID, ST_PW, ST_NAME, ST_SSN)
VALUES('ST009', 'HWANG', '1122233', 'Ȳ����', '951010-1122233');

INSERT INTO STUDENTS(ST_CODE, ST_ID, ST_PW, ST_NAME, ST_SSN)
VALUES('ST010', 'EUNBIN', '2574812', '������', '010707-2574812');

INSERT INTO STUDENTS(ST_CODE, ST_ID, ST_PW, ST_NAME, ST_SSN)
VALUES('ST011', 'JINI', '2020202', 'Ȳ����', '800301-2020202');

INSERT INTO STUDENTS(ST_CODE, ST_ID, ST_PW, ST_NAME, ST_SSN)
VALUES('ST012', 'KIMMINA', '2777777', '��̳�', '790102-2777777');


--���� ���� ������ �Է� ����--
INSERT INTO PROFESSORS(PF_CODE, PF_ID, PF_PW, PF_NAME, PF_SSN, PF_DATE)
VALUES('PF001', 'MANGGOM', '1684233', '������', '781110-1684233', SYSDATE);

INSERT INTO PROFESSORS(PF_CODE, PF_ID, PF_PW, PF_NAME, PF_SSN, PF_DATE)
VALUES('PF002', 'PEACH', '2491530', '����ġ', '670621-2491530', SYSDATE);

INSERT INTO PROFESSORS(PF_CODE, PF_ID, PF_PW, PF_NAME, PF_SSN, PF_DATE)
VALUES('PF003', 'CHUNSIK','1125762', '�����', '830213-1125762', SYSDATE);

INSERT INTO PROFESSORS(PF_CODE, PF_ID, PF_PW, PF_NAME, PF_SSN, PF_DATE)
VALUES('PF004', 'RYAN', '1254873', '���̾�', '730230-1254873', SYSDATE);

INSERT INTO PROFESSORS(PF_CODE, PF_ID, PF_PW, PF_NAME, PF_SSN, PF_DATE)
VALUES('PF005', 'JAYJ', '1456324', '������', '690324-1456324', SYSDATE);

INSERT INTO PROFESSORS(PF_CODE, PF_ID, PF_PW, PF_NAME, PF_SSN, PF_DATE)
VALUES('PF006', 'CHU', '2678431', '��ī��', '810903-2678431', SYSDATE);

INSERT INTO PROFESSORS(PF_CODE, PF_ID, PF_PW, PF_NAME, PF_SSN, PF_DATE)
VALUES('PF007', 'DANG', '2348154', '��Ҽ�', '880129-2348154', SYSDATE);


--���� ������ ������ �Է� ����--
INSERT INTO ADMINS(AD_CODE, AD_ID, AD_PW, AD_DATE)
VALUES('AD001', 'HYEIN', 'java001', SYSDATE);

INSERT INTO ADMINS(AD_CODE, AD_ID, AD_PW, AD_DATE)
VALUES('AD002', 'MINJI', 'java002', SYSDATE);

INSERT INTO ADMINS(AD_CODE, AD_ID, AD_PW, AD_DATE)
VALUES('AD003', 'JUHYUNG', 'java003', SYSDATE);

INSERT INTO ADMINS(AD_CODE, AD_ID, AD_PW, AD_DATE)
VALUES('AD004', 'DONGMIN', 'java004', SYSDATE);

INSERT INTO ADMINS(AD_CODE, AD_ID, AD_PW, AD_DATE)
VALUES('AD005', 'HASEONG', 'java005', SYSDATE);

INSERT INTO ADMINS(AD_CODE, AD_ID, AD_PW, AD_DATE)
VALUES('AD006', 'HANUL', 'java006', SYSDATE);


--���� ���� ������ �Է� ����--
INSERT INTO SUBJECTS(SUB_CODE , SUB_NAME)
VALUES ('SB001', 'Java');

INSERT INTO SUBJECTS(SUB_CODE , SUB_NAME)
VALUES ('SB002', 'Oracle');

INSERT INTO SUBJECTS(SUB_CODE , SUB_NAME)
VALUES ('SB003', 'JavaScript');

INSERT INTO SUBJECTS(SUB_CODE , SUB_NAME)
VALUES ('SB004', 'JSP');

INSERT INTO SUBJECTS(SUB_CODE , SUB_NAME)
VALUES ('SB005', 'HTML');

INSERT INTO SUBJECTS(SUB_CODE , SUB_NAME)
VALUES ('SB006', 'CSS');

INSERT INTO SUBJECTS(SUB_CODE , SUB_NAME)
VALUES ('SB007', 'Python');

INSERT INTO SUBJECTS(SUB_CODE , SUB_NAME)
VALUES ('SB008', 'Spring Framework');

INSERT INTO SUBJECTS(SUB_CODE , SUB_NAME)
VALUES ('SB009', 'C++');



--���� �ߵ�Ż������ ������ �Է� ����--
INSERT INTO DROP_REASONS (DO_REASON_CODE, DO_REASON)
VALUES('DR001', '����');

INSERT INTO DROP_REASONS (DO_REASON_CODE, DO_REASON)
VALUES('DR002', '������');

INSERT INTO DROP_REASONS (DO_REASON_CODE, DO_REASON)
VALUES('DR003', '�ؿ��ⱹ');

INSERT INTO DROP_REASONS (DO_REASON_CODE, DO_REASON)
VALUES('DR004', '�� �Դ�');

INSERT INTO DROP_REASONS (DO_REASON_CODE, DO_REASON)
VALUES('DR005', '����');

--���� ���� ������ �Է� ����--
INSERT INTO COURSES(CRS_CODE , CRS_NAME)
VALUES ('CO001','Java�� Ȱ���� Full-Stack������ �缺����');

INSERT INTO COURSES(CRS_CODE , CRS_NAME)
VALUES ('CO002','�ڹٿ� ������ ��� ������ Full-stack ������ �缺����');

INSERT INTO COURSES(CRS_CODE , CRS_NAME)
VALUES ('CO003','Java(�ڹ�)�׸��� AWS Ȱ���� Full-Stack ������ �缺����');

INSERT INTO COURSES(CRS_CODE , CRS_NAME)
VALUES ('CO004','�ڹ�(Java)��� Web �̿��� ����Ʈ�÷��� Full-Stack ������ �缺����');


--���� ���� ������ �Է� ����--
INSERT INTO BOOKS (BK_CODE, BK_NAME, BK_PRICE, BK_EXPLANATION)
VALUES ('BK001', 'Do it! ���� �� ���̽�', '19800', '���л��� ù������ �ǽ��ϴ� �ʰ��� �Թ���');

INSERT INTO BOOKS (BK_CODE, BK_NAME, BK_PRICE, BK_EXPLANATION)
VALUES ('BK002', 'AWS ������', '34200', '���� ������ �ǽ� ������ �Ǽ� �ְ� ������ AWS �Թ���!');

INSERT INTO BOOKS (BK_CODE, BK_NAME, BK_PRICE, BK_EXPLANATION)
VALUES ('BK003', '���� ������ ��Ʈ', '36000', '�⺻ ������� �ǹ� ����Ʈ ����Ƽ��, �׸��� GraalVM, GraphQL, R����');

INSERT INTO BOOKS (BK_CODE, BK_NAME, BK_PRICE, BK_EXPLANATION)
VALUES ('BK004', '���� �ذ��� ���� �˰����� with ����', '37800', '�˰����� ���� �ذῡ �� �ʿ��� ������ ���İ� �����');

INSERT INTO BOOKS (BK_CODE, BK_NAME, BK_PRICE, BK_EXPLANATION)
VALUES ('BK005', '����Ŭ�� ����', '27000', '�� ������ ������ ����Ŭ �⺻ ������');

INSERT INTO BOOKS (BK_CODE, BK_NAME, BK_PRICE, BK_EXPLANATION)
VALUES ('BK006', '�̰��� ����� ���� �ڵ� �׽�Ʈ�� with �ڹ�', '30600', '����� ������ �����ϴ� �˰����� ���ͺ� �Ϻ�');

INSERT INTO BOOKS (BK_CODE, BK_NAME, BK_PRICE, BK_EXPLANATION)
VALUES ('BK007', '������Ƽ�� ������', '39600', '���ʺ��� �����, ������ ���� ������Ƽ�� ����!');

INSERT INTO BOOKS (BK_CODE, BK_NAME, BK_PRICE, BK_EXPLANATION)
VALUES ('BK008', 'Must Have �������� JSP �ڹ� �� ���α׷���', '27000', ' JSP�������� ���ʺ��� źź�ϰ�');

INSERT INTO BOOKS (BK_CODE, BK_NAME, BK_PRICE, BK_EXPLANATION)
VALUES ('BK009', '������ ���� �ڹٽ�ũ��Ʈ', '25200', '�ܰ躰 300���� �����ϴ� �ڹٽ�ũ��Ʈ');

INSERT INTO BOOKS (BK_CODE, BK_NAME, BK_PRICE, BK_EXPLANATION)
VALUES ('BK010', '�ϼ��� ������Ʈ�� ���� HTML�� CSS �� ������', '19800', '5�� ������ ���� ȿ������ ������Ʈ ���� ���Ͽ�');

INSERT INTO BOOKS (BK_CODE, BK_NAME, BK_PRICE, BK_EXPLANATION)
VALUES ('BK011', 'C++ ����Ʈ���� ������', '28800', '��ǰ�� ����Ʈ���� ������ ���� ���� ��Ģ�� ����');

INSERT INTO BOOKS (BK_CODE, BK_NAME, BK_PRICE, BK_EXPLANATION)
VALUES ('BK012', '������ �����ӿ�ũ ù����', '22500', '�׸��� �ǽ����� ���� ���� ������ �����ӿ�ũ �Ϻ� �Թ���');

--���� ���ǽ� ������ �Է� ����--
INSERT INTO CLASSROOMS(ROOM_CODE,ROOM_NAME,ROOM_EXPLANATION)
VALUES('CR001','A��','1�� 101ȣ �ִ� ���� �ο� : 25��');
INSERT INTO CLASSROOMS(ROOM_CODE,ROOM_NAME,ROOM_EXPLANATION)
VALUES('CR002','B��','1�� 102ȣ �ִ� ���� �ο� : 30��');

INSERT INTO CLASSROOMS(ROOM_CODE,ROOM_NAME,ROOM_EXPLANATION)
VALUES('CR003','C��','2�� 201ȣ �ִ� ���� �ο� : 25��');
INSERT INTO CLASSROOMS(ROOM_CODE,ROOM_NAME,ROOM_EXPLANATION)
VALUES('CR004','D��','2�� 202ȣ �ִ� ���� �ο� : 30��');

INSERT INTO CLASSROOMS(ROOM_CODE,ROOM_NAME,ROOM_EXPLANATION)
VALUES('CR005','E��','3�� 301ȣ �ִ� ���� �ο� : 25��');
INSERT INTO CLASSROOMS(ROOM_CODE,ROOM_NAME,ROOM_EXPLANATION)
VALUES('CR006','F��','3�� 302ȣ �ִ� ���� �ο� : 30��');

INSERT INTO CLASSROOMS(ROOM_CODE,ROOM_NAME,ROOM_EXPLANATION)
VALUES('CR007','G��','4�� 401ȣ �ִ� ���� �ο� : 25��');
INSERT INTO CLASSROOMS(ROOM_CODE,ROOM_NAME,ROOM_EXPLANATION)
VALUES('CR008','H��','4�� 402ȣ �ִ� ���� �ο� : 30��');

--���� �������� ������ �Է� ����--
-- ����
INSERT INTO OPEN_COURSES(OCRS_CODE, CRS_CODE, PF_CODE, ROOM_CODE, START_DATE, END_DATE)
VALUES('OC001', 'CO003', 'PF001', 'CR001', TO_DATE('2022-05-30','YYYY-MM-DD'), TO_DATE('2022-12-21','YYYY-MM-DD'));

INSERT INTO OPEN_COURSES(OCRS_CODE, CRS_CODE, PF_CODE, ROOM_CODE, START_DATE, END_DATE)
VALUES('OC002', 'CO004', 'PF002', 'CR002', TO_DATE('2023-01-25','YYYY-MM-DD'), TO_DATE('2023-08-16','YYYY-MM-DD'));

-- ����
INSERT INTO OPEN_COURSES(OCRS_CODE, CRS_CODE, PF_CODE, ROOM_CODE, START_DATE, END_DATE)
VALUES('OC003', 'CO001', 'PF003', 'CR003', TO_DATE('2023-08-22','YYYY-MM-DD'), TO_DATE('2024-03-19','YYYY-MM-DD'));

INSERT INTO OPEN_COURSES(OCRS_CODE, CRS_CODE, PF_CODE, ROOM_CODE, START_DATE, END_DATE)
VALUES('OC004', 'CO002', 'PF004', 'CR004', TO_DATE('2023-08-23','YYYY-MM-DD'), TO_DATE('2024-03-20','YYYY-MM-DD'));

-- �̷�
INSERT INTO OPEN_COURSES(OCRS_CODE, CRS_CODE, PF_CODE, ROOM_CODE, START_DATE, END_DATE)
VALUES('OC005', 'CO003', 'PF005', 'CR005', TO_DATE('2023-11-13','YYYY-MM-DD'), TO_DATE('2024-06-10','YYYY-MM-DD'));

INSERT INTO OPEN_COURSES(OCRS_CODE, CRS_CODE, PF_CODE, ROOM_CODE, START_DATE, END_DATE)
VALUES('OC006', 'CO001', 'PF006', 'CR006', TO_DATE('2024-01-15','YYYY-MM-DD'), TO_DATE('2024-08-07','YYYY-MM-DD'));

--���� �������� ������ �Է� ����--
INSERT INTO OPEN_SUBJECTS(OSUB_CODE, OCRS_CODE, SUB_CODE, BK_CODE, SUB_START_DATE
                        , SUB_END_DATE, ATTENDANCE_SCORE, WRITTEN_SCORE, PRACTICAL_SCORE)
VALUES('0S001','OC001','SB001','BK006',TO_DATE('2022-05-30','YYYY-MM-DD'),TO_DATE('2022-08-26','YYYY-MM-DD'),30,30,40);
INSERT INTO OPEN_SUBJECTS(OSUB_CODE, OCRS_CODE, SUB_CODE, BK_CODE, SUB_START_DATE
                        , SUB_END_DATE, ATTENDANCE_SCORE, WRITTEN_SCORE, PRACTICAL_SCORE)
VALUES('0S002','OC001','SB002','BK005',TO_DATE('2022-08-29','YYYY-MM-DD'),TO_DATE('2022-12-21','YYYY-MM-DD'),30,30,40);

INSERT INTO OPEN_SUBJECTS(OSUB_CODE, OCRS_CODE, SUB_CODE, BK_CODE, SUB_START_DATE
                        , SUB_END_DATE, ATTENDANCE_SCORE, WRITTEN_SCORE, PRACTICAL_SCORE)
VALUES('0S003','OC002','SB004','BK008',TO_DATE('2023-01-25','YYYY-MM-DD'),TO_DATE('2023-04-07','YYYY-MM-DD'),20,40,40);
INSERT INTO OPEN_SUBJECTS(OSUB_CODE, OCRS_CODE, SUB_CODE, BK_CODE, SUB_START_DATE
                        , SUB_END_DATE, ATTENDANCE_SCORE, WRITTEN_SCORE, PRACTICAL_SCORE)
VALUES('0S004','OC002','SB003','BK009',TO_DATE('2022-04-10','YYYY-MM-DD'),TO_DATE('2023-08-16','YYYY-MM-DD'),20,40,40);

INSERT INTO OPEN_SUBJECTS(OSUB_CODE, OCRS_CODE, SUB_CODE, BK_CODE, SUB_START_DATE
                        , SUB_END_DATE, ATTENDANCE_SCORE, WRITTEN_SCORE, PRACTICAL_SCORE)
VALUES('0S005','OC003','SB004','BK008',TO_DATE('2023-08-22','YYYY-MM-DD'),TO_DATE('2023-12-01','YYYY-MM-DD'),20,40,40);
INSERT INTO OPEN_SUBJECTS(OSUB_CODE, OCRS_CODE, SUB_CODE, BK_CODE, SUB_START_DATE
                        , SUB_END_DATE, ATTENDANCE_SCORE, WRITTEN_SCORE, PRACTICAL_SCORE)
VALUES('0S006','OC003','SB003','BK009',TO_DATE('2023-12-04','YYYY-MM-DD'),TO_DATE('2024-03-19','YYYY-MM-DD'),20,40,40);

INSERT INTO OPEN_SUBJECTS(OSUB_CODE, OCRS_CODE, SUB_CODE, BK_CODE, SUB_START_DATE
                        , SUB_END_DATE, ATTENDANCE_SCORE, WRITTEN_SCORE, PRACTICAL_SCORE)
VALUES('0S007','OC004','SB004','BK008',TO_DATE('2023-08-23','YYYY-MM-DD'),TO_DATE('2023-12-04','YYYY-MM-DD'),20,40,40);
INSERT INTO OPEN_SUBJECTS(OSUB_CODE, OCRS_CODE, SUB_CODE, BK_CODE, SUB_START_DATE
                        , SUB_END_DATE, ATTENDANCE_SCORE, WRITTEN_SCORE, PRACTICAL_SCORE)
VALUES('0S008','OC004','SB003','BK009',TO_DATE('2023-12-05','YYYY-MM-DD'),TO_DATE('2024-03-20','YYYY-MM-DD'),20,40,40);

INSERT INTO OPEN_SUBJECTS(OSUB_CODE, OCRS_CODE, SUB_CODE, BK_CODE, SUB_START_DATE
                        , SUB_END_DATE, ATTENDANCE_SCORE, WRITTEN_SCORE, PRACTICAL_SCORE)
VALUES('0S009','OC005','SB005','BK010',TO_DATE('2023-11-13','YYYY-MM-DD'),TO_DATE('2024-02-23','YYYY-MM-DD'),20,40,40);
INSERT INTO OPEN_SUBJECTS(OSUB_CODE, OCRS_CODE, SUB_CODE, BK_CODE, SUB_START_DATE
                        , SUB_END_DATE, ATTENDANCE_SCORE, WRITTEN_SCORE, PRACTICAL_SCORE)
VALUES('0S010','OC005','SB009','BK011',TO_DATE('2024-02-26','YYYY-MM-DD'),TO_DATE('2024-06-10','YYYY-MM-DD'),40,0,60);

INSERT INTO OPEN_SUBJECTS(OSUB_CODE, OCRS_CODE, SUB_CODE, BK_CODE, SUB_START_DATE
                        , SUB_END_DATE, ATTENDANCE_SCORE, WRITTEN_SCORE, PRACTICAL_SCORE)
VALUES('0S011','OC006','SB006','BK010',TO_DATE('2024-01-15','YYYY-MM-DD'),TO_DATE('2024-04-12','YYYY-MM-DD'),30,30,40);
INSERT INTO OPEN_SUBJECTS(OSUB_CODE, OCRS_CODE, SUB_CODE, BK_CODE, SUB_START_DATE
                        , SUB_END_DATE, ATTENDANCE_SCORE, WRITTEN_SCORE, PRACTICAL_SCORE)
VALUES('0S012','OC006','SB008','BK012',TO_DATE('2024-04-15','YYYY-MM-DD'),TO_DATE('2024-08-07','YYYY-MM-DD'),30,20,50);


--���� �ߵ�Ż�� ������ �Է� ����--
INSERT INTO DROP_OUT_LISTS(DO_CODE, REG_CODE, DO_REASON_CODE, DO_DATE)
VALUES('DO001', 'RG001', 'DR005', TO_DATE('2022-10-20','YYYY-MM-DD'));

INSERT INTO DROP_OUT_LISTS(DO_CODE, REG_CODE, DO_REASON_CODE, DO_DATE)
VALUES('DO002', 'RG005', 'DR002', TO_DATE('2023-09-20','YYYY-MM-DD'));


--���� ������û ������ �Է� ����--
INSERT INTO COURSE_REGISTRATIONS(REG_CODE , ST_CODE, OCRS_CODE,REG_DATE)
VALUES ('RG001','ST001','OC001',TO_DATE('2015-04-30','YYYY-MM-DD'));

INSERT INTO COURSE_REGISTRATIONS(REG_CODE , ST_CODE, OCRS_CODE,REG_DATE)
VALUES ('RG002','ST002','OC001',TO_DATE('2019-07-29','YYYY-MM-DD'));

INSERT INTO COURSE_REGISTRATIONS(REG_CODE , ST_CODE, OCRS_CODE,REG_DATE)
VALUES ('RG003','ST003','OC002',TO_DATE('2020-10-10','YYYY-MM-DD'));

INSERT INTO COURSE_REGISTRATIONS(REG_CODE , ST_CODE, OCRS_CODE,REG_DATE)
VALUES ('RG004','ST004','OC002',TO_DATE('2021-11-11','YYYY-MM-DD'));

INSERT INTO COURSE_REGISTRATIONS(REG_CODE , ST_CODE, OCRS_CODE,REG_DATE)
VALUES ('RG005','ST005','OC003',TO_DATE('2022-1-24','YYYY-MM-DD'));

INSERT INTO COURSE_REGISTRATIONS(REG_CODE , ST_CODE, OCRS_CODE, REG_DATE)
VALUES ('RG006','ST006','OC003',TO_DATE('2022-12-25','YYYY-MM-DD'));

INSERT INTO COURSE_REGISTRATIONS(REG_CODE , ST_CODE, OCRS_CODE,REG_DATE)
VALUES ('RG007','ST007','OC004',TO_DATE('2023-05-02','YYYY-MM-DD'));

INSERT INTO COURSE_REGISTRATIONS(REG_CODE , ST_CODE, OCRS_CODE,REG_DATE)
VALUES ('RG008','ST008','OC004',TO_DATE('2023-06-30','YYYY-MM-DD'));

INSERT INTO COURSE_REGISTRATIONS(REG_CODE , ST_CODE, OCRS_CODE,REG_DATE)
VALUES ('RG009','ST009','OC005',TO_DATE('2023-10-04','YYYY-MM-DD'));

INSERT INTO COURSE_REGISTRATIONS(REG_CODE , ST_CODE, OCRS_CODE,REG_DATE)
VALUES ('RG010','ST010','OC005',TO_DATE('2023-11-12','YYYY-MM-DD'));

INSERT INTO COURSE_REGISTRATIONS(REG_CODE , ST_CODE, OCRS_CODE,REG_DATE)
VALUES ('RG011','ST011','OC006',TO_DATE('2023-12-31','YYYY-MM-DD'));

INSERT INTO COURSE_REGISTRATIONS(REG_CODE , ST_CODE, OCRS_CODE,REG_DATE)
VALUES ('RG012','ST012','OC006',TO_DATE('2024-01-01','YYYY-MM-DD'));




--���� ���� ������ �Է� ����--
INSERT INTO SCORES(SCORE_CODE, REG_CODE, OSUB_CODE, ATTENDANCE_SCORE, WRITTEN_SCORE, PRACTICAL_SCORE, TEST_DATE)
VALUES('SC001', 'RG001', '0S001', 20, 26, 30, TO_DATE('2022-08-26', 'YYYY-MM-DD'));

INSERT INTO SCORES(SCORE_CODE, REG_CODE, OSUB_CODE, ATTENDANCE_SCORE, WRITTEN_SCORE, PRACTICAL_SCORE, TEST_DATE)
VALUES('SC002', 'RG001', '0S002', 25, 29, 26, TO_DATE('2022-12-21', 'YYYY-MM-DD'));

INSERT INTO SCORES(SCORE_CODE, REG_CODE, OSUB_CODE, ATTENDANCE_SCORE, WRITTEN_SCORE, PRACTICAL_SCORE, TEST_DATE)
VALUES('SC003', 'RG002', '0S001', 21, 29, 20, TO_DATE('2022-08-26', 'YYYY-MM-DD'));

INSERT INTO SCORES(SCORE_CODE, REG_CODE, OSUB_CODE, ATTENDANCE_SCORE, WRITTEN_SCORE, PRACTICAL_SCORE, TEST_DATE)
VALUES('SC004', 'RG002', '0S002', 29, 26, 30, TO_DATE('2022-12-21', 'YYYY-MM-DD'));

INSERT INTO SCORES(SCORE_CODE, REG_CODE, OSUB_CODE, ATTENDANCE_SCORE, WRITTEN_SCORE, PRACTICAL_SCORE, TEST_DATE)
VALUES('SC005', 'RG003', '0S003', 20, 35, 30, TO_DATE('2023-04-07', 'YYYY-MM-DD'));

INSERT INTO SCORES(SCORE_CODE, REG_CODE, OSUB_CODE, ATTENDANCE_SCORE, WRITTEN_SCORE, PRACTICAL_SCORE, TEST_DATE)
VALUES('SC006', 'RG003', '0S004', 16, 32, 38, TO_DATE('2023-08-16', 'YYYY-MM-DD'));

INSERT INTO SCORES(SCORE_CODE, REG_CODE, OSUB_CODE, ATTENDANCE_SCORE, WRITTEN_SCORE, PRACTICAL_SCORE, TEST_DATE)
VALUES('SC007', 'RG004', '0S003', 10, 30, 35, TO_DATE('2023-04-07', 'YYYY-MM-DD'));

INSERT INTO SCORES(SCORE_CODE, REG_CODE, OSUB_CODE, ATTENDANCE_SCORE, WRITTEN_SCORE, PRACTICAL_SCORE, TEST_DATE)
VALUES('SC008', 'RG004', '0S004', 20, 38, 35, TO_DATE('2023-08-16', 'YYYY-MM-DD'));

SELECT *
FROM SCORES;


SELECT *
FROM TAB;

---------------------------------------------------------------------------------------------

SELECT *
FROM CLASSROOMS;



SELECT *
FROM OPEN_COURSES;



SELECT *
FROM ADMINS;

SELECT *
FROM OPEN_SUBJECTS;

---------------------------------------------------------------------------------

SELECT AD_CODE
FROM ADMINS
WHERE AD_ID = AD_ID
AND AD_PW = AD_PW;

---------------------------------------------------------------------------------

SELECT *
FROM OPEN_SUBJECTS;

SELECT PF_NAME
FROM PROFESSORS
WHERE PF_ID = PF_ID
AND PF_PW = SUBSTR(PF_SSN, 8, 7);

SELECT B.PF_NAME "�����ڸ�", F.SUB_NAME "������ �����", A.SUB_START_DATE "������", A.SUB_END_DATE "������", D.BK_NAME "�����", E.ROOM_NAME "���ǽ�"
    , CASE WHEN SYSDATE > A.SUB_END_DATE THEN '��������'
         WHEN SYSDATE < A.SUB_START_DATE THEN '���ǿ���'
         WHEN SYSDATE > A.SUB_START_DATE AND SYSDATE < A.SUB_END_DATE THEN '������' ELSE '���Ǿ���' END "�������࿩��"
FROM OPEN_SUBJECTS A, PROFESSORS B, OPEN_COURSES C, BOOKS D, CLASSROOMS E, SUBJECTS F
WHERE B.PF_CODE = C.PF_CODE
AND C.OCRS_CODE = A.OCRS_CODE
AND F.SUB_CODE = A.SUB_CODE
AND A.BK_CODE = D.BK_CODE
AND C.ROOM_CODE = E.ROOM_CODE;

-- �����
CREATE OR REPLACE VIEW VIEW_PROFESSORS
AS
SELECT B.PF_NAME "�����ڸ�", F.SUB_NAME "������ �����", A.SUB_START_DATE "������", A.SUB_END_DATE "������", D.BK_NAME "�����", E.ROOM_NAME "���ǽ�"
    , CASE WHEN SYSDATE > A.SUB_END_DATE THEN '��������'
         WHEN SYSDATE < A.SUB_START_DATE THEN '���ǿ���'
         WHEN SYSDATE > A.SUB_START_DATE AND SYSDATE < A.SUB_END_DATE THEN '������' ELSE '���Ǿ���' END "�������࿩��"
FROM OPEN_SUBJECTS A, PROFESSORS B, OPEN_COURSES C, BOOKS D, CLASSROOMS E, SUBJECTS F
WHERE B.PF_CODE = C.PF_CODE
AND C.OCRS_CODE = A.OCRS_CODE
AND F.SUB_CODE = A.SUB_CODE
AND A.BK_CODE = D.BK_CODE
AND C.ROOM_CODE = E.ROOM_CODE;

SELECT *
FROM VIEW_PROFESSORS;

/*-- �ڵ����� �н����� ����ϴ� Ʈ����
CREATE OR REPLACE TRIGGER TRG_PROFESSORS
        AFTER
        INSERT ON PROFESSORS
        FOR EACH ROW
DECLARE
    USER_DEFINE_ERROR EXCEPTION;
BEGIN
    UPDATE PROFESSORS
    SET PF_PW = SUBSTR(PF_SSN, 8, 7)
    WHERE PF_ID = :NEW.PF_ID;
    
    --���� ó��
    EXCEPTION
    WHEN USER_DEFINE_ERROR
        THEN RAISE_APPLICATION_ERROR(-20004, '�ùٸ��� ����');
END;*/

SELECT *
FROM PROFESSORS;

--���� ������
CREATE SEQUENCE PROFESSORS_SEQ
INCREMENT BY 1
START WITH 1
MINVALUE 1
MAXVALUE 9999
NOCYCLE
NOCACHE;

--���� ���
CREATE OR REPLACE PROCEDURE PRC_PROFESSORS_INSERT
( V_PF_ID       IN PROFESSORS.PF_ID%TYPE
, V_PF_NAME     IN PROFESSORS.PF_NAME%TYPE
, V_PF_SSN      IN PROFESSORS.PF_SSN%TYPE
)
IS
    V_PF_ID2 PROFESSORS.PF_ID%TYPE;
    V_FLAG NUMBER := 0;
    USER_DEFINE_ERROR EXCEPTION;
BEGIN
    SELECT COUNT(*) INTO V_FLAG
    FROM PROFESSORS
    WHERE PF_ID = V_PF_ID;

    IF V_FLAG = 1
        THEN RAISE_APPLICATION_ERROR(-20050, '�̹� ��ϵ� ID�Դϴ�.' );
        ROLLBACK;
    END IF;
    
    IF (V_FLAG = 1)
        THEN RAISE USER_DEFINE_ERROR;
    END IF;
    -- ������ �Է� ������ ����
    INSERT INTO PROFESSORS(PF_CODE, PF_ID, PF_PW, PF_NAME, PF_SSN)
    VALUES(('PF' || LPAD(TO_CHAR(PROFESSORS_SEQ.NEXTVAL+8), 3, '0')), V_PF_ID, SUBSTR(V_PF_SSN, 8, 7), V_PF_NAME, V_PF_SSN);

    --Ŀ��
    --COMMIT;
END;

--���� ����
CREATE OR REPLACE PROCEDURE PRC_PROFESSORS_UPDATE
( V_PF_CODE     IN PROFESSORS.PF_CODE%TYPE
, V_PF_ID       IN PROFESSORS.PF_ID%TYPE
, V_PF_PW       IN PROFESSORS.PF_PW %TYPE
, V_PF_NAME     IN PROFESSORS.PF_NAME%TYPE
, V_PF_SSN      IN PROFESSORS.PF_SSN%TYPE
, V_PF_DATE     IN PROFESSORS.PF_DATE%TYPE
)
IS
    V_PF_ID2 PROFESSORS.PF_ID%TYPE;
    V_FLAG NUMBER := 0;
    USER_DEFINE_ERROR EXCEPTION;
BEGIN
    SELECT COUNT(*) INTO V_PF_ID2
    FROM PROFESSORS
    WHERE PF_CODE NOT IN V_PF_CODE
    AND PF_ID = V_PF_ID;
    
    IF V_PF_ID2 = 1
        THEN RAISE USER_DEFINE_ERROR;
    END IF;
    
    UPDATE PROFESSORS
    SET PF_ID = V_PF_ID ,PF_PW = V_PF_PW, PF_NAME = V_PF_NAME, PF_SSN = V_PF_SSN, PF_DATE = V_PF_DATE
    WHERE PF_CODE = V_PF_CODE;
    
    EXCEPTION
    WHEN USER_DEFINE_ERROR
        THEN RAISE_APPLICATION_ERROR(-20098, '�̹� ��ϵ� ID�Դϴ�.' );
        ROLLBACK;
    
    --Ŀ��
    --COMMIT;
END;


-- ���� ����
CREATE OR REPLACE TRIGGER TRG_PROFESSORS_DELETE
-- �ڽĵ��� ���� �� �����ؾ� �θ����̺����� ���� �����ϹǷ� Ʈ���ſ��� BEFORE ���  
        BEFORE
        DELETE ON PROFESSORS
        FOR EACH ROW
BEGIN
    DELETE
    FROM DROP_OUT_LISTS
    WHERE REG_CODE IN (SELECT REG_CODE
                        FROM COURSE_REGISTRATIONS
                        WHERE OCRS_CODE IN (SELECT OCRS_CODE
                                             FROM OPEN_COURSES
                                            WHERE PF_CODE = :OLD.PF_CODE));
    DELETE
    FROM SCORES
    WHERE REG_CODE IN (SELECT REG_CODE
                        FROM COURSE_REGISTRATIONS
                        WHERE OCRS_CODE IN (SELECT OCRS_CODE
                                             FROM OPEN_COURSES
                                            WHERE PF_CODE = :OLD.PF_CODE));
    DELETE
    FROM COURSE_REGISTRATIONS
    WHERE OCRS_CODE IN (SELECT OCRS_CODE
                        FROM OPEN_COURSES
                        WHERE PF_CODE = :OLD.PF_CODE);
    DELETE
    FROM OPEN_SUBJECTS
    WHERE OCRS_CODE IN (SELECT OCRS_CODE
                        FROM OPEN_COURSES
                        WHERE PF_CODE = :OLD.PF_CODE);
    DELETE
    FROM OPEN_COURSES
    WHERE PF_CODE = :OLD.PF_CODE;
END;

---------------------------------------------------------------------------------

--���� ������
CREATE SEQUENCE COURSES_SEQ
INCREMENT BY 1
START WITH 1
MINVALUE 1
MAXVALUE 9999
NOCYCLE
NOCACHE;

--�������� ������
CREATE SEQUENCE OPEN_COURSES_SEQ
INCREMENT BY 1
START WITH 1
MINVALUE 1
MAXVALUE 9999
NOCYCLE
NOCACHE;


--�����
CREATE OR REPLACE VIEW VIEW_COURSES
AS
SELECT A.CRS_NAME "������", C.ROOM_NAME "���ǽ�", D.SUB_NAME "�����", E.SUB_START_DATE "������", E.SUB_END_DATE "������", F.BK_NAME "�����", G.PF_NAME "�����ڸ�"
FROM COURSES A, OPEN_COURSES B, CLASSROOMS C, SUBJECTS D, OPEN_SUBJECTS E, BOOKS F, PROFESSORS G
WHERE A.CRS_CODE = B.CRS_CODE
AND B.ROOM_CODE = C.ROOM_CODE
AND D.SUB_CODE = E.SUB_CODE
AND B.OCRS_CODE = E.OCRS_CODE
AND E.BK_CODE = F.BK_CODE
AND B.PF_CODE = G.PF_CODE;


SELECT A.CRS_NAME "������", C.ROOM_NAME "���ǽ�", D.SUB_NAME "�����", E.SUB_START_DATE "������", E.SUB_END_DATE "������", F.BK_NAME "�����", G.PF_NAME "�����ڸ�"
FROM COURSES A, OPEN_COURSES B, CLASSROOMS C, SUBJECTS D, OPEN_SUBJECTS E, BOOKS F, PROFESSORS G
WHERE A.CRS_CODE = B.CRS_CODE
AND B.ROOM_CODE = C.ROOM_CODE
AND D.SUB_CODE = E.SUB_CODE
AND B.OCRS_CODE = E.OCRS_CODE
AND E.BK_CODE = F.BK_CODE
AND B.PF_CODE = G.PF_CODE;


--���� ���
CREATE OR REPLACE PROCEDURE PRC_COURSES_INSERT
( V_CRS_NAME     IN COURSES.CRS_NAME%TYPE
)
IS
    FLAG_COURSES NUMBER; -- FLAG ����
    USER_DEFINE_ERROR EXCEPTION;
BEGIN
    SELECT NVL((SELECT 1
               FROM COURSES
               WHERE CRS_NAME = V_CRS_NAME), 0) INTO FLAG_COURSES
    FROM DUAL;
    
    IF (FLAG_COURSES != 0)
        THEN RAISE USER_DEFINE_ERROR;
    END IF;

    INSERT INTO COURSES(CRS_CODE, CRS_NAME)
    VALUES(('CO' || LPAD(TO_CHAR(COURSES_SEQ.NEXTVAL+4), 3, '0')), V_CRS_NAME);
    
    EXCEPTION
        WHEN USER_DEFINE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20098, '�̹� ��ϵ� �����Դϴ�.' );
            ROLLBACK;
        WHEN OTHERS
            THEN ROLLBACK;
    --Ŀ��
    --COMMIT;
END;

--���� ����
CREATE OR REPLACE PROCEDURE PRC_COURSES_UPDATE
( V_CRS_CODE     IN COURSES.CRS_CODE%TYPE
, V_CRS_NAME     IN COURSES.CRS_NAME%TYPE
)
IS
    FLAG_COURSES NUMBER; -- FLAG ����
    USER_DEFINE_ERROR EXCEPTION;
BEGIN
    SELECT NVL((SELECT 1
               FROM COURSES
               WHERE CRS_NAME = V_CRS_NAME), 0) INTO FLAG_COURSES
    FROM DUAL;
    
    IF (FLAG_COURSES != 0)
        THEN RAISE USER_DEFINE_ERROR;
    END IF;
    
    UPDATE COURSES
    SET CRS_NAME = V_CRS_NAME
    WHERE CRS_CODE = V_CRS_CODE;

    EXCEPTION
        WHEN USER_DEFINE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20098, '�̹� ��ϵ� �����Դϴ�.' );
            ROLLBACK;
        WHEN OTHERS
            THEN ROLLBACK;
    --Ŀ��
    --COMMIT;
END;

SELECT *
FROM OPEN_COURSES;


--�����������
CREATE OR REPLACE PROCEDURE PRC_OPEN_COURSES_INSERT
( V_CRS_CODE     IN OPEN_COURSES.CRS_CODE%TYPE
, V_PF_CODE      IN OPEN_COURSES.PF_CODE%TYPE
, V_ROOM_CODE    IN OPEN_COURSES.ROOM_CODE%TYPE
, V_START_DATE   IN OPEN_COURSES.START_DATE%TYPE
, V_END_DATE     IN OPEN_COURSES.END_DATE%TYPE
)
IS
    FLAG_COURSES  NUMBER;
    USER_DEFINE_ERROR1    EXCEPTION;
    
    FLAG_CLASSROOMS  NUMBER;
    USER_DEFINE_ERROR2    EXCEPTION;
    
    FLAG_PROFESSORS  NUMBER;
    USER_DEFINE_ERROR3    EXCEPTION;
    
    START_DATE2     OPEN_COURSES.START_DATE%TYPE;
    END_DATE2       OPEN_COURSES.END_DATE%TYPE;
    USER_DEFINE_ERROR4    EXCEPTION;
    
    V_OCRS_CODE       OPEN_COURSES.OCRS_CODE%TYPE;
    
    START_DATE3     OPEN_COURSES.START_DATE%TYPE;
    END_DATE3       OPEN_COURSES.END_DATE%TYPE;
    USER_DEFINE_ERROR5    EXCEPTION;
    USER_DEFINE_ERROR6    EXCEPTION;
    
    CURSOR COURSESCURSOR IS
    SELECT START_DATE, END_DATE
    FROM OPEN_COURSES
    WHERE ROOM_CODE = V_ROOM_CODE;
    
    CURSOR COURSESCURSOR2 IS
    SELECT START_DATE, END_DATE
    FROM OPEN_COURSES
    WHERE PF_CODE = V_PF_CODE;
BEGIN
    -- �������� �� Ŭ�� �����߻�
    IF V_START_DATE >= V_END_DATE THEN
          RAISE USER_DEFINE_ERROR6;
    END IF;
    
    
    -- �ش� ������ ������
    SELECT COUNT(*) INTO FLAG_COURSES
    FROM COURSES
    WHERE CRS_CODE =V_CRS_CODE;
    
    IF (FLAG_COURSES = 0)
        THEN RAISE USER_DEFINE_ERROR1;
    END IF;
    
    -- ���ǽ��� ������
    SELECT COUNT(*) INTO FLAG_CLASSROOMS
    FROM CLASSROOMS
    WHERE ROOM_CODE = V_ROOM_CODE;
    
    IF (FLAG_CLASSROOMS = 0)
        THEN RAISE USER_DEFINE_ERROR2;
    END IF;
    
    -- �������� ������
    SELECT COUNT(*) INTO FLAG_PROFESSORS
    FROM PROFESSORS
    WHERE PF_CODE = V_PF_CODE;
    
    IF (FLAG_PROFESSORS = 0)
        THEN RAISE USER_DEFINE_ERROR3;
    END IF;

    --�������� - ���ǽ�
    OPEN COURSESCURSOR;
    LOOP
        FETCH COURSESCURSOR INTO START_DATE2, END_DATE2;
        EXIT WHEN COURSESCURSOR%NOTFOUND;
        IF ((START_DATE2 BETWEEN V_START_DATE AND V_END_DATE) OR (END_DATE2 BETWEEN V_START_DATE AND V_END_DATE) 
            OR (V_START_DATE BETWEEN START_DATE2 AND END_DATE2) OR (V_END_DATE BETWEEN START_DATE2 AND END_DATE2)) THEN
             RAISE USER_DEFINE_ERROR4;
        END IF;
    END LOOP;
    CLOSE COURSESCURSOR;
    
    --�������� - ����
    OPEN COURSESCURSOR2;
    LOOP
        FETCH COURSESCURSOR2 INTO START_DATE3, END_DATE3;
        EXIT WHEN COURSESCURSOR2%NOTFOUND;
        IF ((START_DATE3 BETWEEN V_START_DATE AND V_END_DATE) OR (END_DATE3 BETWEEN V_START_DATE AND V_END_DATE) 
            OR (V_START_DATE BETWEEN START_DATE3 AND END_DATE3) OR (V_END_DATE BETWEEN START_DATE3 AND END_DATE3)) THEN
             RAISE USER_DEFINE_ERROR5;
        END IF;
    END LOOP;
    CLOSE COURSESCURSOR2;

    -- ������ �Է� ������ ����
    INSERT INTO OPEN_COURSES(OCRS_CODE, CRS_CODE, PF_CODE, ROOM_CODE, START_DATE, END_DATE)
    VALUES(('OC' || LPAD(TO_CHAR(OPEN_COURSES_SEQ.NEXTVAL), 3, '0')), V_CRS_CODE, V_PF_CODE, V_ROOM_CODE, V_START_DATE, V_END_DATE);
    
    
     -- ����ó��
        EXCEPTION
        WHEN USER_DEFINE_ERROR1
            THEN RAISE_APPLICATION_ERROR(-20099, '�ش� ������ �����ϴ�.');
            ROLLBACK;
        WHEN USER_DEFINE_ERROR2
            THEN RAISE_APPLICATION_ERROR(-20099, '���ǽ��� �����ϴ�.');
            ROLLBACK;
        WHEN USER_DEFINE_ERROR3
            THEN RAISE_APPLICATION_ERROR(-20099, '��� �������� �����ϴ�.');
            ROLLBACK;
        WHEN USER_DEFINE_ERROR4
            THEN RAISE_APPLICATION_ERROR(-20099, '�Ⱓ ���� ���� ���ǽ��� �����մϴ�.');
            ROLLBACK;
        WHEN USER_DEFINE_ERROR5
            THEN RAISE_APPLICATION_ERROR(-20099, '�Ⱓ ���� ���� �������� �����մϴ�.');
            ROLLBACK;
        WHEN USER_DEFINE_ERROR6
            THEN RAISE_APPLICATION_ERROR(-20099, '�ùٸ��� �Է��ϼ���');
            ROLLBACK;
END;



--������������
CREATE OR REPLACE PROCEDURE PRC_OPEN_COURSES_UPDATE
( V_OCRS_CODE    IN OPEN_COURSES.OCRS_CODE%TYPE
, V_CRS_CODE     IN OPEN_COURSES.CRS_CODE%TYPE
, V_PF_CODE      IN OPEN_COURSES.PF_CODE%TYPE
, V_ROOM_CODE    IN OPEN_COURSES.ROOM_CODE%TYPE
, V_START_DATE   IN OPEN_COURSES.START_DATE%TYPE
, V_END_DATE     IN OPEN_COURSES.END_DATE%TYPE
)
IS
    SUBJECTS_START  OPEN_SUBJECTS.SUB_START_DATE%TYPE;
    SUBJECTS_END    OPEN_SUBJECTS.SUB_END_DATE%TYPE;
    V_OSUB_CODE     OPEN_SUBJECTS.OSUB_CODE%TYPE;
    END_DATE2     OPEN_COURSES.END_DATE%TYPE;
    START_DATE2     OPEN_COURSES.START_DATE%TYPE;
    
    FLAG_COURSES  NUMBER;
    USER_DEFINE_ERROR1    EXCEPTION;
    
    FLAG_CLASSROOMS  NUMBER;
    USER_DEFINE_ERROR2    EXCEPTION;
    
    FLAG_PROFESSORS  NUMBER;
    USER_DEFINE_ERROR3    EXCEPTION;
    
    
    USER_DEFINE_ERROR4    EXCEPTION;
    
    USER_DEFINE_ERROR5    EXCEPTION;
    
    USER_DEFINE_ERROR6    EXCEPTION;

    START_DATE3     OPEN_COURSES.START_DATE%TYPE;
    END_DATE3       OPEN_COURSES.END_DATE%TYPE;
    USER_DEFINE_ERROR7    EXCEPTION;
    
    CURSOR SUBJECTSCURSOR IS
    SELECT OSUB_CODE, SUB_END_DATE
    FROM OPEN_SUBJECTS
    WHERE OCRS_CODE = V_OCRS_CODE;
    
    
    CURSOR COURSESCURSOR IS
    SELECT START_DATE, END_DATE
    FROM OPEN_COURSES
    WHERE ROOM_CODE = V_ROOM_CODE
    AND OCRS_CODE != V_OCRS_CODE;
    
    CURSOR COURSESCURSOR2 IS
    SELECT START_DATE, END_DATE
    FROM OPEN_COURSES
    WHERE PF_CODE = V_PF_CODE
    AND OCRS_CODE != V_OCRS_CODE;;
    
BEGIN
    -- �̹� ���� ���� �����Ϸ��� �ϸ� ���� �߻��ϰ� SYSDATE�� �����������̶� ��
    SELECT END_DATE INTO END_DATE2
    FROM OPEN_COURSES
    WHERE OCRS_CODE = V_OCRS_CODE;

    IF SYSDATE > END_DATE2 THEN
        RAISE USER_DEFINE_ERROR6;
    END IF;
    
    -- �ش� ������ ������
    SELECT COUNT(*) INTO FLAG_CLASSROOMS
    FROM CLASSROOMS
    WHERE ROOM_CODE = V_ROOM_CODE;
    
    IF (FLAG_COURSES = 0)
        THEN RAISE USER_DEFINE_ERROR1;
    END IF;
    
    -- ���ǽ��� ������
    SELECT COUNT(*) INTO FLAG_CLASSROOMS
    FROM CLASSROOMS
    WHERE ROOM_CODE = V_ROOM_CODE;
    
    IF (FLAG_CLASSROOMS = 0)
        THEN RAISE USER_DEFINE_ERROR2;
    END IF;
    
    -- �������� ������
    SELECT COUNT(*) INTO FLAG_PROFESSORS
    FROM PROFESSORS
    WHERE PF_CODE = V_PF_CODE;
    
    IF (FLAG_PROFESSORS = 0)
        THEN RAISE USER_DEFINE_ERROR3;
    END IF;
    
    --�������� - �������� Ŀ��
    OPEN SUBJECTSCURSOR;
    LOOP
        FETCH SUBJECTSCURSOR INTO V_OSUB_CODE, SUBJECTS_END;
            -- �ٲٴ� �������������� >= �������� ������
            IF (V_END_DATE < SUBJECTS_END) THEN
                 RAISE USER_DEFINE_ERROR4;
            END IF;
            EXIT WHEN SUBJECTSCURSOR%NOTFOUND;
    END LOOP;
    CLOSE SUBJECTSCURSOR;
    
    
    --�������� - ���ǽ�
    OPEN COURSESCURSOR;
    LOOP
        FETCH COURSESCURSOR INTO START_DATE2, END_DATE2;
                EXIT WHEN COURSESCURSOR%NOTFOUND;
            IF ((START_DATE2 BETWEEN V_START_DATE AND V_END_DATE) OR (END_DATE2 BETWEEN V_START_DATE AND V_END_DATE) 
            OR (V_START_DATE BETWEEN START_DATE2 AND END_DATE2) OR (V_END_DATE BETWEEN START_DATE2 AND END_DATE2)) THEN
                 RAISE USER_DEFINE_ERROR5;
            END IF;

    END LOOP;
    CLOSE COURSESCURSOR;
    
    --�������� - ����
    OPEN COURSESCURSOR2;
    LOOP
        FETCH COURSESCURSOR2 INTO START_DATE3, END_DATE3;
        EXIT WHEN COURSESCURSOR2%NOTFOUND;
        IF ((START_DATE3 BETWEEN V_START_DATE AND V_END_DATE) OR (END_DATE3 BETWEEN V_START_DATE AND V_END_DATE) 
            OR (V_START_DATE BETWEEN START_DATE3 AND END_DATE3) OR (V_END_DATE BETWEEN START_DATE3 AND END_DATE3)) THEN
             RAISE USER_DEFINE_ERROR7;
        END IF;
    END LOOP;
    CLOSE COURSESCURSOR2;
    
    -- ������ ���� ������ ����
    UPDATE OPEN_COURSES
    SET CRS_CODE = V_CRS_CODE, PF_CODE = V_PF_CODE, ROOM_CODE = V_ROOM_CODE, START_DATE = V_START_DATE, END_DATE = V_END_DATE
    WHERE OCRS_CODE = V_OCRS_CODE;
    -- ����ó��
        EXCEPTION
        WHEN USER_DEFINE_ERROR1
            THEN RAISE_APPLICATION_ERROR(-20099, '�ش� ������ �����ϴ�.');
            ROLLBACK;
        WHEN USER_DEFINE_ERROR2
            THEN RAISE_APPLICATION_ERROR(-20099, '���ǽ��� �����ϴ�.');
            ROLLBACK;
        WHEN USER_DEFINE_ERROR3
            THEN RAISE_APPLICATION_ERROR(-20099, '��� �������� �����ϴ�.');
            ROLLBACK;
        WHEN USER_DEFINE_ERROR4
            THEN RAISE_APPLICATION_ERROR(-20099, '���� �߻�');
            ROLLBACK;
        WHEN USER_DEFINE_ERROR5
            THEN RAISE_APPLICATION_ERROR(-20099, '�Ⱓ ���� ���� ���ǽ��� �����մϴ�.');
            ROLLBACK;
        WHEN USER_DEFINE_ERROR6
            THEN RAISE_APPLICATION_ERROR(-20099, '�̹� ����� �����Դϴ�.');
            ROLLBACK;
        WHEN USER_DEFINE_ERROR7
            THEN RAISE_APPLICATION_ERROR(-20099, '�Ⱓ ���� ���� �������� �����մϴ�.');
            ROLLBACK;
END;

