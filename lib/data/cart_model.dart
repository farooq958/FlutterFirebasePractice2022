import 'package:meta/meta.dart';
import 'dart:convert';

class Cartmodel {
  Cartmodel({
    required this.status,
    required this.discount,
    required this.id,
    required this.TPrice,
    required this.NPrice,
  });

  bool status;
  double discount;
  String id;
num TPrice;
num NPrice;
  factory Cartmodel.fromJson(String str) => Cartmodel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Cartmodel.fromMap(Map<String, dynamic> json) => Cartmodel(
    status: json["Status"],
    discount: json["Discount"].toDouble(),
    id: json["id"],
      TPrice: json["TPrice"]
      ,
      NPrice: json["NPrice"]
  );

  Map<String, dynamic> toMap() => {
    "Status": status,
    "Discount": discount,
    "id": id,
  };
}
// To parse this JSON data, do
//
//     final productscart = productscartFromMap(jsonString);


class Productscart {
  Productscart({
    required this.price,
    required this.title,
    required this.quantity,
    required this.id,

  });

  int price;
  String title;
  int quantity;
  int id;

  factory Productscart.fromJson(String str) => Productscart.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Productscart.fromMap(Map<String, dynamic> json) => Productscart(
    price: json["Price"],
    title: json["Title"],
    quantity: json["Quantity"],
    id: json["id"],

  );

  Map<String, dynamic> toMap() => {
    "Price": price,
    "Title": title,
    "Quantity": quantity,
    "id": id,
  };
}
