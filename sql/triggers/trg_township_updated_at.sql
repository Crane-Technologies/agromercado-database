CREATE TRIGGER trg_township_updated_at
BEFORE UPDATE ON township
FOR EACH ROW
EXECUTE FUNCTION update_timestamp();
