DROP TRIGGER ZatrudnijPracownika;
DROP TRIGGER AktualizujDateModyfikacjiIStatusProjektu;
DROP PROCEDURE DajPodwyzke;
DROP PROCEDURE ZnajdzPensjePowyzejSredniej;

--Procedura 1
--Zwiększa pensję pracownika o 10%, jeśli pracownik ma więcej niż 3 lata stażu
CREATE PROCEDURE DajPodwyzke(v_id_pracownika INTEGER) AS
BEGIN
    DECLARE
        v_data_zatrudnienia DATE;
    BEGIN
        SELECT Data_zatrudnienia INTO v_data_zatrudnienia FROM Pracownik WHERE Id_pracownika = v_id_pracownika;

        IF (SYSDATE - v_data_zatrudnienia) > 730 THEN
            UPDATE Pracownik
            SET Pensja = Pensja * 1.1
            WHERE Id_pracownika = v_id_pracownika;
        END IF;
    END;
END DajPodwyzke;

--Procedura 2
--Znajduje i zwraca listę pracowników, których pensje przekraczają średnią pensję pracowników w ich zespole
CREATE PROCEDURE ZnajdzPensjePowyzejSredniej AS
BEGIN
    FOR Prac IN (SELECT P.Id_pracownika, O.Imie, O.Nazwisko
                 FROM Pracownik P
                 JOIN Osoba O ON P.Osoba_Id_osoby = O.Id_osoby
                 WHERE P.Pensja > (SELECT AVG(Pensja) FROM Pracownik WHERE Osoba_Id_osoby = O.Id_osoby)) LOOP
        DBMS_OUTPUT.PUT_LINE('ID: ' || Prac.Id_pracownika || ', Imię: ' || Prac.Imie || ', Nazwisko: ' || Prac.Nazwisko);
    END LOOP;
END ZnajdzPensjePowyzejSredniej;

--Trigger 1
--Sprawdza, czy data zatrudnienia pracownika nie jest przyszła, a pensja nie jest niższa niż minimalna
CREATE TRIGGER ZatrudnijPracownika
BEFORE INSERT ON Pracownik
FOR EACH ROW
BEGIN
    IF :NEW.Data_zatrudnienia > SYSDATE OR :NEW.Pensja < 3000 THEN
        RAISE_APPLICATION_ERROR(-20001, 'Data zatrudnienia nie może być przyszła, a pensja nie może być niższa niż minimalna.');
    END IF;
END ZatrudnijPracownika;

--Trigger 2
--Aktualizuje datę ostatniej modyfikacji projektu i sprawdza,
--czy planowana data zakończenia nie jest wcześniejsza niż data rozpoczęcia, jeśli jest to ustawia status projektu na anulowany
CREATE TRIGGER AktualizujDateModyfikacjiIStatusProjektu
AFTER UPDATE ON Projekt
FOR EACH ROW
BEGIN
    UPDATE Projekt
    SET Data_ostatniej_modyfikacji = SYSDATE
    WHERE Id_projektu = :NEW.Id_projektu;

    IF :NEW.Przewidywana_data_zakonczenia < :NEW.Data_rozpoczecia THEN
        UPDATE Projekt
        SET Status_Id_statusu = 3
        WHERE Id_projektu = :NEW.Id_projektu;
    END IF;
END AktualizujDateModyfikacjiIStatusProjektu;

--procedura 1
EXEC DajPodwyzke(1);

DECLARE
    v_id_pracownika INTEGER;
BEGIN
    SELECT Id_pracownika
    INTO v_id_pracownika
    FROM Osoba O
    JOIN Pracownik P ON O.Id_osoby = P.Osoba_Id_osoby
    WHERE O.Imie = 'Jan' AND O.Nazwisko = 'Kowalski';

    DajPodwyzke(v_id_pracownika);
END;

SELECT * FROM Pracownik;

--procedura 2
EXEC ZnajdzPensjePowyzejSredniej;

--wyzwalacz 1
INSERT INTO Osoba (Id_osoby, Imie, Nazwisko)
VALUES (10, 'John', 'Doe');

INSERT INTO Pracownik (Id_pracownika, Osoba_Id_osoby, Pensja, Data_zatrudnienia)
VALUES (10, 10, 3000, TO_DATE('2025-12-31', 'YYYY-MM-DD'));

--wyzwalacz 2
SELECT * FROM Projekt;

--wyzwalacz 2
INSERT INTO Projekt (Id_projektu, Nazwa, Opis, Data_rozpoczecia, Przewidywana_data_zakonczenia, Klient_Id_klienta, Status_Id_statusu)
VALUES (10, 'Projekt Testowy', 'Opis projektu', TO_DATE('2023-01-01', 'YYYY-MM-DD'), TO_DATE('2022-01-01', 'YYYY-MM-DD'), 1, 1);

SELECT * FROM Projekt;