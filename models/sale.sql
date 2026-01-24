CREATE TABLE IF NOT EXISTS sale(
	sale_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
	livestock_post_id UUID NOT NULL REFERENCES livestock_post(livestock_post_id) ON DELETE RESTRICT,
	sold_by UUID NOT NULL REFERENCES app_user(app_user_id) ON DELETE RESTRICT,
	bought_by UUID NOT NULL REFERENCES app_user(app_user_id) ON DELETE RESTRICT,
	amount NUMERIC(8,2) NOT NULL,
	commission_percentage NUMERIC(4,2) DEFAULT 2.5,
	commission_amount NUMERIC(8,2) GENERATED ALWAYS AS (amount * commission_percentage / 100) STORED,
	sale_rating NUMERIC(2,1) CHECK (sale_rating BETWEEN 1 AND 5),
	sale_completed BOOLEAN DEFAULT false,
	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	CONSTRAINT chk_sale_not_self
		CHECK (sold_by <> bought_by)
);
CREATE INDEX idx_sale_sold_by_completed
ON sale (sold_by)
WHERE sale_completed = true AND sale_rating IS NOT NULL;
