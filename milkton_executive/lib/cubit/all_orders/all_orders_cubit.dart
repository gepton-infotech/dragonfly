import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'all_orders_state.dart';

class AllOrdersCubit extends Cubit<AllOrdersState> {
  AllOrdersCubit() : super(AllOrdersInitial());

  void getOrders(List orders) {
    emit(AllOrdersFound(orders: orders));
  }
}
