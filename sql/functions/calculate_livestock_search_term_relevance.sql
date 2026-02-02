CREATE OR REPLACE FUNCTION calculate_livestock_search_term_relevance(
    p_name TEXT,
    p_details TEXT,
    p_search_term TEXT
)
RETURNS REAL AS $$
    SELECT (
        similarity(p_name, p_search_term) * 0.7 + 
        similarity(COALESCE(p_details, ''), p_search_term) * 0.3
    );
$$ LANGUAGE sql IMMUTABLE;