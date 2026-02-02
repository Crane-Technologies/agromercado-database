CREATE TRIGGER trg_sector_updated_at
BEFORE UPDATE ON sector
FOR EACH ROW
EXECUTE FUNCTION update_timestamp();
