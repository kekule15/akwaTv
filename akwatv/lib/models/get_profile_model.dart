// To parse this JSON data, do
//
//     final getProfileModel = getProfileModelFromJson(jsonString);

import 'dart:convert';

GetProfileModel getProfileModelFromJson(String str) => GetProfileModel.fromJson(json.decode(str));

String getProfileModelToJson(GetProfileModel data) => json.encode(data.toJson());

class GetProfileModel {
    GetProfileModel({
        this.data,
        this.errors,
        this.message,
    });

    final Data? data;
    final Errors? errors;
    final String? message;

    factory GetProfileModel.fromJson(Map<String, dynamic> json) => GetProfileModel(
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
        this.id,
        this.username,
        this.email,
        this.password,
        this.phone,
        this.userAgent,
        this.avatar,
        this.deviceToken,
        this.verified,
        this.isAdmin,
        this.subscriptionIsActive,
        this.watchList,
        this.ratedList,
        this.timestamps,
        this.v,
        this.subscription,
        this.lastLogin,
    });

    final String? id;
    final String? username;
    final String? email;
    final String? password;
    final String? phone;
    final String? userAgent;
    final dynamic avatar;
    final dynamic deviceToken;
    final bool? verified;
    final bool? isAdmin;
    final bool? subscriptionIsActive;
    final List<dynamic>? watchList;
    final List<dynamic>? ratedList;
    final DateTime? timestamps;
    final int? v;
    final Subscription? subscription;
    final DateTime? lastLogin;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["_id"] == null ? null : json["_id"],
        username: json["username"] == null ? null : json["username"],
        email: json["email"] == null ? null : json["email"],
        password: json["password"] == null ? null : json["password"],
        phone: json["phone"] == null ? null : json["phone"],
        userAgent: json["userAgent"] == null ? null : json["userAgent"],
        avatar: json["avatar"],
        deviceToken: json["deviceToken"],
        verified: json["verified"] == null ? null : json["verified"],
        isAdmin: json["isAdmin"] == null ? null : json["isAdmin"],
        subscriptionIsActive: json["subscriptionIsActive"] == null ? null : json["subscriptionIsActive"],
        watchList: json["watchList"] == null ? null : List<dynamic>.from(json["watchList"].map((x) => x)),
        ratedList: json["ratedList"] == null ? null : List<dynamic>.from(json["ratedList"].map((x) => x)),
        timestamps: json["timestamps"] == null ? null : DateTime.parse(json["timestamps"]),
        v: json["__v"] == null ? null : json["__v"],
        subscription: json["subscription"] == null ? null : Subscription.fromJson(json["subscription"]),
        lastLogin: json["last_login"] == null ? null : DateTime.parse(json["last_login"]),
    );

    Map<String, dynamic> toJson() => {
        "_id": id == null ? null : id,
        "username": username == null ? null : username,
        "email": email == null ? null : email,
        "password": password == null ? null : password,
        "phone": phone == null ? null : phone,
        "userAgent": userAgent == null ? null : userAgent,
        "avatar": avatar,
        "deviceToken": deviceToken,
        "verified": verified == null ? null : verified,
        "isAdmin": isAdmin == null ? null : isAdmin,
        "subscriptionIsActive": subscriptionIsActive == null ? null : subscriptionIsActive,
        "watchList": watchList == null ? null : List<dynamic>.from(watchList!.map((x) => x)),
        "ratedList": ratedList == null ? null : List<dynamic>.from(ratedList!.map((x) => x)),
        "timestamps": timestamps == null ? null : timestamps!.toIso8601String(),
        "__v": v == null ? null : v,
        "subscription": subscription == null ? null : subscription!.toJson(),
        "last_login": lastLogin == null ? null : lastLogin!.toIso8601String(),
    };
}

class Subscription {
    Subscription({
        this.name,
        this.email,
        this.username,
        this.amount,
        this.createdAt,
        this.expiredAt,
        this.paystackResponse,
        this.id,
    });

    final String? name;
    final String? email;
    final String? username;
    final String? amount;
    final DateTime? createdAt;
    final DateTime? expiredAt;
    final String? paystackResponse;
    final String? id;

    factory Subscription.fromJson(Map<String, dynamic> json) => Subscription(
        name: json["name"] == null ? null : json["name"],
        email: json["email"] == null ? null : json["email"],
        username: json["username"] == null ? null : json["username"],
        amount: json["amount"] == null ? null : json["amount"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        expiredAt: json["expiredAt"] == null ? null : DateTime.parse(json["expiredAt"]),
        paystackResponse: json["paystackResponse"] == null ? null : json["paystackResponse"],
        id: json["_id"] == null ? null : json["_id"],
    );

    Map<String, dynamic> toJson() => {
        "name": name == null ? null : name,
        "email": email == null ? null : email,
        "username": username == null ? null : username,
        "amount": amount == null ? null : amount,
        "createdAt": createdAt == null ? null : createdAt!.toIso8601String(),
        "expiredAt": expiredAt == null ? null : expiredAt!.toIso8601String(),
        "paystackResponse": paystackResponse == null ? null : paystackResponse,
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
