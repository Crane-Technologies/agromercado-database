INSERT INTO role(role_name, role_hierarchy) VALUES
 ('common', 1), -- usuarios comunes.
 ('admin', 2), -- usuarios administradores del sistema.
 ('superuser', 3) -- usuarios absoluto.
ON CONFLICT DO NOTHING;
