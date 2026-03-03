CREATE OR REPLACE FUNCTION search_livestock_posts(
    p_search_term TEXT,
    p_min_relevance REAL DEFAULT 0.15,
    p_limit INTEGER DEFAULT 20,
    p_offset INTEGER DEFAULT 0,
    p_township_id INTEGER DEFAULT NULL,
    p_state_id INTEGER DEFAULT NULL,
    p_min_weight NUMERIC(6,2) DEFAULT NULL,
    p_max_weight NUMERIC(6,2) DEFAULT NULL,
    p_min_price_per_kg NUMERIC(8,2) DEFAULT NULL,
    p_max_price_per_kg NUMERIC(8,2) DEFAULT NULL,
    p_min_price_per_unit NUMERIC(10,2) DEFAULT NULL,
    p_max_price_per_unit NUMERIC(10,2) DEFAULT NULL,
    p_livestock_type_id INTEGER DEFAULT NULL,
    p_sector_id INTEGER DEFAULT NULL,
    p_sex VARCHAR(6) DEFAULT NULL
)
RETURNS TABLE(
    livestock_post_id UUID,
    livestock_post_name VARCHAR(100),
    posted_by UUID,
    posted_by_name TEXT,
    relevance REAL,
    total_count BIGINT  
) AS $$
BEGIN
    RETURN QUERY
    SELECT 
        lp.livestock_post_id,
        lp.livestock_post_name,
        lp.posted_by,
        COALESCE(
            (SELECT CONCAT_WS(' ', p.first_name, p.surname) 
             FROM person p 
             WHERE p.app_user_id = lp.posted_by),
            (SELECT c.company_name 
             FROM company c 
             WHERE c.app_user_id = lp.posted_by)
        ) AS posted_by_name,
        calculate_livestock_search_term_relevance(
            lp.livestock_post_name, lp.details, p_search_term
        ) AS relevance,
        COUNT(*) OVER() AS total_count
    FROM livestock_post lp
    JOIN township t ON t.township_id = lp.township_id
    WHERE 
        lp.is_active = true
        AND calculate_livestock_search_term_relevance(lp.livestock_post_name, lp.details, p_search_term) > p_min_relevance
        AND (p_township_id IS NULL OR lp.township_id = p_township_id)
        AND (p_state_id IS NULL OR t.township_state_id = p_state_id)
        AND (p_min_weight IS NULL OR lp.avg_weight_kg >= p_min_weight)
        AND (p_max_weight IS NULL OR lp.avg_weight_kg <= p_max_weight)
        AND (p_min_price_per_kg IS NULL OR lp.price_per_kg >= p_min_price_per_kg)
        AND (p_max_price_per_kg IS NULL OR lp.price_per_kg <= p_max_price_per_kg)
        AND (p_min_price_per_unit IS NULL OR lp.price_per_unit >= p_min_price_per_unit)
        AND (p_max_price_per_unit IS NULL OR lp.price_per_unit <= p_max_price_per_unit)
        AND (p_livestock_type_id IS NULL OR lp.livestock_type_id = p_livestock_type_id)
        AND (p_sector_id IS NULL OR lp.sector_id = p_sector_id)
        AND (p_sex IS NULL OR lp.sex = p_sex)
    ORDER BY relevance DESC, lp.created_at DESC
    LIMIT p_limit
    OFFSET p_offset;
END;
$$ LANGUAGE plpgsql STABLE;

COMMENT ON FUNCTION search_livestock_posts(TEXT, REAL, INTEGER, INTEGER, INTEGER, INTEGER, NUMERIC, NUMERIC, NUMERIC, NUMERIC, NUMERIC, NUMERIC, INTEGER, INTEGER, VARCHAR)
IS 'Searches livestock posts with optional filters for township, state, weight range, price range, livestock type, sector, and sex.
All filter parameters are optional (NULL = no filter applied).
Uses weighted similarity matching: 70% name, 30% details.
Returns active posts ordered by relevance and creation date.';