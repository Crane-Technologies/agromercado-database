CREATE TRIGGER trg_update_livestock_quantity
AFTER INSERT ON sale
FOR EACH ROW
EXECUTE FUNCTION update_livestock_quantity();