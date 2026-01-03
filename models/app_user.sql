CREATE TABLE IF NOT EXISTS app_user(
	app_user_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
	role_id INTEGER NOT NULL REFERENCES role(role_id) ON DELETE CASCADE, 
	email VARCHAR(50) UNIQUE NOT NULL,
	phone VARCHAR(20) UNIQUE NOT NULL,
	password_hash VARCHAR(255) NOT NULL,
	document_type VARCHAR(1) NOT NULL,
	document_number INTEGER UNIQUE NOT NULL,
	township_id INTEGER NOT NULL REFERENCES township(township_id) ON DELETE RESTRICT, 
	is_verified BOOLEAN DEFAULT false, -- para verificación de correo electrónico al crear la cuenta.
	reputation_level_id INTEGER NOT NULL REFERENCES reputation_level(reputation_level_id) DEFAULT 1 ON DELETE RESTRICT,
	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	CONSTRAINT chk_app_user_phone
		CHECK (phone ~ '^\+[1-9][0-9]{7,14}$'),
	CONSTRAINT chk_app_user_document_type
		CHECK (document_type IN ('V','J'))
);
