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
CREATE EXTENSION IF NOT EXISTS "pg_trgm";

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
\i models/sale_type.sql
\i models/purchase_status.sql
\i models/purchase_notification_type.sql
\i models/file_type.sql
\i models/app_user.sql
\i models/verification_code.sql
\i models/person.sql
\i models/company.sql
\i models/livestock_post.sql
\i models/purchase_request.sql
\i models/sale.sql
\i models/sale_rating.sql
\i models/purchase_notification.sql
\i models/file.sql

-- -----------------
-- FUNCTIONS
-- -----------------
\i sql/functions/update_timestamp.sql
\i sql/functions/create_app_user.sql
\i sql/functions/insert_verification_code.sql
\i sql/functions/verify_and_mark_user.sql
\i sql/functions/update_livestock_quantity.sql
\i sql/functions/calculate_livestock_search_term_relevance.sql
\i sql/functions/search_livestock_posts.sql

-- -----------------
-- TRIGGERS
-- -----------------
\i sql/triggers/trg_state_updated_at.sql
\i sql/triggers/trg_township_updated_at.sql
\i sql/triggers/trg_role_updated_at.sql
\i sql/triggers/trg_reputation_level_updated_at.sql
\i sql/triggers/trg_livestock_type_updated_at.sql
\i sql/triggers/trg_breed_updated_at.sql
\i sql/triggers/trg_sector_updated_at.sql
\i sql/triggers/trg_sale_type_updated_at.sql
\i sql/triggers/trg_purchase_status_updated_at.sql
\i sql/triggers/trg_purchase_notification_type_updated_at.sql
\i sql/triggers/trg_app_user_updated_at.sql
\i sql/triggers/trg_person_updated_at.sql
\i sql/triggers/trg_company_updated_at.sql
\i sql/triggers/trg_livestock_post_updated_at.sql
\i sql/triggers/trg_purchase_request_updated_at.sql
\i sql/triggers/trg_sale_updated_at.sql
\i sql/triggers/trg_sale_rating_updated_at.sql
\i sql/triggers/trg_purchase_notification_updated_at.sql
\i sql/triggers/trg_update_livestock_quantity.sql
\i sql/triggers/trg_app_file_type_updated_at.sql
\i sql/triggers/trg_app_file_updated_at.sql

-- -----------------
-- SEEDS
-- -----------------
\i seeds/catalog/001-insert-states.sql
\i seeds/catalog/002-insert-roles.sql
\i seeds/catalog/003-insert-reputation-levels.sql
\i seeds/catalog/004-insert-purchase-status.sql
\i seeds/catalog/005-insert-sale-types.sql
\i seeds/catalog/006-insert-notification-types.sql
\i seeds/catalog/007-insert-zulia-townships.sql
\i seeds/catalog/008-insert-livestock-types.sql
\i seeds/catalog/009-insert-breeds.sql
\i seeds/catalog/010-insert-sectors.sql
\i seeds/catalog/011-insert-file-types.sql

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

    IF (SELECT COUNT(*) FROM purchase_status) = 0 THEN
        RAISE EXCEPTION 'Purchase Status table is empty after seed';
    END IF;

    IF (SELECT COUNT(*) FROM sale_type) = 0 THEN
        RAISE EXCEPTION 'Sale Type table is empty after seed';
    END IF;

    IF (SELECT COUNT(*) FROM purchase_notification_type) = 0 THEN
        RAISE EXCEPTION 'Notification Type table is empty after seed';
    END IF;

    IF (SELECT COUNT(*) FROM township WHERE township_state_id = (SELECT state_id FROM state WHERE state_name = 'Zulia')) = 0 THEN
        RAISE EXCEPTION 'Zulia townships table is empty after seed';
    END IF;

    IF (SELECT COUNT(*) FROM livestock_type) = 0 THEN
        RAISE EXCEPTION 'Livestock Types table is empty after seed';
    END IF;

    IF (SELECT COUNT(*) FROM breed) = 0 THEN
        RAISE EXCEPTION 'Breeds table is empty after seed';
    END IF;

    IF (SELECT COUNT(*) FROM sector) = 0 THEN
        RAISE EXCEPTION 'Sectors table is empty after seed';
    END IF;
END $$;

COMMIT;