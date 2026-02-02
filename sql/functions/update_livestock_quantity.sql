CREATE OR REPLACE FUNCTION update_livestock_quantity()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE livestock_post
    SET quantity = quantity - NEW.quantity
    WHERE livestock_post_id = NEW.livestock_post_id;

    UPDATE livestock_post
    SET is_active = false
    WHERE livestock_post_id = NEW.livestock_post_id
    AND quantity <= 0;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION update_livestock_quantity() 
IS 'Updates the quantity of livestock in the livestock_post table after a sale is made. 
Deactivates the post if quantity reaches zero or below.';

