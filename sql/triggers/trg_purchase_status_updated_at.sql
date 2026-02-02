CREATE TRIGGER trg_purchase_status_updated_at
BEFORE UPDATE ON purchase_status
FOR EACH ROW
EXECUTE FUNCTION update_timestamp();
