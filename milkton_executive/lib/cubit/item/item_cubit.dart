import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:milkton_executive/models/order.dart';

class ItemCubit extends Cubit<List<Item>> {
  ItemCubit() : super([]);

  void setItems(List<Item> items) {
    emit(items);
  }

  void increaseQuantity(String productID) {
    final index = state.indexWhere((element) => element.productID == productID);
    if (index != -1) {
      final item = state[index];
      emit([
        ...state.sublist(0, index),
        Item(
          productID: item.productID,
          quantity: item.quantity + 1,
          price: item.price,
          name: item.name,
          id: item.id,
        ),
        ...state.sublist(index + 1),
      ]);
    }
  }

  void decreaseQuantity(String productID) {
    final index = state.indexWhere((element) => element.productID == productID);
    if (index != -1) {
      final item = state[index];
      if (item.quantity > 0) {
        emit([
          ...state.sublist(0, index),
          Item(
            productID: item.productID,
            quantity: item.quantity - 1,
            price: item.price,
            name: item.name,
            id: item.id,
          ),
          ...state.sublist(index + 1),
        ]);
      }
    }
  }
}
