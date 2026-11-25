import 'package:bridgewearaa/controlleur/usercontrolleur.dart';

class User {
  String id;
  String email;
  String phone;
  String firstname;
  String secondname;
  String picture;
  String password;
  String role; 
  String etat; 

  User({
    required this.id,
    required this.firstname,
    required this.secondname,
    required this.email,
    required this.phone,
    required this.picture,
    required this.password,
    required this.role,
         this.etat="",

  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
            etat: json['state'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      picture: json['Profilepicture'] ?? '',
      firstname: json['firstname'] ?? '',
      secondname: json['secondname'] ?? '',
      password: json['password'] ?? '',
      role: json['role'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'email': email,
      'phone': phone,
      'secondname': secondname,
      'firstname': firstname,
      'password': password,
      'Profilepicture': picture,
      'role': role,
    };
  }

  Map<String, dynamic> toJson2() {
    return {
      'email': email,
      'phone': phone,
      'secondname': secondname,
      'firstname': firstname,
      'password': password,
      'role': role, 
    };
  }
}
