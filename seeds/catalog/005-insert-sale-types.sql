INSERT INTO sale_type (sale_type_id, sale_type_name, sale_type_description) VALUES
 (1, 'by_weight', 'Sale by weight (price per kilogram)'),
 (2, 'by_unit', 'Sale by unit (fixed price per animal)')
ON CONFLICT DO NOTHING;