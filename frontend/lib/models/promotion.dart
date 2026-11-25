import 'dart:ui';

import 'package:bridgewearaa/models/categorie.dart';

promotion? findFirstPromotionByCategoryId(List<promotion> promotions, String categoryId) {
  for (var promotion in promotions) {
    if (promotion.iddepartement.id == categoryId) {
      return promotion;
    }
  }
  return null;
}

promotion? findFirstPromotionByCode(List<promotion> promotions, String code) {
  for (var promotion in promotions) {
    if (promotion.code == code) {
      return promotion;
    }
  }
  return promotion(iddepartement:categorie(dateadd: DateTime.now(), id: "id", image: "image", name: "name"), id: "id", etat: "etat", code: code, title: "title", datestart: DateTime.now(), dateend: DateTime.now(), percentage: 0);
}
class promotion {
  String title;
  String id;
  DateTime datestart;
  DateTime dateend;
  String etat;
  String code;

  double percentage;
categorie iddepartement;


  // Constructor
  promotion({
    required this.iddepartement,
    required this.id,
required this.etat,
    required this.code,
    required this.title,
    required this.datestart,
    required this.dateend,
    required this.percentage


  });
  factory promotion.fromJson(Map<String, dynamic> json) {
    return promotion(
      code: json["code"] ??"AAA",
            iddepartement:categorie.fromJson(json["iddepartement"]),

      percentage: json["percentage"].toDouble()??10,
      id:json["_id"],
      title: json["title"],
            etat: (DateTime.parse(json['datestart']).isBefore(DateTime.now())&&DateTime.parse(json['dateend']).isAfter(DateTime.now()))?"active":"notactive",

      datestart: json['datestart'] != null
        ? DateTime.parse(json['datestart'])
        : DateTime.now(),  
            dateend: json['dateend'] != null
        ? DateTime.parse(json['dateend'])
        : DateTime.now(),  
    );
  }

 Map<String, dynamic> toJson() {
    return {
      'percentage': percentage,
      '_id': id,
      'title': title,
      'etat': etat,
      'datestart': datestart.toString(),
      'dateend': dateend.toString(),
            'iddepartement': iddepartement,

    };
  }
}