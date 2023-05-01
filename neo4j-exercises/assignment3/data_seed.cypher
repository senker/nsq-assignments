// Authors
CREATE (a:Author{
    FirstName: 'John',
    MiddleName: 'Celt',
    LastName: 'Smith'
});

CREATE (a:Author{
    FirstName: 'Mircea',
    MiddleName: '',
    LastName: 'Eliade'
});

CREATE (a:Author{
    FirstName: 'Nichita',
    MiddleName: '',
    LastName: 'Stanescu'
});

CREATE (a:Author{
    FirstName: 'Charlotte',
    MiddleName: '',
    LastName: 'Bronte'
});

CREATE (a:Author{
    FirstName: 'Nicolae',
    MiddleName: '',
    LastName: 'Dabija'
});

CREATE (c: Categories{
    CategoryName: 'Cyberpunk',
    ParentCategory: 'ScienceFiction',
    Genres: 'Fiction',
    CharacterTypes: 'Protagonist'
})
CREATE (c: Categories{
    CategoryName: 'ScienceFiction',
    ParentCategory: 'Fiction',
    Genres: 'Fiction',
    CharacterTypes: 'Protagonist'
})
CREATE (c: Categories{
    CategoryName: 'Fiction',
    ParentCategory: '',
    Genres: 'Mystery',
    CharacterTypes: 'Deuteragonists'
})
CREATE (c: Categories{
    CategoryName: 'Romance',
    ParentCategory: 'ScienceFiction',
    Genres: 'Horror',
    CharacterTypes: 'Helper'
})
CREATE (c: Categories{
    CategoryName: 'Thriller',
    ParentCategory: 'ScienceFiction',
    Genres: 'Comedy',
    CharacterTypes: 'Anti-Hero'
})

MATCH (b:Book), (a:Author)
WHERE b.ISBN = '9780575090712' AND a.FirstName = 'Pula'
CREATE (b)-[:WRITTEN_BY]->(a);

MATCH (b:Book), (a:Genre)
WHERE b.ISBN = '9780575090712'
CREATE (b)-[:HAS]->(a);

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

MATCH (b:Book), (b1:Book{isbn: '9780575090712'}), (c:Customer)
WHERE b.isbn = '9781780228228' AND c.email = 'emma.blacksmith@hotmail.com'
CREATE (o:Order{
    address: 'Aarhus, Denmark',
    date: datetime(),
    deliveryPrice: 10.0,
    estimatedDeliveryDate: datetime()
})
CREATE (o)-[:CONTAINS{quantity: 1, price: r.price}]->(b)
CREATE (o)-[:CONTAINS{quantity: 3, price: r1.price}]->(b1)
CREATE (c)-[:HAS_ORDERED]->(o);