Create database LibraryManagementSystem
use LibraryManagementSystem;

CREATE TABLE Library (
Library_ID INT IDENTITY(1,1) PRIMARY KEY,
Name NVARCHAR(100) NOT NULL UNIQUE,
Location VARCHAR(150) NOT NULL,
Contact_Number VARCHAR(20) NOT NULL,
Established_Year INT
);

CREATE TABLE Book (
Book_ID INT IDENTITY(1,1) PRIMARY KEY,
ISBN VARCHAR(20) NOT NULL UNIQUE,
Title VARCHAR(150) NOT NULL,
Genre VARCHAR(30) NOT NULL,
Price DECIMAL(10,2) CHECK (Price > 0),
IsAvailable BIT DEFAULT 1,
Shelf_Location VARCHAR(50) NOT NULL,
Library_ID INT NOT NULL,

CONSTRAINT CHK_Book_Genre
CHECK (Genre IN ('Fiction', 'Non-fiction', 'Reference', 'Children')),

CONSTRAINT FK_Book_Library
FOREIGN KEY (Library_ID)
REFERENCES Library(Library_ID)
ON DELETE CASCADE
ON UPDATE CASCADE
);

CREATE TABLE Member (
Member_ID INT IDENTITY(1,1) PRIMARY KEY,
Full_Name VARCHAR(150),
Email VARCHAR(150) NOT NULL UNIQUE,
Phone_Number VARCHAR(20),
Membership_Start_Date DATE NOT NULL
);

CREATE TABLE Staff (
Staff_ID INT IDENTITY(1,1) PRIMARY KEY,
Full_Name VARCHAR(150),
Position VARCHAR(50),
Contact_Number VARCHAR(20),
Library_ID INT NOT NULL,
CONSTRAINT FK_Staff_Library
FOREIGN KEY (Library_ID) REFERENCES Library(Library_ID)
ON DELETE CASCADE
ON UPDATE CASCADE
);

CREATE TABLE Loan (
Loan_ID INT IDENTITY(1,1) PRIMARY KEY,
Loan_Date DATE NOT NULL,
Due_Date DATE NOT NULL,
Return_Date DATE,
Status VARCHAR(20) NOT NULL DEFAULT 'Issued',
Member_ID INT NOT NULL,
Book_ID INT NOT NULL,

CONSTRAINT CHK_Loan_Status
CHECK (Status IN ('Issued', 'Returned', 'Overdue')),
CONSTRAINT CHK_Return_Date
CHECK (Return_Date IS NULL OR Return_Date >= Loan_Date),

CONSTRAINT FK_Loan_Member
FOREIGN KEY (Member_ID) REFERENCES Member(Member_ID)
ON DELETE CASCADE
ON UPDATE CASCADE,
CONSTRAINT FK_Loan_Book
FOREIGN KEY (Book_ID) REFERENCES Book(Book_ID)
ON DELETE CASCADE
ON UPDATE CASCADE
);

CREATE TABLE Fine_Payment (
Payment_ID INT IDENTITY(1,1) PRIMARY KEY,
Payment_Date DATE NOT NULL,
Amount DECIMAL(10,2) NOT NULL CHECK (Amount > 0),
Method VARCHAR(30),
Loan_ID INT NOT NULL,

CONSTRAINT FK_Payment_Loan
FOREIGN KEY (Loan_ID) REFERENCES Loan(Loan_ID)
ON DELETE CASCADE
ON UPDATE CASCADE
);

CREATE TABLE Review (
Review_ID INT IDENTITY(1,1) PRIMARY KEY,
Rating INT NOT NULL,
Comments VARCHAR(300) DEFAULT 'No comments',
Review_Date DATE NOT NULL,
Member_ID INT NOT NULL,
Book_ID INT NOT NULL,

CONSTRAINT CHK_Review_Rating
CHECK (Rating BETWEEN 1 AND 5),
CONSTRAINT FK_Review_Member
FOREIGN KEY (Member_ID) REFERENCES Member(Member_ID)
ON DELETE CASCADE
ON UPDATE CASCADE,
CONSTRAINT FK_Review_Book
FOREIGN KEY (Book_ID) REFERENCES Book(Book_ID)
ON DELETE CASCADE
ON UPDATE CASCADE
);

-- INSERT--
INSERT INTO Library (Name, Location, Contact_Number, Established_Year)
VALUES
('Central Library', 'Muscat', '12345678', 1995),
('Sohar Library', 'Sohar', '87654321', 2005),
('Salalah Library', 'Salalah', '8976535',2011);
Select * from Library;

INSERT INTO Book (ISBN, Title, Genre, Price, Shelf_Location, Library_ID)
VALUES
('978-1234567890', 'Learn SQL', 'Reference', 25.50, 'A1', 1),
('978-0987654321', 'Children Stories', 'Children', 15.00, 'B2', 1),
('978-1112131415', 'Fiction Novel', 'Fiction', 20.00, 'C3', 2);
Select * from Book;

INSERT INTO Member (Full_Name, Email, Phone_Number, Membership_Start_Date)
VALUES
('Ali Al-Harthy', 'ali@example.com', '90011122', '2025-01-10'),
('Sara Al-Maawali', 'sara@example.com', '90022233', '2025-02-15'),
('Malak AL-Sinani', 'malak@example.com', '95590876', '2021-01-5');
Select * from Member;

INSERT INTO Staff (Full_Name, Position, Contact_Number, Library_ID)
VALUES
('Huda Al-Balushi', 'Librarian', '95011122', 1),
('Khalid Al-Saadi', 'Assistant', '95022233', 2);
Select * from Staff;

INSERT INTO Loan (Loan_Date, Due_Date, Return_Date, Status, Member_ID, Book_ID)
VALUES
('2025-12-01', '2025-12-15', NULL, DEFAULT, 1, 1),
('2025-12-03', '2025-12-17', '2025-12-16', 'Returned', 2, 2),
('2025-10-12', '2025-10-20', '2025-12-17', 'Returned', 3,3); 
Select * from Loan;

INSERT INTO Fine_Payment (Payment_Date, Amount, Method, Loan_ID)
VALUES
('2025-12-16', 5.00, 'Cash', 2),
('2025-12-10', 7.00, 'Visa', 3),
('2025-12-11', 10.00, 'Credit card', 4);
Select * from Fine_Payment;

INSERT INTO Review (Rating, Comments, Review_Date, Member_ID, Book_ID)
VALUES
(5, 'Very helpful book!', '2025-12-05', 1, 1),
(4, NULL, '2025-12-10', 2, 3);
Select * from Review;

-- اضافة -- 
INSERT INTO Book (ISBN, Title, Genre, Price, Shelf_Location, Library_ID)
VALUES
('978-9999999999', 'Advanced Database Systems', 'Reference', 350.00, 'Z9', 1);
Select * from Book;

-- اضافة تابعة لسؤال 7--
ALTER TABLE Book
ADD Published_Year INT;
UPDATE Book
SET Published_Year = 2020
WHERE Book_ID = 1;

UPDATE Book
SET Published_Year = 2019
WHERE Book_ID = 2;

UPDATE Book
SET Published_Year = 2015
WHERE Book_ID = 3;
Select * from Book;
