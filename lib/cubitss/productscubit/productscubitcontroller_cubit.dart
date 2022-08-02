import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:tasky/data/repo/repoapi.dart';

import '../../data/model.dart';

part 'productscubitcontroller_state.dart';

class ProductscubitcontrollerCubit extends Cubit<ProductscubitcontrollerState> {
  ProductscubitcontrollerCubit() : super(ProductscubitcontrollerInitial());

  getProduct() async {
    try {
      emit(ProductscubitcontrollerInitial());
      final data = await RepoApi.productList();
      debugPrint(data.toString());
      emit(ListOfProductsLoaded(prod: data));
    } catch (e) {
      if (e is SocketException) {
        emit(ListOfInternetIssue());
      }
      debugPrint(e.toString());
      emit(ListInException());
    }
  }
}
