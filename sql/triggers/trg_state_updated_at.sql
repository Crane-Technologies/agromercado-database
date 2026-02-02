CREATE TRIGGER trg_state_updated_at
BEFORE UPDATE ON state
FOR EACH ROW
EXECUTE FUNCTION update_timestamp();
