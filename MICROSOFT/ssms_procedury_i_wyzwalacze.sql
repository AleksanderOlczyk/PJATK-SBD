use[2019SBD]

DROP TRIGGER CzyMoznaUsunacPracownika;
DROP TRIGGER CzyMozaRozwiazacZespol;
DROP PROCEDURE PrzypiszProjektyDoZespolow;
DROP PROCEDURE UsunProjektyAnulowane;

--trigger 1
--sprawdza czy mozna uzunac pracownika
GO
CREATE TRIGGER CzyMoznaUsunacPracownika
ON Pracownik
INSTEAD OF DELETE
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @id_pracownika INT;

    DECLARE pracownik_cursor CURSOR FOR
        SELECT Id_pracownika
        FROM deleted;

    OPEN pracownik_cursor;
    FETCH NEXT FROM pracownik_cursor INTO @id_pracownika;

    WHILE @@FETCH_STATUS = 0
    BEGIN
        IF EXISTS (SELECT 1 FROM CzlonkowieZespolu WHERE Pracownik_Id_pracownika = @id_pracownika)
        BEGIN
            PRINT 'Pracownika nie mozna usunac, poniewaz jest przypisany do zespolu.';
            RETURN;
        END;

        FETCH NEXT FROM pracownik_cursor INTO @id_pracownika;
    END;

    CLOSE pracownik_cursor;
    DEALLOCATE pracownik_cursor;

    DELETE FROM Pracownik
    WHERE Id_pracownika IN (SELECT Id_pracownika FROM deleted);

    PRINT 'Pracownik zostal usuniety';
END;

--trigger 2
--sprawdza czy mozna rozwiazac zepsol
CREATE TRIGGER CzyMozaRozwiazacZespol
ON Zespol
INSTEAD OF DELETE
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @id_zespolu INT;
    DECLARE zespol_cursor CURSOR FOR
        SELECT Id_zespolu
        FROM deleted;

    OPEN zespol_cursor;
    FETCH NEXT FROM zespol_cursor INTO @id_zespolu;

    WHILE @@FETCH_STATUS = 0
    BEGIN
        IF EXISTS (
            SELECT 1
            FROM ProjektyZespolu pz
            INNER JOIN Projekt p ON pz.Projekt_Id_projektu = p.Id_projektu
            INNER JOIN Status s ON p.Status_Id_statusu = s.Id_statusu
            WHERE pz.Zespol_Id_zespolu = @id_zespolu AND s.Status_projektu = 'W trakcie realizacji'
        )
        BEGIN
            PRINT 'Nie mozna usunac zespolu, poniewaz posiada projekty w trakcie realizacji.';
            RETURN;
        END;

        FETCH NEXT FROM zespol_cursor INTO @id_zespolu;
    END;

    CLOSE zespol_cursor;
    DEALLOCATE zespol_cursor;

    DELETE FROM Zespol
    WHERE Id_zespolu IN (SELECT Id_zespolu FROM deleted);

    PRINT 'Zespol zostal usuniety.';
END;

--procedura 1
--przypisuje nowe projekty do zespolow, ktore maja najmniej zadan;
CREATE PROCEDURE PrzypiszProjektyDoZespolow
AS
BEGIN
    SET NOCOUNT ON;
    CREATE TABLE #LiczbaProjektowZespolu
    (
        Zespol_Id_zespolu INT,
        LiczbaProjektow INT
    );

    INSERT INTO #LiczbaProjektowZespolu (Zespol_Id_zespolu, LiczbaProjektow)
    SELECT Z.Id_zespolu, COUNT(PZ.Projekt_Id_projektu) AS LiczbaProjektow
    FROM Zespol Z
    LEFT JOIN ProjektyZespolu PZ ON Z.Id_zespolu = PZ.Zespol_Id_zespolu
    GROUP BY Z.Id_zespolu;

    WHILE EXISTS (SELECT 1 FROM Projekt WHERE Id_projektu NOT IN (SELECT Projekt_Id_projektu FROM ProjektyZespolu))
    BEGIN
        DECLARE @projektId INT;

        SELECT TOP 1 @projektId = Id_projektu
        FROM Projekt
        WHERE Id_projektu NOT IN (SELECT Projekt_Id_projektu FROM ProjektyZespolu);

        DECLARE @zespolId INT;

        SELECT TOP 1 @zespolId = Zespol_Id_zespolu
        FROM #LiczbaProjektowZespolu
        ORDER BY LiczbaProjektow ASC;

        INSERT INTO ProjektyZespolu (Projekt_Id_projektu, Zespol_Id_zespolu)
        VALUES (@projektId, @zespolId);

        UPDATE #LiczbaProjektowZespolu
        SET LiczbaProjektow = LiczbaProjektow + 1
        WHERE Zespol_Id_zespolu = @zespolId;
    END;
    DROP TABLE #LiczbaProjektowZespolu;
END;

--procedura 2
--usuwa wszystkie anulowane projekty
CREATE PROCEDURE UsunProjektyAnulowane
AS
BEGIN
    SET NOCOUNT ON;
    
    DELETE PZ
    FROM ProjektyZespolu PZ
    INNER JOIN Projekt PR ON PZ.Projekt_Id_projektu = PR.Id_projektu
    INNER JOIN Status S ON PR.Status_Id_statusu = S.Id_statusu
    WHERE S.Status_projektu = 'Anulowany';
    
    DELETE PR
    FROM Projekt PR
    INNER JOIN Status S ON PR.Status_Id_statusu = S.Id_statusu
    WHERE S.Status_projektu = 'Anulowany';
END;


--test triggera 1
DELETE FROM Pracownik WHERE Id_pracownika = 1;

--test triggera 2
DELETE FROM Zespol WHERE Id_zespolu = 1;

GO
DECLARE @zespolId INT;

SELECT @zespolId = Id_zespolu
FROM Zespol
WHERE Nazwa = 'Zespó³ Programistyczny A';

DELETE FROM Zespol WHERE Id_zespolu = @zespolId;

SELECT * FROM Zespol;

--test procedury 1
INSERT INTO Projekt (Id_projektu, Nazwa, Opis, Data_rozpoczecia, Przewidywana_data_zakonczenia, Klient_Id_klienta, Status_Id_statusu, Data_ostataniej_modyfikacji)
VALUES (11, 'Projekt A', 'Opis projektu A', '2024-01-20', '2024-02-20', 1, 1, GETDATE());
INSERT INTO Projekt (Id_projektu, Nazwa, Opis, Data_rozpoczecia, Przewidywana_data_zakonczenia, Klient_Id_klienta, Status_Id_statusu, Data_ostataniej_modyfikacji)
VALUES (12, 'Projekt B', 'Opis projektu B', '2024-01-22', '2024-03-22', 2, 2, GETDATE());
INSERT INTO Projekt (Id_projektu, Nazwa, Opis, Data_rozpoczecia, Przewidywana_data_zakonczenia, Klient_Id_klienta, Status_Id_statusu, Data_ostataniej_modyfikacji)
VALUES (13, 'Projekt C', 'Opis projektu C', '2024-02-01', '2024-04-01', 3, 3, GETDATE());

EXEC PrzypiszProjektyDoZespolow;
SELECT * FROM ProjektyZespolu;

--test procedury 2
SELECT
    P.Id_projektu,
    P.Nazwa AS NazwaProjektu,
    S.Status_projektu AS StatusProjektu
FROM
    Projekt P
INNER JOIN
    Status S ON P.Status_Id_statusu = S.Id_statusu;
EXEC UsunProjektyAnulowane;