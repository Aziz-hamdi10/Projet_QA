import 'dart:ui';

import 'package:bridgewearaa/models/adress.dart';
import 'package:bridgewearaa/models/product.dart';

class categorie {
  String name;
  String id;
  String image;
  DateTime dateadd;



  // Constructor
  categorie({
    required this.dateadd,
    required this.id,
    required this.image,

    required this.name,


  });
  factory categorie.fromJson(Map<String, dynamic> json) {
    return categorie(
      dateadd: DateTime.parse(json['dateadd']),
      id:json["_id"]??"0",
      name: json["title"] ?? '',
      image: json["image"]??''

    );
  }


}