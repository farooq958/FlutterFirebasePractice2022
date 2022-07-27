import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

import '../../data/cart_model.dart';

part 'fetch_it_admin_state.dart';

class FetchItAdminCubit extends Cubit<FetchItAdminState> {
  FetchItAdminCubit() : super(FetchItAdminInitial());

  getit(id)
  async
  {
    List<Productscart> Productlist = [];
    FirebaseFirestore.instance
        .collection('Cart').doc(id).collection('Products').snapshots().listen((event) {

      for(var dt in event.docs)
      {
        Productlist.add(Productscart.fromMap(dt.data()));

        // print(jsonEncode(dt.data()));
      }
      emit(FetchItAdminLoaded(pr:Productlist));


    });

  }
  changestatus(id,status)
  async {
   await FirebaseFirestore.instance
        .collection('Cart').doc(id).update({

     'Status':status

   });
   emit(FetchItChangeState());

  }
}
