class ExecutiveModel {
  String status;
  String executiveID;
  String phone;
  String firstName;
  String lastName;

  ExecutiveModel({
    this.status,
    this.executiveID,
    this.phone,
    this.firstName,
    this.lastName,
  });

  factory ExecutiveModel.fromJson(final json) {
    return ExecutiveModel(
        status: json["status"],
        executiveID: json["id"],
        phone: json["phone"],
        firstName: json["firstName"],
        lastName: json["lastName"]);
  }
}
