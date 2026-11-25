import 'dart:ui';
import 'package:bridgewearaa/controlleur/colorcontrolleur.dart';
import 'package:flutter/material.dart';

import 'package:bridgewearaa/models/product.dart';

class color {
  String id;

  String name;
  Color coleur;
  DateTime dateadd;

  // Constructor
  color({
    required this.dateadd,
    required  this.id,
    required this.name,
    required this.coleur,


  });
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'HexCode': colorToHex(coleur),
    };
  }
  
  factory color.fromJson(Map<String, dynamic> json) {
    return color(
      id:json["_id"]??"0",
      name: json["name"] ?? 'rd',
      coleur: toColor(json["hexCode"]) ,
      dateadd: DateTime.parse(json['dateadd'])
    );
  }

}