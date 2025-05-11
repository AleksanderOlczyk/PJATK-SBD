-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2023-12-31 22:05:27.805

-- tables
-- Table: CzlonkowieZespolu
CREATE TABLE CzlonkowieZespolu (
    Pracownik_Id_pracownika integer  NOT NULL,
    Zespol_Id_zespolu integer  NOT NULL,
    CONSTRAINT CzlonkowieZespolu_pk PRIMARY KEY (Zespol_Id_zespolu,Pracownik_Id_pracownika)
) ;

-- Table: Klient
CREATE TABLE Klient (
    Id_klienta integer  NOT NULL,
    Id_osoby_kontaktowej integer  NOT NULL,
    Nazwa_firmy_klienta varchar2(500)  NOT NULL,
    CONSTRAINT Klient_pk PRIMARY KEY (Id_klienta)
) ;

-- Table: Osoba
CREATE TABLE Osoba (
    Id_osoby integer  NOT NULL,
    Imie varchar2(100)  NOT NULL,
    Nazwisko varchar2(100)  NOT NULL,
    CONSTRAINT Osoba_pk PRIMARY KEY (Id_osoby)
) ;

-- Table: Pracownik
CREATE TABLE Pracownik (
    Id_pracownika integer  NOT NULL,
    Osoba_Id_osoby integer  NOT NULL,
    Pensja integer  NOT NULL,
    Data_zatrudnienia date  NOT NULL,
    CONSTRAINT Pracownik_pk PRIMARY KEY (Id_pracownika)
) ;

-- Table: Projekt
CREATE TABLE Projekt (
    Id_projektu integer  NOT NULL,
    Nazwa varchar2(255)  NOT NULL,
    Opis clob  NOT NULL,
    Data_rozpoczecia date  NOT NULL,
    Przewidywana_data_zakonczenia date  NOT NULL,
    Klient_Id_klienta integer  NOT NULL,
    Status_Id_statusu integer  NOT NULL,
    Data_ostatniej_modyfikacji date  NULL,
    CONSTRAINT Projekt_pk PRIMARY KEY (Id_projektu)
) ;

-- Table: ProjektyZespolu
CREATE TABLE ProjektyZespolu (
    Projekt_Id_projektu integer  NOT NULL,
    Zespol_Id_zespolu integer  NOT NULL,
    CONSTRAINT ProjektyZespolu_pk PRIMARY KEY (Zespol_Id_zespolu,Projekt_Id_projektu)
) ;

-- Table: Status
CREATE TABLE Status (
    Id_statusu integer  NOT NULL,
    Status_projektu varchar2(50)  NOT NULL,
    CONSTRAINT Status_pk PRIMARY KEY (Id_statusu)
) ;

-- Table: Zespol
CREATE TABLE Zespol (
    Id_zespolu integer  NOT NULL,
    Nazwa varchar2(255)  NOT NULL,
    Data_utworzenia date  NOT NULL,
    CONSTRAINT Zespol_pk PRIMARY KEY (Id_zespolu)
) ;

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

