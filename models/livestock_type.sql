CREATE TABLE IF NOT EXISTS livestock_type(
	livestock_type_id SERIAL PRIMARY KEY,
	livestock_type_name VARCHAR(25) NOT NULL,
	livestock_type_description TEXT,
	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
