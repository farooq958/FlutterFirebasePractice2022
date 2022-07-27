part of 'fetchcontroller_cubit.dart';

@immutable
abstract class FetchcontrollerState {}


class FetchInvoiceInitial extends FetchcontrollerState {}
class InvoiceFetched extends FetchcontrollerState {

 List<Invoice> invoice;
  InvoiceFetched({required this.invoice});
}
class InvoicefetchingError extends FetchcontrollerState {
String msg;
 InvoicefetchingError({required this.msg});

}