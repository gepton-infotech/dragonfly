String markOrder = """
mutation MarkOrder(\$id: ID!, \$status: String, \$items: [Item], \$comment: String) {
  markOrderAndAddTransaction(id: \$id, status: \$status, items: \$items, comment: \$comment) {
    id
    items
    comment
    status
    isSub
    customer {
      id
      firstName
      lastName
      phone
      address
      latitude
      longitude
    }
  }
}

""";
