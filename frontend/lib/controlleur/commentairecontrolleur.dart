import 'dart:ui';

import 'package:bridgewearaa/config.dart';
import 'package:bridgewearaa/models/commentaire.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:typed_data';
import 'package:http_parser/http_parser.dart';
Future<void> ajoutcommentaire(Commentaire cmt ,Function(String,Color,Commentaire?) added) async {
  final url = Uri.parse(addcommentaireurl);
  final body = jsonEncode({'userid': cmt.user?.id, 'productid': cmt.idproduct,'message':cmt.message});

  try {
    final response = await http.post(url, headers:  <String, String>{
      'Content-Type': 'application/json',
    }, body: body);

    if (response.statusCode == 201) {
      final jsonData = json.decode(response.body);
      print(jsonData);
      added('Comment added !',Colors.green,Commentaire.fromJson(jsonData));
    } else if (response.statusCode == 200) {
      added('Error !',Colors.red,null);
    } else {
      print('Failed to add Comment ${response.statusCode}');
    }
  } catch (error) {
    print('Internal Server Error: $error');
  }
}
Future<void> Deletecmnt(String token, String commentId, Function(String, Color) deleted) async {
  try {
    final response = await http.delete(
      Uri.parse(deletecmnturl+commentId),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      // Comment deleted successfully
      deleted('Comment deleted successfully', Colors.green);
    } else if (response.statusCode == 404) {
      // Comment not found
      deleted('Comment not found', Colors.red);
    } else {
      // Other error
      deleted('Failed to delete comment: ${response.reasonPhrase}', Colors.red);
    }
  } catch (err) {
    // Network or other error
    deleted('An error occurred: $err', Colors.red);
  }
}
Future<void> modifycmt(Commentaire cmt,String msg,String token ,Function(String,Color,Commentaire?) added) async {
  final body = jsonEncode({'commentId': cmt.id,'newContent':msg});

  try {
    final response = await http.post(
      Uri.parse(modiftcmturl),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: body,
    );
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      added('Comment Modifed !',Colors.green,Commentaire.fromJson(jsonData));
    } else if (response.statusCode == 200) {
      added('Error !',Colors.red,null);
    } else {
      print('Failed to Modify Comment ${response.statusCode}');
    }
  } catch (error) {
    print('Internal Server Error: $error');
  }
}
