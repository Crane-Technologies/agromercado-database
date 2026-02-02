CREATE TRIGGER trg_purchase_notification_updated_at
BEFORE UPDATE ON purchase_notification
FOR EACH ROW
EXECUTE FUNCTION update_timestamp();
