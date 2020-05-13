/*
 Триггер-функция для триггера NURSE_DISMISSAL.
 Для всех врачей, которые рискуют остаться без медсестры,
 назначаем новую медсестру.
 */
CREATE OR REPLACE FUNCTION CHANGE_NURSE() RETURNS TRIGGER AS $$
    BEGIN
        UPDATE DOCTOR SET NURSE_ID = (SELECT MAX(NURSE_ID)
                                      FROM NURSE
                                      WHERE CLINIC_NO = (SELECT CLINIC_NO
                                                         FROM NURSE
                                                         WHERE NURSE_ID = OLD.NURSE_ID)
                                            AND NURSE_ID <> OLD.NURSE_ID)
        WHERE DOCTOR.NURSE_ID = OLD.NURSE_ID;

        RETURN OLD;
    END;
$$ LANGUAGE plpgsql;

/*
 Триггер-функция для триггера UPDATE_PRICE_AMT.
 При обновлении цены какой-либо услуги мы должны сохранить
 обратную совместимость, то есть не сломать версионность таблицы SERVICE.
 */
CREATE OR REPLACE FUNCTION UPDATE_PRICE() RETURNS TRIGGER AS $$
    BEGIN
        UPDATE SERVICE SET INFO_START_DT = NOW()
        WHERE SERVICE_NM = OLD.SERVICE_NM;

        INSERT INTO SERVICE VALUES (OLD.SERVICE_NM, OLD.INFO_START_DT, OLD.PRICE_AMT);

        RETURN NEW;
    END;
$$ LANGUAGE plpgsql;
