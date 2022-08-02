import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/cupertino.dart';
import 'package:tasky/data/mesagemodel.dart';
import 'package:tasky/data/model.dart';

import 'invoicemodel.dart';

class Firebaserepo {
  List<MessageModel> msg = [];

  Future<List<MessageModel>> getMessages() async {
    FirebaseFirestore.instance
        .collection("UserGroup")
        .orderBy('time')
        .snapshots()
        .listen((event) {
      for (QueryDocumentSnapshot querysnapshot in event.docs) {
        debugPrint(jsonEncode(querysnapshot.data()));

        var data = MessageModel.fromRawJson(jsonEncode(querysnapshot.data()));

        msg.add(data);
      }
    });
    return msg;
  }

  addMessage(chatMessageData) {
    return FirebaseFirestore.instance
        .collection("UserGroup")
        .add(chatMessageData)
        .catchError((e) {
      //  print(e.toString());
    });
  }

  Future<bool> deleteMessage(id) async {
    try {
      await FirebaseFirestore.instance.collection('UserGroup').doc(id).delete();
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> updated(msg, String id) async {
    try {
      await FirebaseFirestore.instance
          .collection('UserGroup')
          .doc(id)
          .update(msg);
      return true;
    } catch (e) {
      return false;
    }
  }

  static final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  Future<bool> createInvoice(Invoice invoice, uid) async {
    final docId = FirebaseFirestore.instance
        .collection('Invoice')
        .doc(uid)
        .collection('myinvoices')
        .doc()
        .id;
    try {
      await _fireStore
          .collection('Invoice')
          .doc(uid)
          .collection('myinvoices')
          .doc(docId)
          .set({
        'id': docId,
        'invoice_number': invoice.invoiceNumber,
        'sender_name': invoice.senderName,
        'receiver_name': invoice.receiverName
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> sendBill(List<Product> pr, num total, num nettotal) async {
    final docId = FirebaseFirestore.instance.collection('Cart').doc().id;
    //  var map2 = {};
    //  var map1 = {};
    // pr.forEach((Product) {map2[Product.title] = Product.price.toString();
    // map2[Product.id.toString()] = Product.quantity.toString();
    //
    //
    // });

    for (var dt in pr) {
      await _fireStore
          .collection('Cart')
          .doc(docId)
          .collection('Products')
          .add({
        //'id':docId,
        'Price': dt.price,

        'Title': dt.title,
        'Quantity': dt.quantity,
        'id': dt.id
      });

      await _fireStore.collection('Cart').doc(docId).set({
        'Discount': dt.discountPercentage,
        'id': docId,
        'TPrice': total,
        'NPrice': nettotal,
        'Status': false
      });
    }
    //await _fireStore.collection('Cart').doc(docId).set({});

    //  pr.forEach((Product) => map1[Product.price.toString()] = Product.price.toString());

    return true;
  }

  Future<bool> sendBill2(List<Product> pr, num total, num nettotal, bool status,
      num discountpercentage) async {
    final docId = FirebaseFirestore.instance.collection('Cart2').doc().id;
    //  var map2 = {};
    //  var map1 = {};
    // pr.forEach((Product) {map2[Product.title] = Product.price.toString();
    // map2[Product.id.toString()] = Product.quantity.toString();
    //
    //
    // });
    var dte = List<Map>.from(pr.map((e) => e.toJson()));

    await _fireStore.collection('Cart2').doc(docId).set({
      //'id':docId,

      'products': dte,
      'Discount': discountpercentage, 'id': docId,
      'TotalPrice': total,
      'NetPrice': nettotal,
      'Status': false
    });

    //await _fireStore.collection('Cart').doc(docId).set({});

    //  pr.forEach((Product) => map1[Product.price.toString()] = Product.price.toString());

    return true;
  }

  Future<List<Invoice>> fetchInvoice(uid) async {
    List<Invoice> invoiceList = [];
    FirebaseFirestore.instance
        .collection('Invoice')
        .doc(uid)
        .collection('myinvoices')
        .snapshots()
        .listen((event) {
      event.docs.forEach((element) {
        invoiceList.add(Invoice.fromMap(element));
      });
    });
    return invoiceList;
  }
}
