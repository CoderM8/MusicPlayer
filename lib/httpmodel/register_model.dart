// To parse this JSON data, do
//
//     final registerModel = registerModelFromJson(jsonString);

import 'dart:convert';

RegisterModel registerModelFromJson(String str) => RegisterModel.fromJson(json.decode(str));

String registerModelToJson(RegisterModel data) => json.encode(data.toJson());

class RegisterModel {
  final List<OnlineMp3> onlineMp3;

  RegisterModel({
    required this.onlineMp3,
  });

  factory RegisterModel.fromJson(Map<String, dynamic> json) => RegisterModel(
        onlineMp3: List<OnlineMp3>.from(json["ONLINE_MP3"].map((x) => OnlineMp3.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "ONLINE_MP3": List<dynamic>.from(onlineMp3.map((x) => x.toJson())),
      };
}

class OnlineMp3 {
  final String userId;
  final String name;
  final String userImage;
  final String email;
  final String success;
  final String msg;
  final String authId;

  OnlineMp3({
    required this.userId,
    required this.name,
    required this.userImage,
    required this.email,
    required this.success,
    required this.msg,
    required this.authId,
  });

  factory OnlineMp3.fromJson(Map<String, dynamic> json) => OnlineMp3(
        userId: json["user_id"],
        name: json["name"],
        userImage: json["user_image"],
        email: json["email"],
        success: json["success"],
        msg: json["msg"],
        authId: json["auth_id"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "name": name,
        "user_image": userImage,
        "email": email,
        "success": success,
        "msg": msg,
        "auth_id": authId,
      };
}
