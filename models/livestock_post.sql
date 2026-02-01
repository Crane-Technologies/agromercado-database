CREATE TABLE IF NOT EXISTS livestock_post(
    livestock_post_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    livestock_type_id INTEGER NOT NULL REFERENCES livestock_type(livestock_type_id) ON DELETE RESTRICT,
    posted_by UUID NOT NULL REFERENCES app_user(app_user_id) ON DELETE CASCADE,
    breed_id INTEGER NOT NULL REFERENCES breed(breed_id) ON DELETE RESTRICT,
    sector_id INTEGER NOT NULL REFERENCES sector(sector_id) ON DELETE RESTRICT,
    sale_type_id INTEGER NOT NULL REFERENCES sale_type(sale_type_id) ON DELETE RESTRICT,
    sex VARCHAR(6) NOT NULL,
    quantity SMALLINT NOT NULL CHECK (quantity > 0),

    avg_weight_kg NUMERIC(6,2),
    price_per_kg NUMERIC(8,2),
    price_per_unit NUMERIC(10,2),
    township_id INTEGER NOT NULL REFERENCES township(township_id) ON DELETE RESTRICT,
    details TEXT,
    is_active BOOLEAN DEFAULT true,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT chk_livestock_post_sex
        CHECK (sex IN ('Male','Female','Both')),

    CONSTRAINT chk_livestock_post_by_weight
        CHECK (
            (sale_type_id = 1 AND avg_weight_kg > 0 AND price_per_kg > 0 AND price_per_unit IS NULL)
            OR sale_type_id <> 1
        ),

    CONSTRAINT chk_livestock_post_by_unit
        CHECK (
            (sale_type_id = 2 AND price_per_unit > 0 AND avg_weight_kg IS NULL AND price_per_kg IS NULL)
            OR sale_type_id <> 2
        )
);

CREATE INDEX IF NOT EXISTS idx_livestock_post_posted_by ON livestock_post(posted_by);
CREATE INDEX IF NOT EXISTS idx_livestock_post_township ON livestock_post(township_id);
CREATE INDEX IF NOT EXISTS idx_livestock_post_sale_type ON livestock_post(sale_type_id);
CREATE INDEX IF NOT EXISTS idx_livestock_post_active ON livestock_post(is_active) WHERE is_active = true;