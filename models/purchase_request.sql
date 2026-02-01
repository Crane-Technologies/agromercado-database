CREATE TABLE IF NOT EXISTS purchase_request(
    purchase_request_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    livestock_post_id UUID NOT NULL REFERENCES livestock_post(livestock_post_id) ON DELETE RESTRICT,
    potential_buyer UUID NOT NULL REFERENCES app_user(app_user_id) ON DELETE RESTRICT,
    requested_quantity SMALLINT NOT NULL CHECK (requested_quantity > 0),
    message TEXT,
    purchase_status_id INTEGER DEFAULT 1 NOT NULL REFERENCES purchase_status(purchase_status_id),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX IF NOT EXISTS idx_purchase_request_buyer ON purchase_request(potential_buyer);
CREATE INDEX IF NOT EXISTS idx_purchase_request_post ON purchase_request(livestock_post_id);
CREATE INDEX IF NOT EXISTS idx_purchase_request_status ON purchase_request(purchase_status_id);