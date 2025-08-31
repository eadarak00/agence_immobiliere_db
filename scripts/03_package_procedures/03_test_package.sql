COLUMN OBJECT_NAME FORMAT A20;

-- Vérification de la création du package
SELECT object_name, object_type, status
FROM user_objects
WHERE object_name = 'PKG_AGENCE';


SET SERVEROUTPUT ON;
PROMPT '=== TEST DE LA FONCTION Prix_Mensuel ===';
DECLARE
    v_prix NUMBER;
BEGIN
    v_prix := PKG_AGENCE.PRIX_MENSUEL('IMM001');
    DBMS_OUTPUT.PUT_LINE('Fonction retourne: ' || v_prix || ' FCFA');
END;
/

PROMPT '';
PROMPT '=== TEST DE LA PROCEDURE Liste_Locataires ===';
BEGIN
    PKG_AGENCE.LISTE_LOCATAIRES('IMM003');
END;
/
