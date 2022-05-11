// To parse this JSON data, do
//
//     final getProfileModel = getProfileModelFromJson(jsonString);

import 'dart:convert';

GetProfileModel getProfileModelFromJson(String str) => GetProfileModel.fromJson(json.decode(str));

String getProfileModelToJson(GetProfileModel data) => json.encode(data.toJson());

class GetProfileModel {
    GetProfileModel({
        this.success,
        this.data,
    });

    final bool? success;
    final ProfileData? data;

    factory GetProfileModel.fromJson(Map<String, dynamic> json) => GetProfileModel(
        success: json["success"],
        data: ProfileData.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "data": data!.toJson(),
    };
}

class ProfileData {
    ProfileData({
        this.id,
        this.username,
        this.email,
        this.phone,
        this.password,
        this.profilePic,
        this.isAdmin,
        this.createdAt,
        this.updatedAt,
        this.v,
    });

    final String? id;
    final String? username;
    final String? email;
    final String? phone;
    final String? password;
    final String? profilePic;
    final bool? isAdmin;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final int? v;

    factory ProfileData.fromJson(Map<String, dynamic> json) => ProfileData(
        id: json["_id"],
        username: json["username"],
        email: json["email"],
        phone: json["phone"],
        password: json["password"],
        profilePic: json["profilePic"],
        isAdmin: json["isAdmin"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "username": username,
        "email": email,
        "phone": phone,
        "password": password,
        "profilePic": profilePic,
        "isAdmin": isAdmin,
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
        "__v": v,
    };
}
