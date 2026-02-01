CREATE TRIGGER trg_person_updated_at
BEFORE UPDATE ON person
FOR EACH ROW
EXECUTE FUNCTION update_timestamp();
