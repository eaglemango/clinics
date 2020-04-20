/*
    В результате выполнения данного запроса будут получены идентификаторы медсестёр,
    работающих хотя бы с одним врачом наивысшей категории.
 */
SELECT NURSE_ID
FROM DOCTOR INNER JOIN DOCTOR_EDUCATION on DOCTOR.DOCTOR_ID = DOCTOR_EDUCATION.DOCTOR_ID
GROUP BY NURSE_ID
HAVING MIN(DOCTOR_CATEGORY) < 2;

/*
    В результате выполнения данного запроса будет получена средняя цена каждой из услуг
    за всё время работы сети клиник. Результаты будут выведены в порядке убывания цены.
 */
SELECT SERVICE_NM, AVG(PRICE_AMT) as AVERAGE_PRICE_AMT
FROM SERVICE
GROUP BY SERVICE_NM
ORDER BY AVERAGE_PRICE_AMT DESC;

/*
    В результате выполнения данного запроса мы получим топ-5 самых дорогих услуг в клинике.
 */
SELECT TOP_SERVICE.SERVICE_NM, TOP_SERVICE.PRICE_AMT
FROM (
    SELECT RANK() OVER (ORDER BY PRICE_AMT DESC) AS ranking, SERVICE_NM, PRICE_AMT
    FROM SERVICE
) AS TOP_SERVICE
WHERE ranking <= 5;

/*
    В результате выполнения данного запроса для каждого приёма мы получим его стоимость,
    а также долю каждой услуги в нём.
 */
SELECT APPOINTMENT_ID,
       SUM(PRICE_AMT) OVER (PARTITION BY APPOINTMENT_ID) AS TOTAL_PRICE_AMT,
       100 * PRICE_AMT / SUM(PRICE_AMT) OVER (PARTITION BY APPOINTMENT_ID) AS SERVICE_PRICE_PART,
       SERVICE.SERVICE_NM
FROM SERVICE_IN_APPOINTMENT INNER JOIN SERVICE ON SERVICE_IN_APPOINTMENT.SERVICE_NM = SERVICE.SERVICE_NM
WHERE PRICE_AMT >= 0;

/*
    В результате выполнения данного запроса для каждой клиники будут получены пары дежурных,
    которые будут находиться в ней по очереди (сразу всем на работу нельзя из-за коронавируса).
 */
SELECT CLINIC_NO, STAFF_ID, T.PARTNER_ID
FROM (
    SELECT CLINIC_NO,
             STAFF_ID,
             LEAD(STAFF_ID) OVER (PARTITION BY CLINIC_NO) AS PARTNER_ID
    FROM STAFF
) AS T
WHERE T.PARTNER_ID IS NOT NULL;
