CREATE TABLE IF NOT EXISTS person(
	person_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
	app_user_id UUID UNIQUE NOT NULL REFERENCES app_user(app_user_id) ON DELETE CASCADE,
	first_name VARCHAR(25) NOT NULL,
	middle_name VARCHAR(25),
	surname VARCHAR(25) NOT NULL,
	second_surname VARCHAR(25),
	birthdate DATE,
	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
-- TODO: verificar si es necesario guardar mas información de una persona
);
