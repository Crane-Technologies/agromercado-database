CREATE TABLE IF NOT EXISTS sale_type(
    sale_type_id SERIAL PRIMARY KEY,
    sale_type_name VARCHAR(20) UNIQUE NOT NULL,
    sale_type_description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);