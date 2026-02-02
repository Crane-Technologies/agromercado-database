-- Insert townships for Zulia state
INSERT INTO township (township_name, township_state_id)
SELECT township_name, (SELECT state_id FROM state WHERE state_name = 'Zulia')
FROM (VALUES
    ('Almirante Padilla'),
    ('Baralt'),
    ('Cabimas'),
    ('Catatumbo'),
    ('Colón'),
    ('Francisco Javier Pulgar'),
    ('Jesús Enrique Lossada'),
    ('Jesús María Semprún'),
    ('La Cañada de Urdaneta'),
    ('Lagunillas'),
    ('Machiques de Perijá'),
    ('Mara'),
    ('Maracaibo'),
    ('Miranda'),
    ('Rosario de Perijá'),
    ('San Francisco'),
    ('Santa Rita'),
    ('Simón Bolívar'),
    ('Sucre'),
    ('Valmore Rodríguez'),
    ('Guajira')
) AS townships(township_name)
ON CONFLICT (township_name, township_state_id) DO NOTHING;
