CREATE TABLE IF NOT EXISTS company(
	company_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
	app_user_id UUID UNIQUE NOT NULL REFERENCES app_user(app_user_id) ON DELETE CASCADE,
	company_name VARCHAR(50) NOT NULL,
	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
-- TODO: verificar si es necesario guardar mas información de una persona
);
