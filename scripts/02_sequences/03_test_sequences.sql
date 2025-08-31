-- Vérification des séquences
SELECT sequence_name, last_number, increment_by 
FROM user_sequences 
ORDER BY sequence_name;

-- Vérification des triggers
SELECT trigger_name, table_name, status 
FROM user_triggers 
ORDER BY table_name;
