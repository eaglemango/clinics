CREATE DATABASE CLINIC_DATABASE;

CREATE TABLE CLINIC(
    CLINIC_NO INTEGER PRIMARY KEY,
    CLINIC_ADDR VARCHAR(300) NOT NULL
);

CREATE TABLE STAFF(
    STAFF_ID INTEGER PRIMARY KEY,
    CLINIC_NO INTEGER NOT NULL,
    STAFF_NM VARCHAR(100) NOT NULL,
    JOB_NM VARCHAR(50) NOT NULL,
    FOREIGN KEY (CLINIC_NO) REFERENCES CLINIC(CLINIC_NO)
);

CREATE TABLE NURSE(
    NURSE_ID INTEGER PRIMARY KEY,
    CLINIC_NO INTEGER NOT NULL,
    NURSE_NM VARCHAR(100) NOT NULL,
    FOREIGN KEY (CLINIC_NO) REFERENCES CLINIC(CLINIC_NO)
);

CREATE TABLE DOCTOR(
    DOCTOR_ID INTEGER PRIMARY KEY,
    CLINIC_NO INTEGER NOT NULL,
    NURSE_ID INTEGER NOT NULL,
    DOCTOR_NM VARCHAR(100) NOT NULL,
    FOREIGN KEY (CLINIC_NO) REFERENCES CLINIC(CLINIC_NO),
    FOREIGN KEY (NURSE_ID) REFERENCES NURSE(NURSE_ID)
);

CREATE TABLE DOCTOR_EDUCATION(
    DOCTOR_ID INTEGER NOT NULL UNIQUE,
    SPECIALIZATION_NM VARCHAR(50) NOT NULL,
    DOCTOR_CATEGORY INTEGER NOT NULL,
    FOREIGN KEY (DOCTOR_ID) REFERENCES DOCTOR(DOCTOR_ID)
);

CREATE TABLE PATIENT(
    PATIENT_ID INTEGER PRIMARY KEY,
    PATIENT_NM VARCHAR(100) NOT NULL,
    BIRTH_DT DATE
);

CREATE TABLE MEDICAL_RECORD(
    RECORD_ID INTEGER PRIMARY KEY,
    PATIENT_ID INTEGER NOT NULL UNIQUE,
    STORY_DESC VARCHAR(1000),
    FOREIGN KEY (PATIENT_ID) REFERENCES PATIENT(PATIENT_ID)
);

CREATE TABLE APPOINTMENT(
    APPOINTMENT_ID INTEGER PRIMARY KEY,
    DOCTOR_ID INTEGER NOT NULL,
    RECORD_ID INTEGER NOT NULL,
    APPOINTMENT_DTTM TIMESTAMP NOT NULL,
    FOREIGN KEY (DOCTOR_ID) REFERENCES DOCTOR(DOCTOR_ID),
    FOREIGN KEY (RECORD_ID) REFERENCES MEDICAL_RECORD(RECORD_ID)
);

CREATE TABLE SERVICE(
    SERVICE_NM VARCHAR(100) NOT NULL,
    INFO_START_DT DATE NOT NULL,
    INFO_END_DT DATE NOT NULL,
    PRIMARY KEY (SERVICE_NM, INFO_START_DT, INFO_END_DT),
    PRICE_AMT INTEGER NOT NULL
);

CREATE TABLE SERVICE_IN_APPOINTMENT(
    APPOINTMENT_ID INTEGER NOT NULL,
    SERVICE_NM VARCHAR(100) NOT NULL,
    PRIMARY KEY (APPOINTMENT_ID, SERVICE_NM),
    FOREIGN KEY (APPOINTMENT_ID) REFERENCES APPOINTMENT(APPOINTMENT_ID)
);
