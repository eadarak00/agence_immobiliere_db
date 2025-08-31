-- Vérification de la création du package
SELECT object_name, object_type, status
FROM user_objects
WHERE object_name = 'PKG_AGENCE';
