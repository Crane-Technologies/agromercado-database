INSERT INTO purchase_notification_type (purchase_notification_type_id, purchase_notification_type_name, purchase_notification_type_description) VALUES
    (1, 'purchase_request', 'Notificación de nueva solicitud de compra'),
    (2, 'message_received', 'Notificación de nuevo mensaje recibido'),
    (3, 'sale_completed', 'Notificación de venta completada'),
    (4, 'rating_received', 'Notificación de calificación recibida'),
    (5, 'post_update', 'Notificación de actualización en publicación'),
    (6, 'status_change', 'Notificación de cambio de estado')
ON CONFLICT (purchase_notification_type_id) DO NOTHING;
