import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:tasky/data/repo/repoapi.dart';

import '../../data/model.dart';

part 'productscubitcontroller_state.dart';

class ProductscubitcontrollerCubit extends Cubit<ProductscubitcontrollerState> {
  ProductscubitcontrollerCubit() : super(ProductscubitcontrollerInitial());

  getproduct()
  async {
    try {
      emit(ProductscubitcontrollerInitial());
      final Data = await repoapi.productList();
      debugPrint(Data.toString());
     emit(ListOfProductsLoaded(prod: Data));

    } catch (e) {
      if (e is SocketException)
      {

        emit(ListOfinternetissue());
      }
      debugPrint(e.toString());
      emit(ListInException());
    }



  }

}
