SELECT USER
FROM DUAL;
--==> HR

--���� CHECK(CK:C) ����--

-- 1. �÷����� ��� ������ �������� ������ ������ �����ϱ� ���� ��������.
--    �÷��� �ԷµǴ� �����͸� �˻��Ͽ� ���ǿ� �´� �����͸� �Էµ� �� �ֵ��� �Ѵ�.
--    ����, �÷����� �����Ǵ� �����͸� �˻��Ͽ� ���ǿ� �´� �����ͷ� �����Ǵ� �͸�
--    ����ϴ� ����� �����ϰ� �ȴ�.

-- 2. ���� �� ����
--  �� �÷� ������ ����
--     �÷��� ������ Ÿ�� [CONSTRAINT CONSTRAINT��] CHECK(�÷� ����)

--  �� ���̺� ������ ����
--     �÷��� ������ Ÿ��,
--     �÷��� ������ Ÿ��,
--     CONSTRAINT CONSTRAINT�� CHECK(�÷� ����)

--�� CK ���� �ǽ�(�� �÷� ������ ����)
-- ���̺� ����
CREATE TABLE TBL_TEST8
( COL1 NUMBER(5)        PRIMARY KEY
, COL2 VARCHAR2(30)
, COL3 NUMBER(3)        CHECK(COL3 BETWEEN 0 AND 100)
);
--==> Table TBL_TEST8��(��) �����Ǿ����ϴ�.

-- ������ �Է�
INSERT INTO TBL_TEST8(COL1, COL2, COL3) VALUES(1, '�ڹ���', 100);
--==> 1 �� ��(��) ���ԵǾ����ϴ�.

INSERT INTO TBL_TEST8(COL1, COL2, COL3) VALUES(1, '�����', 100);
--==> ���� �߻�
-- ORA-00001: unique constraint (HR.SYS_C007032) violated

INSERT INTO TBL_TEST8(COL1, COL2, COL3) VALUES(2, '�����', 101);
--==> ���� �߻�
-- ORA-02290: check constraint (HR.SYS_C007031) violated

INSERT INTO TBL_TEST8(COL1, COL2, COL3) VALUES(3, '�����', -1);
--==> ���� �߻�
-- ORA-02290: check constraint (HR.SYS_C007031) violated

-- Ȯ��
SELECT *
FROM TBL_TEST8;
/*
1	�ڹ���	100
2	�����	100
*/

-- Ŀ��
COMMIT;
--==> Ŀ�� �Ϸ�

-- �������� Ȯ��
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_TEST8';
/*
HR	SYS_C007031	TBL_TEST8	C	COL3	COL3 BETWEEN 0 AND 100	
HR	SYS_C007032	TBL_TEST8	P	COL1		
*/


--�� CK ���� �ǽ�(�� ���̺� ������ ����)
-- ���̺� ����
CREATE TABLE TBL_TEST9
( COL1 NUMBER(5)
, COL2 VARCHAR2(30)
, COL3 NUMBER(3)
, CONSTRAINT TEST9_COL1_PK PRIMARY KEY(COL1)
, CONSTRAINT TEST9_COL3_CK CHECK(COL3 BETWEEN 0 AND 100)
);
--==> Table TBL_TEST9��(��) �����Ǿ����ϴ�.

-- ������ �Է�
INSERT INTO TBL_TEST9(COL1, COL2, COL3) VALUES(1, '�ڹ���', 100);
--==> 1 �� ��(��) ���ԵǾ����ϴ�.

INSERT INTO TBL_TEST9(COL1, COL2, COL3) VALUES(1, '�����', 100);
--==> ���� �߻�
-- ORA-00001: unique constraint (HR.SYS_C007032) violated

INSERT INTO TBL_TEST9(COL1, COL2, COL3) VALUES(2, '�����', 101);
--==> ���� �߻�
-- ORA-02290: check constraint (HR.SYS_C007031) violated

INSERT INTO TBL_TEST9(COL1, COL2, COL3) VALUES(2, '�����', -1);

INSERT INTO TBL_TEST9(COL1, COL2, COL3) VALUES(2, '�����', 80);

-- Ȯ��
SELECT *
FROM TBL_TEST9;
/*
1	�ڹ���	100
2	�����	80
*/

-- Ŀ��
COMMIT;
--==> Ŀ�� �Ϸ�

-- �������� Ȯ��
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_TEST9';
/*
HR	TEST9_COL3_CK	TBL_TEST9	C	COL3	COL3 BETWEEN 0 AND 100	
HR	TEST9_COL1_PK	TBL_TEST9	P	COL1		
*/

--�� CK ���� �ǽ�(�� ���̺� ���� ���� �������� �߰�)
-- ���̺� ����
CREATE TABLE TBL_TEST10
( COL1 NUMBER(5)
, COL2 VARCHAR2(30)
, COL3 NUMBER(3)
);
--==> Table TBL_TEST10��(��) �����Ǿ����ϴ�.

-- �������� Ȯ��
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_TEST10';
--==> ��ȸ ��� ����

-- �������� �߰�
ALTER TABLE TBL_TEST10
ADD ( CONSTRAINT TEST10_COL1_PK PRIMARY KEY(COL1)
    , CONSTRAINT TEST10_COL3_CK CHECK(COL3 BETWEEN 0 AND 100));
--==> Table TBL_TEST10��(��) ����Ǿ����ϴ�.

-- �������� Ȯ��
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_TEST10';
/*
HR	TEST10_COL1_PK	TBL_TEST10	P	COL1		
HR	TEST10_COL3_CK	TBL_TEST10	C	COL3	COL3 BETWEEN 0 AND 100	
*/

-- ���̺� ����
CREATE TABLE TBL_TESTMEMBER
( SID   NUMBER
, NAME  VARCHAR2(30)
, SSN   CHAR(14)       --�Է����� -> 'YYMMDD-NNNNNNN'
, TEL   VARCHAR2(40)
);
--==> Table TBL_TESTMEMBER��(��) �����Ǿ����ϴ�.

--�� TBL_TESTMEMBER ���̺��� SSN �÷�(�ֹε�Ϲ�ȣ �÷�)����
--   ������ �Է��̳� ���� ��, ������ ��ȿ�� �����͸� �Էµ� �� �ֵ���
--   üũ ���������� �߰��� �� �ֵ��� �Ѵ�.
--   (-> �ֹι�ȣ Ư�� �ڸ��� �Է� ������ �����͸� 1, 2, 3, 4�� �����ϵ��� ó��)
--   ����, SID �÷����� PRIMARY KEY ���������� ������ �� �ֵ��� �Ѵ�.

-- �������� �߰�
ALTER TABLE TBL_TESTMEMBER
ADD ( CONSTRAINT TBL_TESTMEMBER_SID_PK PRIMARY KEY(SID)
    , CONSTRAINT TBL_TESTMEMBER_SSN_CK CHECK(SUBSTR(SSN,8,1) BETWEEN 1 AND 4));
--==> Table TBL_TESTMEMBER��(��) ����Ǿ����ϴ�.

/* ���2
ALTER TABLE TBL_TESTMEMBER
ADD ( CONSTRAINT TBL_TESTMEMBER_SID_PK PRIMARY KEY(SID)
    , CONSTRAINT TBL_TESTMEMBER_SSN_CK CHECK(SUBSTR(SSN,8,1) IN ('1', '2', '3', '4'));
*/


-- �������� Ȯ��
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_TESTMEMBER';
/*
HR	TBL_TESTMEMBER_SID_PK	TBL_TESTMEMBER	P	SID		
HR	TBL_TESTMEMBER_SSN_CK	TBL_TESTMEMBER	C	SSN	SUBSTR(SSN,8,1) BETWEEN 1 AND 4	
*/

-- �����Ϸ���
--DROP CONSTRAINT TBL_TESTMEMBER_SSN_CK;

DROP TABLE TBL_TESTMEMBER;

-- ������ �Է� �׽�Ʈ
INSERT INTO TBL_TESTMEMBER(SID, NAME, SSN, TEL)
VALUES(1, '������', '950106-1234567', '010-1111-1111');

INSERT INTO TBL_TESTMEMBER(SID, NAME, SSN, TEL)
VALUES(2, '�ڳ���', '990208-1234567', '010-2222-2222');

INSERT INTO TBL_TESTMEMBER(SID, NAME, SSN, TEL)
VALUES(3, '������', '070811-4234567', '010-3333-3333');

INSERT INTO TBL_TESTMEMBER(SID, NAME, SSN, TEL)
VALUES(4, '������', '090211-3234567', '010-4444-4444');

INSERT INTO TBL_TESTMEMBER(SID, NAME, SSN, TEL)
VALUES(5, '������', '000220-5234567', '010-5555-5555');
--==> ���� �߻�
-- ORA-02290: check constraint (HR.TBL_TESTMEMBER_SSN_CK) violated

INSERT INTO TBL_TESTMEMBER(SID, NAME, SSN, TEL)
VALUES(5, '������', '000220-6234567', '010-5555-5555');
--==> ���� �߻�
-- ORA-02290: check constraint (HR.TBL_TESTMEMBER_SSN_CK) violated

-- Ȯ��
SELECT *
FROM TBL_TESTMEMBER;
/*
1	������	950106-1234567	010-1111-1111
2	�ڳ���	990208-1234567	010-2222-2222
3	������	070811-4234567	010-3333-3333
4	������	090211-3234567	010-4444-4444
*/

-- Ŀ��
COMMIT;
--==> Ŀ�� �Ϸ�.

--------------------------------------------------------------------------------

--���� FOREIGN KEY(FK:F:R) ����--

-- 1. ���� Ű(R) �Ǵ� �ܷ� Ű(FK:F)�� �� ���̺��� ������ �� ������ �����ϰ�
--    ���� �����Ű�µ� ���Ǵ� ���̴�.
--    �� ���̺��� �⺻ Ű ���� �ִ� ����
--    �ٸ� ���̺� �߰��ϸ� ���̺� �� ������ ������ �� �ִ�.
--    �� ��, �� ��° ���̺� �߰��Ǵ� ���� �ܷ�Ű�� �ȴ�.

-- 2. �θ� ���̺�(�����޴� �÷��� ���Ե� ���̺�)�� ���� ������ ��
--    �ڽ� ���̺�(�����ϴ� �÷��� ���Ե� ���̺�)�� �����Ǿ�� �Ѵ�.
--    �� ��, �ڽ� ���̺� FOREIGN KEY ���������� �����ȴ�.

-- 3. ���� �� ����
-- �� �÷� ������ ����
--    �÷��� ������Ÿ�� [CONSTRAINT CONSTRAINT��]
--                      REFERENCES �������̺��(�����÷���)
--                      [ON DELETE CASCADE | ON DELETE SET NULL] -> �߰� �ɼ�

-- �� ���̺� ������ ����
--    �÷��� ������ Ÿ��,
--    �÷��� ������ Ÿ��,
--    CONSTRAINT CONSTRAINT�� FOREIGN KEY(�÷���)
--               REFERENCES �������̺��(�����÷���)
--               [ON DELETE CASCADE | ON DELETE SET NULL] -> �߰� �ɼ�

--�� FOREIGN KEY ���������� �����ϴ� �ǽ��� �����ϱ� ���ؼ���
--   �θ� ���̺��� ���� �۾��� ���� �����ؾ� �Ѵ�.
--   �׸��� �� ��, �θ� ���̺��� �ݵ�� PK �Ǵ� UK ����������
--   ������ �÷��� �����ؾ� �Ѵ�.

-- �θ� ���̺� ����
CREATE TABLE TBL_JOBS
( JIKWI_ID      NUMBER
, JIKWI_NAME    VARCHAR2(30)
, CONSTRAINT JOBS_ID_PK PRIMARY KEY(JIKWI_ID)
);
--==> Table TBL_JOBS��(��) �����Ǿ����ϴ�.

-- �θ� ���̺� ������ �Է�
INSERT INTO TBL_JOBS(JIKWI_ID, JIKWI_NAME) VALUES(1, '���');
INSERT INTO TBL_JOBS(JIKWI_ID, JIKWI_NAME) VALUES(2, '�븮');
INSERT INTO TBL_JOBS(JIKWI_ID, JIKWI_NAME) VALUES(3, '����');
INSERT INTO TBL_JOBS(JIKWI_ID, JIKWI_NAME) VALUES(4, '����');
--==> 1 �� ��(��) ���ԵǾ����ϴ�.

--Ȯ��
SELECT *
FROM TBL_JOBS;
/*
1	���
2	�븮
3	����
4	����
*/

-- Ŀ��
COMMIT;
--==> Ŀ�� �Ϸ�.

--�� FK ���� �ǽ�(�� �÷� ������ ����)
-- ���̺� ����
CREATE TABLE TBL_EMP1
( SID       NUMBER          PRIMARY KEY
, NAME      VARCHAR2(30)
, JIKWI_ID  NUMBER          REFERENCES TBL_JOBS(JIKWI_ID)
);
--==> Table TBL_EMP1��(��) �����Ǿ����ϴ�.
-- FOREIGN KEY�� �Է����� �ʴ´�, JIKWI_ID = �θ����̺��� JIKWI_ID, TBL_JOBS.JIKWI_ID�� �ƴϴ�. ����

-- �������� Ȯ��
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_EMP1';
/*
HR	SYS_C007040	TBL_EMP1	P	SID		
HR	SYS_C007041	TBL_EMP1	R	JIKWI_ID		NO ACTION
*/

-- ������ �Է�
INSERT INTO TBL_EMP1(SID, NAME, JIKWI_ID) VALUES(1, '������', 1);

INSERT INTO TBL_EMP1(SID, NAME, JIKWI_ID) VALUES(2, '�ڰ���', 2);

INSERT INTO TBL_EMP1(SID, NAME, JIKWI_ID) VALUES(3, 'ä�ټ�', 3);

INSERT INTO TBL_EMP1(SID, NAME, JIKWI_ID) VALUES(4, '���ȯ', 4);

INSERT INTO TBL_EMP1(SID, NAME, JIKWI_ID) VALUES(5, '��ٽ�', 5);
--==> ���� �߻�
-- ORA-02291: integrity constraint (HR.SYS_C007041) violated - parent key not found

INSERT INTO TBL_EMP1(SID, NAME, JIKWI_ID) VALUES(5, '��ٽ�', 1);

INSERT INTO TBL_EMP1(SID, NAME) VALUES(6, '������');

--==> Ȯ��
SELECT *
FROM TBL_EMP1;
/*
1	������	1
2	�ڰ���	2
3	ä�ټ�	3
4	���ȯ	4
5	��ٽ�	1
6	������	(null)
*/

COMMIT;
--==> Ŀ�� �Ϸ�.

--�� FK ���� �ǽ�(�� ���̺� ������ ����)
--���̺� ����
CREATE TABLE TBL_EMP2
( SID       NUMBER
, NAME      VARCHAR2(30)
, JIKWI_ID  NUMBER
, CONSTRAINT EMP2_SID_PK PRIMARY KEY(SID)
, CONSTRAINT EMP2_JIKWI_ID_FK FOREIGN KEY(JIKWI_ID)
              REFERENCES TBL_JOBS(JIKWI_ID)
);
--==> Table TBL_EMP2��(��) �����Ǿ����ϴ�.
-- FOREIGN KEY(JIKWI_ID) ������ JIKWI_ID�� EMP2�� ���� ���̵�
-- REFERENCES TBL_JOBS(JIKWI_ID) ������ JIKWI_ID�� JOBS�� ���� ���̵�.

-- �������� Ȯ��
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_EMP2';
/*
HR	EMP2_SID_PK	TBL_EMP2	P	SID		
HR	EMP2_JIKWI_ID_FK	TBL_EMP2	R	JIKWI_ID		NO ACTION
*/

--�� FK ���� �ǽ�(�� ���̺� ���� ���� �������� �߰�)
CREATE TABLE TBL_EMP3
( SID       NUMBER
, NAME      VARCHAR2(30)
, JIKWI_ID  NUMBER
);
--==> Table TBL_EMP3��(��) �����Ǿ����ϴ�.

-- �������� �߰�
ALTER TABLE TBL_EMP3
ADD ( CONSTRAINT EMP3_SID_PK PRIMARY KEY(SID)
    , CONSTRAINT EMP3_JIKWI_ID_FK FOREIGN KEY(JIKWI_ID)
                REFERENCES TBL_JOBS(JIKWI_ID) );
--==> Table TBL_EMP3��(��) ����Ǿ����ϴ�.

-- �������� ����
ALTER TABLE TBL_EMP3
DROP CONSTRAINT EMP3_JIKWI_ID_FK;
--==> Table TBL_EMP3��(��) ����Ǿ����ϴ�.

-- �������� Ȯ��
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_EMP3';
--==> HR	EMP3_SID_PK	TBL_EMP3	P	SID		

-- �ٽ� �������� �߰�
ALTER TABLE TBL_EMP3
ADD CONSTRAINT EMP3_JIKWI_ID_FK FOREIGN KEY(JIKWI_ID)
                REFERENCES TBL_JOBS(JIKWI_ID);
--==> Table TBL_EMP3��(��) ����Ǿ����ϴ�.

-- �������� Ȯ��
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_EMP3';
/*
HR	EMP3_SID_PK	TBL_EMP3	P	SID		
HR	EMP3_JIKWI_ID_FK	TBL_EMP3	R	JIKWI_ID		NO ACTION
*/

-- 4. FOREIGN KEY ���� �� ���ǻ���
--    �����ϰ��� �ϴ� �θ� ���̺��� ���� �����ؾ� �Ѵ�.
--    �����ϰ��� �ϴ� �÷��� PRIMARY KEY �Ǵ� UNIQUE ���������� �����Ǿ� �־�� �Ѵ�.
--    ���̺� ���̿� PRIMARY KEY �� FOREIGN KEY �� ���ǵǾ� ������
--    PRIMARY KEY ���������� ������ ������ ���� ��
--    FOREIGN KEY �÷��� �� ���� �ԷµǾ� �ִ� ��� �������� �ʴ´�.
--    (��, �ڽ� ���̺� �����ϴ� ���ڵ尡 ������ ���
--    �θ� ���̺��� �����޴� �ش� ���ڵ�� ������ �� ���ٴ� ���̴�.)
--    ��, FK ���� �������� ON DELETE CASCADE �� ON DELETE SET NULL �ɼ���
--    ����Ͽ� ������ ��쿡�� ������ �����ϴ�.
--    ����, �θ� ���̺��� �����ϱ� ���ؼ��� �ڽ� ���̺��� ���� �����ؾ� �Ѵ�.


-- �θ� ���̺�
SELECT *
FROM TBL_JOBS;
/*
1	���
2	�븮
3	����
4	����
*/

-- �ڽ� ���̺�
SELECT *
FROM TBL_EMP1;
/*
1	������	1
2	�ڰ���	2
3	ä�ټ�	3
4	���ȯ	4
5	��ٽ�	1
6	������	
*/

-- �θ� ���̺� ���� �õ�
DROP TABLE TBL_JOBS;
--==> ���� �߻�
-- ORA-02449: unique/primary keys in table referenced by foreign keys

-- �θ� ���̺��� ���� ���� ������ ���� �õ�
SELECT *
FROM TBL_JOBS
WHERE JIKWI_ID=4;

DELETE
FROM TBL_JOBS
WHERE JIKWI_ID=4;
--==> ���� �߻�
-- ORA-02292: integrity constraint (HR.SYS_C007041) violated - child record found

-- ���ȯ ������ ������ ������� ����
UPDATE TBL_EMP1
SET JIKWI_ID=1
WHERE SID = 4;
--==> 1 �� ��(��) ������Ʈ�Ǿ����ϴ�.

-- Ȯ��
SELECT *
FROM TBL_EMP1;
/*
1	������	1
2	�ڰ���	2
3	ä�ټ�	3
4	���ȯ	1
5	��ٽ�	1
6	������	
*/

-- Ŀ��
COMMIT;
--==> Ŀ�� �Ϸ�.

-- �θ� ���̺�(TBL_JOBS)�� ���� �����͸� �����ϰ� �ִ�
-- �ڽ� ���̺�(TBL_EMP1)�� �����Ͱ� �������� �ʴ� ��Ȳ

-- �̿� ���� ��Ȳ���� �θ� ���̺�(TBL_JOBS)��
-- ���� ������ ����
DELETE
FROM TBL_JOBS
WHERE JIKWI_ID=4;
--==> 1 �� ��(��) �����Ǿ����ϴ�.

-- Ȯ��
SELECT *
FROM TBL_JOBS;
/*
1	���
2	�븮
3	����
*/

COMMIT;
--==> Ŀ�� �Ϸ�.

--�� �θ� ���̺��� �����͸� �����Ӱ�(?) �����ϱ� ���ؼ���
--   ON DELETE CASCADE �ɼ� ������ �ʿ��ϴ�.

-- TBL_EMP1 ���̺�(�ڽ� ���̺�)���� FK ���������� ������ ��
-- CASCADE �ɼ��� �����Ͽ� �ٽ� FK ���������� �����Ѵ�.
-- �������� Ȯ��
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_EMP1';

-- �������� ����
ALTER TABLE TBL_EMP1
DROP CONSTRAINT SYS_C007041;
--==> Table TBL_EMP1��(��) ����Ǿ����ϴ�.

-- ON DELETE CASCADE �ɼ��� ���Ե� �������� �������� �ٽ� ����
ALTER TABLE TBL_EMP1
ADD CONSTRAINT EMP1_JIKWI_ID_FK FOREIGN KEY(JIKWI_ID)
                REFERENCES TBL_JOBS(JIKWI_ID)
                ON DELETE CASCADE;
--==> Table TBL_EMP1��(��) ����Ǿ����ϴ�.

-- �������� ���� ���� �ٽ� Ȯ��
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_EMP1';
/*
HR	SYS_C007040	TBL_EMP1	P	SID		
HR	EMP1_JIKWI_ID_FK	TBL_EMP1	R	JIKWI_ID		CASCADE
*/

--�� CASCADE �ɼ��� ������ �Ŀ���
--   �����ް� �ִ� �θ� ���̺��� �����͸�
--   �������� �����Ӱ� �����ϴ� ���� �����ϴ�.
--   ��, ... �θ� ���̺��� �����Ͱ� ������ ���...
--   �̸� �����ϴ� �ڽ� ���̺�(��� �ڽ� ���̺�)�� �����͵� ��~~~~~~~~~�� �Բ� �����ȴ�.

-- �θ� ���̺�
SELECT *
FROM TBL_JOBS;
/*
1	���
2	�븮
3	����
*/

-- �ڽ� ���̺�
SELECT *
FROM TBL_EMP1;
/*
1	������	1
2	�ڰ���	2
3	ä�ټ�	3
4	���ȯ	1
5	��ٽ�	1
6	������	
*/

-- �θ� ���̺�(TBL_JOBS)���� ���� ������ ����
SELECT *
FROM TBL_JOBS
WHERE JIKWI_ID=3;

DELETE
FROM TBL_JOBS
WHERE JIKWI_ID=3;
--==> 1 �� ��(��) �����Ǿ����ϴ�.

-- �θ� ���̺�
SELECT *
FROM TBL_JOBS;
/*
1	���
2	�븮
*/

-- �ڽ� ���̺�
SELECT *
FROM TBL_EMP1;
/*
1	������	1
2	�ڰ���	2
4	���ȯ	1
5	��ٽ�	1
6	������	
*/

-- �θ� ���̺�(TBL_JOBS)���� ��� ������ ����
SELECT *
FROM TBL_JOBS
WHERE JIKWI_ID=1;

DELETE
FROM TBL_JOBS
WHERE JIKWI_ID=1;
--==> 1 �� ��(��) �����Ǿ����ϴ�.

-- �θ� ���̺�
SELECT *
FROM TBL_JOBS;
/*
2	�븮
*/

-- �ڽ� ���̺�
SELECT *
FROM TBL_EMP1;
/*
2	�ڰ���	2
6	������	
*/

DROP TABLE TBL_EMP2;
--==> Table TBL_EMP2��(��) �����Ǿ����ϴ�.

DROP TABLE TBL_EMP3;
--==> Table TBL_EMP3��(��) �����Ǿ����ϴ�.

DROP TABLE TBL_JOBS;
--==> ���� �߻�
-- ORA-02449: unique/primary keys in table referenced by foreign keys
-- TBL_EMP1�� ���� ����

DROP TABLE TBL_EMP1;
--==> Table TBL_EMP1��(��) �����Ǿ����ϴ�.

DROP TABLE TBL_JOBS;
--==> Table TBL_JOBS��(��) �����Ǿ����ϴ�.

--���� NOT NULL(NN:CK:C) ����--

-- 1. ���̺��� ������ �÷��� �����Ͱ� NULL �� ���¸� ���� ���ϵ��� �ϴ� ��������.

-- 2. ���� �� ����
-- �� �÷� ������ ���� -> DEFAULT��� ����
--  �÷��� ������ Ÿ�� [CONSTRAINT CONSTRAINT��] NOT NULL

-- �� ���̺� ������ ����
--  �÷��� ������Ÿ��,
--  �÷��� ������Ÿ��,
--  CONSTRAINT CONSTRAINT�� CHECK(�÷��� IS NOT NULL)

-- 3. ������ �����Ǿ� �ִ� ���̺� NOT NULL ���������� �߰��� ���
--    ADD���� MODIFY���� �� ���� ���ȴ�.
--    ALTER TABLE ���̺��
--    MODIFY �÷��� ������Ÿ�� NOT NULL;

-- 4. ���� ���̺� �����Ͱ� �̹� ������� ���� �÷�(-> NULL�� ����)��
--    NOT NULL ���������� ������ �����ϴ� ��쿡�� ���� �߻��Ѵ�.

--�� NOT NULL ���� �ǽ�(�� �÷� ������ ����)
-- ���̺� ����
CREATE TABLE TBL_TEST11
( COL1      NUMBER(5)   PRIMARY KEY
, COL2      VARCHAR2(30) NOT NULL
);
--==> Table TBL_TEST11��(��) �����Ǿ����ϴ�.

-- ������ �Է�
INSERT INTO TBL_TEST11(COL1, COL2) VALUES(1,'TEST');

INSERT INTO TBL_TEST11(COL1, COL2) VALUES(2,'ABCD');

INSERT INTO TBL_TEST11(COL1, COL2) VALUES(3,NULL);
--==> ���� �߻�
-- ORA-01400: cannot insert NULL into ("HR"."TBL_TEST11"."COL2")

INSERT INTO TBL_TEST11(COL1) VALUES(4);
--==> ���� �߻�
-- ORA-01400: cannot insert NULL into ("HR"."TBL_TEST11"."COL2")

-- Ȯ��
SELECT *
FROM TBL_TEST11;
/*
1	TEST
2	ABCD
*/

--�������� Ȯ��
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME ='TBL_TEST11';
/*
HR	SYS_C007048	TBL_TEST11	C	COL2	"COL2" IS NOT NULL	
HR	SYS_C007049	TBL_TEST11	P	COL1		
*/

--�� NOT NULL ���� �ǽ�(�� ���̺� ������ ����)
CREATE TABLE TBL_TEST12
( COL1      NUMBER(5)
, COL2      VARCHAR2(30)
, CONSTRAINT TEST12_COL1_PK PRIMARY KEY(COL1)
, CONSTRAINT TEST12_COL2_NN CHECK(COL2 IS NOT NULL)
);
--==> Table TBL_TEST12��(��) �����Ǿ����ϴ�.

--�������� Ȯ��
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME ='TBL_TEST12';
/*
HR	TEST12_COL2_NN	TBL_TEST12	C	COL2	COL2 IS NOT NULL	
HR	TEST12_COL1_PK	TBL_TEST12	P	COL1		
*/

--�� NOT NULL ���� �ǽ�(�� ���̺� ���� ���� �������� �߰�)
CREATE TABLE TBL_TEST13
( COL1      NUMBER(5)
, COL2      VARCHAR2(30)
);
--==> Table TBL_TEST13��(��) �����Ǿ����ϴ�.

--�������� Ȯ��
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME ='TBL_TEST13';
--==> ��ȸ ��� ����

-- �������� �߰�
ALTER TABLE TBL_TEST13
ADD ( CONSTRAINT TEST13_COL1_PK PRIMARY KEY(COL1)
    , CONSTRAINT TEST13_COL2_NN CHECK(COL2 IS NOT NULL));
--==> Table TBL_TEST13��(��) ����Ǿ����ϴ�.

--�������� Ȯ��
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME ='TBL_TEST13';
/*
HR	TEST13_COL1_PK	TBL_TEST13	P	COL1		
HR	TEST13_COL2_NN	TBL_TEST13	C	COL2	COL2 IS NOT NULL	
*/

-- ���� �� ����
--�� NOT NULL �������Ǹ� TBL_TEST13 ���̺��� COL2 �� �߰��ϴ� ���
--   ������ ���� ����� ����ϴ� �͵� �����ϴ�.
ALTER TABLE TBL_TEST13
MODIFY COL2 NOT NULL;
--==> Table TBL_TEST13��(��) ����Ǿ����ϴ�.

--�������� Ȯ��
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME ='TBL_TEST13';
/*
HR	TEST13_COL1_PK	TBL_TEST13	P	COL1		
HR	TEST13_COL2_NN	TBL_TEST13	C	COL2	COL2 IS NOT NULL	
HR	SYS_C007054	TBL_TEST13	C	COL2	"COL2" IS NOT NULL	
*/

-- �÷� �������� NOT NULL ���������� ������ ���̺�(TBL_TEST11)
DESC TBL_TEST11;
/*
�̸�   ��?       ����           
---- -------- ------------ 
COL1 NOT NULL NUMBER(5)    
COL2 NOT NULL VARCHAR2(30) 
*/

-- ���̺� �������� NOT NULL ���������� ������ ���̺�(TBL_TEST12)
DESC TBL_TEST12;
/*
�̸�   ��?       ����           
---- -------- ------------ 
COL1 NOT NULL NUMBER(5)    
COL2          VARCHAR2(30)
*/

-- ���̺� ���� ���� ADD �� ���� NOT NULL ���������� �߰��Ͽ�����
-- ���⿡ ���Ͽ�, MODIFY ���� ���� NOT NULL ���������� �߰��� ���̺�(TBL_TEST13)
DESC TBL_TEST13;
/*
�̸�   ��?       ����           
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

--���� DEFAULT ǥ���� ����--

-- 1. INSERT �� UPDATE ������
--    Ư�� ���� �ƴ� �⺻ ���� �Է��ϵ��� ó���� �� �ִ�.

-- 2. ���� �� ����
--    �÷��� ������Ÿ�� DEFAULT �⺻��

-- 3. INSERT ��� �� �ش� �÷��� �Էµ� ���� �Ҵ����� �ʰų�
--    DEFAULT Ű���带 Ȱ���Ͽ� �⺻���� ������ ���� �Է��ϵ��� �� �� �ִ�.

-- 4. DEFAULT Ű����� �ٸ� ����(NOT NULL ��) ǥ�Ⱑ �Բ� ���Ǿ�� �ϴ� ���
--    DEFAULT Ű���带 ���� ǥ��(�ۼ�)�� ���� �����Ѵ�.

--�� DEFAULT ǥ���� ���� �ǽ�
-- ���̺� ����
CREATE TABLE TBL_BBS                             -- �Խ��� ���̺� ����
( SID       NUMBER          PRIMARY KEY         -- �Խù� ��ȣ -> �ĺ��� -> �ڵ� ����
, NAME      VARCHAR2(20)                         -- �Խù� �ۼ���
, CONTENTS  VARCHAR2(200)                        -- �Խù� ����
, WRITEDAY  DATE            DEFAULT SYSDATE      -- �Խù� �ۼ���
, COUNTS    NUMBER          DEFAULT 0            -- �Խù� ��ȸ��
, COMMENTS  NUMBER          DEFAULT 0            -- �Խù� ��� ����
);
--==> Table TBL_BBS��(��) �����Ǿ����ϴ�.

--�� SID �� �ڵ� ���� ������ ��Ϸ��� ������ ��ü�� �ʿ��ϴ�.
--   �ڵ����� �ԷµǴ� �÷��� ������� �Է� �׸񿡼� ���ܽ�ų �� �ִ�.

-- ������ ����
CREATE SEQUENCE SEQ_BBS
NOCACHE;
--==> Sequence SEQ_BBS��(��) �����Ǿ����ϴ�.

-- ��¥ ���� ���� ���� ����
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS';
--==> Session��(��) ����Ǿ����ϴ�.

-- �Խù� �ۼ�
INSERT INTO TBL_BBS(SID, NAME, CONTENTS, WRITEDAY, COUNTS, COMMENTS)
VALUES(SEQ_BBS.NEXTVAL, '��罽', '����Ŭ DEFAULT ǥ������ �ǽ����Դϴ�.'
        , TO_DATE('2023-10-31 14:39:10', 'YYYY-MM-DD HH24:MI:SS'), 0 , 0);
--==> 1 �� ��(��) ���ԵǾ����ϴ�.

INSERT INTO TBL_BBS(SID, NAME, CONTENTS, WRITEDAY, COUNTS, COMMENTS)
VALUES(SEQ_BBS.NEXTVAL, '��罽', '����Ŭ DEFAULT ǥ������ �ǽ����Դϴ�.', SYSDATE, 0 , 0);
--==> 1 �� ��(��) ���ԵǾ����ϴ�.

INSERT INTO TBL_BBS(SID, NAME, CONTENTS, WRITEDAY, COUNTS, COMMENTS)
VALUES(SEQ_BBS.NEXTVAL, '������', '��� �ǽ����Դϴ�.', DEFAULT, 0 , 0);
--==> 1 �� ��(��) ���ԵǾ����ϴ�.

INSERT INTO TBL_BBS(SID, NAME, CONTENTS, WRITEDAY, COUNTS, COMMENTS)
VALUES(SEQ_BBS.NEXTVAL, '����ȯ', '������ �ǽ����Դϴ�.', DEFAULT, DEFAULT, DEFAULT);
--==> 1 �� ��(��) ���ԵǾ����ϴ�.

INSERT INTO TBL_BBS(SID, NAME, CONTENTS)
VALUES(SEQ_BBS.NEXTVAL, '������', '������ �ǽ����Դϴ�.');
--==> 1 �� ��(��) ���ԵǾ����ϴ�.

SELECT *
FROM TBL_BBS;
/*
1	��罽	����Ŭ DEFAULT ǥ������ �ǽ����Դϴ�.	2023-10-31 14:39:10	0	0
2	��罽	����Ŭ DEFAULT ǥ������ �ǽ����Դϴ�.	2023-10-31 14:45:12	0	0
3	������	��� �ǽ����Դϴ�.	                    2023-10-31 14:46:14	0	0
4	����ȯ	������ �ǽ����Դϴ�.	                    2023-10-31 14:47:10	0	0
5	������	������ �ǽ����Դϴ�.                 	2023-10-31 14:48:05	0	0
*/

--�� DEFAULT ǥ���� ��ȸ(Ȯ��)
SELECT *
FROM USER_TAB_COLUMNS
WHERE TABLE_NAME='TBL_BBS';
--DATA_DEFAULT�� ���� Ȯ�� ����
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

--�� ���̺� ���� ���� DEFAULT ǥ���� �߰� / ����
ALTER TABLE ���̺��
MODIFY �÷��� [�ڷ���(��������)] DEFAULT �⺻��;

--�� ������ DEFAULT ǥ���� ����
ALTER TABLE ���̺��
MODIFY �÷��� [�ڷ���] DEFAULT NULL;

COMMIT;
--==> Ŀ�� �Ϸ�.






















