import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:tasky/data/fproductcontroller.dart';

part 'fetch_it_admin_state.dart';

class FetchItAdminCubit extends Cubit<FetchItAdminState> {
  FetchItAdminCubit() : super(FetchItAdminInitial());

  getIt(id) async {
    FirebaseProductsCart productList;
    FirebaseFirestore.instance
        .collection('Cart2')
        .doc(id)
        .snapshots()
        .listen((event) async {
      if (event.data() != null) {
        productList = FirebaseProductsCart.fromMap(event.data()!);

        emit(FetchItAdminLoaded(pr: productList));
      }
    });
  }

  changeStatus(id, status) async {
    await FirebaseFirestore.instance
        .collection('Cart2')
        .doc(id)
        .update({'Status': status});
    // emit(FetchItChangeState());
  }

  num getTotalPrice(FirebaseProductsCart dta) {
    int p = 0;
    for (var i in dta.products) {
      p += i.price * i.quantity;
    }
    return p;
  }

  getTotal(FirebaseProductsCart dta) {
    var totalprice = (getTotalPrice(dta) * dta.discount) / 100;

    return getTotalPrice(dta) - totalprice;
  }

  changeQuantity(id, int quantity, FirebaseProductsCart fp, index) async {
    fp.products[index].quantity = quantity;
    var tupdte = getTotalPrice(fp);
    var nupdt = getTotal(fp);
    await FirebaseFirestore.instance.collection('Cart2').doc(id).update({
      'TotalPrice': tupdte,
      'NetPrice': nupdt,
      'products': List<Map>.from(fp.products.map((e) => e.toMap()))
    });
    // emit(FetchItChangeState());
  }

  deleteWholeCart(id) async {
    await FirebaseFirestore.instance.collection('Cart2').doc(id).delete();
  }

  deleteAnItem(FirebaseProductsCart fp, index, int price, int quantity) async {
    int totalofoneitem = price * quantity;
    num newtotal1 = ((fp.totalPrice - totalofoneitem) * fp.discount) / 100;
    num newtotal = (fp.totalPrice - totalofoneitem) - newtotal1;
    fp.products.removeAt(index);
    await FirebaseFirestore.instance.collection('Cart2').doc(fp.id).update({
      'TotalPrice': fp.totalPrice - totalofoneitem,
      'NetPrice': newtotal,
      'products': List<Map>.from(fp.products.map((e) => e.toMap()))
    });
  }

  @override
  Future<void> close() {
    // TODO: implement close
    return super.close();
  }
}
