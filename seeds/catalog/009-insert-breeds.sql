INSERT INTO breed (livestock_type_id, breed_name, breed_description) VALUES
    (1, 'Brahman', 'Raza cebuina de origen estadounidense, adaptada a climas tropicales. Caracterizada por su joroba, piel suelta y resistencia al calor y parásitos.'),
    (1, 'Cebu', 'Ganado bovino de origen asiático, caracterizado por su joroba sobre los hombros. Altamente adaptado a climas cálidos y húmedos.'),
    (1, 'Mestizo', 'Resultado del cruce entre diferentes razas bovinas, combina características de razas europeas y cebuinas.'),
    (1, 'Carora', 'Raza venezolana desarrollada en el estado Lara, doble propósito (leche y carne), bien adaptada al trópico.'),
    (1, 'Criollo Limonero', 'Raza criolla venezolana originaria de la Sierra de Perijá, resistente y adaptada a condiciones de trópico bajo.'),
    (1, 'Gyr', 'Raza cebuina lechera de origen indio, conocida por su alta producción de leche en condiciones tropicales.'),
    (1, 'Guzerat', 'Raza cebuina de triple propósito (carne, leche, trabajo), de origen indio, con buena adaptación al trópico.'),
    (1, 'Nelore', 'Raza cebuina de carne de origen brasileño, excelente para producción de carne en climas cálidos.'),
    (1, 'Angus', 'Raza europea de carne de origen escocés, conocida por la calidad de su carne marmoleada.'),
    (1, 'Simmental', 'Raza europea de doble propósito (carne y leche), de origen suizo, de gran tamaño y rusticidad.'),
    (1, 'Charolais', 'Raza europea de carne de origen francés, caracterizada por su pelaje blanco y gran desarrollo muscular.'),
    (1, 'Santa Gertrudis', 'Raza estadounidense resultado del cruce Brahman x Shorthorn, de buen rendimiento cárnico y adaptada al calor.')
ON CONFLICT DO NOTHING;