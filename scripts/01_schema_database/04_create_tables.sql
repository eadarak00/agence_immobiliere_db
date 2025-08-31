-- Supprimer les tables dans l'ordre inverse des dépendances
DROP TABLE Gerer CASCADE CONSTRAINTS;
DROP TABLE Louer CASCADE CONSTRAINTS;
DROP TABLE Appartenir CASCADE CONSTRAINTS;
DROP TABLE Appartement CASCADE CONSTRAINTS;
DROP TABLE Agence CASCADE CONSTRAINTS;
DROP TABLE Immeuble CASCADE CONSTRAINTS;
DROP TABLE Locataire CASCADE CONSTRAINTS;
DROP TABLE Proprietaire CASCADE CONSTRAINTS;


-- Propriétaire
CREATE TABLE Proprietaire (
    CNI VARCHAR2(20),
    Nom VARCHAR2(50) NOT NULL,
    Prenom VARCHAR2(50) NOT NULL,
    Adresse VARCHAR2(100),
    Age NUMBER(3),
    Sexe CHAR(1),
    Telephone VARCHAR2(20),
    CONSTRAINT pk_proprietaire PRIMARY KEY (CNI),
    CONSTRAINT chk_age_proprietaire CHECK (Age > 18),
    CONSTRAINT chk_sexe_proprietaire CHECK (Sexe IN ('M','F')),
    CONSTRAINT uq_tel_proprietaire UNIQUE (Telephone)
)CLUSTER cluster_nom_prenom (Nom, Prenom);


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
    CONSTRAINT pk_immeuble PRIMARY KEY (Code),
    CONSTRAINT chk_niveau CHECK (Nb_Niveau >= 1)
) CLUSTER cluster_code (Code);

-- Appartement
CREATE TABLE Appartement (
    Numero NUMBER,
    Immeuble VARCHAR2(10) NOT NULL,
    Superficie NUMBER,
    Nb_Piece NUMBER,
    Niveau NUMBER,
    CONSTRAINT pk_appartement PRIMARY KEY (Numero, Immeuble),
    CONSTRAINT chk_superficie CHECK (Superficie > 0),
    CONSTRAINT chk_piece CHECK (Nb_Piece >= 1),
    CONSTRAINT fk_app_immeuble FOREIGN KEY (Immeuble) REFERENCES Immeuble(code)
) CLUSTER cluster_code (Immeuble);

-- Appartenir
CREATE TABLE Appartenir (
    Immeuble VARCHAR2(10) NOT NULL,
    Proprietaire VARCHAR2(20) NOT NULL,
    Debut DATE NOT NULL,
    Fin DATE,
    CONSTRAINT pk_appartenir PRIMARY KEY (Immeuble, Proprietaire, Debut),
    CONSTRAINT fk_appart_immeuble FOREIGN KEY (Immeuble) REFERENCES Immeuble(Code),
    CONSTRAINT fk_appart_proprio FOREIGN KEY (Proprietaire) REFERENCES Proprietaire(CNI)
) CLUSTER cluster_code (Immeuble);

-- Louer
CREATE TABLE Louer (
    Appartement NUMBER NOT NULL,
    Immeuble VARCHAR2(10) NOT NULL,
    Locataire NUMBER NOT NULL,
    Debut DATE NOT NULL,
    Fin DATE,
    Prix NUMBER(10,2),
    CONSTRAINT pk_louer PRIMARY KEY (Appartement, Immeuble, Locataire, Debut),
    CONSTRAINT chk_prix CHECK (Prix > 0),
    CONSTRAINT fk_louer_appartement FOREIGN KEY (Appartement, Immeuble) REFERENCES Appartement(Numero, Immeuble),
    CONSTRAINT fk_louer_locataire FOREIGN KEY (Locataire) REFERENCES Locataire(Numero)
) CLUSTER cluster_code (Immeuble);

-- Agence
CREATE TABLE Agence (
    Nom VARCHAR2(50),
    Adresse VARCHAR2(100),
    Telephone VARCHAR2(20),
    CONSTRAINT pk_agence PRIMARY KEY (Nom),
    CONSTRAINT uq_tel_agence UNIQUE (Telephone)
);

-- Gerer
CREATE TABLE Gerer (
    Agence VARCHAR2(50) NOT NULL,
    Immeuble VARCHAR2(10) NOT NULL,
    Debut DATE NOT NULL,
    Fin DATE,
    CONSTRAINT pk_gerer PRIMARY KEY (Agence, Immeuble, Debut),
    CONSTRAINT fk_gerer_agence FOREIGN KEY (Agence) REFERENCES Agence(Nom),
    CONSTRAINT fk_gerer_immeuble FOREIGN KEY (Immeuble) REFERENCES Immeuble(Code)
) CLUSTER cluster_code (Immeuble);