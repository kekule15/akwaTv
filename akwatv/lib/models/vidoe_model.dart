// To parse this JSON data, do
//
//     final homeVideoModel = homeVideoModelFromJson(jsonString);

import 'dart:convert';

List<HomeVideoModel> homeVideoModelFromJson(String str) => List<HomeVideoModel>.from(json.decode(str).map((x) => HomeVideoModel.fromJson(x)));

String homeVideoModelToJson(List<HomeVideoModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class HomeVideoModel {
    HomeVideoModel({
        this.id,
        this.title,
        this.desc,
        this.img,
        this.imgTitle,
        this.imgSmall,
        this.trailer,
        this.video,
        this.year,
        this.ageLimit,
        this.genre,
        this.isSeries,
        this.createdAt,
        this.updatedAt,
        this.v,
    });

    final String? id;
    final String? title;
    final String? desc;
    final String? img;
    final String? imgTitle;
    final String? imgSmall;
    final String? trailer;
    final String? video;
    final String? year;
    final int? ageLimit;
    final String? genre;
    final bool? isSeries;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final int? v;

    factory HomeVideoModel.fromJson(Map<String, dynamic> json) => HomeVideoModel(
        id: json["_id"],
        title: json["title"],
        desc: json["desc"],
        img: json["img"],
        imgTitle: json["imgTitle"],
        imgSmall: json["imgSmall"],
        trailer: json["trailer"],
        video: json["video"],
        year: json["year"],
        ageLimit: json["ageLimit"],
        genre: json["genre"],
        isSeries: json["isSeries"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "desc": desc,
        "img": img,
        "imgTitle": imgTitle,
        "imgSmall": imgSmall,
        "trailer": trailer,
        "video": video,
        "year": year,
        "ageLimit": ageLimit,
        "genre": genre,
        "isSeries": isSeries,
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
        "__v": v,
    };
}
