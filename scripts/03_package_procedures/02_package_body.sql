CREATE OR REPLACE PACKAGE BODY pkg_agence AS
  -- Fonction prix_mensuel
FUNCTION prix_mensuel(p_code_immeuble VARCHAR2) RETURN NUMBER IS
        v_prix_total NUMBER := 0;
        v_count NUMBER := 0;
    BEGIN
        -- Calculer la somme des loyers des appartements actuellement loués
        SELECT NVL(SUM(l.Prix), 0), COUNT(*)
        INTO v_prix_total, v_count
        FROM Louer l
        INNER JOIN Appartement a ON l.Appartement = a.Numero
        WHERE l.Immeuble = p_code_immeuble
        AND l.Debut <= SYSDATE
        AND (l.Fin IS NULL OR l.Fin >= SYSDATE);
        
        -- Afficher des informations de débogage
        DBMS_OUTPUT.PUT_LINE('Immeuble: ' || p_code_immeuble);
        DBMS_OUTPUT.PUT_LINE('Nombre d''appartements loués: ' || v_count);
        DBMS_OUTPUT.PUT_LINE('Prix total mensuel: ' || v_prix_total || ' FCFA');
        
        RETURN v_prix_total;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('Aucune location trouvée pour l''immeuble: ' || p_code_immeuble);
            RETURN 0;
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Erreur dans prix_mensuel: ' || SQLERRM);
            RETURN 0;
    END prix_mensuel;

  -- Procédure liste_locataires
 PROCEDURE liste_locataires(p_code_immeuble VARCHAR2) IS
        CURSOR c_locataires IS
            SELECT DISTINCT 
                loc.Numero,
                loc.Nom,
                loc.Prenom,
                loc.Telephone,
                loc.Fonction,
                a.Numero as Num_Appartement,
                l.Debut,
                l.Fin,
                l.Prix
            FROM Locataire loc
            INNER JOIN Louer l ON loc.Numero = l.Locataire
            INNER JOIN Appartement a ON l.Appartement = a.Numero
            WHERE l.Immeuble = p_code_immeuble
            AND l.Debut <= SYSDATE
            AND (l.Fin IS NULL OR l.Fin >= SYSDATE)
            ORDER BY loc.Nom, loc.Prenom;
        
        v_count NUMBER := 0;
    BEGIN
        DBMS_OUTPUT.PUT_LINE('===========================================');
        DBMS_OUTPUT.PUT_LINE('LISTE DES LOCATAIRES - IMMEUBLE: ' || p_code_immeuble);
        DBMS_OUTPUT.PUT_LINE('===========================================');
        
        FOR rec IN c_locataires LOOP
            v_count := v_count + 1;
            DBMS_OUTPUT.PUT_LINE(v_count || '. ' || rec.Nom || ' ' || rec.Prenom);
            DBMS_OUTPUT.PUT_LINE('   Numéro: ' || rec.Numero);
            DBMS_OUTPUT.PUT_LINE('   Téléphone: ' || NVL(rec.Telephone, 'Non renseigné'));
            DBMS_OUTPUT.PUT_LINE('   Fonction: ' || NVL(rec.Fonction, 'Non renseignée'));
            DBMS_OUTPUT.PUT_LINE('   Appartement N°: ' || rec.Num_Appartement);
            DBMS_OUTPUT.PUT_LINE('   Période: du ' || TO_CHAR(rec.Debut, 'DD/MM/YYYY') || 
                                ' au ' || NVL(TO_CHAR(rec.Fin, 'DD/MM/YYYY'), 'En cours'));
            DBMS_OUTPUT.PUT_LINE('   Loyer: ' || rec.Prix || ' FCFA/mois');
            DBMS_OUTPUT.PUT_LINE('   ---');
        END LOOP;
        
        IF v_count = 0 THEN
            DBMS_OUTPUT.PUT_LINE('Aucun locataire trouvé pour cet immeuble.');
        ELSE
            DBMS_OUTPUT.PUT_LINE('Total: ' || v_count || ' locataire(s)');
        END IF;
        
        DBMS_OUTPUT.PUT_LINE('===========================================');
        
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Erreur dans liste_locataires: ' || SQLERRM);
    END liste_locataires;
END pkg_agence;
/