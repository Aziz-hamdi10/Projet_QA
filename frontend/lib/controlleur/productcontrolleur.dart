import 'dart:convert';
import 'dart:ui';
import 'package:bridgewearaa/models/productgenerale.dart';
import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart' as path;

import 'package:bridgewearaa/config.dart';
import 'package:bridgewearaa/models/product.dart';
import 'package:http/http.dart' as http;
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_svg/flutter_svg.dart';
Future<List<String>> fetchImagesnames(String productId) async {
  final url = getproductimages+productId;

  try {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      // Parse the response and extract the "image" field
      List<dynamic> images = json.decode(response.body);
      List<String> imageUrls =
      images.map((image) => image['image'] as String).toList();

      return imageUrls;
    } else {
      throw Exception('Failed to load images names');
    }
  } catch (error) {
    print('Error: $error');
    throw Exception('Failed to load images names ');
  }
}
Future<void> getnumberlikes(String idproduct ,Function (int)  change )  async {
  final response = await http.get(Uri.parse(getnumberlikesurl+idproduct));

  if (response.statusCode == 200) {
    final jsonData = json.decode(response.body);

    change( jsonData['numberOflikes']);
  } else {
    throw Exception('Failed to load number of follows');

  }
}
Future<void> getProducts(Function (List<Product>) remplir,String iduser  )  async {
  final response = await http.get(Uri.parse(getproducts+iduser));

  if (response.statusCode == 200) {
    final List<dynamic> jsonData = json.decode(response.body);
    List<Product> products = jsonData.map((json) => Product.fromJson(json)).toList();
    remplir(products);
  } else {
    remplir([]);
  }
}
Future<void> getProductsgen(Function (List<Productgen>) remplir,String token  )  async {
  final response = await http.get(Uri.parse(getproductgenurl),

    headers: <String, String>{
      'Content-Type': 'application/json',
      'Authorization': token,
    },);

  if (response.statusCode == 200) {
    final List<dynamic> jsonData = json.decode(response.body);
    List<Productgen> products = jsonData.map((json) =>

        Productgen.fromJson(json)).toList();
    remplir(products);
  } else {
    remplir([]);
  }
}
Future<void> getproductbyidproduct(Function (Product) remplir,String iduser  )  async {
  final response = await http.get(Uri.parse(getproductsbyidproducturl+iduser));

  if (response.statusCode == 200) {
    final jsonData = json.decode(response.body);
    Product products = Product.fromJson(jsonData);
    remplir(products);
  } else {

  }
}
Future<void> getProductsbyid(Function (List<Productgen>) remplir ,String id )  async {
  final response = await http.get(Uri.parse(getproductsbyidurl+id));

  if (response.statusCode == 200) {
    final List<dynamic> jsonData = json.decode(response.body);
    List<Productgen> products = jsonData.map((json) => Productgen.fromJson(json)).toList();
    remplir(products);
  } else {
    remplir([]);
  }
}
Future<void> getProductliked(Function (List<Productgen>) remplir ,String id )  async {
  final response = await http.get(Uri.parse(getproductslikedurl+id));

  if (response.statusCode == 200) {
    final List<dynamic> jsonData = json.decode(response.body);

    List<Productgen> products = jsonData.map((json) =>

        Productgen.fromJson(json)).toList();
    remplir(products);
  } else {
    remplir([]);
  }
}
Future<void> Deleteproductbyid(Function (String,Color  ) delete,String id )  async {
  final response = await http.delete(Uri.parse(deleteproductbyidurl+id));

  if (response.statusCode == 200) {

    delete("Product Deleted with Sucess",Colors.green);
  } else {
    delete("Error",Colors.red);
  }
}
Future<void> addToWishlist(String iduser, String idproduct,Function(String) like,Function(String) dislike) async {
  final url = Uri.parse(likeproducturl);
  final headers = {'Content-Type': 'application/json'};
  final body = jsonEncode({'iduser': iduser, 'idproduct': idproduct});

  try {
    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 201) {
      like('Product added to wishlist successfully.');
    } else if (response.statusCode == 200) {
      dislike('Product removed from wishlist successfully.');
    } else {
      print('Failed to add/remove product from wishlist: ${response.statusCode}');
    }
  } catch (error) {
    print('Internal Server Error: $error');
  }
}
bool searchProductById(String productId,List<Productgen> list) {

  return list.any((product) => product.id == productId);
}

void removeProductById(String productId, List<Productgen> productList) {
  int index = productList.indexWhere((product) => product.id == productId);

  if (index != -1) {
    productList.removeAt(index);
  }

}

String getMimeType(XFile file) {
  return file.path.split('.').last;
}
Future<void> addimage(List<XFile?> images, String productId) async {
  for(XFile? image in images){
    if (image == null) return;

    try {

      final url = Uri.parse(addimageurl + productId);
      var request = http.MultipartRequest('POST', url)
        ..files.add(await http.MultipartFile.fromPath('image', image.path,
            contentType: new MediaType('image',getMimeType(image))
        ));

      var response = await request.send();
      var responseBody = await response.stream.bytesToString();

      if (response.statusCode == 201) {
        print('Image uploaded successfully 1');
      } else {
        print('Failed to upload image. Response body: $responseBody');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

}
Future<void> addProductWithImages(Product p) async {
  var request = http.MultipartRequest('POST', Uri.parse(url + "/product/addProductWithImages"));
  request.fields['name'] = p.name;
  request.fields['description'] = p.description;
  request.fields['originalPrice'] = p.Originalprice.toString();
  request.fields['sellingPrice'] = p.SeelingPrice.toString();
  request.fields['department'] = p.department;
  request.fields['brand'] = p.Brand.id;
  request.fields['size'] = p.Size.id;
  request.fields['state'] = p.state;
  request.fields['idcolor'] = p.cl!.id;
  request.fields['idcateg'] = p.Categorie!.id;
  request.fields['idbrand'] = p.Brand.id;

  request.fields['iduser'] = p.iduser!.id;

  for (var image in p.imageUrl) {
    List<int> bytes = await image!.readAsBytes();
    request.files.add(http.MultipartFile.fromBytes('images', bytes, filename: image!.name,contentType:  new MediaType('image',getMimeType(image))));
  }


  try {
    var response = await request.send();

    if (response.statusCode == 201) {
      print('Product added successfully');
    } else {
      print('Failed to add product. Status code: ${response.statusCode}');
      print(await response.stream.bytesToString());
    }
  } catch (e) {
    print('Error: $e');
  }
}
Future<void> modifyProduct(String productId, String name, String description, double originalPrice, double sellingPrice, String category, String department, String brand,String idcolor, String size, String state, List<XFile?> images,List<String>imagenames,Function(String,Color,IconData,Product?)fn) async {
  if(images.isNotEmpty){
    for(XFile? x in images){
      String imageName = path.basename(x!.path);
      List<String> parts = imageName.split('_');
      String desiredName = parts.last;
      imagenames.add(desiredName);
    }

  }
  var request = http.MultipartRequest('POST', Uri.parse(url + "/product/modify-product"));
  request.fields['imageNames'] = imagenames.join(',');

  request.fields['productId'] = productId;
  request.fields['name'] = name;
  request.fields['description'] = description;
  request.fields['originalPrice'] = originalPrice.toString();
  request.fields['sellingPrice'] = sellingPrice.toString();
  request.fields['idcateg'] = category;
  request.fields['idcolor'] = idcolor;

  request.fields['department'] = department;
  request.fields['idbrand'] = brand;
  request.fields['size'] = size;
  request.fields['state'] = state;
  if(images.isNotEmpty)
  addimage(images,productId);

  try {
    var response = await request.send();
    var responseBody = await response.stream.bytesToString();

    if (response.statusCode == 200||response.statusCode == 201) {

      fn('Product modified successfully',Colors.green,Icons.check,Product.fromJson(jsonDecode(responseBody)));
    } else {
      if (response.stream != null) {
        print(await response.stream.bytesToString());
      }
      fn('Failed to modify product',Colors.red,Icons.cancel_outlined,null);

    }
  } catch (e) {
    fn('Error'+e.toString(),Colors.red,Icons.cancel_outlined,null);

  }
}

/*Future<void> addProduct(Product p) async {
  try {

    final response = await http.post(
      Uri.parse(addproducturl),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(p.toJson()),
    );

    if (response.statusCode == 200) {
      print('Product added successfully');
      Map<String, dynamic> jsonData = json.decode(response.body);

      addimage(p.imageUrl, jsonData['_id']);
    } else {
      print('Failed to add product. Status code: ${response.statusCode}');
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
      // Handle the case when the server returns an error
      print('Failed to fetch image. Status code: ${response.statusCode}');
      return null;
    }
  } catch (error) {
    // Handle other potential errors
    print('Error: $error');
    return null;
  }
}*/
