-- Order
-- Find all subjects sorted by subject
    SELECT * FROM subjects ORDER BY subject;
-- Find all subjects sorted by location
    SELECT * FROM subjects ORDER BY location;

-- Where
-- Find the book "Little Women"
    SELECT * FROM books WHERE title = 'Little Women';
-- Find all books containing the word "Python"
    SELECT * FROM books WHERE title LIKE '%Python%';
-- Find all subjects with the location "Main St" sort them by subject
    SELECT * FROM subjects WHERE location = 'Main St' ORDER BY subject;

-- Joins
-- Find all books about Computers and list ONLY the book titles
    SELECT title FROM books WHERE subject_id = (
    SELECT id FROM subjects WHERE subject LIKE '%Computer%'
    );


    SELECT books.title, subjects.id
    FROM books
    INNER JOIN subjects
    ON books.subject_id = subjects.id 
    WHERE subject LIKE '%Computer%';

    
-- Find all books and display a result table with ONLY the following columns

    -- Book title
    -- Author's first name
    -- Author's last name
    -- Book subject

    SELECT new.title AS book_title, new.first_name AS author_first_name, new.last_name AS author_last_name, subjects.subject AS book_subject
    FROM (
    SELECT books.subject_id, books.title, authors.first_name, authors.last_name
    FROM books
    INNER JOIN authors
    ON books.author_id = authors.id
    ) new
    INNER JOIN subjects
    ON new.subject_id = subjects.id;


-- Find all books that are listed in the stock table
    -- stock isbn = editions isbn & editions book_id = books.id
-- Sort them by retail price (most expensive first)
-- Display ONLY: title and price

    SELECT books.title, new.retail AS price
    FROM (
    SELECT stock.retail, editions.book_id
    FROM stock
    INNER JOIN editions
    ON stock.isbn = editions.isbn) new
    INNER JOIN books
    ON new.book_id = books.id
    ORDER BY new.retail DESC;

-- Find the book "Dune" and display ONLY the following columns
-- Book title
-- ISBN number
-- Publisher name = publisher.name, --  editions.publisher_id = publishers.id 
-- Retail price
    
    SELECT new2.title AS book_title, new2.isbn AS ISBN_number, publishers.name AS publisher_name, new2.retail AS retail_price
    FROM (
        SELECT books.title, new.isbn, new.retail, new.publisher_id
        FROM (
            SELECT stock.retail, stock.isbn, editions.book_id, editions.publisher_id
            FROM stock
            INNER JOIN editions
            ON stock.isbn = editions.isbn) new
        INNER JOIN books
        ON new.book_id = books.id) new2
    INNER JOIN publishers
    ON new2.publisher_id = publishers.id;
    

-- Find all shipments sorted by ship date display a result table with ONLY the following columns:
    
-- Customer first name
    -- shipments.customer_id = customers.id
    -- customers.first_name
-- Customer last name
    -- shipments.customer_id = customers.id
    -- customers.last_name
-- ship date
    -- shipments.ship_date
-- book title
    -- shipments.isbn = editions.isbn, editions.book_id = books.id , select book title

SELECT new.first_name, new.last_name, new.ship_date, books.title
FROM (
    SELECT shipments.customer_id, shipments.ship_date, shipments.isbn, customers.first_name, customers.last_name
    FROM shipments
    INNER JOIN customers
    ON shipments.customer_id = customers.id
)
-- STOPPED HERE



-- Grouping and Counting
-- Get the COUNT of all books
-- Get the COUNT of all Locations
-- Get the COUNT of each unique location in the subjects table. Display the count and the location name. (hint: requires GROUP BY).
-- List all books. Display the book_id, title, and a count of how many editions each book has. (hint: requires GROUP BY and JOIN)
-- YAY! You're done!!