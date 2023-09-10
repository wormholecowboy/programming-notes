# GraphQL

Created: July 10, 2022 4:17 PM
Updated: September 5, 2022 10:35 PM

[graphql-shorthand-notation-cheat-sheet.pdf](GraphQL%20cd15273faf544364bcd5055638f50138/graphql-shorthand-notation-cheat-sheet.pdf)

MISC

- Only uses one endpoint, as opposed to REST. Uses query syntax to grab exact data. Less calls to server.
- Everything is strongly typed
- vars are prefixed with $
- A combo of types, with fields, that have functions
- ! is non-nullable
- no GET, you are always POSTing a query

```graphql
// SCHEMAS FOR QUERYING

# prop: type

type Creator{
	id: ID! # ! makes it required
	name: String
	subscribers: Int
	video: [Video] # means that can have many of this other type
	# creates a realationship to video
}

type Video {
	url: String!
  creator: Creator # this also creates a relationship
}

# creating a root query
type Query{
	video: [Video]
	creator(id: String!): Creator
}

# chaning data
type Mutation {
	createVideo(url: string): Video
	deleteVideo(url: string): String
	
```

```graphql
// RESOLVING QUERIES

const resolvers = {
	Query: {
		someObject(parentObject, params, dataSources) {
			return db.data.whatever
}
} // 'Query' will match the request schema so resolver knows where to look
} // dataSources is a global context, available everywhere (ex. auth tokens)

```

```graphql
# QUERYING SYNTAX

{
	human(id: 1234) { #passing args to filter
		name
		height
	}
}
```

# **GraphQL Introspection Query**

A server exposes the following introspection queries on the `Query` operation type.

- `__schema`
- `__type`
- `__typename`

### **Fetch Available Queries**

There are scenarios where you might want to see all the available queries in a GraphQL API. You can query the schema as follows:

```
Copy{
  __schema {
    queryType {
      fields {
        name
        description
      }
    }
  }
}

```

You can also fetch all the available mutations with the following query:

```
Copy{
  __schema {
    mutationType {
      fields {
        name
        description
      }
    }
  }
}

```

Lastly, you can fetch all the types as follows:

```
Copy{
  __schema {
    types {
      name
      description
    }
  }
}

```