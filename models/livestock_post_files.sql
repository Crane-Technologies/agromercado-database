CREATE TABLE IF NOT EXISTS livestock_post_files(
    file_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    livestock_post_id UUID NOT NULL REFERENCES livestock_post(livestock_post_id) ON DELETE CASCADE,
    s3_bucket VARCHAR(100) NOT NULL,
    s3_key VARCHAR(500) NOT NULL,
    file_type VARCHAR(10) NOT NULL,
    file_size_bytes INTEGER NOT NULL CHECK (file_size_bytes > 0),
    mime_type VARCHAR(50) NOT NULL,
    is_main BOOLEAN DEFAULT false,
    display_order SMALLINT DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT chk_livestock_post_files_type
        CHECK (file_type IN ('image','video')),
    CONSTRAINT chk_livestock_post_files_mime
        CHECK (
            (file_type = 'image' AND mime_type IN ('image/jpeg','image/png','image/webp'))
            OR (file_type = 'video' AND mime_type IN ('video/mp4','video/webm'))
        )
);

CREATE INDEX IF NOT EXISTS idx_livestock_post_files_post ON livestock_post_files(livestock_post_id);
CREATE INDEX IF NOT EXISTS idx_livestock_post_files_main ON livestock_post_files(livestock_post_id, is_main) WHERE is_main = true;
CREATE UNIQUE INDEX IF NOT EXISTS uq_livestock_post_main_file ON livestock_post_files(livestock_post_id) WHERE is_main = true;

COMMENT ON TABLE livestock_post_files IS 'Stores multimedia files (images/videos) for livestock posts. Maximum 10 files per post. Files are stored in Amazon S3.';