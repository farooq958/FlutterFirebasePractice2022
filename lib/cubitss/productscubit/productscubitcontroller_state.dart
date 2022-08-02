part of 'productscubitcontroller_cubit.dart';

@immutable
abstract class ProductscubitcontrollerState {}

class ProductscubitcontrollerInitial extends ProductscubitcontrollerState {}

class ListOfProductsLoaded extends ProductscubitcontrollerState {
  Products? prod;

  ListOfProductsLoaded({required this.prod});
}

class ListOfInternetIssue extends ProductscubitcontrollerState {}

class ListOfInternalSever extends ProductscubitcontrollerState {}

class ListOfImageError extends ProductscubitcontrollerState {}

class ListInException extends ProductscubitcontrollerState {}
