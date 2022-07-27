import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

import '../../../data/firebase_repo.dart';
import '../../../data/invoicemodel.dart';

part 'fetchcontroller_state.dart';

class FetchcontrollerCubit extends Cubit<FetchcontrollerState> {
  FetchcontrollerCubit() : super(FetchInvoiceInitial());


  fetchInvoice(uid) async {
    try {
      emit(FetchInvoiceInitial());

      //await Firebaserepo.fetchInvoice(uid);
      List<Invoice> invoiceList = [];
      FirebaseFirestore.instance.collection('Invoice').doc(uid).collection('myinvoices').snapshots().listen((event) {

        invoiceList.clear();
        event.docs.forEach((element) {
          invoiceList.add(Invoice.fromMap(element));
        });
        emit(InvoiceFetched(invoice: invoiceList));
      });


    } catch (e) {
      print(e);
      if(e is FirebaseException)
      emit(InvoicefetchingError(msg : e.message!));
    }
  }
}
