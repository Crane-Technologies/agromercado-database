CREATE OR REPLACE FUNCTION create_app_user(
    p_email VARCHAR(50),
    p_phone VARCHAR(20),
    p_password_hash VARCHAR(255),
    p_document_type VARCHAR(1),
    p_document_number INTEGER,
    p_township_id INTEGER,
    p_role_id INTEGER DEFAULT 1,
    p_first_name VARCHAR(25) DEFAULT NULL,
    p_middle_name VARCHAR(25) DEFAULT NULL,
    p_surname VARCHAR(25) DEFAULT NULL,
    p_second_surname VARCHAR(25) DEFAULT NULL,
    p_birthdate DATE DEFAULT NULL,
    p_company_name VARCHAR(50) DEFAULT NULL
)
RETURNS SETOF app_user AS $$
DECLARE
    v_user_id    UUID;
    v_is_company BOOLEAN;
BEGIN
    v_is_company := (p_document_type = 'J');

    IF v_is_company AND p_company_name IS NULL THEN
        RAISE EXCEPTION 'Company name is required for legal entities (document type J)';
    END IF;

    IF NOT v_is_company AND (p_first_name IS NULL OR p_surname IS NULL) THEN
        RAISE EXCEPTION 'First name and surname are required for natural persons (document type V)';
    END IF;

    INSERT INTO app_user (
        role_id,
        email,
        phone,
        password_hash,
        document_type,
        document_number,
        township_id
    ) VALUES (
        p_role_id,
        p_email,
        p_phone,
        p_password_hash,
        p_document_type,
        p_document_number,
        p_township_id
    )
    RETURNING app_user_id INTO v_user_id;

    IF v_is_company THEN
        INSERT INTO company (
            app_user_id,
            company_name
        ) VALUES (
            v_user_id,
            p_company_name
        );
    ELSE
        INSERT INTO person (
            app_user_id,
            first_name,
            middle_name,
            surname,
            second_surname,
            birthdate
        ) VALUES (
            v_user_id,
            p_first_name,
            p_middle_name,
            p_surname,
            p_second_surname,
            p_birthdate
        );
    END IF;

    RETURN QUERY SELECT * FROM app_user WHERE app_user_id = v_user_id;

EXCEPTION
    WHEN unique_violation THEN
        RAISE EXCEPTION 'User with this email, phone, or document number already exists';
    WHEN foreign_key_violation THEN
        RAISE EXCEPTION 'Invalid reference: check role_id and township_id';
    WHEN OTHERS THEN
        RAISE EXCEPTION 'Error creating user: %', SQLERRM;
END;
$$ LANGUAGE plpgsql;

COMMENT ON FUNCTION create_app_user(VARCHAR, VARCHAR, VARCHAR, VARCHAR, INTEGER, INTEGER, INTEGER, VARCHAR, VARCHAR, VARCHAR, VARCHAR, DATE, VARCHAR) IS
    'Registers a new user in the system.
    Automatically determines if the user is a person (V) or company (J)
    based on document type and creates the corresponding record in person or
    company table. Returns the full app_user row of the created user.';
