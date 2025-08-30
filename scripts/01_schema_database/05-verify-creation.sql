-- Se connecter avec le nouvel utilisateur
CONNECT AgenceImmobiliere/agence123;

-- Afficher les variables définies
DEFINE

-- Afficher les clusters créés dans le schéma utilisateur
SELECT cluster_name, tablespace_name, cluster_type
FROM user_clusters;

-- Afficher toutes les tables créées dans le schéma utilisateur avec leur cluster associé
SELECT table_name, cluster_name 
FROM user_tables 
ORDER BY table_name;

-- Afficher les contraintes des tables spécifiques
SELECT table_name, constraint_name, constraint_type
FROM user_constraints
WHERE table_name IN ('PROPRIETAIRE', 'LOCATAIRE', 'IMMEUBLE', 'APPARTEMENT', 
                     'AGENCE', 'APPARTENIR', 'LOUER', 'GERER')
ORDER BY table_name, constraint_name;
