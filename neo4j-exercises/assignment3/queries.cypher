// Sell a book to a customer.

MATCH (b:Book), (c:Customer)
WHERE b.ISBN = '9780591824512' AND c.Email = 'john.doe@gmail.com'
CREATE (a:Order {OrderNumber:'9999', OrderAddress:'Jensen Str 123', OrderDate:date({year: 2022, month: 4, day: 23})})
CREATE (c)-[:ORDERS]->(a)
CREATE (a)-[:CONTAINS{quantity: 1}]->(b);

// Change the address of a customer.

MATCH (c:Customer)
WHERE ID(c) = 251
SET c.Address = 'Stefan Cel Mare 2, Chisingtown'
RETURN c

// Add an existing author to a book.

MATCH (b:Book), (a:Author)
WHERE b.ISBN = '9780575442211' AND a.FullName='Nichita Stanescu'
CREATE (b)-[:WRITTEN_BY]->(a); 

// Retire the "Space Opera" category and assign all books from that category to the parent category. Don't assume you know the id of the parent category.

MATCH (child:Category {CategoryName: "Space Opera"})-[:SUBCATEGORY_OF]->(parent:Category)
MATCH (book:Book)-[:HAS_CATEGORY]->(child)
MERGE (book)-[:HAS_CATEGORY]->(parent)
DETACH DELETE child


// Sell 3 copies of one book and 2 of another in a single order

MATCH (b:Book), (b1:Book), (c:Customer)
WHERE b.ISBN = '9780591824512' AND b1.ISBN = '9780575442211' AND c.Email = 'john.doe@gmail.com'
CREATE (a:Order {OrderNumber:'9999', OrderAddress:'Jensen Str 123', OrderDate:date({year: 2022, month: 4, day: 23})})
CREATE (c)-[:ORDERS]->(a)
CREATE (a)-[:CONTAINS{quantity: 2}]->(b1)
CREATE (a)-[:CONTAINS{quantity: 3}]->(b);

//Querying data
//Write Cypher queries to return the following data
// 1. All books by an author

MATCH (a:Author {FullName: 'John Celt Smith'})<-[:WRITTEN_BY]-(b:Book)
RETURN b.BookName, b.ISBN

// 2. Total price of an order

MATCH (o:Order)-[r:CONTAINS]->(b:Book)
WHERE o.OrderNumber='2002' 
RETURN SUM(toFloat(b.Price) * r.quantity) AS totalPrice

// 3. Total sales (in £) to a customer

MATCH (c:Customer)-[:ORDERS]->(o:Order)-[r:CONTAINS]->(b:Book)
WHERE c.Email = 'john.doe@gmail.com'
RETURN SUM(toFloat(b.Price) * r.quantity) AS totalSales


// 4. Books that are categorized as neither fiction nor non-fiction

MATCH (b:Book)-[:HAS_CATEGORY]->(c:Category)
WHERE NOT c.CategoryName IN ["Fiction", "Non-Fiction"]
RETURN b.BookName, c.CategoryName


// 5. Average page count by genre

MATCH (g:Genre)-[:HAS_GENRE]->(b:Book)
RETURN g.GenreName AS genre, AVG(toInteger(b.PageCount)) AS avg_page_count


// 6. Categories that have no sub-categories


MATCH (c:Category)
WHERE NOT EXISTS ((c)-[:SUBCATEGORY_OF]->())
RETURN c



// 7. ISBN numbers of books with more than one author

MATCH (b:Book)-[:WRITTEN_BY]->(a:Author)
WITH b.ISBN AS isbn, count(a) AS num_authors
WHERE num_authors > 1
RETURN isbn

// 8. ISBN numbers of books that sold at least X copies (you decide the value for X)

MATCH (b:Book)<-[c:CONTAINS]-()
WHERE c.quantity >= 2
RETURN b.ISBN


// 9. Number of copies of each book sold – unsold books should show as 0 sold copies.

MATCH (b:Book)
OPTIONAL MATCH (b)<-[c:CONTAINS]-()
WITH b, COALESCE(SUM(c.quantity), 0) AS sold_copies
RETURN b.ISBN, sold_copies


// 10. Best-selling books: The top 10 selling books ordered in descending order by number of sales.

MATCH (b:Book)<-[c:CONTAINS]-()
RETURN b.BookName AS BookName, b.ISBN AS ISBN, COALESCE(SUM(c.quantity), 0) AS SoldCopies
ORDER BY SoldCopies DESC LIMIT 10


// 11. Best-selling genres: The top 3 selling genres ordered in descending order by number of sales.

MATCH (o:Order)-[r:CONTAINS]->(b:Book)-[:HAS_GENRE]-(g:Genre)
RETURN g.GenreName AS Genre, SUM(r.quantity) AS SoldCopies
ORDER BY SoldCopies
DESC
LIMIT 3

// 12. All science fiction books. Note: Books in science fiction subcategories like cyberpunk also count as science fiction.

MATCH (b:Book)-[:HAS_CATEGORY]->(c:Category)
WHERE c.CategoryName = 'ScienceFiction' OR
      (c)-[:SUBCATEGORY_OF*]->(:Category{CategoryName:'ScienceFiction'})
RETURN b

// 13. Characters used in science fiction books. Note from (12) applies here as well

MATCH (c:CharacterType)<-[:HAS_CHARACTER]-(b:Book)-[:HAS_CATEGORY]->
(cat:Category)
WHERE cat.CategoryName = 'ScienceFiction' OR
      	(cat)-[:SUBCATEGORY_OF*]->(:Category{CategoryName:'ScienceFiction'})
RETURN DISTINCT c.CharacterTypeName

// 14. Number of books in each category including books in subcategories.

MATCH (c:Category)
OPTIONAL MATCH (c)<-[:HAS_CATEGORY*]-(b:Book)
RETURN c.CategoryName, COUNT(DISTINCT b) as NumBooks