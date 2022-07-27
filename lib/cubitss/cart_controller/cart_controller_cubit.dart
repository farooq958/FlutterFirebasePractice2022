import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tasky/data/firebase_repo.dart';

import '../../data/model.dart';

part 'cart_controller_state.dart';

class CartControllerCubit extends Cubit<CartControllerState> {
  CartControllerCubit() : super(CartControllerInitial());

  senddata(List<Product> pr, num gettotalprice,num gettotal)
  async {
    emit(CartControllerInitial());
    var tosend= await Firebaserepo().SendBill(pr,gettotalprice,gettotal);
    if(tosend)
    emit(CartControllerLoaded());

  }

}
