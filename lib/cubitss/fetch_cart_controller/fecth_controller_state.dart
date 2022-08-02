part of 'fecth_controller_cubit.dart';

@immutable
abstract class FecthControllerState {}

class FecthControllerInitial extends FecthControllerState {}

class FecthControllerLoaded extends FecthControllerState {
  // List<Cartmodel> ls=[];
  // List<Productscart> ps=[];
  // FecthControllerLoaded({required this.ls,required this.ps});
  List<FirebaseProductsCart> ps = [];
  FecthControllerLoaded({required this.ps});
}

class FecthControllerException extends FecthControllerState {
  String msg;
  FecthControllerException({required this.msg});
}
