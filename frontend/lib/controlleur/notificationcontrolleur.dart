import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui';
import 'package:bridgewearaa/models/color.dart';
import 'package:bridgewearaa/models/commande.dart';
import 'package:bridgewearaa/models/notification.dart';
import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';

import 'package:bridgewearaa/config.dart';
import 'package:bridgewearaa/models/product.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

Future<void> getnotifications(Function (List<notification>) remplir,String iduser  )  async {
  final response = await http.get(Uri.parse(getnotificationurl+iduser));

  if (response.statusCode == 200) {
    final List<dynamic> jsonData = json.decode(response.body);
    List<notification> commandes = jsonData.map((json) => notification.fromJson(json)).toList();

    remplir(commandes);
  } else {
    remplir([]);
  }
}
