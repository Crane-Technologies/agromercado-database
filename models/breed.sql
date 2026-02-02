CREATE TABLE IF NOT EXISTS breed(
	breed_id SERIAL PRIMARY KEY,
	breed_name VARCHAR(25) NOT NULL,
	breed_description TEXT,
	livestock_type_id INTEGER NOT NULL REFERENCES livestock_type(livestock_type_id),
	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	UNIQUE (breed_name, livestock_type_id)
);
