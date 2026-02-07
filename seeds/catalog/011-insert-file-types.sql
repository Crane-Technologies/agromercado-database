INSERT INTO app_file_type (app_file_type_name)
VALUES
	('image'),
	('video')
ON CONFLICT (app_file_type_name) DO NOTHING;
