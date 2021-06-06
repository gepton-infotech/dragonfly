String markOrder = """
mutation MarkOrder(\$id: ID!, \$status: String, \$items: [Item]){
  markOrder(input: {id: \$id, status: \$status, items: \$items}){
    id
    items
    address {
      name
      lat
      long
    }
    comment
    status
    isSub
    customer {
      id
      firstName
      lastName
      phone
    }
  }
}
""";
