import 'package:bridgewearaa/controlleur/usercontrolleur.dart';
import 'package:bridgewearaa/models/user.dart';

class frais {
  String id;

  double value;

  frais({

    required this.value,
    required this.id,


  });
  factory frais.fromJson(Map<String, dynamic> json) {
    return frais(
      id: json['_id']??"",
      value: json['value'].toDouble()??10,

    );
  }

}