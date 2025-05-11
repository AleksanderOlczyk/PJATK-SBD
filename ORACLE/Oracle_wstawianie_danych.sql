INSERT INTO Osoba (Id_osoby, Imie, Nazwisko) VALUES	(1, 'Jan', 'Kowalski');
INSERT INTO Osoba (Id_osoby, Imie, Nazwisko) VALUES	(2, 'Anna', 'Nowak');
INSERT INTO Osoba (Id_osoby, Imie, Nazwisko) VALUES	(3, 'Piotr', 'Wisniewski');
INSERT INTO Osoba (Id_osoby, Imie, Nazwisko) VALUES (4, 'Katarzyna', 'Dabrowska');
INSERT INTO Osoba (Id_osoby, Imie, Nazwisko) VALUES	(5, 'Marek', 'Lewandowski');

INSERT INTO Klient (Id_klienta, Id_osoby_kontaktowej, Nazwa_firmy_klienta) VALUES (1, 2, 'ABC Company');
INSERT INTO Klient (Id_klienta, Id_osoby_kontaktowej, Nazwa_firmy_klienta) VALUES (2, 4, 'XYZ Corporation');
INSERT INTO Klient (Id_klienta, Id_osoby_kontaktowej, Nazwa_firmy_klienta) VALUES (3, 1, '123 Enterprises');
INSERT INTO Klient (Id_klienta, Id_osoby_kontaktowej, Nazwa_firmy_klienta) VALUES (4, 3, 'Tech Solutions');
INSERT INTO Klient (Id_klienta, Id_osoby_kontaktowej, Nazwa_firmy_klienta) VALUES (5, 5, 'Innovate Industry');

INSERT INTO Pracownik (Id_pracownika, Osoba_Id_osoby, Pensja, Data_zatrudnienia) VALUES	(1, 1, 5000, TO_DATE('2022-01-15', 'YYYY-MM-DD'));
INSERT INTO Pracownik (Id_pracownika, Osoba_Id_osoby, Pensja, Data_zatrudnienia) VALUES	(2, 3, 6000, TO_DATE('2021-12-01', 'YYYY-MM-DD'));
INSERT INTO Pracownik (Id_pracownika, Osoba_Id_osoby, Pensja, Data_zatrudnienia) VALUES	(3, 5, 5500, TO_DATE('2020-03-10', 'YYYY-MM-DD'));
INSERT INTO Pracownik (Id_pracownika, Osoba_Id_osoby, Pensja, Data_zatrudnienia) VALUES	(4, 2, 7000, TO_DATE('2022-02-20', 'YYYY-MM-DD'));
INSERT INTO Pracownik (Id_pracownika, Osoba_Id_osoby, Pensja, Data_zatrudnienia) VALUES	(5, 4, 8500, TO_DATE('2018-04-05', 'YYYY-MM-DD'));

INSERT INTO Zespol (Id_zespolu, Nazwa, Data_utworzenia) VALUES (1, 'Zespół Programistyczny A', TO_DATE('2022-01-01', 'YYYY-MM-DD'));
INSERT INTO Zespol (Id_zespolu, Nazwa, Data_utworzenia) VALUES (2, 'Zespół QA', TO_DATE('2022-02-15', 'YYYY-MM-DD'));
INSERT INTO Zespol (Id_zespolu, Nazwa, Data_utworzenia) VALUES (3, 'Zespół UX/UI', TO_DATE('2022-03-01', 'YYYY-MM-DD'));
INSERT INTO Zespol (Id_zespolu, Nazwa, Data_utworzenia) VALUES (4, 'Zespół Projektowy', TO_DATE('2022-04-01', 'YYYY-MM-DD'));
INSERT INTO Zespol (Id_zespolu, Nazwa, Data_utworzenia) VALUES (5, 'Zespół Helpdesk', TO_DATE('2022-05-01', 'YYYY-MM-DD'));

INSERT INTO CzlonkowieZespolu (Pracownik_Id_pracownika, Zespol_Id_zespolu) VALUES (1, 1);
INSERT INTO CzlonkowieZespolu (Pracownik_Id_pracownika, Zespol_Id_zespolu) VALUES (5, 1);
INSERT INTO CzlonkowieZespolu (Pracownik_Id_pracownika, Zespol_Id_zespolu) VALUES (3, 1);
INSERT INTO CzlonkowieZespolu (Pracownik_Id_pracownika, Zespol_Id_zespolu) VALUES (4, 2);
INSERT INTO CzlonkowieZespolu (Pracownik_Id_pracownika, Zespol_Id_zespolu) VALUES (3, 3);
INSERT INTO CzlonkowieZespolu (Pracownik_Id_pracownika, Zespol_Id_zespolu) VALUES (3, 5);
INSERT INTO CzlonkowieZespolu (Pracownik_Id_pracownika, Zespol_Id_zespolu) VALUES (1, 3);
INSERT INTO CzlonkowieZespolu (Pracownik_Id_pracownika, Zespol_Id_zespolu) VALUES (4, 4);
INSERT INTO CzlonkowieZespolu (Pracownik_Id_pracownika, Zespol_Id_zespolu) VALUES (5, 4);
INSERT INTO CzlonkowieZespolu (Pracownik_Id_pracownika, Zespol_Id_zespolu) VALUES (5, 5);

INSERT INTO Status (Id_statusu, Status_projektu) VALUES (1, 'W trakcie realizacji');
INSERT INTO Status (Id_statusu, Status_projektu) VALUES	(2, 'Zakończony');
INSERT INTO Status (Id_statusu, Status_projektu) VALUES	(3, 'Anulowany');
INSERT INTO Status (Id_statusu, Status_projektu) VALUES	(4, 'Planowany');
INSERT INTO Status (Id_statusu, Status_projektu) VALUES	(5, 'Wstrzymany');

INSERT INTO Projekt (Id_projektu, Nazwa, Opis, Data_rozpoczecia, Przewidywana_data_zakonczenia, Klient_Id_klienta, Status_Id_statusu) VALUES
	(1, 'Projekt A', 'Opis projektu A', TO_DATE('2022-01-10', 'YYYY-MM-DD'), TO_DATE('2024-06-30', 'YYYY-MM-DD'), 1, 1);
INSERT INTO Projekt (Id_projektu, Nazwa, Opis, Data_rozpoczecia, Przewidywana_data_zakonczenia, Klient_Id_klienta, Status_Id_statusu) VALUES
	(2, 'Projekt B', 'Opis projektu B', TO_DATE('2022-02-01', 'YYYY-MM-DD'), TO_DATE('2022-07-15', 'YYYY-MM-DD'), 2, 2);
INSERT INTO Projekt (Id_projektu, Nazwa, Opis, Data_rozpoczecia, Przewidywana_data_zakonczenia, Klient_Id_klienta, Status_Id_statusu) VALUES
	(3, 'Projekt C', 'Opis projektu C', TO_DATE('2021-03-15', 'YYYY-MM-DD'), TO_DATE('2021-08-10', 'YYYY-MM-DD'), 3, 3);
INSERT INTO Projekt (Id_projektu, Nazwa, Opis, Data_rozpoczecia, Przewidywana_data_zakonczenia, Klient_Id_klienta, Status_Id_statusu) VALUES
	(4, 'Projekt D', 'Opis projektu D', TO_DATE('2024-04-01', 'YYYY-MM-DD'), TO_DATE('2026-09-01', 'YYYY-MM-DD'), 4, 4);
INSERT INTO Projekt (Id_projektu, Nazwa, Opis, Data_rozpoczecia, Przewidywana_data_zakonczenia, Klient_Id_klienta, Status_Id_statusu) VALUES
	(5, 'Projekt E', 'Opis projektu E', TO_DATE('2022-05-01', 'YYYY-MM-DD'), TO_DATE('2027-10-15', 'YYYY-MM-DD'), 5, 5);

INSERT INTO ProjektyZespolu (Projekt_Id_projektu, Zespol_Id_zespolu) VALUES	(1, 1);
INSERT INTO ProjektyZespolu (Projekt_Id_projektu, Zespol_Id_zespolu) VALUES	(2, 2);
INSERT INTO ProjektyZespolu (Projekt_Id_projektu, Zespol_Id_zespolu) VALUES	(3, 3);
INSERT INTO ProjektyZespolu (Projekt_Id_projektu, Zespol_Id_zespolu) VALUES	(4, 4);
INSERT INTO ProjektyZespolu (Projekt_Id_projektu, Zespol_Id_zespolu) VALUES	(5, 5);
