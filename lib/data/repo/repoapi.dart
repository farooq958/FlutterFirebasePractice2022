
import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:tasky/data/controller/Apicontroller.dart';
import 'package:tasky/data/model.dart';
class repoapi{

  static Future<Products?> productList() async {

    // var request = http.Request('GET', Uri.parse('https://jsonplaceholder.typicode.com/users'));
    var request = http.Request('GET', Uri.parse('https://dummyjson.com/products'));


    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      //var rr = await response.stream.bytesToString();
      Products ProductData = Products.fromRawJson(
          await response.stream.bytesToString());

return ProductData;
    }
    else {
     debugPrint(response.reasonPhrase);
    }


  }

}