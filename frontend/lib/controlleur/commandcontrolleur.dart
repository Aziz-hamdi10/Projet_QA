import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui';
import 'package:bridgewearaa/models/adress.dart';
import 'package:bridgewearaa/models/color.dart';
import 'package:bridgewearaa/models/commande.dart';
import 'package:bridgewearaa/models/commentaire.dart';
import 'package:bridgewearaa/models/frais.dart';
import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';

import 'package:bridgewearaa/config.dart';
import 'package:bridgewearaa/models/product.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
Future<void> modifyorderstate(String token,String ordeid, String state, Function(String,Color,IconData)fn) async {
    final url = Uri.parse(updateorderurl+ordeid);
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({'newState': state});

    try {
      final response = await http.put(url,    headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': token,
      }, body: body);

    if (response.statusCode == 200) {
      fn('Order modified successfully',Colors.green,Icons.check);
    } else {
  
      fn('Failed to modify Order',Colors.red,Icons.cancel_outlined);
    }
  } catch (e) {
    fn('Error',Colors.red,Icons.cancel_outlined);

  }
}

Future<void> getcommand(Function (List<commande>) remplir,String iduser  )  async {
  final response = await http.get(Uri.parse(getallbyidordesrurl+iduser));

  if (response.statusCode == 200) {
    final List<dynamic> jsonData = json.decode(response.body);
    List<commande> commandes = jsonData.map((json) => commande.fromJson(json)).toList();
    remplir(commandes);
  } else {
    remplir([]);
  }
}

Future<void> getsalles(Function (List<commande>) remplir,String iduser  )  async {
  final response = await http.get(Uri.parse(getsalesurl+iduser));

  if (response.statusCode == 200) {
    final List<dynamic> jsonData = json.decode(response.body);
    List<commande> commandes = jsonData.map((json) => commande.fromJson(json)).toList();
    remplir(commandes);
  } else {
    remplir([]);
  }
}
Future<void> getcmdbystate(Function (List<commande>) remplir,String token,String state  )  async {
  final response = await http.get(Uri.parse('$getallorderbyetaturl?etat=$state'),
    headers: <String, String>{
      'Content-Type': 'application/json',
      'Authorization': token,
    },
  );

  if (response.statusCode == 200) {
    final List<dynamic> jsonData = json.decode(response.body);
    List<commande> commandes = jsonData.map((json) => commande.fromJson(json)).toList();
    remplir(commandes);
  } else {
    remplir([]);
  }
}


Future<void> getallcmd(Function (List<commande>) remplir )  async {
  final response = await http.get(Uri.parse(getallorderurl));

  if (response.statusCode == 200) {
    final List<dynamic> jsonData = json.decode(response.body);
    List<commande> commandes = jsonData.map((json) => commande.fromJson(json)).toList();
    remplir(commandes);
  } else {
    remplir([]);
  }
}

Future<void> getcommandbyidcmd(Function (commande) remplir,String iduser  )  async {
  final response = await http.get(Uri.parse(getorderbyidurl+iduser));

  if (response.statusCode == 200) {
    final  jsonData = json.decode(response.body);
    commande commandes =  commande.fromJson(jsonData);

    remplir(commandes);
  } else {
    print("erro1r");
  }
}
Future<void> getadress(Function (Address) remplir,String iduser  )  async {
  final response = await http.get(Uri.parse(getadressurl+iduser));

  if (response.statusCode == 200) {
    final  jsonData = json.decode(response.body);
    Address adr =  Address.fromJson(jsonData);
    remplir(adr);
  } else {
    remplir(Address(street: "street", city: "city", state: "state", postalCode: "postalCode"));
    print("erroradr");
  }
}
Future<void> getfrais(Function (frais) remplir)  async {
  final response = await http.get(Uri.parse(getfraisurl));

  if (response.statusCode == 200) {
    final  jsonData = json.decode(response.body);

    frais adr = frais.fromJson(jsonData['latestFrais']);

    remplir(adr);
  } else {
    print("error");
  }
}
Future<void> addcommand(commande cmd,Function(String,Color) message) async {
  try {

    final response = await http.post(
      Uri.parse(addorderurl),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(cmd.toJson()),
    );

    if (response.statusCode == 201) {
      message('order added successfully',Colors.green);
      Map<String, dynamic> jsonData = json.decode(response.body);

    } else {

      message('Failed to add order.' ,Colors.red);
      print(response.body);
    }
  } catch (error) {
    print('Error: $error');
  }
}
Future<XFile?> getImageXFile(String imageUrl) async {
  try {
    // Fetch the image data from the server
    final response = await http.get(Uri.parse(url+"/getimage/1709772086290.png"));

    if (response.statusCode == 200) {
      // Convert the response body to Uint8List
      Uint8List imageData = response.bodyBytes;
      XFile xFile = XFile.fromData(imageData);


      return xFile;
    } else {
      print('Failed to fetch image. Status code: ${response.statusCode}');
      return null;
    }
  } catch (error) {
    print('Error: $error');
    return null;
  }
}
Future<double> gettotalselling(String token)  async {
  final response = await http.get(Uri.parse(totalsellingpriceurl));

  if (response.statusCode == 200) {
    final jsonResponse = jsonDecode(response.body);
      final double totalSellingPrice = jsonResponse['totalSellingPrice'];
      return totalSellingPrice;
  
  } else {
      return 0;

    throw Exception('Failed to load Total Selling Price');

  }
}
Future<double> gettottalprofit(String token)  async {
  final response = await http.get(Uri.parse(totalprofiturl));

  if (response.statusCode == 200) {
    final jsonResponse = jsonDecode(response.body);
      final double totalSellingPrice = jsonResponse['totalprofil'];
      return totalSellingPrice;
  
  } else {
      return 0;

    throw Exception('Failed to load Total profit');

  }
}
Future<int> getnmuberorders(String etat) async {
  final apiUrl = getnumberordersbyrole; 

  try {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'etat': etat}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['ordercount'];
    } else {
      throw Exception('Failed to load order count');
    }
  } catch (error) {
    throw Exception('Error fetching order count: $error');
  }
}
Future<String?> payment(String idprd,double amount, String email, String phone, String firstname, String secondname, Function(String, Color) added) async {
  final url = Uri.parse(paymenturl);
  final headers = {'Content-Type': 'application/json'};
  final body = jsonEncode({'amount': amount, 'first_name': firstname, 'last_name': secondname, 'email': email, 'phone': phone, 'idprd':idprd});

  try {
    final response = await http.post(url, headers: headers, body: body);
    if (response.statusCode == 200) {
      Map<String, dynamic> responseData = jsonDecode(response.body);
      String? paymentUrl = responseData['data']['payment_url'];
      added(paymentUrl!,Colors.green);

      return paymentUrl;
    } else if (response.statusCode == 201) {
      // Handle other status codes if needed
    } else {
      print('Failed to add/remove product from wishlist: ${response.statusCode}');
    }
  } catch (error) {
    print('Internal Server Error: $error');
  }

  return null; // Return null if there's an error or the response is not successful
}
