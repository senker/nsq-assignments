MATCH (v) DETACH DELETE v;


// GENRE: 
CREATE (n:Genre{ GenreName: 'Mystery' });
CREATE (n:Genre{ GenreName: 'Romance' });
CREATE (n:Genre{ GenreName: 'Fiction' });
CREATE (n:Genre{ GenreName: 'Horror' });
CREATE (n:Genre{ GenreName: 'Comedy' });

// CHARACTER TYPE: 
CREATE (:CharacterType{ CharacterTypeName: 'Protagonist' });
CREATE (:CharacterType{ CharacterTypeName: 'Anti-Hero' });
CREATE (:CharacterType{ CharacterTypeName: 'Confidant' });
CREATE (:CharacterType{ CharacterTypeName: 'Helper' });
CREATE (:CharacterType{ CharacterTypeName: 'Deuteragonists' });

// AUTHOR:
CREATE (a:Author{
    FullName: 'John Celt Smith'
});
CREATE (a:Author{
    FullName: 'Mircea Eliade'
});
CREATE (a:Author{
    FullName: 'Nichita Stanescu'
});
CREATE (a:Author{
    FullName: 'Charlotte Bronte'
});
CREATE (a:Author{
    FullName: 'Nicolae Dabija'
});


// CATEGORY:
CREATE (:Category{
    CategoryName: 'Cyberpunk'
})
CREATE (:Category{
    CategoryName: 'Science Fiction'
})
CREATE (:Category{
    CategoryName: 'Fiction'
})
CREATE (:Category{
    CategoryName: 'Romance'
})
CREATE (:Category{
    CategoryName: 'Thriller'
})
CREATE (:Category{
    CategoryName: 'Space Opera'
})


// PUBLISHER:
CREATE (p:Publisher{
        PublisherName: 'Litera'
});
CREATE (p:Publisher{
        PublisherName: 'Penguin Random House'
});
CREATE (p:Publisher{
        PublisherName: 'Gazgolder'
});
CREATE (p:Publisher{
        PublisherName: 'Hachette Livre'
});
CREATE (p:Publisher{
        PublisherName: 'Macmillan Publishers'
});
CREATE (p:Publisher{
        PublisherName: 'Simon & Schuster'
});

// BOOK: 
CREATE (n:Book{
    BookName: 'Celtic Blood',
    PublishedDate: date("1976-09-26"),
    Price: '15',
    Quantity: '100',
    PageCount: '329',
    ISBN: '9780575090712'
});
CREATE (n:Book{
    BookName: 'The Bengali Nights',
    PublishedDate: date("1933-01-02"),
    Price: '15',
    Quantity: '100',
    PageCount: '400',
    ISBN: '9780575090711'
});
CREATE (n:Book{
    BookName: 'Jane Eyre',
    PublishedDate: date("1967-04-11"),
    Price: '20',
    Quantity: '34',
    PageCount: '512',
    ISBN: '9780575442211'
});

CREATE (n:Book{
    BookName: 'Tema pentru acasa',
    PublishedDate: date("1988-08-01"),
    Price: '12',
    Quantity: '40',
    PageCount: '253',
    ISBN: '9780591824512'
});

// CUSTOMER: 
CREATE (n:Customer{
    CustomerName: 'Bruce Wayne',
    Email: 'ogbatman@gmail.com',
    Address: 'Smedegade 33, Horsens',
    Phone: 51515151
});
CREATE (n:Customer{
    CustomerName: 'John Doe',
    Address: 'Solvgade 18, Aarhus',
    Email: 'john.doe@gmail.com',
    Phone: 52525252
});
CREATE (n:Customer{
    CustomerName: 'Jane Doe',
    Address: 'Plantagen 5, Vejle',
    Email: 'jane.doe@gmail.com',
    Phone: 53535353
});
CREATE (n:Customer{
    CustomerName: 'James O’Sullivan',
    Address: 'Ole Jensen Vej 22, Horsens',
    Email: 'james.osul@gmail.com',
    Phone: 54545454
});
CREATE (n:Customer{
    CustomerName: 'Gheorghe Grau',
    Address: 'Stefan Cel Mare 1, Chisinau',
    Email: 'gheorghe@gmail.com',
    Phone: 55555555
});

// ORDER:
CREATE (n:Order{
    OrderNumber: '2001',
    OrderDate: date({year: 2022, month: 11, day: 27}), 
    DeliveryAddress: 'Solvgade 18, Aarhus'
});

CREATE (n:Order{
    OrderNumber: '2002',
    OrderDate: date({year: 2022, month: 11, day: 28}),
    DeliveryAddress: 'Smedegade 33, Horsens'
});

CREATE (n:Order{
    OrderNumber: '2003',
    OrderDate: date({year: 2023, month: 1, day: 12}),
    DeliveryAddress: 'Stefan Cel Mare 1, Chisinau'
});

CREATE (n:Order{
    OrderNumber: '2004',
    OrderDate: date({year: 2023, month: 1, day: 15}),
    DeliveryAddress: 'Ole Jensen Vej 22, Horsens'
});

CREATE (n:Order{
    OrderNumber: '2005',
    OrderDate: date({year: 2023, month: 1, day: 24}),
    DeliveryAddress: 'Plantagen 5, Vejle'
});


















// Set Genre to a Book
MATCH (b:Book), (a:Genre)
WHERE b.ISBN = '9780575090712' AND a.GenreName='Comedy'
CREATE (a)-[:HAS_GENRE]->(b);

MATCH (b:Book), (a:Genre)
WHERE b.ISBN = '9780575090711' AND a.GenreName='Romance'
CREATE (a)-[:HAS_GENRE]->(b);

MATCH (b:Book), (a:Genre)
WHERE b.ISBN = '9780575442211' AND a.GenreName='Mystery'
CREATE (a)-[:HAS_GENRE]->(b);

MATCH (b:Book), (a:Genre)
WHERE b.ISBN = '9780591824512' AND a.GenreName='Horror'
CREATE (a)-[:HAS_GENRE]->(b);

MATCH (b:Book), (a:Genre)
WHERE b.ISBN = '9780591824512' AND a.GenreName='Romance'
CREATE (a)-[:HAS_GENRE]->(b);


// Set CharacterType to a Book
MATCH (b:Book), (c:CharacterType)
WHERE b.ISBN = '9780575090712' AND c.CharacterTypeName='Deuteragonists'
CREATE (b)-[:HAS_CHARACTER]->(c);

MATCH (b:Book), (c:CharacterType)
WHERE b.ISBN = '9780575090712' AND c.CharacterTypeName='Confidant'
CREATE (b)-[:HAS_CHARACTER]->(c);

MATCH (b:Book), (c:CharacterType)
WHERE b.ISBN = '9780575442211' AND c.CharacterTypeName='Protagonist'
CREATE (b)-[:HAS_CHARACTER]->(c);

MATCH (b:Book), (c:CharacterType)
WHERE b.ISBN = '9780575442211' AND c.CharacterTypeName='Helper'
CREATE (b)-[:HAS_CHARACTER]->(c);

MATCH (b:Book), (c:CharacterType)
WHERE b.ISBN = '9780575090711' AND c.CharacterTypeName='Protagonist'
CREATE (b)-[:HAS_CHARACTER]->(c);

MATCH (b:Book), (c:CharacterType)
WHERE b.ISBN = '9780575090711' AND c.CharacterTypeName='Anti-Hero'
CREATE (b)-[:HAS_CHARACTER]->(c);
MATCH (b:Book), (c:CharacterType)
WHERE b.ISBN = '9780591824512' AND c.CharacterTypeName='Protagonist'
CREATE (b)-[:HAS_CHARACTER]->(c);


// Set Order to a Book
MATCH (b:Book), (a:Order)
WHERE b.ISBN = '9780575090712' AND a.OrderNumber='2001'
CREATE (a)-[:CONTAINS{quantity: 2}]->(b);

MATCH (b:Book), (b1:Book), (a:Order)
WHERE b.ISBN = '9780575442211' AND b1.ISBN = '9780591824512' AND a.OrderNumber='2002'
CREATE (a)-[:CONTAINS{quantity: 1}]->(b);
CREATE (a)-[:CONTAINS{quantity: 3}]->(b1);

MATCH (b:Book), (a:Order)
WHERE b.ISBN = '9780575090711' AND a.OrderNumber='2003'
CREATE (a)-[:CONTAINS{quantity: 1}]->(b);

MATCH (b:Book), (a:Order)
WHERE b.ISBN = '9780575090711' AND a.OrderNumber='2004'
CREATE (a)-[:CONTAINS{quantity: 3}]->(b);

MATCH (b:Book), (b1:Book), (a:Order)
WHERE b.ISBN = '9780575090712' AND b1.ISBN = '9780591824512' AND a.OrderNumber='2005'
CREATE (a)-[:CONTAINS{quantity: 4}]->(b);
CREATE (a)-[:CONTAINS{quantity: 3}]->(b1);

// Set Customer to an Order
MATCH (b:Customer), (a:Order)
WHERE b.Email = 'john.doe@gmail.com' AND a.OrderNumber='2001'
CREATE (b)-[:ORDERS]->(a); 

MATCH (b:Customer), (a:Order)
WHERE b.Email = 'ogbatman@gmail.com' AND a.OrderNumber='2002'
CREATE (b)-[:ORDERS]->(a); 

MATCH (b:Customer), (a:Order)
WHERE b.Email = 'jane.doe@gmail.com' AND a.OrderNumber='2003'
CREATE (b)-[:ORDERS]->(a); 

MATCH (b:Customer), (a:Order)
WHERE b.Email = 'james.osul@gmail.com' AND a.OrderNumber='2004'
CREATE (b)-[:ORDERS]->(a); 

MATCH (b:Customer), (a:Order)
WHERE b.Email = 'gheorghe@gmail.com' AND a.OrderNumber='2005'
CREATE (b)-[:ORDERS]->(a); 

//  Set Publisher to a Book
MATCH (b:Book), (a:Publisher)
WHERE b.ISBN = '9780575090712' AND a.PublisherName='Litera'
CREATE (b)-[:PUBLISHED_BY]->(a); 

MATCH (b:Book), (a:Publisher), (a1:Publisher) 
WHERE b.ISBN = '9780575090711' AND a.PublisherName='Penguin Random House' AND a.PublisherName='Gazgolder'
CREATE (b)-[:PUBLISHED_BY]->(a);
CREATE (b)-[:PUBLISHED_BY]->(a1);

MATCH (b:Book), (a:Publisher)
WHERE b.ISBN = '9780575442211' AND a.PublisherName='Macmillan Publishers'
CREATE (b)-[:PUBLISHED_BY]->(a); 

MATCH (b:Book), (a:Publisher)
WHERE b.ISBN = '9780591824512' AND a.PublisherName='Simon & Schuster'
CREATE (b)-[:PUBLISHED_BY]->(a); 


//  Set Author to a Book
MATCH (b:Book), (a:Author)
WHERE b.ISBN = '9780575090712' AND a.FullName='John Celt Smith'
CREATE (b)-[:WRITTEN_BY]->(a); 

MATCH (b:Book), (a:Author)
WHERE b.ISBN = '9780575090711' AND a.FullName='Mircea Eliade'
CREATE (b)-[:WRITTEN_BY]->(a); 

MATCH (b:Book), (a:Author)
WHERE b.ISBN = '9780575442211' AND a.FullName='Nichita Stanescu'
CREATE (b)-[:WRITTEN_BY]->(a); 

MATCH (b:Book), (a:Author), (a1:Author)
WHERE b.ISBN = '9780591824512' AND a.FullName='Nichita Stanescu' AND a.FullName='Nicolae Dabija'
CREATE (b)-[:WRITTEN_BY]->(a); 

//  Set Category to a Book
MATCH (b:Book), (c:Category)
WHERE b.ISBN = '9780575090712' AND c.CategoryName='Fiction'
CREATE (b)-[:HAS_CATEGORY]->(c);

MATCH (b:Book), (c:Category)
WHERE b.ISBN = '9780575090711' AND c.CategoryName='Romance'
CREATE (b)-[:HAS_CATEGORY]->(c);

MATCH (b:Book), (c:Category)
WHERE b.ISBN = '9780575442211' AND c.CategoryName='Science Fiction'
CREATE (b)-[:HAS_CATEGORY]->(c);

MATCH (b:Book), (c:Category), (c1:Category)
WHERE b.ISBN = '9780591824512' AND c.CategoryName='Thriller' AND c.CategoryName='Romance'
CREATE (b)-[:HAS_CATEGORY]->(c);
CREATE (b)-[:HAS_CATEGORY]->(c1);

//  Set parent categories
MATCH (pc:Category), (c:Category)
WHERE pc.CategoryName = 'Cyberpunk' AND c.CategoryName = 'Science Fiction'
CREATE (pc)-[r:SUBCATEGORY_OF]->(c);

MATCH (pc:Category), (c:Category)
WHERE pc.CategoryName = 'Fiction' AND c.CategoryName = 'Science Fiction'
CREATE (pc)-[r:SUBCATEGORY_OF]->(c);

MATCH (pc:Category), (c:Category)
WHERE pc.CategoryName = 'Space Opera' AND c.CategoryName = 'Thriller'
CREATE (pc)-[r:SUBCATEGORY_OF]->(c);

// Delete relationship
MATCH (c:Category {CategoryName:'Fiction'})
-[r:SUBCATEGORY_OF]-
(ca:Category {CategoryName: 'Science Fiction'})
DELETE r
RETURN c, r;