// 1. Show blogs (remember to use LIMIT)

MATCH (p:Post)
RETURN p
LIMIT 25

// 2. Show blogs with no comments

MATCH (p:Post)
WHERE NOT EXISTS(()-[:COMMENTS]->(p))
RETURN p
LIMIT 25

// 3. Which users have never commented?

MATCH (u:User)
WHERE NOT (:Post)<-[:COMMENTS]-(:Comment)<-[:WROTE]-(u)
RETURN u
LIMIT 25

// 4. Which users have commented more than twice?

MATCH (u:User)-[:WROTE]->(c:Comment)
WITH u, count(c) AS commentCount
WHERE commentCount > 2
RETURN u
LIMIT 25

// 5. Find blog posts by user "thecrowd"

MATCH (:User {username: "thecrowd"})-[:WROTE]->(p:Post)
RETURN p

// 6. How many blog posts has user "myattention" posted?

MATCH (:User {username: "myattention"})-[:WROTE]->(p:Post)
RETURN count(p)

// 7. Which blog posts have the "Thames" tag?

MATCH (p:Post)-[:TAGGED]->(t:Tag{name: "Thames"})
RETURN p

// 8. Which blog posts have the "Thames" and the "surface" tag?

MATCH (p:Post)-[:TAGGED]->(t1:Tag {name: "surface"})
MATCH (p)-[:TAGGED]->(t2:Tag {name: "Thames"})
RETURN p

// 9. Which blog posts have the "Thames" or the "surface" tag?

MATCH (p:Post)-[:TAGGED]->(t:Tag)
WHERE t.name = "surface" OR t.name = "Thames"
RETURN p

// 10. Which blog posts are tagged with "field" and nothing else?

MATCH (p:Post)-[:TAGGED]->(t:Tag)
WHERE t.name = "field"
AND NOT EXISTS((p)-[:TAGGED]->(:Tag)-[:TAGGED]->(t))
RETURN p

// 11. Show for each user an array of the texts they have written whether blog posts or comments.

MATCH (u:User)-[:WROTE]->(t)
WITH u, COLLECT(t.text) AS texts
RETURN u.name, texts

// 12. Show for each comment an array of the usernames of the likes ordered by number of likes. 
// (Note: Some comments have no likes.)

MATCH (c:Comment)<-[:LIKES]-(u:User)
WITH c, collect(u.username) AS likers
ORDER BY size(likers) DESC
RETURN c.text AS comment_text, likers

// 13. Which users have commented on their own blog post? 
// (Can you do it with only one match and one return?)

MATCH (u:User)-[:WROTE]->(p:Post)<-[:COMMENTS]-(c:Comment)<-[:WROTE]-(u)
RETURN DISTINCT u

// 14. Which comments have "twilight" liked?

MATCH (u:User {username: "twilight"})-[:LIKES]->(c:Comment)
RETURN c

// 15. Which blog posts contain "Martians" in the text?

MATCH (p:Post)
WHERE toLower(p.text) CONTAINS "martians"
RETURN p
LIMIT 25