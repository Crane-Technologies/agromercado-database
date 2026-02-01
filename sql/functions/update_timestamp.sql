CREATE OR REPLACE FUNCTION update_timestamp()
returns trigger as $$
BEGIN
    new.updated_at = current_timestamp;
    return new;
end;
$$ language plpgsql;