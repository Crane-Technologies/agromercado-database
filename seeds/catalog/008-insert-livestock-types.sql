INSERT INTO livestock_type (livestock_type_id, livestock_type_name, livestock_type_description) VALUES
    (1, 'Bovino', 'Ganado vacuno, incluye vacas, toros, novillas, y becerros')
ON CONFLICT (livestock_type_id) DO NOTHING;
