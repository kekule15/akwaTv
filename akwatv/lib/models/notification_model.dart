// To parse this JSON data, do
//
//     final userNotificationModel = userNotificationModelFromJson(jsonString);

import 'dart:convert';

UserNotificationModel userNotificationModelFromJson(String str) => UserNotificationModel.fromJson(json.decode(str));

String userNotificationModelToJson(UserNotificationModel data) => json.encode(data.toJson());

class UserNotificationModel {
    UserNotificationModel({
        this.data,
        this.errors,
        this.message,
    });

    final List<DataList>? data;
    final Errors? errors;
    final String? message;

    factory UserNotificationModel.fromJson(Map<String, dynamic> json) => UserNotificationModel(
        data: json["data"] == null ? null : List<DataList>.from(json["data"].map((x) => DataList.fromJson(x))),
        errors: json["errors"] == null ? null : Errors.fromJson(json["errors"]),
        message: json["message"] == null ? null : json["message"],
    );

    Map<String, dynamic> toJson() => {
        "data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toJson())),
        "errors": errors == null ? null : errors!.toJson(),
        "message": message == null ? null : message,
    };
}

class DataList {
    DataList({
        this.id,
        this.userId,
        this.title,
        this.message,
        this.v,
    });

    final String? id;
    final String? userId;
    final String? title;
    final String? message;
    final int? v;

    factory DataList.fromJson(Map<String, dynamic> json) => DataList(
        id: json["_id"] == null ? null : json["_id"],
        userId: json["userId"] == null ? null : json["userId"],
        title: json["title"] == null ? null : json["title"],
        message: json["message"] == null ? null : json["message"],
        v: json["__v"] == null ? null : json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id == null ? null : id,
        "userId": userId == null ? null : userId,
        "title": title == null ? null : title,
        "message": message == null ? null : message,
        "__v": v == null ? null : v,
    };
}

class Errors {
    Errors();

    factory Errors.fromJson(Map<String, dynamic> json) => Errors(
    );

    Map<String, dynamic> toJson() => {
    };
}
