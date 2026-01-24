CREATE TABLE IF NOT EXISTS township(
	township_id SERIAL PRIMARY KEY,
	township_name VARCHAR(50) NOT NULL,
	township_state_id INTEGER NOT NULL REFERENCES state(state_id),
	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	UNIQUE (township_name, township_state_id)
);
