// // To parse this JSON data, do
// //
// //     final loginResponseModel = loginResponseModelFromJson(jsonString);

// import 'dart:convert';

// LoginResponseModel loginResponseModelFromJson(String str) => LoginResponseModel.fromJson(json.decode(str));

// String loginResponseModelToJson(LoginResponseModel data) => json.encode(data.toJson());

// class LoginResponseModel {
//     LoginResponseModel({
//         this.id,
//         this.username,
//         this.email,
//         this.phone,
//         this.profilePic,
//         this.isAdmin,
//         this.createdAt,
//         this.updatedAt,
//         this.v,
//         this.accessToken,
//     });

//     final String? id;
//     final String? username;
//     final String? email;
//     final String? phone;
//     final String? profilePic;
//     final bool? isAdmin;
//     final DateTime? createdAt;
//     final DateTime? updatedAt;
//     final int? v;
//     final String? accessToken;

//     factory LoginResponseModel.fromJson(Map<String, dynamic> json) => LoginResponseModel(
//         id: json["_id"],
//         username: json["username"],
//         email: json["email"],
//         phone: json["phone"],
//         profilePic: json["profilePic"],
//         isAdmin: json["isAdmin"],
//         createdAt: DateTime.parse(json["createdAt"]),
//         updatedAt: DateTime.parse(json["updatedAt"]),
//         v: json["__v"],
//         accessToken: json["accessToken"],
//     );

//     Map<String, dynamic> toJson() => {
//         "_id": id,
//         "username": username,
//         "email": email,
//         "phone": phone,
//         "profilePic": profilePic,
//         "isAdmin": isAdmin,
//         "createdAt": createdAt!.toIso8601String(),
//         "updatedAt": updatedAt!.toIso8601String(),
//         "__v": v,
//         "accessToken": accessToken,
//     };
// }
