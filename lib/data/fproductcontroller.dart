// To parse this JSON data, do
//
//     final fproductscart = fproductscartFromMap(jsonString);

import 'dart:convert';

FirebaseProductsCart firebaseProductsCartFromMap(String str) =>
    FirebaseProductsCart.fromMap(json.decode(str));

String firebaseProductsToMap(FirebaseProductsCart data) =>
    json.encode(data.toMap());

class FirebaseProductsCart {
  FirebaseProductsCart({
    required this.status,
    required this.discount,
    required this.netPrice,
    required this.totalPrice,
    required this.id,
    required this.products,
  });

  bool status;
  num discount;
  num netPrice;
  int totalPrice;
  String id;
  List<Product> products;

  factory FirebaseProductsCart.fromMap(Map<String, dynamic> json) =>
      FirebaseProductsCart(
        status: json["Status"],
        discount: json["Discount"],
        netPrice: json["NetPrice"],
        totalPrice: json["TotalPrice"],
        id: json["id"],
        products:
            List<Product>.from(json["products"].map((x) => Product.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "Status": status,
        "Discount": discount,
        "NetPrice": netPrice,
        "TotalPrice": totalPrice,
        "id": id,
        "products": List<dynamic>.from(products.map((x) => x.toMap())),
      };
}

class Product {
  Product({
    required this.discountPercentage,
    required this.images,
    required this.quantity,
    required this.price,
    required this.description,
    required this.id,
    required this.title,
    required this.category,
  });

  double discountPercentage;
  List<String> images;
  int quantity;
  int price;
  String description;
  int id;
  String title;
  String category;

  factory Product.fromMap(Map<String, dynamic> json) => Product(
        discountPercentage: json["discountPercentage"].toDouble(),
        images: List<String>.from(json["images"].map((x) => x)),
        quantity: json["quantity"],
        price: json["price"],
        description: json["description"],
        id: json["id"],
        title: json["title"],
        category: json["category"],
      );

  Map<String, dynamic> toMap() => {
        "discountPercentage": discountPercentage,
        "images": List<dynamic>.from(images.map((x) => x)),
        "quantity": quantity,
        "price": price,
        "description": description,
        "id": id,
        "title": title,
        "category": category,
      };
}
