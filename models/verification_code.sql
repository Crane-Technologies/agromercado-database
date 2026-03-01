CREATE TABLE IF NOT EXISTS verification_code(
    verification_code_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    app_user_id UUID NOT NULL REFERENCES app_user(app_user_id) ON DELETE CASCADE,
    code VARCHAR(6) NOT NULL,
    verification_type VARCHAR(10) NOT NULL CHECK (verification_type IN ('email','phone')),
    is_used BOOLEAN DEFAULT false,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    expires_at TIMESTAMP NOT NULL,
    used_at TIMESTAMP DEFAULT NULL 
);

CREATE INDEX IF NOT EXISTS idx_verification_code_user_type 
    ON verification_code(app_user_id, verification_type, is_used);

CREATE INDEX IF NOT EXISTS idx_verification_code_expires 
    ON verification_code(expires_at) WHERE is_used = false;