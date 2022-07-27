import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:tasky/data/firebase_repo.dart';

import '../../data/invoicemodel.dart';

part 'invoice_state.dart';

class InvoiceCubit extends Cubit<InvoiceState> {
  InvoiceCubit() : super(InvoiceInitial());
  createInvoice(Invoice invoice,uid) async {
    emit(InvoiceInitial());
    try {
      final isInvoiceCreated = await Firebaserepo().createInvoice(invoice,uid);
      if (isInvoiceCreated) {
        emit(InvoiceCreated());
      } else {
        emit(InvoiceCreatingError());
      }
    } catch (e) {
      print(e);
      emit(InvoiceCreatingError());
    }
  }
updateInvoice(Invoice invoice,uid,id)async {
  try {
    //var id = FirebaseFirestore.instance.collection('Invoice').doc(uid).collection('myinvoices').where("invoice_number", isEqualTo: invoice.invoiceNumber).get();
   // debugPrint(id.toString());
    await  FirebaseFirestore.instance.collection('Invoice').doc(uid).collection('myinvoices').doc(id).update({
      'id': id,
      'invoice_number': invoice.invoiceNumber,
      'sender_name': invoice.senderName,
      'receiver_name': invoice.receiverName
    });
    emit(InvoiceUpdated());

  }
  catch
  (e)
  {
emit(InvoiceUpdateerror());
  }

}
  delete(String id,uid) async {
    try {
      await FirebaseFirestore.instance.collection('Invoice').doc(uid).collection('myinvoices').doc(id).delete();
      emit(InvoiceDeleted());
    } catch (e) {
    emit(InvoiceDeeltingerror());
    }
  }

}
