-- ======================================================
-- SCHEMA BOOTSTRAP FILE
-- ======================================================

\c agromercado

BEGIN;

DROP SCHEMA IF EXISTS public CASCADE;
CREATE SCHEMA public;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO public;

-- -----------------
-- EXTENSIONS
-- -----------------
CREATE EXTENSION IF NOT EXISTS "pgcrypto";

-- -----------------
-- TABLES
-- -----------------
\i models/state.sql
\i models/township.sql
\i models/role.sql
\i models/reputation_level.sql
\i models/livestock_type.sql
\i models/breed.sql
\i models/sector.sql
\i models/app_user.sql
\i models/person.sql
\i models/company.sql
\i models/livestock_post.sql
\i models/sale.sql

-- -----------------
-- FUNCTIONS
-- -----------------
-- \i functions/update_timestamp.sql

-- -----------------
-- SEEDS
-- -----------------
\i seeds/catalog/001-insert-states.sql
\i seeds/catalog/002-insert-roles.sql
\i seeds/catalog/003-insert-reputation-levels.sql

-- -----------------
-- INTEGRITY CHECKS
-- -----------------
DO $$
BEGIN
    IF (SELECT COUNT(*) FROM state) = 0 THEN
        RAISE EXCEPTION 'States table is empty after seed';
    END IF;
    
    IF (SELECT COUNT(*) FROM role) = 0 THEN
        RAISE EXCEPTION 'Roles table is empty after seed';
    END IF;

    IF (SELECT COUNT(*) FROM reputation_level) = 0 THEN
        RAISE EXCEPTION 'Reputation Levels table is empty after seed';
    END IF;
END $$;

COMMIT;