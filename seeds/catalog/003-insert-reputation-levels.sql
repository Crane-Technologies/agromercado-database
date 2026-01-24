INSERT INTO reputation_level
(reputation_level_name, reputation_level_hierarchy, required_stars)
VALUES ('new', 0, 0.0)
ON CONFLICT DO NOTHING;
