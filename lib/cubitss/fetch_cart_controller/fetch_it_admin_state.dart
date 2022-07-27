part of 'fetch_it_admin_cubit.dart';

@immutable
abstract class FetchItAdminState {}

class FetchItAdminInitial extends FetchItAdminState {}
class FetchItAdminLoaded extends FetchItAdminState {
  //List<Cartmodel> ls=[];
  List<Productscart> pr=[];
  FetchItAdminLoaded({required this.pr});


}
class FetchItChangeState extends FetchItAdminState {}