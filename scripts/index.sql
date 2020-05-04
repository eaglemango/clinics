/*
 Часто на практике нам нужно найти человека по его ФИО, но у нас они расположены не в
 алфавитном порядке, а такие приключения поиск будет проходить полным перебором.
 Воспользуемся индексами для оптимизации нашей базы данных.
 Работаем в UPPERCASE, чтобы поиск был регистронезависимым (ну мало ли).
 */
CREATE INDEX ON DOCTOR ((upper(DOCTOR_NM)));
CREATE INDEX ON NURSE ((upper(NURSE_NM)));
CREATE INDEX ON PATIENT ((upper(PATIENT_NM)));
CREATE INDEX ON STAFF ((upper(STAFF_NM)));

/*
 Аналогично может понадобиться и поиск по названию услуги.
 */
CREATE INDEX ON SERVICE ((upper(SERVICE_NM)));
CREATE INDEX ON SERVICE_IN_APPOINTMENT ((upper(SERVICE_NM)));

/*
 Организовываем индекс на датах рождениях пациентов,
 чтобы ускорить запросы, в которых возникает деление
 по возрасту.
 */
CREATE INDEX BIRTH_DT_INDEX ON PATIENT (BIRTH_DT ASC);
