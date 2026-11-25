import 'package:bridgewearaa/config.dart';
import 'package:bridgewearaa/models/color.dart';
import 'package:bridgewearaa/screens/signin.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:typed_data';
import 'package:http_parser/http_parser.dart';
import 'package:http/http.dart' as http;
String colorToHex(Color color) {
  return '#${color.value.toRadixString(16).substring(2)}';
}

bool isHexColor(String hexColor) {
  if (hexColor.isEmpty) return false;
  final hexPattern = RegExp(r'^#([A-Fa-f0-9]{6}|[A-Fa-f0-9]{3})$');
  return hexPattern.hasMatch(hexColor);
}
Color? hexToColor(String hexColor) {
  if (!isHexColor(hexColor)) return null;
  return Color(int.parse(hexColor.substring(1, 7), radix: 16) + 0xFF000000);
}
bool searchColorByHex(String hexColor, List<color> listColors) {
  Color? color = hexToColor(hexColor);
  if (color != null) {
    return listColors.any((item) => item.coleur == color);
  }
  return false; 
}
bool searchColorByName(String name, List<color> listColors) {

  if (name != null) {
    return listColors.any((item) => item.name.toLowerCase() == name.toLowerCase());
  }
  return false; 
}
Future<void> getcolors(Function (List<color>) remplir  )  async {
  final response = await http.get(Uri.parse(getcolorsurl));

  if (response.statusCode == 200) {
    final List<dynamic> jsonData = json.decode(response.body);
    List<color> colors = jsonData.map((json) => color.fromJson(json)).toList();

    remplir(colors);
  } else {
    throw Exception('Failed to load colors');
  }
}
Future<void> deletecolor(Function (String,Color,IconData icon) delete,String id )  async {
  final response = await http.delete(Uri.parse(deletecolorurl+id));

  if (response.statusCode == 200) {

    delete("Color Deleted with Success",Colors.green,Icons.check);
  } else {
    delete("Error",Colors.red,Icons.error);
  }
}
Future<bool> checkcoloravaible(String hexcode) async {
    final response = await http.get(Uri.parse("checkcode" + hexcode));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['available'] ?? false; // Use null-aware operator to handle null value
    } else {
      // Handle error
      throw Exception('Failed to check username availability');
    }
  }
  
Future<void> addcolor(String name,String hexcode,Function(String,Color) added) async {
  try {
  final response = await http.post(
      Uri.parse(addcolorurl),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "name":name,
        "hexCode":hexcode
      }),
    );


    if (response.statusCode == 201) {
      added('Color added !',Colors.green);
    } else if (response.statusCode == 200) {
      added('Error !',Colors.red);
    } else {
      print('Failed to add Color ${response.statusCode}');
    }
  } catch (error) {
    print('Internal Server Error: $error');
  }
}

Future<void> updatecolor(String id,String name,String hexcode,Function(String,Color) changed) async {
  try {
  final response = await http.put(
      Uri.parse(modifcolorurl+id),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "name":name,
        "hexCode":hexcode
      }),
    );


    if (response.statusCode == 201||response.statusCode == 200) {
      changed('Color Modified !',Colors.green);
    }  else {
      print('Failed to add Color ${response.statusCode}');
    }
  } catch (error) {
    print('Internal Server Error: $error');
  }
}


