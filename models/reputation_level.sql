CREATE TABLE IF NOT EXISTS reputation_level(
	reputation_level_id SERIAL PRIMARY KEY,
	reputation_level_name VARCHAR(20) NOT NULL,
	reputation_level_hierarchy SMALLINT NOT NULL,
	required_stars NUMERIC(2,1),
	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
