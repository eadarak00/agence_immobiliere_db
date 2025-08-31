-- Trigger pour auto-incrémenter les locataires
CREATE OR REPLACE TRIGGER trg_locataire_auto_inc
BEFORE INSERT ON Locataire
FOR EACH ROW
BEGIN
    IF :NEW.Numero IS NULL THEN
        :NEW.Numero := seq_locataire.NEXTVAL;
    END IF;
END;
/

-- Trigger pour auto-incrémenter les appartements
CREATE OR REPLACE TRIGGER trg_appartement_auto_inc
BEFORE INSERT ON Appartement
FOR EACH ROW
BEGIN
    IF :NEW.Numero IS NULL THEN
        :NEW.Numero := seq_appartement.NEXTVAL;
    END IF;
END;
/
