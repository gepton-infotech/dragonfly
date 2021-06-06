String orderForToday = """
query OrderForToday(\$id: String)
  {
    executive(id: \$id) {
    ordersForToday {
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
}
""";
