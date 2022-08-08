// To parse this JSON data, do
//
//     final updateDeviceModel = updateDeviceModelFromJson(jsonString);

import 'dart:convert';

UpdateDeviceModel updateDeviceModelFromJson(String str) => UpdateDeviceModel.fromJson(json.decode(str));

String updateDeviceModelToJson(UpdateDeviceModel data) => json.encode(data.toJson());

class UpdateDeviceModel {
    UpdateDeviceModel({
        this.data,
        this.errors,
        this.message,
    });

    final Data? data;
    final Data? errors;
    final String? message;

    factory UpdateDeviceModel.fromJson(Map<String, dynamic> json) => UpdateDeviceModel(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        errors: json["errors"] == null ? null : Data.fromJson(json["errors"]),
        message: json["message"] == null ? null : json["message"],
    );

    Map<String, dynamic> toJson() => {
        "data": data == null ? null : data!.toJson(),
        "errors": errors == null ? null : errors!.toJson(),
        "message": message == null ? null : message,
    };
}

class Data {
    Data();

    factory Data.fromJson(Map<String, dynamic> json) => Data(
    );

    Map<String, dynamic> toJson() => {
    };
}
