-- Propriétaire
CREATE TABLE Proprietaire (
    CNI VARCHAR2(20),
    Nom VARCHAR2(50) NOT NULL,
    Prenom VARCHAR2(50) NOT NULL,
    Adresse VARCHAR2(100),
    Age NUMBER(3),
    Sexe CHAR(1),
    Telephone VARCHAR2(20),
    
    -- Contraintes de table
    CONSTRAINT pk_proprietaire PRIMARY KEY (CNI),
    CONSTRAINT chk_age_proprietaire CHECK (Age > 18),
    CONSTRAINT chk_sexe_proprietaire CHECK (Sexe IN ('M','F')),
    CONSTRAINT uq_tel_proprietaire UNIQUE (Telephone)
) CLUSTER cluster_nom_prenom (Nom, Prenom);

-- Locataire
CREATE TABLE Locataire (
    Numero NUMBER,
    Nom VARCHAR2(50) NOT NULL,
    Prenom VARCHAR2(50) NOT NULL,
    Adresse VARCHAR2(100),
    Age NUMBER(3),
    Sexe CHAR(1),
    Telephone VARCHAR2(20),
    Fonction VARCHAR2(50),
    
    -- Contraintes de table
    CONSTRAINT pk_locataire PRIMARY KEY (Numero),
    CONSTRAINT chk_age_locataire CHECK (Age > 18),
    CONSTRAINT chk_sexe_locataire CHECK (Sexe IN ('M','F'))
) CLUSTER cluster_nom_prenom (Nom, Prenom);

-- Immeuble
CREATE TABLE Immeuble (
    Code VARCHAR2(10),
    Adresse VARCHAR2(100),
    Type VARCHAR2(50),
    Date_Construction DATE,
    Nb_Niveau NUMBER,
    
    -- Contraintes de table
    CONSTRAINT pk_immeuble PRIMARY KEY (Code),
    CONSTRAINT chk_niveau CHECK (Nb_Niveau >= 1)
) CLUSTER cluster_code (Code);

-- Appartement
CREATE TABLE Appartement (
    Numero NUMBER,
    Code VARCHAR2(10) NOT NULL,
    Superficie NUMBER,
    Nb_Piece NUMBER,
    Niveau NUMBER,
    
    -- Contraintes de table
    CONSTRAINT pk_appartement PRIMARY KEY (Numero),
    CONSTRAINT chk_superficie CHECK (Superficie > 0),
    CONSTRAINT chk_piece CHECK (Nb_Piece >= 1),
    CONSTRAINT fk_appart_immeuble FOREIGN KEY (Code) REFERENCES Immeuble(Code)
) CLUSTER cluster_code (Code);

-- Appartenir
CREATE TABLE Appartenir (
    Code VARCHAR2(10) NOT NULL,
    CNI VARCHAR2(20) NOT NULL,
    Debut DATE NOT NULL,
    Fin DATE,
    
    -- Contraintes de table
    CONSTRAINT pk_appartenir PRIMARY KEY (Code, CNI),
    CONSTRAINT fk_appart_immeuble FOREIGN KEY (Code) REFERENCES Immeuble(Code),
    CONSTRAINT fk_appart_proprio FOREIGN KEY (CNI) REFERENCES Proprietaire(CNI)
) CLUSTER cluster_code (Code);

-- Louer
CREATE TABLE Louer (
    NumeroAppartement NUMBER NOT NULL,
    Code VARCHAR2(10) NOT NULL,
    NumeroLocataire NUMBER NOT NULL,
    Debut DATE NOT NULL,
    Fin DATE,
    Prix NUMBER(10,2),
    
    -- Contraintes de table
    CONSTRAINT pk_louer PRIMARY KEY (NumeroAppartement, NumeroLocataire),
    CONSTRAINT chk_prix CHECK (Prix > 0),
    CONSTRAINT fk_louer_appartement FOREIGN KEY (NumeroAppartement) REFERENCES Appartement(Numero),
    CONSTRAINT fk_louer_immeuble FOREIGN KEY (Code) REFERENCES Immeuble(Code),
    CONSTRAINT fk_louer_locataire FOREIGN KEY (NumeroLocataire) REFERENCES Locataire(Numero)
) CLUSTER cluster_code (Code);

-- Agence
CREATE TABLE Agence (
    Nom VARCHAR2(50),
    Adresse VARCHAR2(100),
    Telephone VARCHAR2(20),
    
    -- Contraintes de table
    CONSTRAINT pk_agence PRIMARY KEY (Nom),
    CONSTRAINT uq_tel_agence UNIQUE (Telephone)
);

-- Gerer
CREATE TABLE Gerer (
    NomAgence VARCHAR2(50) NOT NULL,
    Code VARCHAR2(10) NOT NULL,
    Debut DATE NOT NULL,
    Fin DATE,
    
    -- Contraintes de table
    CONSTRAINT pk_gerer PRIMARY KEY (NomAgence, Code),
    CONSTRAINT fk_gerer_agence FOREIGN KEY (NomAgence) REFERENCES Agence(Nom),
    CONSTRAINT fk_gerer_immeuble FOREIGN KEY (Code) REFERENCES Immeuble(Code)
) CLUSTER cluster_code (Code);