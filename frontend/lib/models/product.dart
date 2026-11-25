import 'package:bridgewearaa/models/categorie.dart';
import 'package:bridgewearaa/models/commentaire.dart';
import 'package:bridgewearaa/models/size.dart';
import 'package:bridgewearaa/models/user.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:typed_data';
import 'package:bridgewearaa/controlleur/productcontrolleur.dart';
import 'package:bridgewearaa/models/brand.dart';
import 'package:bridgewearaa/models/color.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';

class Product {
  User? iduser;

  String id;
  String name;
  String description;
  double Originalprice;
  double SeelingPrice;
  List<XFile?> imageUrl;
  List<String> imgaenames;
  int numberlikes;
  bool? liked;
  categorie? Categorie;
  String department;
  brand Brand;
  color? cl;
  size Size;
  String state;
  List<Commentaire> commentaires;


  Product({
    required this.commentaires,
    required this.iduser,
    required this.imgaenames,
    required this.Originalprice,
    required this.SeelingPrice,
    required this.state,
     this.cl,
    required this.Brand,
    required this.department,
    required this.Categorie,
    required this.Size,
     this.liked=false,
    required this.numberlikes,
    required this.id,
    required this.name,
    required this.description,

    required this.imageUrl,
  });
  void copyFrom(Product other) {
    this.iduser = other.iduser;
    this.id = other.id;
    this.name = other.name;
    this.description = other.description;
    this.Originalprice = other.Originalprice;
    this.SeelingPrice = other.SeelingPrice;
    this.imageUrl = List<XFile?>.from(other.imageUrl);
    this.imgaenames = List<String>.from(other.imgaenames);
    this.numberlikes = other.numberlikes;
    this.liked = other.liked;
    this.Categorie = other.Categorie;
    this.department = other.department;
    this.Brand = other.Brand;
    this.cl = other.cl;
    this.Size = other.Size;
    this.state = other.state;
    this.commentaires = List<Commentaire>.from(other.commentaires);
  }
  Map<String, dynamic> toJson() {
    return {
      'iduser':iduser,
      'originalPrice': Originalprice,
      'sellingPrice': SeelingPrice,
      'state': state,
      'idbrand': brand,
      'department': department,
      'idcateg': categorie,
      'size': Size,
      'liked': liked,
      'numberLikes': numberlikes,
      'name': name,
      'description': description,
      'idcolor': cl?.id.toString()

    };
  }
  factory Product.fromJson(Map<String, dynamic> json) {
    List<dynamic> picturesJson = (json['productPictures'] as List) ?? [];
    List<String> imageNames = picturesJson.map((e) => e['image'].toString()).toList();

    List<dynamic> commentaires = (json['comments'] as List) ?? [];
    List<Commentaire> commentairelist = commentaires.map((e) => Commentaire.fromJson(e)).toList()??[];
    return Product(
      iduser:User.fromJson(json['product']['iduser']) ,
      id: json['product']['_id'] ?? "",
      SeelingPrice: (json['product']['sellingPrice'] ?? 0).toDouble(),
      Originalprice: (json['product']['originalPrice'] ?? 0).toDouble(),
      name: json['product']['name'] ?? '',
      description: json['product']['description'] ?? '',
      Categorie: categorie.fromJson(json['product']['idcateg']) ,
      Brand: brand.fromJson(json['product']['idbrand']) ,
      imgaenames: imageNames, // Adjusted property name
      state: json['product']['state'] ?? '',
      department: json['department'] ?? '',
      Size: size.fromJson(json['product']['size']) ,

      numberlikes: json['likes'] ?? 10,
      imageUrl: [],
      cl: color.fromJson(json['product']['idcolor']),
      
      commentaires: commentairelist,
    );
  }
  factory Product.fromJsonorder(Map<String, dynamic> json) {

    List<dynamic> picturesJson = (json['productPictures'] as List) ?? [];
    List<String> imageNames = picturesJson.map((e) => e['image'].toString()).toList();

    return Product(
        commentaires: [],

        iduser:User.fromJson(json['order']['product']['iduser']),
        id: json['order']['product']['_id'] ?? "",
        SeelingPrice: (json['order']['product']['sellingPrice'] ?? 0).toDouble(),
        Originalprice: (json['order']['product']['originalPrice'] ?? 0).toDouble(),
        name: json['order']['product']['name'] ?? '',
        description: json['order']['product']['description'] ?? '',
      Categorie:categorie(dateadd: DateTime.now(), id: "id", image: "image", name: "name"),
      Brand: brand.fromJson(json['order']['product']['idbrand']),
        imgaenames: imageNames, // Adjusted property name
        state: json['order']['product']['state'] ?? '',
        department: json['order']['product']['department'] ?? '',
        Size: size.fromJson(json['order']['product']['size']),

        numberlikes: json['order']['product']['numberlikes'] ?? 0,
        imageUrl: [],
        cl: color.fromJson(json['order']['product']['idcolor']),
        
    );
  }


}
bool compareProducts(Product product1, Product product2) {
  if (product1.id != product2.id) return false;
  if (product1.name != product2.name) return false;
  if (product1.description != product2.description) return false;
  if (product1.Originalprice != product2.Originalprice) return false;
  if (product1.SeelingPrice != product2.SeelingPrice) return false;
  if (product1.numberlikes != product2.numberlikes) return false;
  if (product1.liked != product2.liked) return false;
  if (product1.Categorie != product2.Categorie) return false;
  if (product1.department != product2.department) return false;
  if (product1.Brand != product2.Brand) return false;
  if (product1.cl?.id != product2.cl?.id) return false;
  if (product1.Size != product2.Size) return false;
  if (product1.state != product2.state) return false;

  if (product1.imgaenames.length != product2.imgaenames.length) return false;
  for (int i = 0; i < product1.imgaenames.length; i++) {
    if (product1.imgaenames[i] != product2.imgaenames[i]) return false;
  }
  return true;
}

List<Product> filterProductsByBrand(List<Product> listproduct, List<brand> listbrandsfiltrerd) {
  return listproduct.where((product) {
    return listbrandsfiltrerd.any((brand) => brand.title.toLowerCase() == product.Brand.title.toLowerCase());
  }).toList();
}
List<Product> filterProductsBycategorie(List<Product> listproduct, List<categorie> listbrandsfiltrerd) {
  return listproduct.where((product) {
    return listbrandsfiltrerd.any((brand) => brand.name.toLowerCase() == product.Categorie!.name.toLowerCase());
  }).toList();
}
List<Product> filterProductsBySize(List<Product> listproduct, List<String> listsize) {
  return listproduct.where((product) {
    return listsize.contains(product.Size.name);
  }).toList();
}
List<Product> filterProductsByColor(List<Product> listproduct, List<color> listcouleurfiltred) {
  return listproduct.where((product) {
    return listcouleurfiltred.any((color) => color.name.toLowerCase() == product.cl?.name.toLowerCase());
  }).toList();
}
List<Product> filterProductsByPrice(List<Product> listproduct, double minPrice, double maxPrice) {
  return listproduct.where((product) {
    return product.SeelingPrice >= minPrice && product.SeelingPrice <= maxPrice;
  }).toList();
}
List<Product> filterProductsByCategorie(List<Product> listproduct,String categorie) {
  return listproduct.where((product) {
    return product.Categorie!.name.toLowerCase()==categorie.toLowerCase();
  }).toList();
}
List<Product> filterProductsByName(List<Product> listproduct,String name) {
  if(name.isNotEmpty)
    {
      return listproduct.where((product) {
        return product.name.toLowerCase().contains(name.toLowerCase());
      }).toList();
    }
  else{
    return listproduct;
  }


}
List<Product> filtrerproductbysearch(List<Product> listproduct,String seach) {
  return listproduct.where((product) {
    return product.name.toLowerCase().contains(seach.toLowerCase()) || product.description.toLowerCase().contains(seach.toLowerCase()) ;
  }).toList();
}
List<Product> orderByPrix(List<Product> listProduct,String orderby) {
  if(orderby=="Price: High to Low")
    {
      listProduct.sort((a, b) => b.SeelingPrice.compareTo(a.SeelingPrice));

    }
  else{
    listProduct.sort((a, b) => a.SeelingPrice.compareTo(b.SeelingPrice));

  }
  return listProduct;
}
  Color toColor(hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
