CREATE TABLE IF NOT EXISTS purchase_notification_type(
    purchase_notification_type_id SERIAL PRIMARY KEY,
    purchase_notification_type_name VARCHAR(30) UNIQUE NOT NULL,
    purchase_notification_type_description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
