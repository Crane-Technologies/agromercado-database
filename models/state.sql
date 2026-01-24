-- state: tabla catálogo con los estados de venezuela.
CREATE TABLE IF NOT EXISTS state(
	state_id SERIAL PRIMARY KEY,
	state_name VARCHAR(50) UNIQUE NOT NULL,
	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);