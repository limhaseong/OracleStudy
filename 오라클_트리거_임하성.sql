--�� TBL_��� ���̺��� ������ �Է�, ����, ���� ��
--   TBL_��ǰ ���̺��� �ش� ��ǰ�� ���� ������ ���� Ʈ���� �ۼ�
--   Ʈ���Ÿ� : TRG_CHULGO
--   ���� ���ϸ� : ����Ŭ_Ʈ����_���ϼ�.sql
--   ��� ���� ���� ���� ó���� ��

-- Ʈ���� ����
CREATE OR REPLACE TRIGGER TRG_CHULGO
        AFTER
        INSERT OR UPDATE OR DELETE ON TBL_���
        FOR EACH ROW
        
DECLARE
    -- �ֿ� ���� ����
    V_������ TBL_��ǰ.������%TYPE;
    USER_DEFINE_ERROR EXCEPTION;
    
BEGIN
    --�����
        IF (INSERTING)
        THEN SELECT ������ INTO V_������
              FROM TBL_��ǰ
              WHERE ��ǰ�ڵ� = :NEW.��ǰ�ڵ�;
        ELSIF (UPDATING)
        THEN SELECT ������ INTO V_������
              FROM TBL_��ǰ
              WHERE ��ǰ�ڵ� = :NEW.��ǰ�ڵ�;
        ELSIF (DELETING)
        THEN SELECT ������ INTO V_������
              FROM TBL_��ǰ
              WHERE ��ǰ�ڵ� = :OLD.��ǰ�ڵ�;
        END IF;
    
    IF (INSERTING)
        THEN IF (V_������ - :NEW.������ < 0)
              THEN RAISE USER_DEFINE_ERROR;
              END IF;
              
              UPDATE TBL_��ǰ
              SET ������ = ������ - :NEW.������
              WHERE ��ǰ�ڵ� = :NEW.��ǰ�ڵ�;
              
    ELSIF (UPDATING)
        THEN IF (V_������ + :OLD.������ - :NEW.������ < 0)
              THEN RAISE USER_DEFINE_ERROR;
              END IF;
              
             UPDATE TBL_��ǰ
             SET ������ = ������ + :OLD.������ - :NEW.������
             WHERE ��ǰ�ڵ� = :OLD.��ǰ�ڵ�;
             
    ELSIF (DELETING)
        THEN UPDATE TBL_��ǰ
             SET ������ = ������ + :OLD.������
             WHERE ��ǰ�ڵ� = :OLD.��ǰ�ڵ�;
    END IF;
    
    --���� ó��
    EXCEPTION
    WHEN USER_DEFINE_ERROR
        THEN RAISE_APPLICATION_ERROR(-20002, '��� ����~');
END;