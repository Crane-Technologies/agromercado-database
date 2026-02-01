CREATE TABLE IF NOT EXISTS sale(
    sale_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    purchase_request_id UUID UNIQUE NOT NULL REFERENCES purchase_request(purchase_request_id) ON DELETE RESTRICT,
    livestock_post_id UUID NOT NULL REFERENCES livestock_post(livestock_post_id) ON DELETE RESTRICT,
    seller_id UUID NOT NULL REFERENCES app_user(app_user_id) ON DELETE RESTRICT,
    buyer_id UUID NOT NULL REFERENCES app_user(app_user_id) ON DELETE RESTRICT,
    sale_type_id INTEGER NOT NULL REFERENCES sale_type(sale_type_id) ON DELETE RESTRICT,
    quantity SMALLINT NOT NULL CHECK (quantity > 0),

    total_weight_kg NUMERIC(8,2) CHECK (total_weight_kg > 0),
    price_per_kg NUMERIC(8,2) CHECK (price_per_kg > 0),
    price_per_unit NUMERIC(10,2) CHECK (price_per_unit > 0),
    total_amount NUMERIC(12,2) GENERATED ALWAYS AS (
        CASE 
            WHEN sale_type_id = 1 THEN total_weight_kg * price_per_kg
            WHEN sale_type_id = 2 THEN quantity * price_per_unit
            ELSE 0
        END
    ) STORED,
    commission_percentage NUMERIC(4,2) DEFAULT 2.5,
    commission_amount NUMERIC(12,2) GENERATED ALWAYS AS (
        CASE 
            WHEN sale_type_id = 1 THEN total_weight_kg * price_per_kg * commission_percentage / 100
            WHEN sale_type_id = 2 THEN quantity * price_per_unit * commission_percentage / 100
            ELSE 0
        END
    ) STORED,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT chk_sale_by_weight
        CHECK (
            (sale_type_id = 1 AND total_weight_kg IS NOT NULL AND price_per_kg IS NOT NULL AND price_per_unit IS NULL)
            OR sale_type_id <> 1
        ),

    CONSTRAINT chk_sale_by_unit
        CHECK (
            (sale_type_id = 2 AND price_per_unit IS NOT NULL AND total_weight_kg IS NULL AND price_per_kg IS NULL)
            OR sale_type_id <> 2
        )
);

CREATE INDEX idx_sale_seller ON sale(seller_id);
CREATE INDEX idx_sale_buyer ON sale(buyer_id);
CREATE INDEX idx_sale_type ON sale(sale_type_id);