import 'package:bridgewearaa/controlleur/usercontrolleur.dart';
import 'package:bridgewearaa/models/user.dart';

class notification {
  String message;
  User usernotif;
  String title;
  String link;

  DateTime dateTime;

  // Constructor
  notification({
    required this.title,
    required this.message,
    required this.dateTime,
    required this.link,
    required this.usernotif

  });
  factory notification.fromJson(Map<String, dynamic> json) {
    return notification(
      title: json['title'],
    link: json['link']??"",
      message: json['message'],
      usernotif:  User.fromJson(json['senderid']),
      dateTime: DateTime.parse(json['date']),

    );
  }

}