const { gql, ApolloServer } = require("apollo-server")
const { Neo4jGraphQL } = require("@neo4j/graphql")
const neo4j = require("neo4j-driver")
const fs = require("fs").promises

async function startServer(driver) {
    try {
        await driver.verifyConnectivity()
        console.log('Verified')
        const content = await fs.readFile('./friends.sdl', 'utf8')
        const typeDefs = gql(content)
        const graphQL = new Neo4jGraphQL({typeDefs, driver})
        const schema = await graphQL.getSchema()
        const server = new ApolloServer({schema})
        const {url} = await server.listen()
        console.log(`GraphQL server ready on ${url}`)
    } catch (err) {
        console.error(`Error: ${err}`)
    }
}
const driver = neo4j.driver(
    "bolt://127.0.0.1:7687",
    neo4j.auth.basic("neo4j", "19980317"), 
    {encrypted: "ENCRYPTION_OFF"}
)

startServer(driver)