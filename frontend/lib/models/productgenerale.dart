import 'package:bridgewearaa/models/commentaire.dart';
import 'package:bridgewearaa/models/product.dart';
import 'package:bridgewearaa/models/user.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:typed_data';
import 'package:bridgewearaa/controlleur/productcontrolleur.dart';
import 'package:bridgewearaa/models/brand.dart';
import 'package:bridgewearaa/models/color.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';

class Productgen {
  User user;

  String id;
  String name;

  double Originalprice;
  double SeelingPrice;
  String imgaename;

  String state;

  color? cl;



  Productgen({
    required this.user,
    required this.state,
    required this.imgaename,
    required this.Originalprice,
    required this.SeelingPrice,
    this.cl,

    required this.id,
    required this.name,

  });
  Map<String, dynamic> toJson() {
    return {

      'originalPrice': Originalprice,
      'sellingPrice': SeelingPrice,



      'size': Size,
      'name': name,
      'idcolor': cl?.id.toString()

    };
  }
  factory Productgen.fromJson(Map<String, dynamic> json) {
    return Productgen(
      state:json['state']??"Available",
      user: User.fromJson(json['user']),
      id: json['id'] ?? "",
      SeelingPrice: (json['sellingPrice'] ?? 10).toDouble(),
      Originalprice: (json['originalPrice'] ?? 1).toDouble(),
      name: json['productName'] ?? '',
     
      imgaename: json['productImage']['image'] ,
        cl: color(id:"0",name:"red", coleur:  Colors.red,dateadd: DateTime.now()),

      //cl: color(
       // id: json['color']['_id']??"1",
        //name: json['color']['name']??"Red",
        //coleur: toColor(json['color']['hexCode']) ?? Colors.red,
      //),

    );
  }

}

