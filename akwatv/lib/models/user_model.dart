// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
    UserModel({
        this.id,
        this.username,
        this.email,
        this.profilePic,
        this.isAdmin,
        this.createdAt,
        this.updatedAt,
        this.v,
        this.accessToken,
    });

    final String? id;
    final String? username;
    final String? email;
    final dynamic profilePic;
    final bool? isAdmin;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final int? v;
    final String? accessToken;

    factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["_id"],
        username: json["username"],
        email: json["email"],
        profilePic: json["profilePic"],
        isAdmin: json["isAdmin"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        accessToken: json["accessToken"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "username": username,
        "email": email,
        "profilePic": profilePic,
        "isAdmin": isAdmin,
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
        "__v": v,
        "accessToken": accessToken,
    };
}
