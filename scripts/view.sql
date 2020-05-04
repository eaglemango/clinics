/*
 Данное представление позволяет провести анализ обезличенных данных о пациентах.
 */
CREATE VIEW PROTECTED_PATIENT_INFO AS
    SELECT RECORD_ID,
           md5(PATIENT_NM),
           BIRTH_DT,
           STORY_DESC
    FROM PATIENT INNER JOIN MEDICAL_RECORD ON PATIENT.PATIENT_ID = MEDICAL_RECORD.PATIENT_ID;

/*
 Данное представление позволяет узнать стоимость каждого приёма.
 */
CREATE VIEW APPOINTMENT_COST_INFO AS
    SELECT APPOINTMENT_ID,
           sum(PRICE_AMT) AS COST
    FROM SERVICE_IN_APPOINTMENT INNER JOIN SERVICE ON SERVICE_IN_APPOINTMENT.SERVICE_NM = SERVICE.SERVICE_NM
    GROUP BY APPOINTMENT_ID;

/*
 Данное представление позволяет узнать категорию и специализацию каждого врача.
 */
CREATE VIEW DOCTOR_INFO AS
    SELECT DOCTOR_NM,
           SPECIALIZATION_NM,
           DOCTOR_CATEGORY
    FROM DOCTOR INNER JOIN DOCTOR_EDUCATION ON DOCTOR.DOCTOR_ID = DOCTOR_EDUCATION.DOCTOR_ID;

/*
 Данное представление позволят узнать количественное состояние медицинских работников в каждой клинике.
 */
CREATE VIEW MEDICAL_STAFF_INFO AS
    SELECT CLINIC.CLINIC_NO,
           count(DOCTOR_ID) AS DOCTOR_COUNT,
           count(DISTINCT NURSE_ID) AS NURSE_COUNT
    FROM CLINIC INNER JOIN DOCTOR ON CLINIC.CLINIC_NO = DOCTOR.CLINIC_NO
    GROUP BY CLINIC.CLINIC_NO;

/*
 Данное представление позволяет получить все запланированные приёмы
 */
CREATE VIEW FUTURE_APPOINTMENT AS
    SELECT APPOINTMENT_ID,
           DOCTOR_ID,
           RECORD_ID
    FROM APPOINTMENT
    WHERE APPOINTMENT_DTTM >= current_timestamp;

/*
 Данное представление позволяет получить информацию о клинике: номер, адрес и администратор.
 */
CREATE VIEW CLINIC_INFO AS
    SELECT CLINIC.CLINIC_NO,
           CLINIC_ADDR,
           STAFF_NM AS ADMIN
    FROM CLINIC INNER JOIN STAFF ON CLINIC.CLINIC_NO = STAFF.CLINIC_NO;
