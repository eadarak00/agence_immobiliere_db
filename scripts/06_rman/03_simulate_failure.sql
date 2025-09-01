-- xécuter en tant que SYS
CONNCT sys/sys as SYSDBA
-- 1. Arrêt propre de la base
SHUTDOWN ABORT;

-- 2. Simulation de corruption de fichiers
-- suppression des fichier system user..

-- 3. Tentative de démarrage (va échouer)
STARTUP;

