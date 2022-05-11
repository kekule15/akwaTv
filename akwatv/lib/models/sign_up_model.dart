// To parse this JSON data, do
//
//     final signUpModel = signUpModelFromJson(jsonString);

import 'dart:convert';

SignUpModel signUpModelFromJson(String str) => SignUpModel.fromJson(json.decode(str));

String signUpModelToJson(SignUpModel data) => json.encode(data.toJson());

class SignUpModel {
    SignUpModel({
        this.username,
        this.email,
        this.password,
        this.profilePic,
        this.isAdmin,
        this.id,
        this.createdAt,
        this.updatedAt,
        this.v,
    });

    final String? username;
    final String? email;
    final String? password;
    final String? profilePic;
    final bool? isAdmin;
    final String? id;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final int? v;

    factory SignUpModel.fromJson(Map<String, dynamic> json) => SignUpModel(
        username: json["username"],
        email: json["email"],
        password: json["password"],
        profilePic: json["profilePic"],
        isAdmin: json["isAdmin"],
        id: json["_id"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "username": username,
        "email": email,
        "password": password,
        "profilePic": profilePic,
        "isAdmin": isAdmin,
        "_id": id,
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
        "__v": v,
    };
}
