DROP CLUSTER cluster_nom_prenom INCLUDING TABLES;
DROP CLUSTER cluster_code INCLUDING TABLES;

-- Cluster basé sur (Nom, Prenom)
CREATE  CLUSTER cluster_nom_prenom (
    Nom    VARCHAR2(50),
    Prenom VARCHAR2(50)
)
SIZE 1024;

-- Cluster basé sur Code
CREATE CLUSTER cluster_code (
    Code VARCHAR2(10)
)
SIZE 1024;
