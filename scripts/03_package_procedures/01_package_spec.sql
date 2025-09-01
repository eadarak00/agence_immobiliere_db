CREATE OR REPLACE PACKAGE pkg_agence AS
  -- Fonction : prix mensuel total des locations d’un immeuble
  FUNCTION prix_mensuel (p_code_immeuble VARCHAR2) RETURN NUMBER;

  -- Procédure : liste des locataires d’un immeuble
  PROCEDURE liste_locataires (p_code_immeuble VARCHAR2);
END pkg_agence;
/
