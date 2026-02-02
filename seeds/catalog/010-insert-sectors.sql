INSERT INTO sector (sector_name, sector_description) VALUES
    ('Cria', 'Producción de becerros y reemplazo. Incluye toros reproductores, vacas de Cria, y becerros hasta el destete.'),
    ('Levante', 'Desarrollo y crecimiento de animales destetados hasta la edad reproductiva o de engorde. Incluye mautes y novillas de reemplazo.'),
    ('Engorde', 'Producción intensiva de carne mediante alimentación especializada para alcanzar peso de sacrificio óptimo.'),
    ('Doble Propósito', 'Sistema productivo que combina producción de leche y carne. Común en sistemas de ganadería tropical.'),
    ('Lechería', 'Producción especializada de leche. Incluye vacas en ordeño y animales de reemplazo lechero.'),
    ('Reproducción', 'Animales destinados específicamente a mejoramiento genético. Incluye toros probados, vacas élite, y semen.'),
    ('Descarte', 'Animales que por edad, condición física o productiva son destinados a venta para sacrificio.')
ON CONFLICT DO NOTHING;

