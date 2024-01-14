part of 'status_cubit.dart';

@immutable
abstract class StatusState {
  String get title;
}

class StatusAll extends StatusState {
  @override
  final String title = "ALL";
}

class StatusActive extends StatusState {
  @override
  final String title = "ACTIVE";
}

class StatusDelivered extends StatusState {
  @override
  final String title = "DELIVERED";
}

class StatusUndelivered extends StatusState {
  @override
  final String title = "UNDELIVERED";
}
