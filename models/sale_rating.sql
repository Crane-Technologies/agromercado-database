CREATE TABLE IF NOT EXISTS sale_rating(
    sale_rating_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    sale_id UUID NOT NULL REFERENCES sale(sale_id) ON DELETE CASCADE,
    rater_id UUID NOT NULL REFERENCES app_user(app_user_id) ON DELETE CASCADE,
    rated_user_id UUID NOT NULL REFERENCES app_user(app_user_id) ON DELETE CASCADE,
    rating NUMERIC(2,1) NOT NULL CHECK (rating BETWEEN 1.0 AND 5.0),
    comment TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT chk_sale_rating_not_self CHECK (rater_id <> rated_user_id),
    CONSTRAINT uq_sale_rating_rater UNIQUE (sale_id, rater_id)
);

CREATE INDEX IF NOT EXISTS idx_sale_rating_rated_user ON sale_rating(rated_user_id);
CREATE INDEX IF NOT EXISTS idx_sale_rating_sale ON sale_rating(sale_id);