// To parse this JSON data, do
//
//     final loginResponseModel = loginResponseModelFromJson(jsonString);

import 'dart:convert';

LoginResponseModel loginResponseModelFromJson(String str) => LoginResponseModel.fromJson(json.decode(str));

String loginResponseModelToJson(LoginResponseModel data) => json.encode(data.toJson());

class LoginResponseModel {
    LoginResponseModel({
        this.data,
        this.errors,
        this.message,
    });

    final Data? data;
    final Errors? errors;
    final dynamic message;

    factory LoginResponseModel.fromJson(Map<String, dynamic> json) => LoginResponseModel(
        data: json["data"] == null? null: Data.fromJson(json["data"]),
        errors: Errors.fromJson(json["errors"]),
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "data": data!.toJson(),
        "errors": errors!.toJson(),
        "message": message,
    };
}

class Data {
    Data({
        this.account,
        this.accessToken,
    });

    final Account? account;
    final String? accessToken;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        account: json["account"] == null ? null : Account.fromJson(json["account"]),
        accessToken: json["accessToken"],
    );

    Map<String, dynamic> toJson() => {
        "account": account!.toJson(),
        "accessToken": accessToken,
    };
}

class Account {
    Account({
        this.id,
        this.username,
        this.email,
        this.password,
        this.phone,
        this.verified,
        this.isAdmin,
        this.timestamps,
        this.v,
        this.lastLogin,
        this.avatar,
        this.cloudinaryId,
        this.emailToken,
        this.watchList,
        this.ratedList,
        this.subscriptionIsActive,
    });

    final String? id;
    final String? username;
    final String? email;
    final String? password;
    final String? phone;
    final bool? verified;
    final bool? isAdmin;
    final DateTime? timestamps;
    final int? v;
    final DateTime? lastLogin;
    final String? avatar;
    final String? cloudinaryId;
    final EmailToken? emailToken;
    final List<dynamic>? watchList;
    final List<dynamic>? ratedList;
    final bool? subscriptionIsActive;

    factory Account.fromJson(Map<String, dynamic> json) => Account(
        id: json["_id"],
        username: json["username"],
        email: json["email"],
        password: json["password"],
        phone: json["phone"],
        verified: json["verified"],
        isAdmin: json["isAdmin"],
        timestamps: DateTime.parse(json["timestamps"]),
        v: json["__v"],
        lastLogin: DateTime.parse(json["last_login"]),
        avatar: json["avatar"],
        cloudinaryId: json["cloudinary_id"],
        emailToken:json["email_token"] == null? null: EmailToken.fromJson(json["email_token"]),
        watchList: List<dynamic>.from(json["watchList"].map((x) => x)),
        ratedList: List<dynamic>.from(json["ratedList"].map((x) => x)),
        subscriptionIsActive: json["subscriptionIsActive"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "username": username,
        "email": email,
        "password": password,
        "phone": phone,
        "verified": verified,
        "isAdmin": isAdmin,
        "timestamps": timestamps!.toIso8601String(),
        "__v": v,
        "last_login": lastLogin!.toIso8601String(),
        "avatar": avatar,
        "cloudinary_id": cloudinaryId,
        "email_token": emailToken!.toJson(),
        "watchList": List<dynamic>.from(watchList!.map((x) => x)),
        "ratedList": List<dynamic>.from(ratedList!.map((x) => x)),
        "subscriptionIsActive": subscriptionIsActive,
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
        token: json["token"],
        createdAt: DateTime.parse(json["createdAt"]),
        id: json["_id"],
    );

    Map<String, dynamic> toJson() => {
        "token": token,
        "createdAt": createdAt!.toIso8601String(),
        "_id": id,
    };
}

class Errors {
    Errors();

    factory Errors.fromJson(Map<String, dynamic> json) => Errors(
    );

    Map<String, dynamic> toJson() => {
    };
}