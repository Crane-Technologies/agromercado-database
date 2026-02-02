CREATE TRIGGER trg_purchase_notification_type_updated_at
BEFORE UPDATE ON purchase_notification_type
FOR EACH ROW
EXECUTE FUNCTION update_timestamp();
