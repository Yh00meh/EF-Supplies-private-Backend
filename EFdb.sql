CREATE book IF NOT EXISTS (
    book_id SERIAL PRIMARY KEY,
    title VARCHAR(50),
    author VARCHAR(30),
    publication_year INT
);


CREATE member IF NOT EXISTS (
    member_id SERIAL PRIMARY KEY,
    member_name VARCHAR(50),
    join_date DATE
);


CREATE loans IF NOT EXISTS (
    loan_id SERIAL PRIMARY KEY
    book_id INT,
    member_id INT,
    loan_date DATE,
    return_date DATE,
    FOREIGN KEY (book_id) REFERENCES book (book_id),
    FOREIGN KEY (member_id) REFERENCES member (member_id)
);


INSERT INTO book (title, author, publication_year)
VALUES
    ('1984', 'George Orwell', 1949),
    ('To Kill a Mockingbird', 'Herper Lee', 1960),
    ('Pride & Prejudice', 'Jane Austen', 1813),
    ('The Great Gatsby', 'F. Sctt Fitzgerald', 1925),
    ('The Cathcher in the Rye', 'F.D. Sallinger', 1951);

INSERT INTO member (member_name, join_date)
VALUES
    ('Alice Green', '2021-02-01'),
    ('Bob Brown', '2020-03-06'),
    ('Charlie Smith', '2018-04-28'),
    ('Ethan White', '2019-09-27'),
    ('Daisy Johnson', '2022-05-29');


INSERT INTO loans (book_id, member_id, loan_date, return_date)
VALUES
    (1, 1, '2024-03-01', '2024-03-15'),
    (2, 2, '2024-03-02', '2024-03-16'),
    (3, 3, '2024-03-05', '2024-03-20'),
    (4, 4, '2024-03-07', '2024-03-21'),
    (5, 5, '2024-03-10', '2024-03-25'),
    (2, 1, '2024-03-16', '2024-03-26'),
    (1, 3, '2024-03-01', '2024-03-15');


/* QUERIES

--- List all books borrowed by member Ethan White.

SELECT book.title
FROM loans
JOIN book ON loans.book_id = book.book_id
WHERE loans.member_id = 4;

--- Result 'The Great Gatsby'

SELECT member.member_name
FROM loans
JOIN member on loans.member_id = member.member_id
WHERE loans.book_id = 2;

SELECT member.member_name, COUNT(loans.book_id) AS total_books_borrowed
FROM member
JOIN loans ON member.member_id = loans.member_id
GROUP BY member.member_name;

*/