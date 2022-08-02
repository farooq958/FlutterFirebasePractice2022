import 'package:bloc/bloc.dart';

class QuantityControllerCubit extends Cubit<int> {
  QuantityControllerCubit() : super(1);

  increment(int q) {
    emit(q);
  }
}
