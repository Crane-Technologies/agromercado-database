CREATE TRIGGER trg_livestock_type_updated_at
BEFORE UPDATE ON livestock_type
FOR EACH ROW
EXECUTE FUNCTION update_timestamp();
