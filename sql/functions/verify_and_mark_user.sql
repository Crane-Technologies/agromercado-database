CREATE OR REPLACE PROCEDURE verify_and_mark_user(
    p_verification_code_id UUID,
    p_app_user_id UUID
)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE verification_code
    SET is_used = true,
        used_at = CURRENT_TIMESTAMP
    WHERE verification_code_id = p_verification_code_id;

    UPDATE app_user
    SET is_verified = true
    WHERE app_user_id = p_app_user_id;

EXCEPTION
    WHEN OTHERS THEN
        RAISE EXCEPTION 'Error verifying user: %', SQLERRM;
END;
$$;

COMMENT ON PROCEDURE verify_and_mark_user(UUID, UUID) IS 
    'Marks verification code as used and marks user as verified. 
    Both operations are executed in a single transaction.';