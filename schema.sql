-- state: tabla catálogo de estados.
CREATE TABLE IF NOT EXISTS state(
	state_id SERIAL PRIMARY KEY,
	state_name VARCHAR(50) UNIQUE NOT NULL,
	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- township: tabla catálogo de municipios.
CREATE TABLE IF NOT EXISTS township(
	township_id SERIAL PRIMARY KEY,
	township_name VARCHAR(50) NOT NULL,
	township_state_id INTEGER NOT NULL REFERENCES state(state_id),
	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	
	UNIQUE (township_name, township_state_id)
);

-- role: tabla catálogo de roles para esquema de autorización del sistema.
CREATE TABLE IF NOT EXISTS role(
	role_id SERIAL PRIMARY KEY,
	role_name VARCHAR(25) NOT NULL,
	role_hierarchy SMALLINT NOT NULL,
	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
INSERT INTO role(role_name, role_hierarchy) VALUES
    ('common', 1), -- usuarios comunes.
    ('admin', 2), -- usuarios administradores del sistema.
    ('superuser', 3), -- usuarios absoluto.
ON CONFLICT DO NOTHING;

--reputation_level: tabla catálogo que guarda los niveles de reputación de usuarios.
CREATE TABLE IF NOT EXISTS reputation_level(
	reputation_level_id SERIAL PRIMARY KEY,
	reputation_level_name VARCHAR(20) NOT NULL,
	reputation_level_hierarchy SMALLINT NOT NULL,
	required_stars NUMERIC(2,1),
	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
INSERT INTO reputation_level
(reputation_level_name, reputation_level_hierarchy, required_stars)
VALUES ('new', 0, 0.0);
ON CONFLICT DO NOTHING;

-- livestock_type: tabla catálogo que guarda todos los tipos de animales que habrán en la base de datos.
CREATE TABLE IF NOT EXISTS livestock_type(
	livestock_type_id SERIAL PRIMARY KEY,
	livestock_type_name VARCHAR(25) NOT NULL,
	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- breed: tabla catálogo que guarda los tipos de raza.
CREATE TABLE IF NOT EXISTS breed(
	breed_id SERIAL PRIMARY KEY,
	breed_name VARCHAR(25) NOT NULL,
	livestock_type_id INTEGER NOT NULL REFERENCES livestock_type(livestock_type_id),
	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	
	UNIQUE (breed_name, livestock_type_id)
);
-- sector: tabla catálogo que guarda los sectores a los cuales puede pertenecer un ganado.
CREATE TABLE IF NOT EXISTS sector(
	sector_id SERIAL PRIMARY KEY,
	sector_name VARCHAR(25) NOT NULL,
	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- user: tabla que guarda todos los usuarios del sistema (compradores, vendedores y administradores).
CREATE TABLE IF NOT EXISTS app_user(
	app_user_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
	role_id INTEGER NOT NULL REFERENCES role(role_id) ON DELETE CASCADE, 
	email VARCHAR(50) UNIQUE NOT NULL,
	phone VARCHAR(20) UNIQUE NOT NULL,
	password_hash VARCHAR(255) NOT NULL,
	document_type VARCHAR(1) NOT NULL,
	document_number INTEGER UNIQUE NOT NULL,
	township_id INTEGER NOT NULL REFERENCES township(township_id) ON DELETE RESTRICT, 
	is_verified BOOLEAN DEFAULT false, -- para verificación de correo electrónico al crear la cuenta.
	reputation_level_id INTEGER NOT NULL REFERENCES reputation_level(reputation_level_id) DEFAULT 1 ON DELETE RESTRICT,
	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	
	CONSTRAINT chk_app_user_phone
		CHECK (phone ~ '^\+[1-9][0-9]{7,14}$'),
	
	CONSTRAINT chk_app_user_document_type
		CHECK (document_type IN ('V','J'))
);

-- person: tabla que guarda los usuarios registrados como persona natural (documento tipo V).
CREATE TABLE IF NOT EXISTS person(
	person_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
	app_user_id UUID UNIQUE NOT NULL REFERENCES app_user(app_user_id) ON DELETE CASCADE,
	first_name VARCHAR(25) NOT NULL,
	middle_name VARCHAR(25),
	surname VARCHAR(25) NOT NULL,
	second_surname VARCHAR(25),
	birthdate DATE,
	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- company: tabla que guarda los usuarios registrados como empresa (documento tipo J)
CREATE TABLE IF NOT EXISTS company(
	company_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
	app_user_id UUID UNIQUE NOT NULL REFERENCES app_user(app_user_id) ON DELETE CASCADE,
	company_name VARCHAR(50) NOT NULL,
	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- livestock_post: tabla que guarda todas las publicaciones con animales en venta
CREATE TABLE IF NOT EXISTS livestock_post(
	livestock_post_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
	livestock_type_id INTEGER NOT NULL REFERENCES livestock_type(livestock_type_id) ON DELETE RESTRICT,
	posted_by UUID NOT NULL REFERENCES app_user(app_user_id) ON DELETE CASCADE,
	breed_id INTEGER NOT NULL REFERENCES breed(breed_id) ON DELETE RESTRICT,
	sector_id INTEGER NOT NULL REFERENCES sector(sector_id) ON DELETE RESTRICT,
	sex VARCHAR(1) NOT NULL,
	quantity SMALLINT NOT NULL CHECK (quantity > 0),
	avg_weight NUMERIC(6,2) NOT NULL CHECK (avg_weight > 0),
	avg_price NUMERIC(8,2) NOT NULL CHECK (avg_price > 0),
	township_id INTEGER NOT NULL REFERENCES township(township_id) ON DELETE RESTRICT,
	details TEXT,
	is_active BOOLEAN DEFAULT true,
	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	
	CONSTRAINT chk_animal_post_sex
		CHECK (sex IN ('M','F'))
);

-- sale: tabla que guarda todas las ventas completadas.
CREATE TABLE IF NOT EXISTS sale(
	sale_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
	livestock_post_id UUID NOT NULL REFERENCES livestock_post(livestock_post_id) ON DELETE RESTRICT,
	sold_by UUID NOT NULL REFERENCES app_user(app_user_id) ON DELETE RESTRICT,
	bought_by UUID NOT NULL REFERENCES app_user(app_user_id) ON DELETE RESTRICT,
	amount NUMERIC(8,2) NOT NULL,
	commission_percentage NUMERIC(4,2) DEFAULT 2.5,
	commission_amount NUMERIC(8,2) GENERATED ALWAYS AS (amount * commission_percentage) STORED,
	sale_rating NUMERIC(2,1) CHECK (sale_rating BETWEEN 1 AND 5),
	sale_completed BOOLEAN DEFAULT false,
	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	
	CONSTRAINT chk_sale_not_self
		CHECK (sold_by <> bought_by)
);
CREATE INDEX idx_sale_sold_by_completed
ON sale (sold_by)
WHERE sale_completed = true AND sale_rating IS NOT NULL;