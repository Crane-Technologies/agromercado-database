CREATE TRIGGER trg_reputation_level_updated_at
BEFORE UPDATE ON reputation_level
FOR EACH ROW
EXECUTE FUNCTION update_timestamp();
