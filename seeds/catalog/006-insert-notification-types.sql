INSERT INTO purchase_notification_type (purchase_notification_type_id, purchase_notification_type_name, purchase_notification_type_description) VALUES
    (1, 'purchase_request', 'Notificación de nueva solicitud de compra'),
    (2, 'sale_completed', 'Notificación de venta completada'),
    (3, 'rating_received', 'Notificación de calificación recibida'),
    (4, 'post_update', 'Notificación de actualización en publicación'),
    (5, 'status_change', 'Notificación de cambio de estado')
ON CONFLICT (purchase_notification_type_id) DO NOTHING;
