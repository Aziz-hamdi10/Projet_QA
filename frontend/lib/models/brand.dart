class brand {
  String title;
  String image;
  String id;
  DateTime datedadd;





  brand({
    required this.datedadd,
    required this.id,
    required this.title,


    required this.image

  });
  factory brand.fromJson(Map<String, dynamic> json) {
    return brand(
      id:json["_id"]??"0",
        image: json["image"] ?? 'rd',

      title: json["title"] ?? 'rd',
      datedadd: json['dateadd'] != null
        ? DateTime.parse(json['dateadd'])
        : DateTime.now(),      

    );
  }


}