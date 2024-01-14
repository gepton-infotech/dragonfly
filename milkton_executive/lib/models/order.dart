class Order {
  final String id;
  final List<Item> items;
  final String comment;
  final String status;
  final bool isSub;
  final Customer customer;

  Order(
      {required this.id,
      required this.items,
      required this.comment,
      required this.status,
      required this.isSub,
      required this.customer});

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      items: (json['items'] as List).map((i) => Item.fromJson(i)).toList(),
      comment: json['comment'],
      status: json['status'],
      isSub: json['isSub'],
      customer: Customer.fromJson(json['customer']),
    );
  }
}

class Item {
  final String productID;
  final int quantity;
  final int price;
  final String name;
  final String id;

  Item(
      {required this.productID,
      required this.quantity,
      required this.price,
      required this.name,
      required this.id});

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      productID: json['productID'],
      quantity: json['quantity'],
      price: json['price'],
      name: json['name'],
      id: json['_id'],
    );
  }
}

class Customer {
  final String id;
  final String firstName;
  final String lastName;
  final String phone;
  final String address;
  final dynamic latitude;
  final dynamic longitude;

  Customer(
      {required this.id,
      required this.firstName,
      required this.lastName,
      required this.phone,
      required this.address,
      this.latitude,
      this.longitude});

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      phone: json['phone'],
      address: json['address'],
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }
}
