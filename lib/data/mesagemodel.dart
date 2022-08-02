// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

class MessageId {
  String id;
  MessageModel msg;
  MessageId({required this.id, required this.msg});
}

class MessageModel {
  MessageModel({
    required this.time,
    required this.message,
    required this.sendBy,
  });

  int time;
  String message;
  String sendBy;

  factory MessageModel.fromRawJson(String str) =>
      MessageModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
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
