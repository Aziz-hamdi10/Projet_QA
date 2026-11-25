import 'package:bridgewearaa/config.dart';
import 'package:bridgewearaa/controlleur/productcontrolleur.dart';
import 'package:bridgewearaa/models/brand.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:typed_data';
import 'package:http_parser/http_parser.dart';
import 'package:http/http.dart' as http;
import 'dart:ui';
import 'package:image_picker/image_picker.dart';


Future<void> getbrands(Function (List<brand>) remplir  )  async {
  final response = await http.get(Uri.parse(getbrandsurl));

  if (response.statusCode == 200) {
    final List<dynamic> jsonData = json.decode(response.body);
    List<brand> brands = jsonData.map((json) => brand.fromJson(json)).toList();
    remplir(brands);
  } else {
    throw Exception('Failed to load products');
  }
}
Future<List<double>> getBrandCounts() async {
  final response = await http.get(Uri.parse(getbrandscounturl));

  if (response.statusCode == 200) {
    final List<dynamic> jsonData = json.decode(response.body);
    print(jsonData);
    return jsonData.map<double>((json) => json["productCount"] as double).toList();
    
  } else {
    throw Exception('Failed to load product counts');
  }
}
Future<bool> checkbrandAvailability(String brand) async {
  
    final response = await http.get(Uri.parse(checkbrandurl + brand));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['available'] ?? false;
    } else {
      throw Exception('Failed to check username availability');
    }


}
Future<void> addbrand(String title ,Function(String,Color,brand?) added,  XFile? image) async {
var request = http.MultipartRequest('POST', Uri.parse(url + "/brand/addbrand"));
  request.fields['title'] = title;

    List<int> bytes = await image!.readAsBytes();
    request.files.add(http.MultipartFile.fromBytes('images', bytes, filename: image!.name,contentType:  new MediaType('image',getMimeType(image))));
  


  try {
    var response = await request.send();
    var responseBody = await response.stream.bytesToString();
 
    if (response.statusCode == 201) {
      added("Brand deleted with success",Colors.green,brand.fromJson(jsonDecode(responseBody)));
    } else if (response.statusCode == 200) {
      added('Error !',Colors.red,null);
    } else {
      print('Failed to add Brand ${response.statusCode}');
    }
  } catch (error) {
    print('Internal Server Error: $error');
  }
}

Future<void> deletbrand(Function (String,Color,IconData icon) delete,String id )  async {
  final response = await http.delete(Uri.parse(deletbrandurl+id));

  if (response.statusCode == 200) {

    delete("Brand Deleted with Success",Colors.green,Icons.check);
  } else {
    delete("Error",Colors.red,Icons.error);
  }
}
Future<void> modifbrand(String brandid, String name,XFile? newimage,Function(String,Color,IconData)fn) async {
 
  var request = http.MultipartRequest('PUT', Uri.parse(url + "/brand/modify-brand/"+brandid));

  request.fields['title'] = name;


  if (newimage!=null) {
      List<int> bytes = await newimage!.readAsBytes();
      request.files.add(http.MultipartFile.fromBytes('image', bytes, filename: newimage!.name,contentType:  new MediaType('image',getMimeType(newimage))));
    
  }

  try {
    var response = await request.send();
    if (response.statusCode == 200) {
      fn('Brand modified successfully',Colors.green,Icons.check);
    } else {
      if (response.stream != null) {
        print(await response.stream.bytesToString());
      }
      fn('Failed to modify brand',Colors.red,Icons.cancel_outlined);

    }
  } catch (e) {
    fn('Error',Colors.red,Icons.cancel_outlined);

  }
}

