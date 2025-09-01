-- Lancer RMAN
rman target /

-- Configuration RMAN pour notre base AgenceImmobiliere
CONFIGURE RETENTION POLICY TO REDUNDANCY 2;
CONFIGURE BACKUP OPTIMIZATION ON;
CONFIGURE DEFAULT DEVICE TYPE TO DISK;
CONFIGURE DEVICE TYPE DISK PARALLELISM 2;
CONFIGURE CHANNEL DEVICE TYPE DISK FORMAT 'C:\eadarak\backup\AGENCE_%T_%U.bkp';
CONFIGURE CONTROLFILE AUTOBACKUP ON;
CONFIGURE CONTROLFILE AUTOBACKUP FORMAT FOR DEVICE TYPE DISK TO 'C:\eadarak\backup\CF_%F';
-- Afficher la configuration actuelle
SHOW ALL;

-- Vérification de l'état de la base avant sauvegarde
SELECT name, open_mode, log_mode FROM v$database;
SELECT tablespace_name, status FROM dba_tablespaces;
