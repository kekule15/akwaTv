// To parse this JSON data, do
//
//     final uploadPicModel = uploadPicModelFromJson(jsonString);

import 'dart:convert';

UploadPicModel uploadPicModelFromJson(String str) => UploadPicModel.fromJson(json.decode(str));

String uploadPicModelToJson(UploadPicModel data) => json.encode(data.toJson());

class UploadPicModel {
    UploadPicModel({
        this.data,
        this.errors,
        this.message,
    });

    final Data? data;
    final Errors? errors;
    final String? message;

    factory UploadPicModel.fromJson(Map<String, dynamic> json) => UploadPicModel(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        errors: json["errors"] == null ? null : Errors.fromJson(json["errors"]),
        message: json["message"] == null ? null : json["message"],
    );

    Map<String, dynamic> toJson() => {
        "data": data == null ? null : data!.toJson(),
        "errors": errors == null ? null : errors!.toJson(),
        "message": message == null ? null : message,
    };
}

class Data {
    Data({
        this.user,
    });

    final User? user;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        user: json["user"] == null ? null : User.fromJson(json["user"]),
    );

    Map<String, dynamic> toJson() => {
        "user": user == null ? null : user!.toJson(),
    };
}

class User {
    User({
        this.id,
        this.username,
        this.email,
        this.password,
        this.phone,
        this.verified,
        this.isAdmin,
        this.subscriptionIsActive,
        this.watchList,
        this.ratedList,
        this.timestamps,
        this.v,
        this.lastLogin,
        this.emailToken,
        this.avatar,
        this.cloudinaryId,
    });

    final String? id;
    final String? username;
    final String? email;
    final String? password;
    final String? phone;
    final bool? verified;
    final bool? isAdmin;
    final bool? subscriptionIsActive;
    final List<dynamic>? watchList;
    final List<dynamic>? ratedList;
    final DateTime? timestamps;
    final int? v;
    final DateTime? lastLogin;
    final EmailToken? emailToken;
    final String? avatar;
    final String? cloudinaryId;

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["_id"] == null ? null : json["_id"],
        username: json["username"] == null ? null : json["username"],
        email: json["email"] == null ? null : json["email"],
        password: json["password"] == null ? null : json["password"],
        phone: json["phone"] == null ? null : json["phone"],
        verified: json["verified"] == null ? null : json["verified"],
        isAdmin: json["isAdmin"] == null ? null : json["isAdmin"],
        subscriptionIsActive: json["subscriptionIsActive"] == null ? null : json["subscriptionIsActive"],
        watchList: json["watchList"] == null ? null : List<dynamic>.from(json["watchList"].map((x) => x)),
        ratedList: json["ratedList"] == null ? null : List<dynamic>.from(json["ratedList"].map((x) => x)),
        timestamps: json["timestamps"] == null ? null : DateTime.parse(json["timestamps"]),
        v: json["__v"] == null ? null : json["__v"],
        lastLogin: json["last_login"] == null ? null : DateTime.parse(json["last_login"]),
        emailToken: json["email_token"] == null ? null : EmailToken.fromJson(json["email_token"]),
        avatar: json["avatar"] == null ? null : json["avatar"],
        cloudinaryId: json["cloudinary_id"] == null ? null : json["cloudinary_id"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id == null ? null : id,
        "username": username == null ? null : username,
        "email": email == null ? null : email,
        "password": password == null ? null : password,
        "phone": phone == null ? null : phone,
        "verified": verified == null ? null : verified,
        "isAdmin": isAdmin == null ? null : isAdmin,
        "subscriptionIsActive": subscriptionIsActive == null ? null : subscriptionIsActive,
        "watchList": watchList == null ? null : List<dynamic>.from(watchList!.map((x) => x)),
        "ratedList": ratedList == null ? null : List<dynamic>.from(ratedList!.map((x) => x)),
        "timestamps": timestamps == null ? null : timestamps!.toIso8601String(),
        "__v": v == null ? null : v,
        "last_login": lastLogin == null ? null : lastLogin!.toIso8601String(),
        "email_token": emailToken == null ? null : emailToken!.toJson(),
        "avatar": avatar == null ? null : avatar,
        "cloudinary_id": cloudinaryId == null ? null : cloudinaryId,
    };
}

class EmailToken {
    EmailToken({
        this.token,
        this.createdAt,
        this.id,
    });

    final String? token;
    final DateTime? createdAt;
    final String? id;

    factory EmailToken.fromJson(Map<String, dynamic> json) => EmailToken(
        token: json["token"] == null ? null : json["token"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        id: json["_id"] == null ? null : json["_id"],
    );

    Map<String, dynamic> toJson() => {
        "token": token == null ? null : token,
        "createdAt": createdAt == null ? null : createdAt!.toIso8601String(),
        "_id": id == null ? null : id,
    };
}

class Errors {
    Errors();

    factory Errors.fromJson(Map<String, dynamic> json) => Errors(
    );

    Map<String, dynamic> toJson() => {
    };
}
