import 'dart:ui';

import 'package:bridgewearaa/controlleur/productcontrolleur.dart';
import 'package:bridgewearaa/models/adress.dart';
import 'package:bridgewearaa/models/product.dart';
import 'package:bridgewearaa/screens/menu2.dart';

import 'frais.dart';

class commande {
  String etat;
  DateTime? dateconfirm;
  DateTime? datedelievry;
  DateTime? datecancel;
    DateTime? datetaked;
  DateTime? datefinished;

  String idbuyer;
  String id;
  DateTime dateadd;
  Product prd;
  String street;
  String city;
  double prixtotal;

  String state;
  String postalCode;
  frais fr;
  commande({
    required this.fr,
    required this.idbuyer,
    required this.prd,
    required this.etat,
    required this.dateconfirm,
    required this.datedelievry,
    required this.datecancel,
    required this.id,
    required this.dateadd,
    required this.datefinished,
    required this.datetaked,
    required this.street,
    required this.city,
    required this.state,
    required this.postalCode,
required this.prixtotal
  });
  Map<String, dynamic> toJson() {

    return {
      "etat": etat,
      "idbuyer": idbuyer,
      "product":prd.id,
      "postal_code":postalCode,
      "state":state,
      "city":city,
      "street":street,
      "prixtotal":prixtotal,
      "frais":fr.id


    };
  }
  factory commande.fromJson(Map<String, dynamic> json) {
    return commande(
      prixtotal:json['order']['prixtotal'].toDouble(),
      fr: frais.fromJson(json['order']['frais']),
      city:json['order']['city'],
      postalCode:json['order']['postal_code'],
      street:json['order']['street'],
      state:json['order']['state'],

      prd: Product.fromJsonorder(json),
      id: json['order']['_id']??"1",
      etat: json['order']['etat'],
      idbuyer: json['order']['idbuyer'],
      dateconfirm:  json['order']['dateconfirm'] != null
        ? DateTime.parse(json['order']['dateconfirm'])
        : null, 
      datedelievry: json['order']['datedelievry'] != null
        ? DateTime.parse(json['order']['datedelievry'])
        : null, 
datecancel: json['order']['datecancel'] != null
        ? DateTime.parse(json['order']['datecancel'])
        : null,
              dateadd: DateTime.parse(json['order']['dateadd']),
              datefinished: json['order']['datefinished'] != null
        ? DateTime.parse(json['order']['datefinished'])
        : null,
              datetaked: json['order']['datetaked'] != null
        ? DateTime.parse(json['order']['datetaked'])
        : null,
        
    );
  }

}


