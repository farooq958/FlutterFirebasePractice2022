part of 'productscubitcontroller_cubit.dart';

@immutable
abstract class ProductscubitcontrollerState {}

class ProductscubitcontrollerInitial extends ProductscubitcontrollerState {}
class ListOfProductsLoaded extends ProductscubitcontrollerState {
  Products? prod ;

  ListOfProductsLoaded({required this.prod});


}
class ListOfinternetissue extends ProductscubitcontrollerState {}
class ListofInternalSever extends ProductscubitcontrollerState {}
class ListofImageError extends ProductscubitcontrollerState {}
class ListInException extends ProductscubitcontrollerState {}