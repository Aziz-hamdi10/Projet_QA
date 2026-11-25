import 'dart:ui';

import 'package:bridgewearaa/config.dart';
import 'package:bridgewearaa/controlleur/productcontrolleur.dart';
import 'package:bridgewearaa/models/color.dart';
import 'package:bridgewearaa/models/categorie.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:typed_data';
import 'package:http_parser/http_parser.dart';
import 'package:http/http.dart' as http;
import 'dart:ui';
import 'package:image_picker/image_picker.dart';
Future<void> getcategories(Function (List<categorie>) remplir  )  async {
  final response = await http.get(Uri.parse(getdepartementsurl));

  if (response.statusCode == 200) {
    final List<dynamic> jsonData = json.decode(response.body);

    List<categorie> cats = jsonData.map((json) => categorie.fromJson(json)).toList();
    remplir(cats);
  } else {
    throw Exception('Failed to load categories');
  }
}
bool searchcatByName(String name, List<categorie> listcategorie) {

 
    return listcategorie.any((item) => item.name.toLowerCase() == name.toLowerCase());
  
}
Future<void> addcategory(String name ,Function(String,Color) added,XFile? image) async {
var request = http.MultipartRequest('POST', Uri.parse(url + "/departement/adddepartement"));
  request.fields['title'] = name;

    List<int> bytes = await image!.readAsBytes();
    request.files.add(http.MultipartFile.fromBytes('departementimage', bytes, filename: image!.name,contentType:  new MediaType('image',getMimeType(image))));
  


  try {
    var response = await request.send();

    if (response.statusCode == 201) {
      added('Category added !',Colors.green);
    } else if (response.statusCode == 200) {
      added('Error !',Colors.red);
    } else {
      print('Failed to add Category ${response.statusCode}');
    }
  } catch (error) {
    print('Internal Server Error: $error');
  }
}

Future<void> modifycategorie(String categoryid, String name,XFile? newimage,Function(String,Color,IconData)fn) async {
 
  var request = http.MultipartRequest('PUT', Uri.parse(url + "/departement/modify-departement/"+categoryid));

  request.fields['title'] = name;


  if (newimage!=null) {
      List<int> bytes = await newimage!.readAsBytes();
      request.files.add(http.MultipartFile.fromBytes('departementimage', bytes, filename: newimage!.name,contentType:  new MediaType('image',getMimeType(newimage))));
    
  }

  try {
    var response = await request.send();
    if (response.statusCode == 200) {
      fn('Category modified successfully',Colors.green,Icons.check);
    } else {
      if (response.stream != null) {
        print(await response.stream.bytesToString());
      }
      fn('Failed to modify Category',Colors.red,Icons.cancel_outlined);

    }
  } catch (e) {
    fn('Error',Colors.red,Icons.cancel_outlined);

  }
}

Future<void> deletecategory(Function (String,Color,IconData icon) delete,String id )  async {
  final response = await http.delete(Uri.parse(deletcategoryurl+id));

  if (response.statusCode == 200) {

    delete("Category Deleted with Success",Colors.green,Icons.check);
  } else {
    delete("Error",Colors.red,Icons.error);
  }
}