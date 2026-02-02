CREATE TRIGGER trg_role_updated_at
BEFORE UPDATE ON role
FOR EACH ROW
EXECUTE FUNCTION update_timestamp();
