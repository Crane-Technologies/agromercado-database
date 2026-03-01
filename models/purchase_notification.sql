CREATE TABLE IF NOT EXISTS purchase_notification(
    purchase_notification_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    sent_by UUID NOT NULL REFERENCES app_user(app_user_id) ON DELETE SET NULL,
    livestock_post_id UUID NOT NULL REFERENCES livestock_post(livestock_post_id) ON DELETE RESTRICT,
    purchase_notification_type_id INTEGER NOT NULL REFERENCES purchase_notification_type(purchase_notification_type_id) ON DELETE RESTRICT,
    message TEXT NOT NULL,
    is_read BOOLEAN DEFAULT false,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX IF NOT EXISTS idx_notification_sender ON purchase_notification(sent_by);
CREATE INDEX IF NOT EXISTS idx_purchase_notification_type ON purchase_notification(purchase_notification_type_id);