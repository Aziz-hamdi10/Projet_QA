import 'package:bridgewearaa/config.dart';
import 'package:bridgewearaa/models/color.dart';
import 'package:bridgewearaa/models/size.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:typed_data';
import 'package:http_parser/http_parser.dart';
import 'package:http/http.dart' as http;

Future<void> getsizes(Function(List<String>) remplir) async {
  final response = await http.get(Uri.parse(getsizesurl));

  if (response.statusCode == 200) {
    final List<dynamic> jsonData = json.decode(response.body);
    List<String> sizes = jsonData.map<String>((json) {
      return json['name'] as String;
    }).toList();
    remplir(sizes);
  } else {
    throw Exception('Failed to load products');
  }
}
bool searchSizeByName(String name, List<size> listsize) {

 
    return listsize.any((item) => item.name.toLowerCase() == name.toLowerCase());
  
}
Future<void> getsizes2(Function(List<size>) remplir) async {
  final response = await http.get(Uri.parse(getsizesurl));

  if (response.statusCode == 200) {
    final List<dynamic> jsonData = json.decode(response.body);
        List<size> sizes = jsonData.map((json) => size.fromJson(json)).toList();

    remplir(sizes);
  } else {
    throw Exception('Failed to load products');
  }
}
Future<void> deletesize(Function (String,Color,IconData icon) delete,String id )  async {
  final response = await http.delete(Uri.parse(deletsizeurl+id));

  if (response.statusCode == 200) {

    delete("Size Deleted with Success",Colors.green,Icons.check);
  } else {
    delete("Error",Colors.red,Icons.error);
  }
}
Future<void> addsize(String name,Function(String,Color) added) async {
  try {
  final response = await http.post(
      Uri.parse(addsizeurl),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "name":name,
      }),
    );


    if (response.statusCode == 201) {
      added('Size added !',Colors.green);
    } else if (response.statusCode == 200) {
      added('Error !',Colors.red);
    } else {
      print('Failed to add Size ${response.statusCode}');
    }
  } catch (error) {
    print('Internal Server Error: $error');
  }
}
