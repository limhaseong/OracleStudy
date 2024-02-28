SELECT USER
FROM DUAL;
--==> SCOTT

--�� TBL_STUDENTS ���̺��� ��ȭ��ȣ�� �ּ� �����͸� �����ϴ�(�����ϴ�)
--   ���ν����� �ۼ��Ѵ�.
--   ��, ID�� PW�� ��ġ�ϴ� ��쿡�� ������ ������ �� �ֵ��� ó���Ѵ�.
--   ���ν����� : PRC_STUDENT_UPDATE()
/*
���� ��)
EXEC PRC_STUDENT_UPDATE('moon', 'java000$', '010-9999-9999', '������ Ⱦ��');
--==> ������ ���� X

EXEC PRC_STUDENT_UPDATE('moon', 'java006$', '010-9999-9999', '������ Ⱦ��');
--==> ������ ���� O
*/
-- ���1
CREATE OR REPLACE PROCEDURE PRC_STUDENT_UPDATE
( V_ID      IN TBL_IDPW.ID%TYPE
, V_PW      IN TBL_IDPW.PW%TYPE
, V_TEL     IN TBL_STUDENTS.TEL%TYPE
, V_ADDR    IN TBL_STUDENTS.ADDR%TYPE
)
IS
BEGIN
    -- UPDATE ������ ����
    UPDATE TBL_STUDENTS
    SET TEL = V_TEL, ADDR = V_ADDR
    WHERE ID = V_ID AND V_PW = (SELECT PW
                                 FROM TBL_IDPW
                                 WHERE ID =V_ID);
    -- Ŀ��
    COMMIT;
END;

--����� ���2
CREATE OR REPLACE PROCEDURE PRC_STUDENT_UPDATE
( V_ID      IN TBL_IDPW.ID%TYPE
, V_PW      IN TBL_IDPW.PW%TYPE               -- ����ڰ� �´ٰ� �����ϰ� ���� ���� ��.
, V_TEL     IN TBL_STUDENTS.TEL%TYPE
, V_ADDR    IN TBL_STUDENTS.ADDR%TYPE
)
IS
    V_PW2 TBL_IDPW.PW%TYPE;
    V_FLAG NUMBER := 0;     --�н����尡 ��ġ�ϸ� 1 ���, �н����尡 ����ġ�ϸ� 2�� ���
BEGIN
    SELECT PW INTO V_PW2
    FROM TBL_IDPW
    WHERE ID = 'moon';
    
    IF (V_PW = V_PW2)
        THEN V_FLAG := 1;       -- �н����� ��ġ
    ELSE
        V_FLAG := 2;            -- �н����� ����ġ
    END IF;
    
    UPDATE TBL_STUDENTS
    SET TEL = V_TEL, ADDR = V_ADDR
    WHERE ID = V_ID AND V_FLAG = 1;
    
    COMMIT;
END;
--==> Procedure PRC_STUDENT_UPDATE��(��) �����ϵǾ����ϴ�.

--����� ���3
CREATE OR REPLACE PROCEDURE PRC_STUDENT_UPDATE
( V_ID      IN TBL_IDPW.ID%TYPE
, V_PW      IN TBL_IDPW.PW%TYPE
, V_TEL     IN TBL_STUDENTS.TEL%TYPE
, V_ADDR    IN TBL_STUDENTS.ADDR%TYPE
)
IS
BEGIN
    UPDATE (SELECT T1.ID, T1.PW, T2.TEL, T2.ADDR
            FROM TBL_IDPW T1 JOIN TBL_STUDENTS T2
            ON T1.ID = T2.ID) T
    SET T.TEL = V_TEL, T.ADDR = V_ADDR
    WHERE T.ID = V_ID AND T.PW = V_PW;
    
    COMMIT;
END;
--==> Procedure PRC_STUDENT_UPDATE��(��) �����ϵǾ����ϴ�.


--�� TBL_INSA ���̺��� ������� �ű� ������ �Է� ���ν����� �ۼ��Ѵ�.
-- NUM, NAME, SSN, IBSADATE, CITY, TEL, BUSEO, JIKWI, BASICPAY, SUDANG ���� ������ �÷� ��
-- NUM(�����ȣ)�׸��� ������ ������ �Է� ��
-- �ش� �׸��� ���� ���� �ο��� ��� ��ȣ ������ ��ȣ �� ���� ��ȣ��
-- �ڵ����� �Է� ó���� �� �ִ� ���ν����� �����Ѵ�.
-- ���ν����� : PRC_INSA_INSERT()
/*
���� ��)
EXEC PRC_INSA_INSERT('������', '970812-2234567, SYSDATE, '����', 010-2509-1783, 
                        '���ߺ�', '�븮', 2000000, 2000000);
--> ���� ���� ���ν��� ȣ�� �� ����

1061 ������ 970812-2234567 2023-11-06 ���� 010-2509-1783 ���ߺ� �븮 2000000 2000000
*/
-- ���1
CREATE OR REPLACE PROCEDURE PRC_INSA_INSERT
( V_NAME            IN TBL_INSA.NAME%TYPE
, V_SSN             IN TBL_INSA.SSN%TYPE
, V_IBSADATE        IN TBL_INSA.IBSADATE%TYPE
, V_CITY            IN TBL_INSA.CITY%TYPE
, V_TEL             IN TBL_INSA.TEL%TYPE
, V_BUSEO           IN TBL_INSA.BUSEO%TYPE
, V_JIKWI           IN TBL_INSA.JIKWI%TYPE
, V_BASICPAY        IN TBL_INSA.BASICPAY%TYPE
, V_SUDANG          IN TBL_INSA.SUDANG%TYPE
)
IS
     V_NUM  TBL_INSA.NUM%TYPE;
BEGIN
    SELECT MAX(NUM)+1 INTO V_NUM FROM TBL_INSA;
    
    INSERT INTO TBL_INSA(NUM, NAME, SSN, IBSADATE, CITY, TEL, BUSEO, JIKWI, BASICPAY, SUDANG)
    VALUES(V_NUM, V_NAME, V_SSN, V_IBSADATE, V_CITY, V_TEL, V_BUSEO, V_JIKWI, V_BASICPAY, V_SUDANG);
    
    COMMIT;
END;

-- ����� ���2
CREATE OR REPLACE PROCEDURE PRC_INSA_INSERT
( V_NAME            IN TBL_INSA.NAME%TYPE
, V_SSN             IN TBL_INSA.SSN%TYPE
, V_IBSADATE        IN TBL_INSA.IBSADATE%TYPE
, V_CITY            IN TBL_INSA.CITY%TYPE
, V_TEL             IN TBL_INSA.TEL%TYPE
, V_BUSEO           IN TBL_INSA.BUSEO%TYPE
, V_JIKWI           IN TBL_INSA.JIKWI%TYPE
, V_BASICPAY        IN TBL_INSA.BASICPAY%TYPE
, V_SUDANG          IN TBL_INSA.SUDANG%TYPE
)
IS
    V_NUM TBL_INSA.NUM%TYPE;
BEGIN
    -- ���� �ο��� �����ȣ�� ������ ��ȣ
    SELECT NVL(MAX(NUM),0) INTO V_NUM
    FROM TBL_INSA;
    
    -- ������ �Է� ������ ����
    INSERT INTO TBL_INSA(NUM, NAME, SSN, IBSADATE, CITY, TEL, BUSEO, JIKWI, BASICPAY, SUDANG)
    VALUES((V_NUM+1), V_NAME, V_SSN, V_IBSADATE, V_CITY, V_TEL, V_BUSEO, V_JIKWI, V_BASICPAY, V_SUDANG);
    
    --Ŀ��
    COMMIT;
    
    /*
    -- ���� �ο��� �����ȣ�� ������ ��ȣ
    SELECT MAX(NVL(NUM,0)) +1 INTO V_NUM
    FROM TBL_INSA;
    
    -- ������ �Է� ������ ����
    INSERT INTO TBL_INSA(NUM, NAME, SSN, IBSADATE, CITY, TEL, BUSEO, JIKWI, BASICPAY, SUDANG)
    VALUES(V_NUM, V_NAME, V_SSN, V_IBSADATE, V_CITY, V_TEL, V_BUSEO, V_JIKWI, V_BASICPAY, V_SUDANG);
    
    --Ŀ��
    COMMIT;
    */
END;
--==> Procedure PRC_INSA_INSERT��(��) �����ϵǾ����ϴ�.


--�� 20231106_02_scott.sql ������ �����Ͽ�
--   TBL_��ǰ, TBL_�԰� ���̺��� �������
--   TBL_�԰� ���̺� ������ �Է� ��(��, �԰� �̺�Ʈ �߻� ��)
--   TBL_��ǰ ���̺��� �ش� ��ǰ�� ���� �������� �Բ� ������ �� �ִ� ����� ����
--   ���ν����� �ۼ��Ѵ�.
--   ��, �� �������� �԰��ȣ�� �ڵ� ���� ó���Ѵ�.(������ ��� ����)
--   TBL_�԰� ���̺� ���� �÷���
--   �԰��ȣ, ��ǰ�ڵ�, �԰�����, �԰����, �԰�ܰ��̸�
--   ���ν��� ȣ���� ���� ������ �Ķ���ʹ� ��ǰ�ڵ�, �԰����, �԰�ܰ��̴�.
--   ���ν����� : PRC_�԰�_INSERT(��ǰ�ڵ�, �԰����, �԰�ܰ�)
-- ���1
CREATE OR REPLACE PROCEDURE PRC_�԰�_INSERT
( V_��ǰ�ڵ�    IN TBL_�԰�.��ǰ�ڵ�%TYPE
, V_�԰����    IN TBL_�԰�.�԰����%TYPE
, V_�԰�ܰ�    IN TBL_�԰�.�԰�ܰ�%TYPE
)
IS
    V_�԰��ȣ TBL_�԰�.�԰��ȣ%TYPE;
BEGIN
    SELECT NVL(MAX(�԰��ȣ),0) + 1 INTO V_�԰��ȣ
    FROM TBL_�԰�;
    
    
    INSERT INTO TBL_�԰�(�԰��ȣ, ��ǰ�ڵ�, �԰�����, �԰����, �԰�ܰ�)
    VALUES (V_�԰��ȣ, V_��ǰ�ڵ�, SYSDATE, V_�԰����, V_�԰�ܰ�);
    
    UPDATE TBL_��ǰ
    SET ������ = ������ + V_�԰����
    WHERE ��ǰ�ڵ� = V_��ǰ�ڵ�;
    
    COMMIT;
END;

--����� ���2
CREATE OR REPLACE PROCEDURE PRC_�԰�_INSERT
( V_��ǰ�ڵ�    IN TBL_�԰�.��ǰ�ڵ�%TYPE
, V_�԰����    IN TBL_�԰�.�԰����%TYPE
, V_�԰�ܰ�    IN TBL_�԰�.�԰�ܰ�%TYPE
)
IS
    -- �����
    -- ������ ������ �� ��Ƴ���
    -- �Ʒ��� �������� �����ϱ� ���� �ʿ��� ���� �߰� ����
    V_�԰��ȣ TBL_�԰�.�԰��ȣ%TYPE;
    
BEGIN
    -- �����
    -- SELECT ������ ���� -> �԰��ȣ Ȯ��
    SELECT NVL(MAX(�԰��ȣ),0) INTO V_�԰��ȣ
    FROM TBL_�԰�;
    
    
    -- INSERT ������ ����
    INSERT INTO TBL_�԰�(�԰��ȣ, ��ǰ�ڵ�, �԰����, �԰�ܰ�)
    VALUES ((V_�԰��ȣ+1), V_��ǰ�ڵ�, V_�԰����, V_�԰�ܰ�);
    
    
    -- UPDATE ������ ����
    UPDATE TBL_��ǰ
    SET ������ = ������ + V_�԰����
    WHERE ��ǰ�ڵ� = V_��ǰ�ڵ�;
    
    -- ���� ó��(INSERT���� UPDATE�� �߿� �ϳ��� ó���� �ȵǸ� �ѹ��ض� -> EX) ����� ����Ʈ�� ���ǰ� ������ �ȶ������� ���)
    EXCEPTION
        WHEN OTHERS THEN ROLLBACK;
    
    
    -- Ŀ��
    COMMIT;
    
END;
--==> Procedure PRC_�԰�_INSERT��(��) �����ϵǾ����ϴ�.


--------------------------------------------------------------------------------

--���� ���ν��� �������� ���� ó�� ����--
--�� TBL_MEMBER ���̺� �����͸� �Է��ϴ� ���ν����� �ۼ�
--   ��, �� ���ν����� ���� �����͸� �Է��� ���
--   CITY(����) �׸� '����', '���', '����'�� �Է��� �����ϵ��� �����Ѵ�.
--   �� ���� ���� �ٸ� ������ ���ν��� ȣ���� ���� �Է��Ϸ��� ���
--   (��, ��ȿ���� ���� ������ �Է��� �õ��Ϸ��� ���)
--   ���ܿ� ���� ó���� �Ϸ��� �Ѵ�.
--   ���ν����� : PRC_MEMBER_INSERT()
/*
���� ��)
EXEC PRC_MEMBER_INSERT('�ڹ���', '010-1111-1111', '����');
--==> ������ �Է� O
EXEC PRC_MEMBER_INSERT('����', '010-2222-2222', '�λ�');
--==> ������ �Է� X
*/
CREATE OR REPLACE PROCEDURE PRC_MEMBER_INSERT
( V_NAME    IN TBL_MEMBER.NAME%TYPE
, V_TEL     IN TBL_MEMBER.TEL%TYPE
, V_CITY    IN TBL_MEMBER.CITY%TYPE
)
IS
    -- ���� ������ ������ ������ ���� �ʿ��� ���� ����
    V_NUM TBL_MEMBER.NUM%TYPE;
    
    -- ����� ���� ���ܿ� ���� ���� ����!
    USER_DEFINE_ERROR EXCEPTION;
BEGIN
    -- ���ν����� ���� �Է� ó���� ���������� �����ؾ� �� ���������� �ƴ����� ���θ�
    -- ���� ���� Ȯ���� �� �ֵ��� �ڵ� ����
    IF (V_CITY NOT IN ('����', '���', '����'))
        --���� �߻�
        THEN RAISE USER_DEFINE_ERROR;
    END IF;
    
    -- ������ ������ �� ��Ƴ���
    SELECT NVL(MAX(NUM), 0) INTO V_NUM
    FROM TBL_MEMBER;
    
    -- INSERT ������ ����
    INSERT INTO TBL_MEMBER(NUM, NAME, TEL, CITY)
    VALUES((V_NUM + 1), V_NAME, V_TEL, V_CITY);
    
    -- ���� ó�� ����
    EXCEPTION
        WHEN USER_DEFINE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20001, '����, ���, ������ �Է��� �����մϴ�.');
                ROLLBACK;
        WHEN OTHERS
            THEN ROLLBACK;
    
    -- Ŀ��
    COMMIT;
END;
--==> Procedure PRC_MEMBER_INSERT��(��) �����ϵǾ����ϴ�.


--�� TBL_��� ���̺� ������ �Է� �� (��, ��� �̺�Ʈ �߻� ��)
--   TBL_��ǰ ���̺��� �������� �����Ǵ� ���ν����� �ۼ��Ѵ�.
--   ��, ����ȣ�� �԰��ȣ�� ���������� �ڵ�����.
--   ����, �������� ���������� ���� ���...
--   ��� �׼��� ����� �� �ֵ��� ó���Ѵ�.
--   (��� �̷������ �ʵ���...) -> ���� ó�� Ȱ��
--   ���ν����� : PRC_���_INSERT()
/*
���� ��)
EXEC PRC_���_INSERT('H001', '10', '600');

--> �� ���������� ��ǰ ���̺��� �ٹ�� �������� 70��

EXEC PRC_���_INSERT('H001', '80', '600');

--> ���� �߻�
-- (20002, ��� ����~)
*/
-- ���1
CREATE OR REPLACE PROCEDURE PRC_���_INSERT
( V_��ǰ�ڵ�    IN TBL_���.��ǰ�ڵ�%TYPE
, V_������    IN TBL_���.������%TYPE
, V_���ܰ�    IN TBL_���.���ܰ�%TYPE
)
IS
    V_����ȣ TBL_���.����ȣ%TYPE;
    V_������ TBL_��ǰ.������%TYPE;
    USER_DEFINE_ERROR EXCEPTION;
BEGIN
    SELECT NVL(MAX(����ȣ),0) INTO V_����ȣ
    FROM TBL_���;
    
    SELECT NVL(������,0) INTO V_������
    FROM TBL_��ǰ
    WHERE ��ǰ�ڵ� = V_��ǰ�ڵ�;
    
    
    IF ( V_������< V_������)
        THEN RAISE USER_DEFINE_ERROR;
    END IF;
    
    INSERT INTO TBL_���(����ȣ, ��ǰ�ڵ�, ������, ���ܰ�)
    VALUES ((V_����ȣ+1), V_��ǰ�ڵ�, V_������, V_���ܰ�);
    
    UPDATE TBL_��ǰ
    SET ������ = ������ - V_������
    WHERE ��ǰ�ڵ� = V_��ǰ�ڵ�;
    
    EXCEPTION
    WHEN USER_DEFINE_ERROR
        THEN RAISE_APPLICATION_ERROR(-20002, '��� ����~');
            ROLLBACK;
    WHEN OTHERS
        THEN ROLLBACK;
        
    COMMIT;
END;

-- ����� ��� 2
CREATE OR REPLACE PROCEDURE PRC_���_INSERT
( V_��ǰ�ڵ�    IN TBL_���.��ǰ�ڵ�%TYPE
, V_������    IN TBL_���.������%TYPE
, V_���ܰ�    IN TBL_���.���ܰ�%TYPE
)
IS
    -- �ֿ� ���� ����
    V_����ȣ TBL_���.����ȣ%TYPE;
    V_������ TBL_��ǰ.������%TYPE;
    
    -- ����� ���� ���� ����
    USER_DEFINE_ERROR EXCEPTION;
    
BEGIN
   
    -- ������ ���� ������ ���� ���θ� Ȯ���ϴ� ��������
    -- ������ �ľ� -> ���� ��� Ȯ���ϴ� ������ ����Ǿ�� �Ѵ�.
    -- �׷��� ���ν��� ȣ�� �� �Ѱܹ޴� �������� �񱳰� �����ϱ� ����...
    SELECT ������ INTO V_������
    FROM TBL_��ǰ
    WHERE ��ǰ�ڵ� = V_��ǰ�ڵ�;
    
    -- ��� ���������� �������� �������� ���� ���� Ȯ��
    -- ������ �ľ��� ���������� ���� ���ν������� �Ѱܹ��� �������� ������
    -- ���� �߻�~
    IF (V_������ > V_������)
        -- ���� �߻�
        THEN RAISE USER_DEFINE_ERROR;
    END IF;

    -- ����ȣ ���� -> ������ ������ ������ �� ��Ƴ���
    SELECT NVL(MAX(����ȣ),0) + 1 INTO V_����ȣ
    FROM TBL_���;
 
    -- ������ ���� -> INSERT(TBL_���)
    INSERT INTO TBL_���(����ȣ, ��ǰ�ڵ�, ������, ���ܰ�)
    VALUES(V_����ȣ, V_��ǰ�ڵ�, V_������, V_���ܰ�);
    
    -- ������ ���� -> UPDATE(TBL_��ǰ)
    UPDATE TBL_��ǰ
    SET ������ = ������ - V_������
    WHERE ��ǰ�ڵ� = V_��ǰ�ڵ�;
    
    EXCEPTION
    WHEN USER_DEFINE_ERROR
        THEN RAISE_APPLICATION_ERROR(-20002, '��� ����~');
            ROLLBACK;
    WHEN OTHERS
        THEN ROLLBACK;
    
    -- Ŀ��
    COMMIT;
    
END;
--==> Procedure PRC_���_INSERT��(��) �����ϵǾ����ϴ�.


--�� TBL_��� ���̺��� �������� ����(����)�ϴ� ���ν����� �ۼ��Ѵ�.(UPDATE ���ν���)
--   ���ν����� : PRC_���_UPDATE()
/*
���� ��)
EXEC PRC_���_UPDATE(����ȣ, �����Ҽ���);
*/

CREATE OR REPLACE PROCEDURE PRC_���_UPDATE
( V_����ȣ IN TBL_���.����ȣ%TYPE
, V_�����Ҽ��� IN TBL_���.������%TYPE
)
IS
    V_������ TBL_��ǰ.������%TYPE;
    V_������ TBL_���.������%TYPE;
    V_��ǰ�ڵ� TBL_��ǰ.��ǰ�ڵ�%TYPE;
    
    -- ����� ���� ���� ����
    USER_DEFINE_ERROR EXCEPTION;
    
BEGIN
    SELECT ��ǰ�ڵ� INTO V_��ǰ�ڵ�
    FROM TBL_���
    WHERE ����ȣ = V_����ȣ;
    
    SELECT ������ INTO V_������
    FROM TBL_��ǰ
    WHERE ��ǰ�ڵ� = V_��ǰ�ڵ�;
    
    SELECT ������ INTO V_������
    FROM TBL_���
    WHERE ����ȣ = V_����ȣ;
    
    
    IF (V_�����Ҽ��� - V_������ > V_������) 
        THEN RAISE USER_DEFINE_ERROR;
    END IF;
    
    -- ���� ��� + ��������� - ���������
    
    UPDATE TBL_���
    SET ������ = V_�����Ҽ���
    WHERE ��ǰ�ڵ� = V_��ǰ�ڵ�;
    
    UPDATE TBL_��ǰ
    SET ������ = ������ + V_������ - V_�����Ҽ���
    WHERE ��ǰ�ڵ� = V_��ǰ�ڵ�;

    EXCEPTION
    WHEN USER_DEFINE_ERROR
        THEN RAISE_APPLICATION_ERROR(-20002, '��� ����~');
            ROLLBACK;
    WHEN OTHERS
        THEN ROLLBACK;
        
    COMMIT;

END;







