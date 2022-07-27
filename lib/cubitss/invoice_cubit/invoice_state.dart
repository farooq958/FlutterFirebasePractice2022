part of 'invoice_cubit.dart';

@immutable
abstract class InvoiceState {}

class InvoiceInitial extends InvoiceState {}
class InvoiceCreated extends InvoiceState {}
class InvoiceCreatingError extends InvoiceState {}
class InvoiceUpdated extends InvoiceState {}
class InvoiceUpdateerror extends InvoiceState {}
class InvoiceDeleted extends InvoiceState {}
class InvoiceDeeltingerror extends InvoiceState {}