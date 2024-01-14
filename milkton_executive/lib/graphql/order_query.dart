const String orderForToday = """
query OrderForToday(\$id: String)
  {
    executive(id: \$id) {
    ordersForToday {
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
}
""";
