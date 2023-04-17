// 1 How many calls were missed in May?

MATCH (c:Call{duration: 0})
WHERE c.from.month = 5
RETURN count(c) as missed

// Another way - Answer: 82

MATCH (c:Call)
WHERE c.from.month = 5 AND c.duration = 0
RETURN count(c) as calls

// 1 May 2019 specifically

MATCH (c:Call{duration: 0})
WHERE datetime.truncate('month', c.from) = datetime({year: 2019, month: 5})
RETURN count(c) as missed

// 2 Find the name of man, who received a call from Tiffany in May?

MATCH (p1:Person{gender: "Man"})-[:IN]->(c:Call)<-[:OUT]-(p2:Person{name:"Tiffany"})
WHERE c.from.month = 5
RETURN p1

// 2 Another way - Answer: Marco

MATCH (p1:Person)-[:OUT]->(c:Call)<-[:IN]-(p2:Person)
WHERE p1.name = "Tiffany" AND c.from.month = 5 AND p2.gender = "Man"
RETURN p2.name

// 3 Find a city with the lowest number of internal city calls?

MATCH (city:City)<-[:FROM]-(:Person)-[:OUT]->(c:Call)<-[:IN]-(:Person)-[:FROM]->(city)
RETURN city, COUNT(c) as internalCalls
ORDER BY internalCalls ASC
LIMIT 1

// 3 Another way - Answer: Chiang Mai

MATCH (c:City)<-[:FROM]-(p1:Person)-[:OUT]->(cc:Call)<-[:IN]-(p2:Person)-[:FROM]->(c)
RETURN c.name, count(cc) as total
ORDER BY total

// 4 How many women from Pattaya received calls from Bangkok men?

MATCH (:City{name: "Bangkok"})<-[:FROM]-(:Person{gender: "Man"})-[:OUT]->(:Call)<-[:IN]-(p:Person{gender: "Woman"})-[:FROM]->(:City{name: "Pattaya"})
RETURN COUNT(distinct p) as womenCalls

// 4 Another way - Answer: 88

MATCH (:City { name: "Pattaya" })<-[:FROM]-(p:Person { gender: "Woman" })-[:IN]->(:Call)<-[:OUT]-(:Person { gender: "Man" })-[:FROM]->(:City { name: "Bangkok" })
RETURN count(distinct p) as total

// 5 On date 25 of April, find the woman who has the least total duration of conversations?
// 5 Answer: Tinsley

MATCH (p:Person)-[]->(c:Call)
WHERE p.gender = "Woman" AND c.from.month = 4 AND c.from.day = 25 AND c.duration > 0
RETURN p.name as name, sum(c.duration) as minutes
ORDER BY minutes
LIMIT 10

// 6 How many pairs of people, where persons called to each other?
// Answer: 11

MATCH (p1:Person)-[:OUT]->(:Call)<-[:IN]-(p2:Person)
WHERE (p1)-[:IN]->(:Call)<-[:OUT]-(p2) AND id(p1) > id(p2)
RETURN count(p1) as total