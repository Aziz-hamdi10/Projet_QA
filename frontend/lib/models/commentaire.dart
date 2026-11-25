import 'package:bridgewearaa/models/user.dart';

class Commentaire {
  String id;
  String message;
  DateTime date;
  String firstname;
  String idproduct;

  User? user;


  Commentaire({
    required this.idproduct,
    required this.user,
    required this.id,
    required this.firstname,
    required this.message,
  required this.date,


  });

  factory Commentaire.fromJson(Map<String, dynamic> json) {

    return Commentaire(
      idproduct:json['productid'] ,
      user: User.fromJson(json['userid']),
      id: json['_id']??"",
      date: DateTime.parse(json['date']),
      message: json['message'] ?? '',
      firstname: json['productid'] ?? '',


    );
  }


}
