String addTransaction = """
mutation AddTransaction(\$subTotal: Int!, \$customerID: String!, \$orderID: String, \$date: DateTime!){
  addTransaction(subTotal: \$subTotal, customerID: \$customerID, orderID: \$orderID, date: \$date, isDebit: true){
    id
  }
}
""";
