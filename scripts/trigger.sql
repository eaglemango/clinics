/*
 При увольнении медсестры возникает следующая проблема: её/его ID
 используется в таблице DOCTOR в качестве FOREIGN KEY,
 соответственно безболезненно запись о медстре мы удалить не можем.
 Проведём предварительную обработку таблицы DOCTOR: заменим всем
 врачам медсестру, если её увольняют.
 */
CREATE TRIGGER NURSE_DISMISSAL
    BEFORE DELETE ON NURSE
    FOR EACH ROW
    EXECUTE FUNCTION CHANGE_NURSE();

/*
 При обновлении цены услуги мы можем сломать версионность таблицы SERVICE,
 поэтому вручную проставляем новой цене новую дату, при этом сохраняя
 старую строку, относящуюся к услуге.
 */
CREATE TRIGGER UPDATE_PRICE_AMT
    AFTER UPDATE OF PRICE_AMT ON SERVICE
    FOR EACH ROW
    EXECUTE FUNCTION UPDATE_PRICE();
