// To parse this JSON data, do
//
//     final paymentHistoryModel = paymentHistoryModelFromJson(jsonString);

import 'dart:convert';

PaymentHistoryModel paymentHistoryModelFromJson(String str) => PaymentHistoryModel.fromJson(json.decode(str));

String paymentHistoryModelToJson(PaymentHistoryModel data) => json.encode(data.toJson());

class PaymentHistoryModel {
    PaymentHistoryModel({
        this.data,
        this.errors,
        this.message,
    });

    final List<DatumList>? data;
    final Errors? errors;
    final String? message;

    factory PaymentHistoryModel.fromJson(Map<String, dynamic> json) => PaymentHistoryModel(
        data: json["data"] == null ? null : List<DatumList>.from(json["data"].map((x) => DatumList.fromJson(x))),
        errors: json["errors"] == null ? null : Errors.fromJson(json["errors"]),
        message: json["message"] == null ? null : json["message"],
    );

    Map<String, dynamic> toJson() => {
        "data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toJson())),
        "errors": errors == null ? null : errors!.toJson(),
        "message": message == null ? null : message,
    };
}

class DatumList {
    DatumList({
        this.id,
        this.userId,
        this.amount,
        this.status,
        this.v,
        this.name,
    });

    final String? id;
    final String? userId;
    final String? amount;
    final String? status;
    final int? v;
    final String? name;

    factory DatumList.fromJson(Map<String, dynamic> json) => DatumList(
        id: json["_id"] == null ? null : json["_id"],
        userId: json["userId"] == null ? null : json["userId"],
        amount: json["amount"] == null ? null : json["amount"],
        status: json["status"] == null ? null : json["status"],
        v: json["__v"] == null ? null : json["__v"],
        name: json["name"] == null ? null : json["name"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id == null ? null : id,
        "userId": userId == null ? null : userId,
        "amount": amount == null ? null : amount,
        "status": status == null ? null : status,
        "__v": v == null ? null : v,
        "name": name == null ? null : name,
    };
}

class Errors {
    Errors();

    factory Errors.fromJson(Map<String, dynamic> json) => Errors(
    );

    Map<String, dynamic> toJson() => {
    };
}
