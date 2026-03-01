CREATE TABLE IF NOT EXISTS app_file (
	app_file_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
	app_file_name VARCHAR(255) NOT NULL,
	app_file_size_bytes INTEGER NOT NULL CHECK (app_file_size_bytes > 0),
	mime_type VARCHAR(20) NOT NULL,
    livestock_post_id UUID REFERENCES livestock_post(livestock_post_id) ON DELETE CASCADE,
	s3_bucket VARCHAR(255) NOT NULL,
	s3_key VARCHAR(255) NOT NULL,
	is_main_file BOOLEAN NOT NULL DEFAULT FALSE,
	display_order INTEGER NOT NULL DEFAULT 0,
	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

COMMENT ON TABLE app_file IS 'Stores file metadata for objects uploaded to S3.';
COMMENT ON COLUMN app_file.app_file_name IS 'Object name used when uploading to S3.';
COMMENT ON COLUMN app_file.app_file_size_bytes IS 'File size in bytes.';
COMMENT ON COLUMN app_file.mime_type IS 'File format or extension (e.g., jpg, png, mp4).';
