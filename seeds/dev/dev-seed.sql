-- Crear usuario persona natural (davidpaz)
SELECT create_app_user(
  'davidpaz@example.com',      -- p_email
  '+584121234567',             -- p_phone
  '$2b$10$hashedpassword1',    -- p_password_hash (debes hashear 'hola1234' en producción)
  'V',                         -- p_document_type
  12345678,                    -- p_document_number
  1,                           -- p_township_id (ajusta según tu catálogo)
  1,                           -- p_role_id (1 = common)
  'David',                     -- p_first_name
  NULL,                        -- p_middle_name
  'Paz',                       -- p_surname
  NULL,                        -- p_second_surname
  NULL,                        -- p_birthdate
  NULL                         -- p_company_name
);

-- Crear usuario compañía (juancomella)
SELECT create_app_user(
  'juancomella@example.com',   -- p_email
  '+584129876543',             -- p_phone
  '$2b$10$hashedpassword2',    -- p_password_hash (debes hashear 'hola1234' en producción)
  'J',                         -- p_document_type
  87654321,                    -- p_document_number
  1,                           -- p_township_id (ajusta según tu catálogo)
  1,                           -- p_role_id (1 = common)
  NULL,                        -- p_first_name
  NULL,                        -- p_middle_name
  NULL,                        -- p_surname
  NULL,                        -- p_second_surname
  NULL,                        -- p_birthdate
  'Comella S.A.'               -- p_company_name
);

-- select * from app_user;

-- select * from livestock_post;

-- select * from purchase_request;

-- select * from purchase_notification;