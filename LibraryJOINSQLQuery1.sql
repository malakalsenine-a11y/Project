--Library Database – JOIN Queries--
--1. Display library ID, name, and the name of the manager.--
SELECT 
    l.Library_ID, 
    l.Name AS Library_Name, 
    s.Full_Name AS Manager_Name
FROM Library l
JOIN Staff s
    ON l.Library_ID = s.Library_ID
WHERE s.Position = 'Librarian';

--2. Display library names and the books available in each one.--
SELECT 
    l.Name AS Library_Name,
    b.Title AS Book_Title
FROM Library l
JOIN Book b
    ON l.Library_ID = b.Library_ID
WHERE b.IsAvailable = 1;

--3. Display all member data along with their loan history.--
SELECT 
    m.Member_ID,
    m.Full_Name,
    m.Email,
    m.Phone_Number,
    m.Membership_Start_Date,
    l.Loan_ID,
    l.Loan_Date,
    l.Due_Date,
    l.Return_Date,
    l.Status,
    l.Book_ID
FROM Member m
LEFT JOIN Loan l
    ON m.Member_ID = l.Member_ID;

--4. Display all books located in 'Muscat' or 'Sohar'.--
SELECT 
    Book.Book_ID,
    Book.Title,
    Book.ISBN,
    Book.Genre,
    Book.Price,
    Book.Shelf_Location,
    Library.Name AS Library_Name,
    Library.Location
FROM Book
JOIN Library
    ON Book.Library_ID = Library.Library_ID
WHERE Library.Location IN ('Muscat', 'Sohar');


--5. Display all books whose titles start with 'T'.--
SELECT *
FROM Book
WHERE Title LIKE 'A%';


--6. List members who borrowed books priced between 100 and 300 LE.--
SELECT DISTINCT
    m.Member_ID,
    m.Full_Name,
    m.Email,
    m.Phone_Number
FROM Loan l
JOIN Member m
    ON l.Member_ID = m.Member_ID
JOIN Book b
    ON l.Book_ID = b.Book_ID
WHERE b.Price BETWEEN 15 AND 30;


--7. Retrieve members who borrowed and returned books titled 'The Alchemist'.--
SELECT 
    Member.Member_ID,
    Member.Full_Name,
    Member.Email,
    Member.Phone_Number,
    Member.Membership_Start_Date
FROM Member
JOIN Loan
    ON Member.Member_ID = Loan.Member_ID
JOIN Book
    ON Loan.Book_ID = Book.Book_ID
WHERE Book.Title = 'Children Stories'
  AND Loan.Status = 'Returned';


--8. Find all members assisted by librarian "Huda Al-Balushi".--
SELECT DISTINCT
    Member.Member_ID,
    Member.Full_Name,
    Member.Email
FROM Staff
JOIN Library
    ON Staff.Library_ID = Library.Library_ID
JOIN Book
    ON Library.Library_ID = Book.Library_ID
JOIN Loan
    ON Book.Book_ID = Loan.Book_ID
JOIN Member
    ON Loan.Member_ID = Member.Member_ID
WHERE Staff.Full_Name = 'Huda Al-Balushi'
  AND Staff.Position = 'Librarian';


--9. Display each member’s name and the books they borrowed, ordered by book title.--
SELECT 
Member.Full_Name AS Member_Name,
Book.Title AS Book_Title
FROM Member
JOIN Loan
ON Member.Member_ID = Loan.Member_ID
JOIN Book
ON Loan.Book_ID = Book.Book_ID
ORDER BY Book.Title;

--10. For each book located in 'Cairo Branch', show title, library name, manager, and shelf info.--
SELECT
    Book.Title,
    Library.Name AS Library_Name,
    Staff.Full_Name AS Librarian_Name,
    Book.Shelf_Location
FROM Book
JOIN Library
    ON Book.Library_ID = Library.Library_ID
JOIN Staff
    ON Library.Library_ID = Staff.Library_ID
WHERE Library.Name = 'Central Library'
  AND Staff.Position = 'Librarian';

--11. Display all staff members who manage libraries.--
SELECT
    Full_Name,
    Position,
    Contact_Number,
    Library_ID
FROM Staff
WHERE Position = 'Librarian';

--12. Display all members and their reviews, even if some didn’t submit any review yet.--
SELECT
Member.Member_ID,
Member.Full_Name,
Member.Email,
Review.Review_ID,
Review.Rating,
Review.Comments,
Review.Review_Date
FROM Member
LEFT JOIN Review
ON Member.Member_ID = Review.Member_ID;
