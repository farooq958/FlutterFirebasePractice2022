import 'dart:convert';

class CartModel {
  CartModel({
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
  factory CartModel.fromJson(String str) => CartModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CartModel.fromMap(Map<String, dynamic> json) => CartModel(
      status: json["Status"],
      discount: json["Discount"].toDouble(),
      id: json["id"],
      TPrice: json["TPrice"],
      NPrice: json["NPrice"]);

  Map<String, dynamic> toMap() => {
        "Status": status,
        "Discount": discount,
        "id": id,
      };
}
// To parse this JSON data, do
//
//     final productscart = productscartFromMap(jsonString);

class ProductsCart {
  ProductsCart({
    required this.price,
    required this.title,
    required this.quantity,
    required this.id,
  });

  int price;
  String title;
  int quantity;
  int id;

  factory ProductsCart.fromJson(String str) =>
      ProductsCart.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ProductsCart.fromMap(Map<String, dynamic> json) => ProductsCart(
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
