CREATE TRIGGER trg_purchase_request_updated_at
BEFORE UPDATE ON purchase_request
FOR EACH ROW
EXECUTE FUNCTION update_timestamp();