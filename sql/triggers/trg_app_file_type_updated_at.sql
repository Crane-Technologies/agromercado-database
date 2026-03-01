CREATE TRIGGER trg_app_file_type_updated_at
BEFORE UPDATE ON app_file_type
FOR EACH ROW
EXECUTE FUNCTION update_timestamp();
