import 'dart:ui';



class size {
  String name;
  String id;
  DateTime dateadd;


  // Constructor
  size({
    required this.id,

    required this.name,
    required this.dateadd


  });
  factory size.fromJson(Map<String, dynamic> json) {
    return size(
      
      id:json["_id"],
      name: json["name"],
      dateadd: json['dateadd'] != null
        ? DateTime.parse(json['dateadd'])
        : DateTime.now(),  
    );
  }


}