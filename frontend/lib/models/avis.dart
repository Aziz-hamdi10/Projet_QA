import 'package:bridgewearaa/controlleur/usercontrolleur.dart';
import 'package:bridgewearaa/models/user.dart';

class avis {
  String description;
  String idcommand;
  double rating;
  DateTime date;


  // Constructor
  avis({
    required this.description,
    required this.idcommand,
    required this.rating,
    required this.date,


  });
  factory avis.fromJson(Map<String, dynamic> json) {
    return avis(
      description: json['content']??"",
      idcommand: json['idorder']??"",
      rating:json['rating'].toDouble(),
      date: json['date'] != null
          ? DateTime.parse(json['date'])
          : DateTime.now(),
    );
  }

}