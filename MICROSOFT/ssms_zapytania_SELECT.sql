use[2019SBD]

--DROP
ALTER TABLE ProjektyZespolu DROP CONSTRAINT ProjektyZespolu_Projekt;
ALTER TABLE ProjektyZespolu DROP CONSTRAINT ProjektyZespolu_Zespol;
ALTER TABLE Projekt DROP CONSTRAINT Projekt_Klient;
ALTER TABLE Projekt DROP CONSTRAINT Projekt_Status;
ALTER TABLE Pracownik DROP CONSTRAINT Pracownik_Osoba;
ALTER TABLE Klient DROP CONSTRAINT Klient_Osoba;
ALTER TABLE CzlonkowieZespolu DROP CONSTRAINT CzlonkowieZespolu_Pracownik;
ALTER TABLE CzlonkowieZespolu DROP CONSTRAINT CzlonkowieZespolu_Zespol;
DROP TABLE ProjektyZespolu;
DROP TABLE Projekt;
DROP TABLE Status;
DROP TABLE Zespol;
DROP TABLE Pracownik;
DROP TABLE Osoba;
DROP TABLE Klient;
DROP TABLE CzlonkowieZespolu;
--KONIEC DROP


--1
--Nazwy projektów, które są w trakcie realizacji, oraz ilość dni, które upłynęły od rozpoczęcia
SELECT Nazwa, DATEDIFF(DAY, Data_rozpoczecia, GETDATE()) AS Dni_Realizacji
FROM Projekt
WHERE Status_Id_statusu = 1;

--2
--Nazwy zespołów, które mają conajmniej dwóch członków, a także liczbę projektów, które są przypisane do tych zespołów
SELECT Z.Nazwa AS NazwaZespolu, COUNT(CZ.Pracownik_Id_pracownika) AS LiczbaCzlonkow, COUNT(PZ.Projekt_Id_projektu) AS LiczbaProjektow
FROM Zespol Z
JOIN CzlonkowieZespolu CZ ON Z.Id_zespolu = CZ.Zespol_Id_zespolu
LEFT JOIN ProjektyZespolu PZ ON Z.Id_zespolu = PZ.Zespol_Id_zespolu
GROUP BY Z.Id_zespolu, Z.Nazwa
HAVING COUNT(CZ.Pracownik_Id_pracownika) >= 2;

--3
--Imiona i nazwiska pracowników, którzy zarabiają więcej niż średnia pensja w firmie
SELECT O.Imie, O.Nazwisko
FROM Pracownik P
JOIN Osoba O ON P.Osoba_Id_osoby = O.Id_osoby
WHERE P.Pensja > (SELECT AVG(Pensja) FROM Pracownik);

--4
--Imiona i nazwiska klientów, którzy mają jeden projekt
SELECT O.Imie, O.Nazwisko
FROM Klient K
JOIN Osoba O ON K.Id_osoby_kontaktowej = O.Id_osoby
JOIN Projekt P ON K.Id_klienta = P.Klient_Id_klienta
GROUP BY K.Id_klienta, O.Imie, O.Nazwisko
HAVING COUNT(DISTINCT P.Id_projektu) = 1;

--5
--Imiona i nazwiska pracowników oraz ilość projektów, nad którymi pracują, posortowane malejąco według ilości projektów
SELECT O.Imie, O.Nazwisko, COUNT(DISTINCT PZ.Projekt_Id_projektu) AS IloscProjektow
FROM Osoba O
JOIN Pracownik P ON O.Id_osoby = P.Osoba_Id_osoby
JOIN CzlonkowieZespolu CZ ON P.Id_pracownika = CZ.Pracownik_Id_pracownika
LEFT JOIN ProjektyZespolu PZ ON CZ.Zespol_Id_zespolu = PZ.Zespol_Id_zespolu
GROUP BY O.Id_osoby, O.Imie, O.Nazwisko
ORDER BY IloscProjektow DESC;

--6
--Lista pracowników zatrudnionych po określonej dacie
SELECT O.Imie, O.Nazwisko, P.Data_zatrudnienia
FROM Osoba O
JOIN Pracownik P ON O.Id_osoby = P.Osoba_Id_osoby
WHERE P.Data_zatrudnienia > '2022-01-01';

--7
--Lista pracowników wraz z ich zespołami i projektami, do których są przypisani
SELECT O.Imie + ' ' + O.Nazwisko AS Pracownik, Z.Nazwa AS Zespol, P.Nazwa AS Projekt
FROM Osoba O
JOIN Pracownik PR ON O.Id_osoby = PR.Osoba_Id_osoby
LEFT JOIN CzlonkowieZespolu CZ ON PR.Id_pracownika = CZ.Pracownik_Id_pracownika
LEFT JOIN Zespol Z ON CZ.Zespol_Id_zespolu = Z.Id_zespolu
LEFT JOIN ProjektyZespolu PZ ON Z.Id_zespolu = PZ.Zespol_Id_zespolu
LEFT JOIN Projekt P ON PZ.Projekt_Id_projektu = P.Id_projektu;

--8
--Liczba projektów w różnych statusach
SELECT S.Status_projektu, COUNT(P.Id_projektu) AS LiczbaProjektow
FROM Projekt P
JOIN Status S ON P.Status_Id_statusu = S.Id_statusu
GROUP BY S.Status_projektu;

--9
--Lista klientów i liczba projektów, które zamówili
SELECT K.Nazwa_firmy_klienta AS Klient, COUNT(P.Id_projektu) AS LiczbaProjektow
FROM Klient K
LEFT JOIN Projekt P ON K.Id_klienta = P.Klient_Id_klienta
GROUP BY K.Id_klienta, K.Nazwa_firmy_klienta;

--10
--Średnia pensja pracowników w poszczególnych zespołach
SELECT Z.Nazwa AS NazwaZespolu, ROUND(AVG(PR.Pensja), 2) AS SredniaPensja
FROM Zespol Z
JOIN CzlonkowieZespolu CZ ON Z.Id_zespolu = CZ.Zespol_Id_zespolu
JOIN Pracownik PR ON CZ.Pracownik_Id_pracownika = PR.Id_pracownika
GROUP BY Z.Id_zespolu, Z.Nazwa;
