-- C - Create Function <-> INSERT
INSERT INTO SERVICE VALUES ('Восстановление эмали', '19/04/2020', 5000);
INSERT INTO STAFF VALUES (13, 5, 'Базаров Евгений Васильевич', 'Ответственный за нигилизм');
INSERT INTO PATIENT VALUES (12, 'Журавлёв Иван Иванович');
INSERT INTO  MEDICAL_RECORD VALUES (12, 12, '');

-- R - Read Function <-> SELECT
SELECT CLINIC_NO, MIN(NURSE_ID) as FIRST_NURSE_ID
FROM NURSE
GROUP BY CLINIC_NO;

SELECT AVG(PRICE_AMT)
FROM SERVICE;

-- U - Update Function <-> UPDATE
UPDATE STAFF
SET STAFF_NM = 'Ёлкина Анастасия Никандровна'
WHERE STAFF_ID = 1;

UPDATE PATIENT
SET BIRTH_DT = '01/05/2000'
WHERE PATIENT_ID = 12;

-- D - Delete Function <-> DELETE
DELETE FROM STAFF
WHERE STAFF_ID = 4;

DELETE FROM MEDICAL_RECORD
WHERE PATIENT_ID = 11;

DELETE FROM patient
WHERE PATIENT_ID = 11;