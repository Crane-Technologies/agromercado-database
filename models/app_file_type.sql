CREATE TABLE IF NOT EXISTS app_file_type (
	app_file_type_id SERIAL PRIMARY KEY,
	app_file_type_name VARCHAR(10) NOT NULL UNIQUE,
	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

COMMENT ON TABLE app_file_type IS 'Catalog of file types allowed in the system.';
COMMENT ON COLUMN app_file_type.app_file_type_name IS 'Allowed values: image, video.';
