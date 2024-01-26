const String appExecutive = """
query appExecutive
  {
  appExecutive {
    id
    firstName
    lastName
    phone
    photoURL
    route{
      routeName
    }
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
