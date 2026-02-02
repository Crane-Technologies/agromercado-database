CREATE TRIGGER trg_livestock_post_updated_at
BEFORE UPDATE ON livestock_post
FOR EACH ROW
EXECUTE FUNCTION update_timestamp();
