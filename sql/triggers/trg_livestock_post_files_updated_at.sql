CREATE TRIGGER trg_livestock_post_files_updated_at
BEFORE UPDATE ON livestock_post_files
FOR EACH ROW
EXECUTE FUNCTION update_timestamp();
