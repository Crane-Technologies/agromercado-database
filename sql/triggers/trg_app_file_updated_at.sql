CREATE TRIGGER trg_app_file_updated_at
BEFORE UPDATE ON app_file
FOR EACH ROW
EXECUTE FUNCTION update_timestamp();
