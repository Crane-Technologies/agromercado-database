CREATE TABLE IF NOT EXISTS livestock_post(
	livestock_post_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
	livestock_type_id INTEGER NOT NULL REFERENCES livestock_type(livestock_type_id) ON DELETE RESTRICT,
	posted_by UUID NOT NULL REFERENCES app_user(app_user_id) ON DELETE CASCADE,
	breed_id INTEGER NOT NULL REFERENCES breed(breed_id) ON DELETE RESTRICT,
	sector_id INTEGER NOT NULL REFERENCES sector(sector_id) ON DELETE RESTRICT,
	sex VARCHAR(1) NOT NULL,
	quantity SMALLINT NOT NULL CHECK (quantity > 0),
	avg_weight NUMERIC(6,2) NOT NULL CHECK (avg_weight > 0),
	avg_price NUMERIC(8,2) NOT NULL CHECK (avg_price > 0),
	township_id INTEGER NOT NULL REFERENCES township(township_id) ON DELETE RESTRICT,
	details TEXT,
	is_active BOOLEAN DEFAULT true,
	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	CONSTRAINT chk_animal_post_sex
		CHECK (sex IN ('M','F'))
--TODO: verificar si en lugar de manejar precio promedio, conviene manejar rangos de precio (min_price y max_price).
);
