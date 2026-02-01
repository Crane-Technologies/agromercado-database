CREATE TABLE IF NOT EXISTS purchase_status(
    purchase_status_id SERIAL PRIMARY KEY,
    purchase_status_name VARCHAR(50) UNIQUE NOT NULL,
    purchase_status_description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);