import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import 'package:tasky/data/cart_model.dart';
import 'package:tasky/data/fproductcontroller.dart';

part 'fecth_controller_state.dart';

class FecthControllerCubit extends Cubit<FecthControllerState> {
  FecthControllerCubit() : super(FecthControllerInitial());

  fetchit() async {
    emit(FecthControllerInitial());
    List<CartModel> cartList = [];
    List<ProductsCart> productList = [];
    FirebaseFirestore.instance
        .collection('Cart')
        .snapshots()
        .listen((event) async {
      cartList.clear();
      productList.clear();
      for (var p in event.docs) {
        cartList.add(CartModel.fromMap(p.data()));
        var ft = await FirebaseFirestore.instance
            .collection('Cart')
            .doc(p.id)
            .collection('Products')
            .get();
        for (var dt in ft.docs) {
          productList.add(ProductsCart.fromMap(dt.data()));

          // print(jsonEncode(dt.data()));
        }
      }
      //   emit(FecthControllerLoaded(ls: cartList, ps: productList));
    });
  }

  fetchit2() async {
    emit(FecthControllerInitial());
    List<FirebaseProductsCart> productList = [];
    FirebaseFirestore.instance
        .collection('Cart2')
        .snapshots()
        .listen((event) async {
      productList.clear();

      // print(jsonEncode(dt.data()));
      for (var p in event.docs) {
        productList.add(firebaseProductsCartFromMap(jsonEncode(p.data())));

      }
      emit(FecthControllerLoaded(ps: productList));
    });
  }

  @override
  Future<void> close() {
    // TODO: implement close
    return super.close();
  }
}
