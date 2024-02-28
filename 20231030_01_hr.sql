SELECT USER
FROM DUAL;
--==> HR

--���� ����ȭ(Normalization) ����--

--�� ����ȭ��?
--   �� ����� �����ͺ��̽� ������ �޸� ���� ���� ����
--   � �ϳ��� ���̺���... �ĺ��ڸ� ������ ���� ���� ���̺��
--   ������ ������ ���Ѵ�. (���ļ� �� �� �ְ� �����ߵ�)

-- ex) ������... �������� �Ǹ��Ѵ�.
--     ������Ʈ -> �ŷ�ó ���� ����� �����ִ� ��ø�� ������
--                   �����ͺ��̽�ȭ �Ϸ��� �Ѵ�.
-- ���̺�� : �ŷ�ó����
/*

  10Byte       10Byte      10Byte       10Byte     10Byte   10Byte  10Byte
--------------------------------------------------------------------------
�ŷ�óȸ���  ȸ���ּ�    ȸ����ȭ    �ŷ�ó������  ����    �̸���   �޴���
--------------------------------------------------------------------------
  LG         ���￩�ǵ�   02-345-6789    ������      ����   chi@na.. 010-23...
  LG         ���￩�ǵ�   02-345-6789    ä�ټ�      ����   cds@da.. 010-76...
  LG         ���￩�ǵ�   02-345-6789    ������      �븮   chy@da.. 010-98...
  LG         ���￩�ǵ�   02-345-6789    ���ѿ�      ����   chw@na.. 010-39...
  SK         ����Ұ���   02-987-6543    ���ϼ�      ����   lhs@na.. 010-12... 
  LG         �λ굿����   051-221-2211   ������      �븮   ljh@em.. 010-55...
  SK         ����Ұ���   02-987-6543    ������      ����   osk@na.. 010-88...
--------------------------------------------------------------------------

����) ���� ���� LG(����)��� ȸ�翡 �ٹ��ϴ� �ŷ�ó ���� �����
      �� 100�����̶�� �����Ѵ�.
      (�� ��(���ڵ�)�� 70Byte)
      
      ��� ��... ���￩�ǵ��� ��ġ�� LG ���簡 ���д�����
      ����� �����ϰ� �Ǿ���.
      ȸ���ּҴ� ���д����� �ٲ��, ȸ����ȭ�� 031-111-2222�� �ٲ�� �Ǿ���.
      
      �׷��� 100�� ���� ȸ���ּҿ� ȸ����ȭ�� �����ؾ� �Ѵ�.
      
      -- �� �� ����Ǿ�� �� ������ -> UPDATE
    
      UPDATE �ŷ�ó����
      SET ȸ���ּ� = '���д�', ȸ����ȭ = '031-111-2222'
      WHERE �ŷ�óȸ��� = 'LG'
        AND ȸ���ּ� = '���￩�ǵ�';
        
      -- 100�� �� ���� �ϵ��ũ�󿡼� �о�ٰ�
         �޸𸮿� �ε���� �־�� �Ѵ�.
         ��, 100�� * 70Byte�� ���
         �ϵ��ũ�󿡼� �о�ٰ� �޸𸮿� �ε���� �־�� �Ѵٴ� ���̴�.
         
         -> �̴� ���̺��� ���谡 �߸��Ǿ����Ƿ�
            DB ������ ������ �޸� ���� ���� DOWN�� ���̴�.
            
            --> �׷��Ƿ� ����ȭ ������ �����ؾ� �Ѵ�.
*/

--�� �� 1 ����ȭ(��)
--> � �ϳ��� ���̺� �ݺ��Ǵ� �÷� ������ �����Ѵٸ�
--  ������ �ݺ��Ǿ� ������ �÷��� �и��Ͽ�
--  ���ο� ���̺��� ������ش�.
/*
-- ���̺�� : ȸ�� -> �θ����̺�(�����޴� ���̺�)
 10Byte     10Byte       10Byte      10Byte      
--------------------------------------
ȸ��ID    �ŷ�óȸ���  ȸ���ּ�    ȸ����ȭ    
------
�����޴� �÷�
--------------------------------------
 10         LG         ���￩�ǵ�   02-345-6789  
 20         SK         ����Ұ���   02-987-6543  
 30         LG         �λ굿����   051-221-2211
--------------------------------------


-- ���̺�� : ���� -> �ڽ����̺�(�����ϴ� ���̺�)
   10Byte     10Byte   10Byte  10Byte   10Byte
------------------------------------
�ŷ�ó������  ����    �̸���   �޴���   ȸ��ID
                                        ------
                                        �����ϴ� �÷�
------------------------------------
������      ����   chi@na.. 010-23...    10
ä�ټ�      ����   cds@da.. 010-76...    10
������      �븮   chy@da.. 010-98...    10
���ѿ�      ����   chw@na.. 010-39...    10
���ϼ�      ����   lhs@na.. 010-12...    20
������      �븮   ljh@em.. 010-55...    30
������      ����   osk@na.. 010-88...    20
------------------------------------
*/
--> �� 1����ȭ(��)�� �����ϴ� �������� �и��� ���̺���
--  �ݵ�� �θ� ���̺�� �ڽ� ���̺��� ���踦 ���� �ȴ�.

--> �θ����̺� -> �����޴� �÷� -> PRIMARY KEY(�⺻Ű, ����Ű)
--> �ڽ����̺� -> �����ϴ� �÷� -> FOREIGN KEY(�ܷ�Ű, ����Ű)

--�� �����޴� �÷��� ���� Ư¡
--   �ݵ�� ������ ��(������)�� ���;� �Ѵ�.
--   ��, �ߺ��� ��(������)�� �־�� �ȵȴ�.
--   ����, ���������(NULL�� �־��) �ȵȴ�.
--   ��, NOT NULL �̾�� �Ѵ�.

--> �� 1����ȭ(��)�� �����ϴ� ��������
--  �θ� ���̺��� PRIMARY KEY��  �׻� �ڽ� ���̺��� FOREIGN KEY �� ���̵ȴ�.

-- ���̺��� �и�(����)�Ǳ� ���� ���·� ��ȸ
/*
SELECT A.�ŷ�óȸ���, A.ȸ���ּ�, A.ȸ����ȭ
     , B.�ŷ�ó������, B.����, B.�̸���, B.�޴���
FROM ȸ�� A, ���� B
WHERE A.ȸ��ID = B.ȸ��ID;
*/
/*
����) ���� ���� LG(����)��� ȸ�翡 �ٹ��ϴ� �ŷ�ó ���� �����
      �� 100�����̶�� �����Ѵ�.
      
      ��� ��... ���￩�ǵ��� ��ġ�� LG ���簡 ���д�����
      ����� �����ϰ� �Ǿ���.
      ȸ���ּҴ� ���д����� �ٲ��, ȸ����ȭ�� 031-111-2222�� �ٲ�� �Ǿ���.
      
      �׷��� ȸ�� ���̺��� 1���� ȸ���ּҿ� ȸ����ȭ�� �����ؾ� �Ѵ�.
      
      -- �� �� ����Ǿ�� �� ������ -> UPDATE
    
      UPDATE �ŷ�ó����
      SET ȸ���ּ� = '���д�', ȸ����ȭ = '031-111-2222'
      WHERE �ŷ�óȸ��� = 'LG'
        AND ȸ���ּ� = '���￩�ǵ�';
        
                ��
                
        UPDATE ȸ��
        SET ȸ���ּ� = '���д�', ȸ����ȭ = '031-111-2222'
        WHERE ȸ��ID = 10;
        
      -- 1 �� ���� �ϵ��ũ�󿡼� �о�ٰ�
         �޸𸮿� �ε���� �־�� �Ѵ�.
         ��, 1 * 40Byte�� ���
         �ϵ��ũ�󿡼� �о�ٰ� �޸𸮿� �ε���� �־�� �Ѵٴ� ���̴�.
         
         -> ����ȭ �������� 100�� ���� ó���ؾ� �� ��������
            1�Ǹ� ó���ϸ� �Ǵ� ������ �ٲ� ��Ȳ�̱� ������
            DB ������ �޸� ���� �Ͼ�� �ʰ� ���� ������ ó���� ���̴�.
            
-- �ŷ�óȸ���, ȸ����ȭ
SELECT �ŷ�óȸ���, ȸ����ȭ | SELECT �ŷ�óȸ���, ȸ����ȭ
FROM ȸ��                     | FROM �ŷ�ó����;
--> 3 * 40Byte                | --> 200�� * 70Byte

-- �ŷ�ó������, ����
SELECT �ŷ�ó������, ����     | SELECT �ŷ�ó������, ����
FROM ����;                    | FROM �ŷ�ó����
--> 200�� * 50Byte            | --> 200�� * 70Byte

-- �ŷ�óȸ���, �ŷ�ó������       | SELECT �ŷ�óȸ���, �ŷ�ó������
SELECT �ŷ�óȸ���, �ŷ�ó������   | FROM �ŷ�ó����
FROM ȸ�� A JOIN ���� B             | 
ON A.ȸ��ID = B.ȸ��ID;             |
--> (3 * 40Byte) + (200�� * 50Byte) | --> 200�� * 70Byte
--> (ȸ�����̺� Ǯ ��ĵ) + (�������̺� Ǯ��ĵ)
*/


-- ���̺�� : �ֹ�
/*
------------------------------------------------------------------------------
 ��ID           ��ǰ�ڵ�                  �ֹ�����        �ֹ�����
------------------------------------------------------------------------------
 UJY1234(�����)   P-KKBK(�ܲʹ��)    2023-10-30 07:20:31     20
 PBK8835(�ڹ���)   P-KKBC(����Ĩ)      2023-10-30 07:21:40     20
 PNY3235(�ڳ���)   P-KKDS(��ũ�ٽ�)    2023-10-30 08:10:10     13
 PKY5834(�ڰ���)   P-SWKK(�����)      2023-10-30 09:07:04     12
                                    :
                                    :
------------------------------------------------------------------------------
*/
--�� �ϳ��� ���̺� �����ϴ� PRIMARY KEY�� �ִ� ������ 1���̴�.
--   ������, PRIMARY KEY�� �̷��(�����ϴ�) �÷��� ������ ����(������)�� ���� �����ϴ�.
--   �÷� 1���θ� ������ PRIMARY KEY�� SINGLE PRIMARY KEY ��� �θ���.
--   (���� �����̸Ӹ� Ű)
--   �� �� �̻��� �÷����� ������ PRIMARY KEY�� COMPOSITE PRIMARY KEY ��� �θ���.
--   (���� �����̸Ӹ� Ű)


--�� �� 2 ����ȭ(��)
--> �� 1 ����ȭ�� ��ģ ��������� PRIMARY KEY �� SINGLE COLUMN�̶��
--  �� 2 ����ȭ�� �������� �ʴ´�.
--  ������, PRIMARY KEY�� COMPOSITE COLUMN�̶��
--  ��.��.��. �� 2 ����ȭ�� �����ؾ� �Ѵ�.

--> �ĺ��ڰ� �ƴ� �÷��� �ĺ��� ��ü �÷��� ���� �������̾�� �ϴµ�
--  �ĺ��� ��ü �÷��� �ƴ� �Ϻ� �ĺ��� �÷��� ���ؼ��� �������̶��
--  �̸� �и��Ͽ� ���ο� ���̺��� ������ �ش�.
--  �� ������ �� 2 ����ȭ�� �Ѵ�.
/*
-- ���̺�� : ���� -> �θ� ���̺�
------------------------------------------------------------------------------
 �����ȣ   �����     ������ȣ    �����ڸ�    ���ǽ��ڵ�   ���ǽǼ���
 ++++++++              ++++++++
      ��>  PRIMARY KEY  <��
------------------------------------------------------------------------------
  J0101     �ڹٱ���    21          ������ó    A301        ����ǽ��� 3�� 40�� �Ը�
  J0102     �ڹ��߱�    22          �׽���      T502        ���ڰ��а� 5�� 60�� �Ը�
  03188   ����Ŭ�߱�    22          �׽���      A301        ����ǽ��� 3�� 40�� �Ը�
  03189   ����Ŭ��ȭ    10          �念��      T502        ���ڰ��а� 5�� 60�� �Ը�
  J3345     JSP ����    20          �ƽ���      K101        �ι����а� 1�� 90�� �Ը�
                                    :
------------------------------------------------------------------------------


-- ���̺�� : ���� -> �ڽ� ���̺�
------------------------------------------------------------------------------
 �����ȣ   ������ȣ        �й�          ����
======================
    FOREIGN KEY
+++++++++                  ++++++
       ��>    PRIMARY KEY   <��
------------------------------------------------------------------------------
  03188     22          2308225(�赿��)    92
  03188     22          2308227(���ȯ)    80
  03189     10          2308229(������)    92
                                    :
------------------------------------------------------------------------------
*/


--�� �� 3 ����ȭ(��)
--> �ĺ��ڰ� �ƴ� �÷��� �ĺ��ڰ� �ƴ� �÷��� �������� ��Ȳ�̶��
--  �̸� �и��Ͽ� ���ο� ���̺��� ������ �־�� �Ѵ�.
--  �� ������ �� 3�������̶� �Ѵ�.
/*
-- ���̺�� : ���� -> �θ� ���̺�
------------------------------------
���ǽ��ڵ�   ���ǽǼ���
------------------------------------
A301        ����ǽ��� 3�� 40�� �Ը�
T502        ���ڰ��а� 5�� 60�� �Ը�
A301        ����ǽ��� 3�� 40�� �Ը�
T502        ���ڰ��а� 5�� 60�� �Ը�
K101        �ι����а� 1�� 90�� �Ը�
                  :
------------------------------------
*/


--�� ����(Relation)�� ����

-- 1 : ��(many)
--> �� 1 ����ȭ�� �����Ͽ� ������ ��ģ ��������� ��Ÿ���� �ٶ����� ����.
--  ������ �����ͺ��̽��� Ȱ���ϴ� �������� �߱��ؾ� �ϴ� ����.

-- 1 : 1
--> ����, ���������� ������ �� �ִ� �����̱� ������
--  ������ �����ͺ��̽� ���� �������� �������̸� ���ؾ� �� ����.

-- ��(many) : ��(many)
--> ������ �𵨸������� ������ �� ������
--  ���� �������� �𵨸������� ������ �� ���� ����
/*
-- ���̺�� : ��                               -- ���̺�� : ��ǰ
--------------------------------------------     --------------------------------------------
 ����ȣ   ����     �̸���     ��ȭ��ȣ        ��ǰ��ȣ    ��ǰ��     ��ǰ�ܰ�    ��ǰ����
--------------------------------------------     --------------------------------------------
 1001       ������   khs@test...  010-1...         pswk      �����        500       ���찡...
 1002       ������   khw@test...  010-2...         pkjk      ���ڱ�        700       ���ڸ�...
 1003       �����   kkt@test...  010-3...         pkkm    ������        800       ������...
 1004       ��ٽ�   kds@test...  010-4...         pjkc      �ڰ�ġ        400       �ڰ���...
                   :                                                    :
--------------------------------------------     --------------------------------------------

                            -- ���̺�� : �ֹ�����(�Ǹ�)
                            ---------------------------------------------------------
                            �ֹ���ȣ    ����ȣ    ��ǰ��ȣ    �ֹ�����     �ֹ�����
                            ---------------------------------------------------------
                                :
                               25        1001        pjkc     2023-10-30...    20
                               26        1002        pjkc     2023-10-30...    10
                               27        1003        pkkm     2023-10-30...    10
                               28        1003        pkkm     2023-10-30...    13
                                                        :
                            ---------------------------------------------------------
*/

--�� �� 4 ����ȭ(��)
--> ������ Ȯ���� ����� ���� many(��) : many(��) ���踦
--  1(��) : many(��) ����� ���߸��� ������ �ٷ� �� 4 ����ȭ ���� �����̴�.
--  -> �Ļ� ���̺� ���� -> ��:�� ���踦 1:�� ����� ���߸��� ���� ����
-- �ֹ� ���̺�, ������û ���̺�

--�� ������ȭ(������ȭ)(��)

-- A ��� -> ������ȭ�� �������� �ʴ� ���� �ٶ����� ���

-- ���̺�� : �μ�         -- ���̺�� : ���
--    10      10    10        10     10    10   10    10      10         10
-----------------------    ----------------------------------------- + --------
-- �μ���ȣ �μ��� �ּ�    �����ȣ ����� ���� �޿� �Ի��� �μ���ȣ    �μ���
-----------------------    ----------------------------------------- + --------
-- 10�� ���ڵ�(��)         1,000,000�� ���ڵ�(��)
-----------------------    ----------------------------------------- + --------

--> ��ȸ �����
--------------------------
-- �μ��� ����� ���� �޿�
--------------------------

--> �μ� ���̺�� ��� ���̺��� JOIN ���� ���� ũ��
-- (10 * 30Byte) + (1,000,000 * 60Byte) = 300 + 60,000,000 = 60,000,300Byte

--> ��� ���̺��� ������ȭ �� �� �� ���̺� �о�� ���� ũ��
--  (��, �μ� ���̺��� �μ��� �÷��� ��� ���̺� �߰��� ���)
--  1,000,000 * 70Byte = 70,000,000Byte


-- B ��� -> ������ȭ�� �����ϴ� ���� �ٶ����� ���

-- ���̺�� : �μ�         -- ���̺�� : ���
--    10      10    10        10     10    10   10    10      10         10
-----------------------    ----------------------------------------- + --------
-- �μ���ȣ �μ��� �ּ�    �����ȣ ����� ���� �޿� �Ի��� �μ���ȣ    �μ���
-----------------------    ----------------------------------------- + --------
-- 500,000�� ���ڵ�(��)         1,000,000�� ���ڵ�(��)
-----------------------    ----------------------------------------- + --------

--> ��ȸ �����
--------------------------
-- �μ��� ����� ���� �޿�
--------------------------

--> �μ� ���̺�� ��� ���̺��� JOIN ���� ���� ũ��
-- (500,000 * 30Byte) + (1,000,000 * 60Byte) = 15,000,000 + 60,000,000 = 75,000,000Byte

--> ��� ���̺��� ������ȭ �� �� �� ���̺� �о�� ���� ũ��
--  (��, �μ� ���̺��� �μ��� �÷��� ��� ���̺� �߰��� ���)
--  1,000,000 * 70Byte = 70,000,000Byte

--==> �θ� ���̺�� �ڽ� ���̺��� ���ڵ��� ������ ���� ���̳��� ������ȭ�� ���ϴ� ���� ����
--    ���ڵ��� ������ ���� ���� �ȳ��� ������ȭ�� �ϴ� ���� ����.


--------------------------------------------------------------------------------

--�� ����
/*
1. ����(relationship, relation)
    - ��� ��Ʈ��(entry)�� ���ϰ��� ������.
    - �� ��(column)�� ������ �̸��� ������ ������ ���ǹ��ϴ�.
    - ���̺��� ��� ��(row==Ʃ��==tuple)�� �������� ������ ������ ���ǹ��ϴ�.
    
2. �Ӽ�(attribute)
    - ���̺��� ��(column)�� ��Ÿ����
    - �ڷ��� �̸��� ���� �ּ� ���� ���� : ��ü�� ����, ���� ���
    - �Ϲ� ����(file)�� �׸�(������==item==�ʵ�==field)�� �ش��Ѵ�.
    - ��ƼƼ(entity)�� Ư���� ���¸� ���
    - �Ӽ�(attribute)�� �̸��� ��� �޶�� �Ѵ�.

3. Ʃ��(tuple)
    - ���̺��� ��(row==��ƼƼ==entity)
    - ������ �� ���� �Ӽ����� ����
    - ���� ���� ����
    - �Ϲ� ����(file)�� ���ڵ�(record)�� �ش��Ѵ�.
    - Ʃ�� ����(tuple variable)
        : Ʃ��(tuple)�� ����Ű�� ����, ��� Ʃ�� ������ ���������� �ϴ� ����

4. ������(domain)
    - �� �Ӽ�(attribute)�� ���� �� �ֵ��� ���� ������ ����
    - �Ӽ� ��� ������ ���� �ݵ�� ������ �ʿ�� ����
    - ��� �����̼ǿ��� ��� �Ӽ����� �������� ������(atomic)�̾�� ��
    - ������ ������
        : �������� ���Ұ� �� �̻� �������� �� ���� ����ü�� ���� ��Ÿ��.

5. �����̼�(relation)
    - ���� �ý��ۿ��� ���ϰ� ���� ����
    - �ߺ��� Ʃ��(tuple==entity==��ƼƼ)�� �������� �ʴ´�. -> ��� ������(Ʃ���� ���ϼ�)
    - �����̼��� Ʃ��(tuple==entity==��ƼƼ)�� ����. ���� Ʃ���� ������ ���ǹ��ϴ�.
    - �Ӽ�(attribute)������ ������ ����.
*/

--------------------------------------------------------------------------------

--���� ���Ἲ(Integrity) ����--
/*
1. ���Ἲ���� ��ü ���Ἲ(Entity Integrity)
              ���� ���Ἲ(Relational Integrity)
              ������ ���Ἲ(Domain Integrity)�� �ִ�.
    
2. ��ü ���Ἲ(Entity Integrity)
    : ��ü ���Ἲ�� �����̼ǿ��� ����Ǵ� Ʃ��(tuple)��
      ���ϼ��� �����ϱ� ���� ���������̴�.

3. ���� ���Ἲ(Relational Integrity)
    : ���� ���Ἲ�� �����̼� ���� ������ �ϰ�����
      �����ϱ� ���� ���������̴�.

4. ������ ���Ἲ(Domain Integrity)
    : ������ ���Ἲ�� ��� ������ ���� ������
      �����ϱ� ���� ���������̴�.

5. ���������� ����
    - PRIMARY KEY(PK:P) -> �⺻Ű, ����Ű, �ĺ�Ű, �ĺ���
      �ش� �÷��� ���� �ݵ�� �����ؾ� �ϸ�, �����ؾ� �Ѵ�.
      (NOT NULL�� UNIQUE �� ���յ� ����)

    - FOREIGN KEY(FK:F:R) -> �ܷ�Ű, �ܺ�Ű, ����Ű
      �ش� �÷��� ���� �����Ǵ� ���̺��� �÷� �����͵� �� �ϳ���
      ��ġ�ϰų� NULL�� ������.

    - UNIQUE(UK:U)
      ���̺� ������ �ش� �÷��� ���� �׻� �����ؾ� �Ѵ�.
      
    - NOT NULL(NN:CK:C)
      �ش� �÷��� NULL�� ������ �� ����.
    
    - CHECK(CK:C)
      �ش� �÷��� ���� ������ �������� ������ ������ �����Ѵ�.
*/

--------------------------------------------------------------------------------

--���� PRIMARY KEY ����--

-- 1. ���̺� ���� �⺻ Ű�� �����Ѵ�.

-- 2. ���̺��� �� ���� �����ϰ� �ĺ��ϴ� �÷� �Ǵ� �÷��� �����̴�.
--    �⺻ Ű�� ���̺� �� �ϳ��� �����Ѵ�.
--    �׷��� �ݵ�� �ϳ��� �÷����θ� �����Ǵ� ���� �ƴϴ�.
--    NULL�� �� ����, �̹� ���̺� �����ϰ� �ִ� �����͸�
--    �ٽ� �Է��� �� ������ ó���Ѵ�.(���ϼ�)
--    UNIQUE INDEX�� ����Ŭ ���������� �ڵ����� �����ȴ�.

-- 3. ���� �� ����
-- �� �÷� ������ ����
-- �÷��� ������ Ÿ��[CONSTRAINT CONSTRAINT��] PRIMARY KEY [(�÷���, ...)]

-- �� ���̺� ������ ����
-- �÷��� ������ Ÿ��,
-- �÷��� ������ Ÿ��,
-- CONSTRAINT CONSTRAINT�� PRIMARY KEY(�÷���, ...)

-- 4. CONSTRAINT �߰� �� CONSTRAINT���� �����ϸ�
--    ����Ŭ ������ �ڵ������� CONSTRAINT���� �ο��Ѵ�.
--    �Ϲ������� CONSTRAINT���� ���̺��_�÷���_CONSTRAINT(��������)����
--    �������� ����Ѵ�.

--�� PK ���� �ǽ�(�� �÷� ������ ����)
--���̺� ����
CREATE TABLE TBL_TEST1
( COL1 NUMBER(5)   PRIMARY KEY
, COL2 VARCHAR2(30)
);
--==> Table TBL_TEST1��(��) �����Ǿ����ϴ�.

SELECT *
FROM TBL_TEST1;

DESC TBL_TEST1;
/*
�̸�   ��?       ����           
---- -------- ------------ 
COL1 NOT NULL NUMBER(5)    
COL2          VARCHAR2(30) 
*/

-- ������ �Է�
INSERT INTO TBL_TEST1(COL1, COL2) VALUES(1,'TEST');  --> �̷��� ���� �� ����
--INSERT INTO TBL_TEST1(COL2, COL1) VALUES('ABCD', 1); --> ����
--INSERT INTO TBL_TEST1(COL2) VALUES('ABCD'); --> ����
--==> 1 �� ��(��) ���ԵǾ����ϴ�.

INSERT INTO TBL_TEST1(COL1, COL2) VALUES(1,'TEST');
--==> ���� �߻�
-- ORA-00001: unique constraint (HR.SYS_C007021) violated
-- ����Ŭ�� ��ü������ ����Ŵ� ��

INSERT INTO TBL_TEST1(COL1, COL2) VALUES(1,'ABCD');
--==> ���� �߻�
-- ORA-00001: unique constraint (HR.SYS_C007021) violated
-- �̸��� �ٲٴ��� ���� �߻��Ѵ�.(ù��° �÷��� ���������� �ɾ����)

INSERT INTO TBL_TEST1(COL1, COL2) VALUES(2,'TEST');
--==> 1 �� ��(��) ���ԵǾ����ϴ�.

INSERT INTO TBL_TEST1(COL1, COL2) VALUES(3,NULL);
--==> 1 �� ��(��) ���ԵǾ����ϴ�.

INSERT INTO TBL_TEST1(COL1) VALUES(4);
--==> 1 �� ��(��) ���ԵǾ����ϴ�.

INSERT INTO TBL_TEST1(COL1) VALUES(4);
--==> ���� �߻�
-- ORA-00001: unique constraint (HR.SYS_C007021) violated

INSERT INTO TBL_TEST1(COL1, COL2) VALUES(5,'ABCD');
--==> 1 �� ��(��) ���ԵǾ����ϴ�.

INSERT INTO TBL_TEST1(COL1, COL2) VALUES(NULL,NULL);
--==> ���� �߻�
-- ORA-01400: cannot insert NULL into ("HR"."TBL_TEST1"."COL1")

INSERT INTO TBL_TEST1(COL2) VALUES('ABCD');
--==> ���� �߻�
-- ORA-01400: cannot insert NULL into ("HR"."TBL_TEST1"."COL1")

-- Ȯ��
SELECT *
FROM TBL_TEST1;
/*
1	TEST
2	TEST
3	(null)
4	(null)
5	ABCD
*/

-- Ŀ��
COMMIT;
--==> Ŀ�� �Ϸ�.

--�� �������� Ȯ��
SELECT *
FROM USER_CONSTRAINTS;
/*
HR	REGION_ID_NN	C	REGIONS	"REGION_ID" IS NOT NULL				ENABLED	NOT DEFERRABLE	IMMEDIATE	VALIDATED	USER NAME			2014-05-29				
HR	REG_ID_PK	P	REGIONS					ENABLED	NOT DEFERRABLE	IMMEDIATE	VALIDATED	USER NAME			2014-05-29	HR	REG_ID_PK		
HR	COUNTRY_ID_NN	C	COUNTRIES	"COUNTRY_ID" IS NOT NULL				ENABLED	NOT DEFERRABLE	IMMEDIATE	VALIDATED	USER NAME			2014-05-29				
HR	COUNTRY_C_ID_PK	P	COUNTRIES					ENABLED	NOT DEFERRABLE	IMMEDIATE	VALIDATED	USER NAME			2014-05-29	HR	COUNTRY_C_ID_PK		
HR	COUNTR_REG_FK	R	COUNTRIES		HR	REG_ID_PK	NO ACTION	ENABLED	NOT DEFERRABLE	IMMEDIATE	VALIDATED	USER NAME			2014-05-29				
HR	LOC_CITY_NN	C	LOCATIONS	"CITY" IS NOT NULL				ENABLED	NOT DEFERRABLE	IMMEDIATE	VALIDATED	USER NAME			2014-05-29				
HR	LOC_ID_PK	P	LOCATIONS					ENABLED	NOT DEFERRABLE	IMMEDIATE	VALIDATED	USER NAME			2014-05-29	HR	LOC_ID_PK		
HR	LOC_C_ID_FK	R	LOCATIONS		HR	COUNTRY_C_ID_PK	NO ACTION	ENABLED	NOT DEFERRABLE	IMMEDIATE	VALIDATED	USER NAME			2014-05-29				
HR	DEPT_NAME_NN	C	DEPARTMENTS	"DEPARTMENT_NAME" IS NOT NULL				ENABLED	NOT DEFERRABLE	IMMEDIATE	VALIDATED	USER NAME			2014-05-29				
HR	DEPT_ID_PK	P	DEPARTMENTS					ENABLED	NOT DEFERRABLE	IMMEDIATE	VALIDATED	USER NAME			2014-05-29	HR	DEPT_ID_PK		
HR	DEPT_LOC_FK	R	DEPARTMENTS		HR	LOC_ID_PK	NO ACTION	ENABLED	NOT DEFERRABLE	IMMEDIATE	VALIDATED	USER NAME			2014-05-29				
HR	JOB_TITLE_NN	C	JOBS	"JOB_TITLE" IS NOT NULL				ENABLED	NOT DEFERRABLE	IMMEDIATE	VALIDATED	USER NAME			2014-05-29				
HR	JOB_ID_PK	P	JOBS					ENABLED	NOT DEFERRABLE	IMMEDIATE	VALIDATED	USER NAME			2014-05-29	HR	JOB_ID_PK		
HR	EMP_LAST_NAME_NN	C	EMPLOYEES	"LAST_NAME" IS NOT NULL				ENABLED	NOT DEFERRABLE	IMMEDIATE	VALIDATED	USER NAME			2014-05-29				
HR	EMP_EMAIL_NN	C	EMPLOYEES	"EMAIL" IS NOT NULL				ENABLED	NOT DEFERRABLE	IMMEDIATE	VALIDATED	USER NAME			2014-05-29				
HR	EMP_HIRE_DATE_NN	C	EMPLOYEES	"HIRE_DATE" IS NOT NULL				ENABLED	NOT DEFERRABLE	IMMEDIATE	VALIDATED	USER NAME			2014-05-29				
HR	EMP_JOB_NN	C	EMPLOYEES	"JOB_ID" IS NOT NULL				ENABLED	NOT DEFERRABLE	IMMEDIATE	VALIDATED	USER NAME			2014-05-29				
HR	EMP_SALARY_MIN	C	EMPLOYEES	salary > 0				ENABLED	NOT DEFERRABLE	IMMEDIATE	VALIDATED	USER NAME			2014-05-29				
HR	EMP_EMAIL_UK	U	EMPLOYEES					ENABLED	NOT DEFERRABLE	IMMEDIATE	VALIDATED	USER NAME			2014-05-29	HR	EMP_EMAIL_UK		
HR	EMP_EMP_ID_PK	P	EMPLOYEES					ENABLED	NOT DEFERRABLE	IMMEDIATE	VALIDATED	USER NAME			2014-05-29	HR	EMP_EMP_ID_PK		
HR	EMP_DEPT_FK	R	EMPLOYEES		HR	DEPT_ID_PK	NO ACTION	ENABLED	NOT DEFERRABLE	IMMEDIATE	VALIDATED	USER NAME			2014-05-29				
HR	EMP_JOB_FK	R	EMPLOYEES		HR	JOB_ID_PK	NO ACTION	ENABLED	NOT DEFERRABLE	IMMEDIATE	VALIDATED	USER NAME			2014-05-29				
HR	EMP_MANAGER_FK	R	EMPLOYEES		HR	EMP_EMP_ID_PK	NO ACTION	ENABLED	NOT DEFERRABLE	IMMEDIATE	VALIDATED	USER NAME			2014-05-29				
HR	DEPT_MGR_FK	R	DEPARTMENTS		HR	EMP_EMP_ID_PK	NO ACTION	ENABLED	NOT DEFERRABLE	IMMEDIATE	VALIDATED	USER NAME			2014-05-29				
HR	JHIST_EMPLOYEE_NN	C	JOB_HISTORY	"EMPLOYEE_ID" IS NOT NULL				ENABLED	NOT DEFERRABLE	IMMEDIATE	VALIDATED	USER NAME			2014-05-29				
HR	JHIST_START_DATE_NN	C	JOB_HISTORY	"START_DATE" IS NOT NULL				ENABLED	NOT DEFERRABLE	IMMEDIATE	VALIDATED	USER NAME			2014-05-29				
HR	JHIST_END_DATE_NN	C	JOB_HISTORY	"END_DATE" IS NOT NULL				ENABLED	NOT DEFERRABLE	IMMEDIATE	VALIDATED	USER NAME			2014-05-29				
HR	JHIST_JOB_NN	C	JOB_HISTORY	"JOB_ID" IS NOT NULL				ENABLED	NOT DEFERRABLE	IMMEDIATE	VALIDATED	USER NAME			2014-05-29				
HR	JHIST_DATE_INTERVAL	C	JOB_HISTORY	end_date > start_date				ENABLED	NOT DEFERRABLE	IMMEDIATE	VALIDATED	USER NAME			2014-05-29				
HR	JHIST_EMP_ID_ST_DATE_PK	P	JOB_HISTORY					ENABLED	NOT DEFERRABLE	IMMEDIATE	VALIDATED	USER NAME			2014-05-29	HR	JHIST_EMP_ID_ST_DATE_PK		
HR	JHIST_JOB_FK	R	JOB_HISTORY		HR	JOB_ID_PK	NO ACTION	ENABLED	NOT DEFERRABLE	IMMEDIATE	VALIDATED	USER NAME			2014-05-29				
HR	JHIST_EMP_FK	R	JOB_HISTORY		HR	EMP_EMP_ID_PK	NO ACTION	ENABLED	NOT DEFERRABLE	IMMEDIATE	VALIDATED	USER NAME			2014-05-29				
HR	JHIST_DEPT_FK	R	JOB_HISTORY		HR	DEPT_ID_PK	NO ACTION	ENABLED	NOT DEFERRABLE	IMMEDIATE	VALIDATED	USER NAME			2014-05-29				
HR	SYS_C004102	O	EMP_DETAILS_VIEW					ENABLED	NOT DEFERRABLE	IMMEDIATE	NOT VALIDATED	GENERATED NAME			2014-05-29				
HR	SYS_C007021	P	TBL_TEST1					ENABLED	NOT DEFERRABLE	IMMEDIATE	VALIDATED	GENERATED NAME			2023-10-30	HR	SYS_C007021		
*/

--�� �������� Ȯ��
SELECT *
FROM USER_CONSTRAINTS
WHERE TABLE_NAME = 'TBL_TEST1';
--==> HR	SYS_C007021	P	TBL_TEST1					ENABLED	NOT DEFERRABLE	IMMEDIATE	VALIDATED	GENERATED NAME			2023-10-30	HR	SYS_C007021		

--�� ���������� ������ �÷� Ȯ��(��ȸ)
SELECT *
FROM USER_CONS_COLUMNS;
/*
HR	REGION_ID_NN	REGIONS	REGION_ID	
HR	REG_ID_PK	REGIONS	REGION_ID	1
HR	COUNTRY_ID_NN	COUNTRIES	COUNTRY_ID	
HR	COUNTRY_C_ID_PK	COUNTRIES	COUNTRY_ID	1
HR	COUNTR_REG_FK	COUNTRIES	REGION_ID	1
HR	LOC_ID_PK	LOCATIONS	LOCATION_ID	1
HR	LOC_CITY_NN	LOCATIONS	CITY	
HR	LOC_C_ID_FK	LOCATIONS	COUNTRY_ID	1
HR	DEPT_ID_PK	DEPARTMENTS	DEPARTMENT_ID	1
HR	DEPT_NAME_NN	DEPARTMENTS	DEPARTMENT_NAME	
HR	DEPT_MGR_FK	DEPARTMENTS	MANAGER_ID	1
HR	DEPT_LOC_FK	DEPARTMENTS	LOCATION_ID	1
HR	JOB_ID_PK	JOBS	JOB_ID	1
HR	JOB_TITLE_NN	JOBS	JOB_TITLE	
HR	EMP_EMP_ID_PK	EMPLOYEES	EMPLOYEE_ID	1
HR	EMP_LAST_NAME_NN	EMPLOYEES	LAST_NAME	
HR	EMP_EMAIL_NN	EMPLOYEES	EMAIL	
HR	EMP_EMAIL_UK	EMPLOYEES	EMAIL	1
HR	EMP_HIRE_DATE_NN	EMPLOYEES	HIRE_DATE	
HR	EMP_JOB_NN	EMPLOYEES	JOB_ID	
HR	EMP_JOB_FK	EMPLOYEES	JOB_ID	1
HR	EMP_SALARY_MIN	EMPLOYEES	SALARY	
HR	EMP_MANAGER_FK	EMPLOYEES	MANAGER_ID	1
HR	EMP_DEPT_FK	EMPLOYEES	DEPARTMENT_ID	1
HR	JHIST_EMPLOYEE_NN	JOB_HISTORY	EMPLOYEE_ID	
HR	JHIST_EMP_ID_ST_DATE_PK	JOB_HISTORY	EMPLOYEE_ID	1
HR	JHIST_EMP_FK	JOB_HISTORY	EMPLOYEE_ID	1
HR	JHIST_START_DATE_NN	JOB_HISTORY	START_DATE	
HR	JHIST_DATE_INTERVAL	JOB_HISTORY	START_DATE	
HR	JHIST_EMP_ID_ST_DATE_PK	JOB_HISTORY	START_DATE	2
HR	JHIST_END_DATE_NN	JOB_HISTORY	END_DATE	
HR	JHIST_DATE_INTERVAL	JOB_HISTORY	END_DATE	
HR	JHIST_JOB_NN	JOB_HISTORY	JOB_ID	
HR	JHIST_JOB_FK	JOB_HISTORY	JOB_ID	1
HR	JHIST_DEPT_FK	JOB_HISTORY	DEPARTMENT_ID	1
HR	SYS_C007021	TBL_TEST1	COL1	1
*/

--�� ���������� ������ �÷� Ȯ��(��ȸ)
SELECT *
FROM USER_CONS_COLUMNS
WHERE TABLE_NAME='TBL_TEST1';
--==> HR	SYS_C007021	TBL_TEST1	COL1	1

--�� USER_CONSTRAINTS �� USER_CONS_COLUMNS �� �������
--   ���������� ������ ���뿡 ���ؼ�
--   ������, �������Ǹ�, ���̺��, ������������, �÷��� �׸��� ��ȸ�Ѵ�.

--���1
SELECT T.OWNER "������", T.CONSTRAINT_NAME "�������Ǹ�", T.CONSTRAINT_TYPE "������������", P.TABLE_NAME "���̺��", P.COLUMN_NAME "�÷���"
FROM USER_CONSTRAINTS T JOIN USER_CONS_COLUMNS P
ON T.CONSTRAINT_NAME = P.CONSTRAINT_NAME;

--����� ���2
SELECT UC.OWNER, UC.CONSTRAINT_NAME, UC.TABLE_NAME, UC.CONSTRAINT_TYPE, UCC.COLUMN_NAME
FROM USER_CONSTRAINTS UC, USER_CONS_COLUMNS UCC
WHERE UC.CONSTRAINT_NAME = UCC.CONSTRAINT_NAME
AND UC.TABLE_NAME = 'TBL_TEST1';
--==> HR	SYS_C007021	TBL_TEST1	P	COL1

--�� PK ���� �ǽ�(�� ���̺� ������ ����)
CREATE TABLE TBL_TEST2
( COL1  NUMBER(5)
, COL2 VARCHAR2(30)
, CONSTRAINT TEST2_COL1_PK PRIMARY KEY(COL1)
);
--==> Table TBL_TEST2��(��) �����Ǿ����ϴ�.

-- ������ �Է�
INSERT INTO TBL_TEST2(COL1, COL2) VALUES(1, 'TEST');
--==> 1 �� ��(��) ���ԵǾ����ϴ�.

INSERT INTO TBL_TEST2(COL1, COL2) VALUES(1, 'TEST');
--==> ���� �߻�
-- ORA-00001: unique constraint (HR.TEST2_COL1_PK) violated

INSERT INTO TBL_TEST2(COL1, COL2) VALUES(1, 'ABCD');
--==> ���� �߻�
-- ORA-00001: unique constraint (HR.TEST2_COL1_PK) violated

INSERT INTO TBL_TEST2(COL1, COL2) VALUES(2, 'ABCD');
--==> 1 �� ��(��) ���ԵǾ����ϴ�.

INSERT INTO TBL_TEST2(COL1, COL2) VALUES(3, NULL);
--==> 1 �� ��(��) ���ԵǾ����ϴ�.

INSERT INTO TBL_TEST2(COL1) VALUES(4);
--==> 1 �� ��(��) ���ԵǾ����ϴ�.

INSERT INTO TBL_TEST2(COL1) VALUES(4);
--==> ���� �߻�
-- ORA-00001: unique constraint (HR.TEST2_COL1_PK) violated

INSERT INTO TBL_TEST2(COL1, COL2) VALUES(5, 'ABCD');
--==> 1 �� ��(��) ���ԵǾ����ϴ�.

INSERT INTO TBL_TEST2(COL1, COL2) VALUES(NULL, NULL);
--==> ���� �߻�
-- ORA-01400: cannot insert NULL into ("HR"."TBL_TEST2"."COL1")

INSERT INTO TBL_TEST2(COL2) VALUES('KKKK');
--==> ���� �߻�
-- ORA-01400: cannot insert NULL into ("HR"."TBL_TEST2"."COL1")

-- Ȯ��
SELECT *
FROM TBL_TEST2;
/*
1	TEST
2	ABCD
3	
4	
5	ABCD
*/

DESC TBL_TEST2;
/*
�̸�   ��?       ����           
---- -------- ------------ 
COL1 NOT NULL NUMBER(5)    
COL2          VARCHAR2(30) 
*/

-- Ŀ��
COMMIT;
--==> Ŀ�� �Ϸ�.

--�� USER_CONSTRAINTS �� USER_CONS_COLUMNS �� �������
--   ���������� ������ ���뿡 ���ؼ�
--   ������, �������Ǹ�, ���̺��, ������������, �÷��� �׸��� ��ȸ�Ѵ�.

SELECT UC.OWNER, UC.CONSTRAINT_NAME, UC.TABLE_NAME, UC.CONSTRAINT_TYPE, UCC.COLUMN_NAME
FROM USER_CONSTRAINTS UC, USER_CONS_COLUMNS UCC
WHERE UC.CONSTRAINT_NAME = UCC.CONSTRAINT_NAME
AND UC.TABLE_NAME = 'TBL_TEST2';
--==> HR	TEST2_COL1_PK	TBL_TEST2	P	COL1

--�� PK ���� �ǽ�(�� ���� �÷� PK ����)
-- ���̺� ����
CREATE TABLE TBL_TEST3
( COL1 NUMBER(5)
, COL2 VARCHAR2(30)
, CONSTRAINT TEST3_COL1_COL2_PK PRIMARY KEY(COL1, COL2)
);
--==> Table TBL_TEST3��(��) �����Ǿ����ϴ�.

-- ������ �Է�
INSERT INTO TBL_TEST3(COL1, COL2) VALUES(1, 'TEST');
--==> 1 �� ��(��) ���ԵǾ����ϴ�.

INSERT INTO TBL_TEST3(COL1, COL2) VALUES(1, 'TEST');
--==> ���� �߻�
-- ORA-00001: unique constraint (HR.TEST3_COL1_COL2_PK) violated

INSERT INTO TBL_TEST3(COL1, COL2) VALUES(1, 'ABCD');
--==> 1 �� ��(��) ���ԵǾ����ϴ�.

INSERT INTO TBL_TEST3(COL1, COL2) VALUES(2, 'ABCD');
--==> 1 �� ��(��) ���ԵǾ����ϴ�.

INSERT INTO TBL_TEST3(COL1, COL2) VALUES(2, 'TEST');
--==> 1 �� ��(��) ���ԵǾ����ϴ�.

INSERT INTO TBL_TEST3(COL1, COL2) VALUES(3, NULL);
--==> ���� �߻�
-- ORA-01400: cannot insert NULL into ("HR"."TBL_TEST3"."COL2")

INSERT INTO TBL_TEST3(COL1, COL2) VALUES(NULL, 'TEST');
--==> ���� �߻�
-- ORA-01400: cannot insert NULL into ("HR"."TBL_TEST3"."COL2")

INSERT INTO TBL_TEST3(COL1, COL2) VALUES(NULL, NULL);
--==> ���� �߻�
-- ORA-01400: cannot insert NULL into ("HR"."TBL_TEST3"."COL2")

-- Ȯ��
SELECT *
FROM TBL_TEST3;
/*
1	ABCD
1	TEST
2	ABCD
2	TEST
*/

-- Ŀ��
COMMIT;
--==> Ŀ�� �Ϸ�.

--�� USER_CONSTRAINTS �� USER_CONS_COLUMNS �� �������
--   ���������� ������ ���뿡 ���ؼ�
--   ������, �������Ǹ�, ���̺��, ������������, �÷��� �׸��� ��ȸ�Ѵ�.

SELECT UC.OWNER, UC.CONSTRAINT_NAME, UC.TABLE_NAME, UC.CONSTRAINT_TYPE, UCC.COLUMN_NAME
FROM USER_CONSTRAINTS UC, USER_CONS_COLUMNS UCC
WHERE UC.CONSTRAINT_NAME = UCC.CONSTRAINT_NAME
AND UC.TABLE_NAME = 'TBL_TEST3';
/*
HR	TEST3_COL1_COL2_PK	TBL_TEST3	P	COL1
HR	TEST3_COL1_COL2_PK	TBL_TEST3	P	COL2
*/

--�� PK ���� �ǽ�(�� ���̺� ���� ���� �������� �߰� ����)
CREATE TABLE TBL_TEST4
( COL1 NUMBER(5)
, COL2 VARCHAR2(30)
);
--==> Table TBL_TEST4��(��) �����Ǿ����ϴ�.

--�� �̹� ������(������� �ִ�) ������ ���̺�
--   �ο��Ϸ��� ���������� ������ �����Ͱ� ���ԵǾ� ���� ���
--   �ش� ���̺� ���������� �߰��ϴ� ���� �Ұ����ϴ�.

-- �������� �߰�
ALTER TABLE TBL_TEST4
ADD CONSTRAINT TEST4_COL1_PK PRIMARY KEY(COL1);
--==> Table TBL_TEST4��(��) ����Ǿ����ϴ�.

--�� USER_CONSTRAINTS �� USER_CONS_COLUMNS �� �������
--   ���������� ������ ���뿡 ���ؼ�
--   ������, �������Ǹ�, ���̺��, ������������, �÷��� �׸��� ��ȸ�Ѵ�.
SELECT UC.OWNER, UC.CONSTRAINT_NAME, UC.TABLE_NAME, UC.CONSTRAINT_TYPE, UCC.COLUMN_NAME
FROM USER_CONSTRAINTS UC, USER_CONS_COLUMNS UCC
WHERE UC.CONSTRAINT_NAME = UCC.CONSTRAINT_NAME
AND UC.TABLE_NAME = 'TBL_TEST4';
--==> HR	TEST4_COL1_PK	TBL_TEST4	P	COL1

--�� �������� Ȯ�� ���� ��(VIEW) ����
CREATE OR REPLACE VIEW VIEW_CONSTCHECK
AS
SELECT UC.OWNER "OWNER"
    , UC.CONSTRAINT_NAME "CONSTRAINT_NAME"
    , UC.TABLE_NAME "TABLE_NAME"
    , UC.CONSTRAINT_TYPE "CONSTRAINT_TYPE"
    , UCC.COLUMN_NAME "COLUMN_NAME"
    , UC.SEARCH_CONDITION "SEARCH_CONDITION"
    , UC.DELETE_RULE "DELETE_RULE"
FROM USER_CONSTRAINTS UC JOIN USER_CONS_COLUMNS UCC
ON UC.CONSTRAINT_NAME = UCC.CONSTRAINT_NAME;
--==> View VIEW_CONSTCHECK��(��) �����Ǿ����ϴ�.

--�� ������ ��(VIEW) �� ���� �������� Ȯ��
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME='TBL_TEST4';
--==> HR	TEST4_COL1_PK	TBL_TEST4	P	COL1		

--------------------------------------------------------------------------------

--���� UNIQUE(UK:U) ����--

-- 1. ���̺��� ������ �÷��� �����Ͱ� �ߺ����� �ʰ� ������ �� �ֵ��� �����ϴ� ��������.
--    PRIMARY KEY �� ������ ��������������, NULL�� ����Ѵٴ� �������� �ִ�.
--    ���������� PRIMARY KEY �� ���������� UNIQUE INDEX �� �ڵ� �����ȴ�.
--    �ϳ��� ���̺� ������ UNIQUE ���������� ���� �� �����ϴ� ���� �����ϴ�.
--    ��, �ϳ��� ���̺� UNIQUE ���������� ���� �� ����� ���� �����ϴٴ� ���̴�.

-- 2. ���� �� ����
-- �� �÷� ������ ����
--  �÷��� ������Ÿ�� [CONSTRAINT CONSTRAINT��] UNIQUE

-- �� ���̺� ������ ����
--  �÷��� ������ Ÿ��,
--  �÷��� ������ Ÿ��,
--  CONSTRAINT CONSTRAINT�� UNIQUE(�÷���, ...)

--�� UK ���� �ǽ�(�� �÷� ������ ����)
CREATE TABLE TBL_TEST5
( COL1 NUMBER(5)      PRIMARY KEY
, COL2 VARCHAR2(30)   UNIQUE
);
--==> Table TBL_TEST5��(��) �����Ǿ����ϴ�.

--�������� ��ȸ
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_TEST5';
/*
HR	SYS_C007025	TBL_TEST5	P	COL1		
HR	SYS_C007026	TBL_TEST5	U	COL2		
*/

-- ������ �Է�
INSERT INTO TBL_TEST5(COL1, COL2) VALUES (1, 'TEST');
--==> 1 �� ��(��) ���ԵǾ����ϴ�.

INSERT INTO TBL_TEST5(COL1, COL2) VALUES (1, 'TEST');
--==> ���� �߻�
-- ORA-00001: unique constraint (HR.SYS_C007025) violated

INSERT INTO TBL_TEST5(COL1, COL2) VALUES (2, 'ABCD');
--==> 1 �� ��(��) ���ԵǾ����ϴ�.

INSERT INTO TBL_TEST5(COL1, COL2) VALUES (3, 'ABCD');
--==> ���� �߻�
-- ORA-00001: unique constraint (HR.SYS_C007026) violated 
-- ����ũ �������� ����

INSERT INTO TBL_TEST5(COL1, COL2) VALUES (3, NULL);
--==> 1 �� ��(��) ���ԵǾ����ϴ�.

INSERT INTO TBL_TEST5(COL1) VALUES (4);
--==> 1 �� ��(��) ���ԵǾ����ϴ�.

INSERT INTO TBL_TEST5(COL1, COL2) VALUES (5, 'ABCD');
--==> ���� �߻�
-- ORA-00001: unique constraint (HR.SYS_C007026) violated 

-- Ȯ��
SELECT *
FROM TBL_TEST5;
/*
1	TEST
2	ABCD
3	
4	
*/

-- Ŀ��
COMMIT;
--==> Ŀ�� �Ϸ�.

--�� UK ���� �ǽ�(�� ���̺� ������ ����)
-- ���̺� ����
CREATE TABLE TBL_TEST6
( COL1 NUMBER(5)
, COL2 VARCHAR2(30)
, CONSTRAINT TEST6_COL1_PK PRIMARY KEY(COL1)
, CONSTRAINT TEST6_COL2_UK UNIQUE(COL2)
);
--==> Table TBL_TEST6��(��) �����Ǿ����ϴ�.

-- �������� Ȯ��
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME='TBL_TEST6';
/*
HR	TEST6_COL1_PK	TBL_TEST6	P	COL1		
HR	TEST6_COL2_UK	TBL_TEST6	U	COL2		
*/

--�� UK ���� �ǽ�(�� ���̺� ���� ���� �������� �߰�)
-- ���̺� ����
CREATE TABLE TBL_TEST7
( COL1 NUMBER(5)
, COL2 VARCHAR2(30)
);
--==> Table TBL_TEST7��(��) �����Ǿ����ϴ�.

-- �������� Ȯ��
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME='TBL_TEST7';
--==> ��ȸ ��� ����

-- �������� �߰�

ALTER TABLE TBL_TEST7
ADD CONSTRAINT TEST7_COL1_PK PRIMARY KEY(COL1);
--   +
ALTER TABLE TBL_TEST7
ADD CONSTRAINT TEST7_COL2_UK UNIQUE(COL2);
-- �̷��� ���� �ص� ������ �Ѱ��� �Ϸ���

ALTER TABLE TBL_TEST7
ADD (CONSTRAINT TEST7_COL1_PK PRIMARY KEY(COL1)
    , CONSTRAINT TEST7_COL2_UK UNIQUE(COL2));
--==> Table TBL_TEST7��(��) ����Ǿ����ϴ�.

-- ���� ���� �߰� ���� �ٽ� Ȯ��
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME='TBL_TEST7';
/*
HR	TEST7_COL1_PK	TBL_TEST7	P	COL1		
HR	TEST7_COL2_UK	TBL_TEST7	U	COL2		
*/

















































