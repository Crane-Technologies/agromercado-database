CREATE TRIGGER trg_sale_updated_at
BEFORE UPDATE ON sale
FOR EACH ROW
EXECUTE FUNCTION update_timestamp();