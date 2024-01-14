import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'status_state.dart';

class StatusCubit extends Cubit<StatusState> {
  StatusCubit() : super(StatusAll());

  void setStatus(StatusState status) => emit(status);
}
