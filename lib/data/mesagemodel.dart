// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';
class messageid{
   String Id;
   Messagemodel msg;
   messageid({required this.Id,required this.msg});

}
class Messagemodel {
   Messagemodel({
      required this.time,
      required this.message,
      required this.sendBy,
   });

   int time;
   String message;
   String sendBy;

   factory Messagemodel.fromRawJson(String str) => Messagemodel.fromJson(json.decode(str));

   String toRawJson() => json.encode(toJson());

   factory Messagemodel.fromJson(Map<String, dynamic> json) => Messagemodel(
      time: json["time"],
      message: json["message"],
      sendBy: json["sendBy"],
   );

   Map<String, dynamic> toJson() => {
      "time": time,
      "message": message,
      "sendBy": sendBy,
   };
}

