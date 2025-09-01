-- Vérification complète après restauration
-- Exécuter en tant que SYS et agenceimmobiliere

-- 1. État de la base
CONNECT / AS SYSDBA
SELECT name, open_mode, database_role, log_mode FROM v$database;

-- 2. État des tablespaces
SELECT tablespace_name, status, contents FROM dba_tablespaces;

-- 3. État des datafiles
SELECT name, status, bytes/1024/1024 AS size_mb FROM v$datafile;

-- 4. Vérification des objets utilisateur
CONNECT agenceimmobiliere/agence123
SELECT object_type, COUNT(*) AS count_objects
FROM user_objects
GROUP BY object_type
ORDER BY object_type;

-- 5. Vérification des données
SELECT 'PROPRIETAIRE' AS table_name, COUNT(*) AS row_count FROM proprietaire
UNION ALL SELECT 'LOCATAIRE', COUNT(*) FROM locataire
UNION ALL SELECT 'IMMEUBLE', COUNT(*) FROM immeuble
UNION ALL SELECT 'APPARTEMENT', COUNT(*) FROM appartement
UNION ALL SELECT 'APPARTENIR', COUNT(*) FROM appartenir
UNION ALL SELECT 'LOUER', COUNT(*) FROM louer
UNION ALL SELECT 'AGENCE', COUNT(*) FROM agence
UNION ALL SELECT 'GERER', COUNT(*) FROM gerer;

-- 6. Vérification des séquences
SELECT sequence_name, last_number FROM user_sequences;

-- 7. Test des fonctions du package
SET SERVEROUTPUT ON
DECLARE
    v_prix NUMBER;
BEGIN
    v_prix := pkg_agence.prix_mensuel('IMM001');
    DBMS_OUTPUT.PUT_LINE('Prix mensuel IMM001: ' || v_prix || ' fcfa');
END;
/

BEGIN
    pkg_agence.liste_locataires('IMM001');
END;
/