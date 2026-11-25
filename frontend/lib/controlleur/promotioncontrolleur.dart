import 'package:bridgewearaa/config.dart';
import 'package:bridgewearaa/models/color.dart';
import 'package:bridgewearaa/models/promotion.dart';
import 'package:bridgewearaa/models/size.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:typed_data';
import 'package:http_parser/http_parser.dart';
import 'package:http/http.dart' as http;

Future<void> getpromotion(Function(List<promotion>) remplir,String categid) async {
  final response = await http.get(Uri.parse(url+"/promotion/getpromotions/"+categid));

  if (response.statusCode == 200) {
    final List<dynamic> jsonData = json.decode(response.body);
     List<promotion> promotions = jsonData.map((json) => promotion.fromJson(json)).toList();

    remplir(promotions);
  } else {
    throw Exception('Failed to load promotion');
  }
}


Future<void> getpromotionactive(Function(List<promotion>) remplir) async {
  final response = await http.get(Uri.parse(url+"/promotion/getpromotionsactive/"));

  if (response.statusCode == 200) {
    final List<dynamic> jsonData = json.decode(response.body);
    List<promotion> promotions = jsonData.map((json) => promotion.fromJson(json)).toList();

    remplir(promotions);
  } else {
    throw Exception('Failed to load promotion');
  }
}

Future<void> addpromo(promotion p,Function(String,Color) added) async {
  try {
  final response = await http.post(
      Uri.parse(addpromourl),
       headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(p.toJson()),
    );


    if (response.statusCode == 201) {
      added('Promotion added !',Colors.green);
    } else if (response.statusCode == 200) {
      added('Error !',Colors.red);
    } else {
      print('Failed to add Promotion ${response.statusCode}');
    }
  } catch (error) {
    print('Internal Server Error: $error');
  }
}

Future<void> deletepromotion(Function (String,Color,IconData icon) delete,String categid )  async {
  final response = await http.delete(Uri.parse(url+"/promotion/deletepromotion/"+categid));

  if (response.statusCode == 200) {

    delete("Promotion Deleted with Success",Colors.green,Icons.check);
  } else {
    delete("Error",Colors.red,Icons.error);
  }
}
Future<bool> checkpromoAvailability(String promo) async {
  
    final response = await http.get(Uri.parse(checkpromo + promo));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['available'] ?? false;
    } else {
      throw Exception('Failed to check username availability');
    }


}
Future<void> modifpromo(promotion p,Function(String,Color) added) async {
  try {
  final response = await http.put(
      Uri.parse(modifpromourl+p.id),
       headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(p.toJson()),
    );


    if (response.statusCode == 201) {
      added('Promotion modifier !',Colors.green);
    } else if (response.statusCode == 200) {
      added('Error !',Colors.red);
    } else {
      print('Failed to modif Promotion ${response.statusCode}');
    }
  } catch (error) {
    print('Internal Server Error: $error');
  }
}
