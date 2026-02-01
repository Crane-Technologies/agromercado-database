CREATE TRIGGER trg_sale_type_updated_at
BEFORE UPDATE ON sale_type
FOR EACH ROW
EXECUTE FUNCTION update_timestamp();
