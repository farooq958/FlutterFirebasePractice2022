import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:tasky/data/cart_model.dart';

import '../../data/model.dart';

part 'fecth_controller_state.dart';

class FecthControllerCubit extends Cubit<FecthControllerState> {
  FecthControllerCubit() : super(FecthControllerInitial());

  fetchit() async {
    emit(FecthControllerInitial());
    List<Cartmodel> CartList = [];
    List<Productscart> Productlist = [];
    FirebaseFirestore.instance
        .collection('Cart').snapshots()
        .listen((event) async {
          CartList.clear();
          Productlist.clear();
      for (var p in event.docs) {

        CartList.add(Cartmodel.fromMap(p.data()));
        var ft= await FirebaseFirestore.instance
            .collection('Cart').doc(p.id).collection('Products').get();
        for(var dt in ft.docs)
          {
            Productlist.add(Productscart.fromMap(dt.data()));

            print(jsonEncode(dt.data()));
          }
      }
      emit(FecthControllerLoaded(ls: CartList, ps: Productlist));
    });
  }

}
