part of 'auth_cubit.dart';

@immutable
sealed class AuthStates {}

final class AuthInitial extends AuthStates {}

final class AuthLoadingState extends AuthStates {}

final class AuthCodeSentState extends AuthStates {
  final String phoneNumber;
  AuthCodeSentState({required this.phoneNumber});
}

final class AuthCodeVerifiedState extends AuthStates {}

final class AuthLoggedInState extends AuthStates {
  final User currentUser;
  AuthLoggedInState({required this.currentUser});
}

final class AuthLoggedOutState extends AuthStates {}

final class AuthErrorState extends AuthStates {
  final String error;
  AuthErrorState({required this.error});
}
