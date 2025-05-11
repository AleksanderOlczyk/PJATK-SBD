use[2019SBD]

-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2024-01-10 19:50:27.909

-- tables
-- Table: CzlonkowieZespolu

CREATE TABLE CzlonkowieZespolu (
    Pracownik_Id_pracownika int  NOT NULL,
    Zespol_Id_zespolu int  NOT NULL,
    CONSTRAINT CzlonkowieZespolu_pk PRIMARY KEY  (Pracownik_Id_pracownika,Zespol_Id_zespolu)
);

-- Table: Klient
CREATE TABLE Klient (
    Id_klienta int  NOT NULL,
    Id_osoby_kontaktowej int  NOT NULL,
    Nazwa_firmy_klienta nvarchar(500)  NOT NULL,
    CONSTRAINT Klient_pk PRIMARY KEY  (Id_klienta)
);

-- Table: Osoba
CREATE TABLE Osoba (
    Id_osoby int  NOT NULL,
    Imie nvarchar(100)  NOT NULL,
    Nazwisko nvarchar(100)  NOT NULL,
    CONSTRAINT Osoba_pk PRIMARY KEY  (Id_osoby)
);

-- Table: Pracownik
CREATE TABLE Pracownik (
    Id_pracownika int  NOT NULL,
    Osoba_Id_osoby int  NOT NULL,
    Pensja int  NOT NULL,
    Data_zatrudnienia datetime  NOT NULL,
    CONSTRAINT Pracownik_pk PRIMARY KEY  (Id_pracownika)
);

-- Table: Projekt
CREATE TABLE Projekt (
    Id_projektu int  NOT NULL,
    Nazwa nvarchar(255)  NOT NULL,
    Opis nvarchar(max)  NOT NULL,
    Data_rozpoczecia datetime  NOT NULL,
    Przewidywana_data_zakonczenia datetime  NOT NULL,
    Klient_Id_klienta int  NOT NULL,
    Status_Id_statusu int  NOT NULL,
    Data_ostataniej_modyfikacji datetime  NULL,
    CONSTRAINT Projekt_pk PRIMARY KEY  (Id_projektu)
);

-- Table: ProjektyZespolu
CREATE TABLE ProjektyZespolu (
    Projekt_Id_projektu int  NOT NULL,
    Zespol_Id_zespolu int  NOT NULL,
    CONSTRAINT ProjektyZespolu_pk PRIMARY KEY  (Zespol_Id_zespolu,Projekt_Id_projektu)
);

-- Table: Status
CREATE TABLE Status (
    Id_statusu int  NOT NULL,
    Status_projektu nvarchar(50)  NOT NULL,
    CONSTRAINT Status_pk PRIMARY KEY  (Id_statusu)
);

-- Table: Zespol
CREATE TABLE Zespol (
    Id_zespolu int  NOT NULL,
    Nazwa nvarchar(255)  NOT NULL,
    Data_utworzenia datetime  NOT NULL,
    CONSTRAINT Zespol_pk PRIMARY KEY  (Id_zespolu)
);

-- foreign keys
-- Reference: CzlonkowieZespolu_Pracownik (table: CzlonkowieZespolu)
ALTER TABLE CzlonkowieZespolu ADD CONSTRAINT CzlonkowieZespolu_Pracownik
    FOREIGN KEY (Pracownik_Id_pracownika)
    REFERENCES Pracownik (Id_pracownika);

-- Reference: CzlonkowieZespolu_Zespol (table: CzlonkowieZespolu)
ALTER TABLE CzlonkowieZespolu ADD CONSTRAINT CzlonkowieZespolu_Zespol
    FOREIGN KEY (Zespol_Id_zespolu)
    REFERENCES Zespol (Id_zespolu);

-- Reference: Klient_Osoba (table: Klient)
ALTER TABLE Klient ADD CONSTRAINT Klient_Osoba
    FOREIGN KEY (Id_osoby_kontaktowej)
    REFERENCES Osoba (Id_osoby);

-- Reference: Pracownik_Osoba (table: Pracownik)
ALTER TABLE Pracownik ADD CONSTRAINT Pracownik_Osoba
    FOREIGN KEY (Osoba_Id_osoby)
    REFERENCES Osoba (Id_osoby);

-- Reference: Projekt_Klient (table: Projekt)
ALTER TABLE Projekt ADD CONSTRAINT Projekt_Klient
    FOREIGN KEY (Klient_Id_klienta)
    REFERENCES Klient (Id_klienta);

-- Reference: Projekt_Status (table: Projekt)
ALTER TABLE Projekt ADD CONSTRAINT Projekt_Status
    FOREIGN KEY (Status_Id_statusu)
    REFERENCES Status (Id_statusu);

-- Reference: ProjektyZespolu_Projekt (table: ProjektyZespolu)
ALTER TABLE ProjektyZespolu ADD CONSTRAINT ProjektyZespolu_Projekt
    FOREIGN KEY (Projekt_Id_projektu)
    REFERENCES Projekt (Id_projektu);

-- Reference: ProjektyZespolu_Zespol (table: ProjektyZespolu)
ALTER TABLE ProjektyZespolu ADD CONSTRAINT ProjektyZespolu_Zespol
    FOREIGN KEY (Zespol_Id_zespolu)
    REFERENCES Zespol (Id_zespolu);

-- End of file.

