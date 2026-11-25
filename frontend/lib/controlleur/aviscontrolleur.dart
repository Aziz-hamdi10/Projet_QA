import 'dart:convert';
import 'dart:ui';

import 'package:bridgewearaa/config.dart';
import 'package:bridgewearaa/models/avis.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<void> getAvis(Function(avis) remplir,String id) async {
  final response = await http.get(Uri.parse(getavisurl+id));

  if (response.statusCode == 200) {
    final Map<String, dynamic> jsonData = json.decode(response.body);

    if (jsonData != null) {
      final avis Avis = avis.fromJson(jsonData);
      remplir(Avis);
    } else {

    }
  } else {
  }
}
Future<void> getAvisuser(Function(List<avis>) remplir,String id) async {
  final response = await http.get(Uri.parse(getavisuserurl+id));

  if (response.statusCode == 200) {
    final List<dynamic> jsonData = json.decode(response.body);

    if (jsonData != null) {
      print(jsonData);
      List<avis> Avis = jsonData.map((json) => avis.fromJson(json)).toList();

      remplir(Avis);
    } else {

    }
  } else {
  }
}
double calculateAverageRating(List<avis> avisList) {
  if (avisList.isEmpty) {
    return 5.0;
  }

  double totalRating = avisList.fold(0.0, (sum, avis) => sum + avis.rating);
  return totalRating / avisList.length;
}
Future<void> addavis(String idorder,String content,double ratting,Function(String,Color) added) async {
  try {
    final response = await http.post(
      Uri.parse(addavisurl),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "idorder":idorder,
        "content":content,
        "rating":ratting,
      }),
    );


    if (response.statusCode == 201) {
      added('Your avis have been added !',Colors.green);
    } else if (response.statusCode == 200) {
      added('Error !',Colors.red);
    } else {
      print('Failed to add Avis ${response.statusCode}');
    }
  } catch (error) {
    print('Internal Server Error: $error');
  }
}
