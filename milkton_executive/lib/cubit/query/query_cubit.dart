import 'package:flutter_bloc/flutter_bloc.dart';

class QueryCubit extends Cubit<String> {
  QueryCubit() : super("");

  void setQuery(String query) {
    emit(query);
  }
}
