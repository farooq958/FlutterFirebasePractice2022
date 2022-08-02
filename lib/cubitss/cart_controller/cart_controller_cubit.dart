import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tasky/data/firebase_repo.dart';

import '../../data/model.dart';

part 'cart_controller_state.dart';

class CartControllerCubit extends Cubit<CartControllerState> {
  CartControllerCubit() : super(CartControllerInitial());

  sendData(List<Product> pr, num gettotalprice,num gettotal,num discountpercentage)
  async {
    emit(CartControllerInitial());
   // var tosend= await Firebaserepo().SendBill(pr,gettotalprice,gettotal);
    var toSend= await Firebaserepo().sendBill2(pr,gettotalprice,gettotal,false,discountpercentage);
    if(toSend) {
      emit(CartControllerLoaded());
    }

  }

}
