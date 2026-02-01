CREATE TRIGGER trg_sale_rating_updated_at
BEFORE UPDATE ON sale_rating
FOR EACH ROW
EXECUTE FUNCTION update_timestamp();