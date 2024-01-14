part of 'all_orders_cubit.dart';

@immutable
sealed class AllOrdersState {}

final class AllOrdersInitial extends AllOrdersState {}

final class AllOrdersLoading extends AllOrdersState {}

final class AllOrdersError extends AllOrdersState {}

final class AllOrdersFound extends AllOrdersState {
  final List orders;
  AllOrdersFound({required this.orders});
}
