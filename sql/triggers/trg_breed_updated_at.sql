CREATE TRIGGER trg_breed_updated_at
BEFORE UPDATE ON breed
FOR EACH ROW
EXECUTE FUNCTION update_timestamp();
