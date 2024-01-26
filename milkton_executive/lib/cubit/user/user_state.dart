part of 'user_cubit.dart';

@immutable
sealed class UserState {}

final class UserInitial extends UserState {}

final class UserFound extends UserState {
  final Executive executive;

  UserFound({required this.executive});
}
