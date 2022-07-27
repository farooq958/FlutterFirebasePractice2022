import 'package:cloud_firestore/cloud_firestore.dart';

class Invoice {
  String? invoiceId;
  String invoiceNumber;
  String senderName;
  String receiverName;

  Invoice(
      {required this.invoiceNumber,
        required this.receiverName,
        this.invoiceId,
        required this.senderName});
  factory Invoice.fromMap(DocumentSnapshot map) {
    return Invoice(
      invoiceId: map['id'],
      invoiceNumber: map['invoice_number'],
      senderName: map['sender_name'],
      receiverName: map['receiver_name'],
    );
  }
}
