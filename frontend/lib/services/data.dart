import 'dart:convert';

import 'package:bridgewearaa/config.dart';
import 'package:bridgewearaa/controlleur/categoriecontroller.dart';
import 'package:bridgewearaa/controlleur/commandcontrolleur.dart';
import 'package:bridgewearaa/controlleur/productcontrolleur.dart';
import 'package:bridgewearaa/controlleur/promotioncontrolleur.dart';
import 'package:bridgewearaa/controlleur/sizecontrolleur.dart';
import 'package:bridgewearaa/controlleur/usercontrolleur.dart';
import 'package:bridgewearaa/models/adress.dart';
import 'package:bridgewearaa/models/brand.dart';
import 'package:bridgewearaa/models/color.dart';
import 'package:bridgewearaa/models/commande.dart';
import 'package:bridgewearaa/models/categorie.dart';
import 'package:bridgewearaa/models/frais.dart';
import 'package:bridgewearaa/models/product.dart';
import 'package:bridgewearaa/models/productgenerale.dart';
import 'package:bridgewearaa/models/promotion.dart';
import 'package:bridgewearaa/models/size.dart';
import 'package:bridgewearaa/models/user.dart';
import 'package:bridgewearaa/screens/signin.dart';
import 'package:bridgewearaa/controlleur/brandcontrolleur.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class DataService extends ChangeNotifier {
String? token;
  User? user ;
  List<Productgen> listproductliked=[

  ];
  List<Productgen> listproductuser=[

  ];
  List<Productgen> listproductenuser=[

  ];
  List<categorie> categories=[

  ];
List<categorie> listcategoriefiltred=[

];
List<promotion> listpromotion=[

];
Address adr=Address(street: "", city: "", state: "", postalCode: "");
frais delivcharge=frais(value: 0, id: "id");

  Future<void> inalizatetoken() async {
    String? t = await getTokenFromSharedPreferences();

    if (t!=null) {
      token = t;
      notifyListeners();
      getuserbytoken(token!, (p0) =>{
user=p0
      });
    }
    else{
      token=null;
    }
  }
  DataService() {
  inalizatetoken();
    getsizes( (list) =>{

       listsize=list
      });
    getbrands( (list) =>{

      brands=list
    });
    getcategories( (list) =>{

      categories=list

    });
  getsizes2( (list) =>{

  listsize2=list
  });
getpromotionactive((p0) => {
  listpromotion=p0
});




  }


  List<Product> listproduct=[

  ];

  List<commande> listcommandes=[
  ];

  double widthproduct=200;
  List<String> listsizefilter = [];
  List<color> listcolors= [

  ];
  List<color> listcolorsfiltred= [

  ];
  String Categorie="all";

  List<brand> listbrandfiltrer = [];

  List<String> listsize=[



  ];
    List<size> listsize2=[



  ];
  List<brand> brands=[





  ];

  String brandajouter="";
  color? coleurajouter=null;
  String Sizeajouter="";
  String categajouter="";



}
void saveUserData(User user) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();


  prefs.setString('userData', jsonEncode(user.toJson()));
}
Future<void> deleteuserData(String key) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.remove(key);
}
Future<Map<String, dynamic>> getUserData() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  String? userDataString = prefs.getString('userData');

  if (userDataString != null) {
    Map<String, dynamic> userData = json.decode(userDataString);
    return userData;
  } else {
    return {};
  }
}

Future<bool> checkUsernameAvailability(String username) async {
  final response = await http.get(Uri.parse(checkusername + username));

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    return data['available'] ?? false;
  } else {
    // Handle error
    throw Exception('Failed to check username availability');
  }
}
Future<bool> checkEmailAvailability(String email) async {
  if(isEmailValid(email)){
    final response = await http.get(Uri.parse(checkemail + email));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['available'] ?? false;
    } else {
      throw Exception('Failed to check username availability');
    }
  }
  else{
    return false;
  }

}
Future<bool> checkEmailAvailability2(String email) async {
    final response = await http.get(Uri.parse(checkemail + email));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['available'] ?? false;
    } else {
      throw Exception('Failed to check username availability');
    }


}
Future<bool> checkpassword(String email,String password) async {
  final response = await http.post(Uri.parse(checckpasswordurl ),

    headers: <String, String>{
      'Content-Type': 'application/json',
    },
    body: jsonEncode(<String, String>{
      'email': email,
      'password': password,
    }),
  );

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    return data['available'] ?? false;
  } else {
    throw Exception('Failed to check username availability');
  }


}
Future<void> sendcode(String email,Function(String,Color) msg) async {
  try {
    final response = await http.post(
      Uri.parse(sendcodeurl),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "email":email,
      }),
    );

    if (response.statusCode == 200) {
      msg('Code Activate Sended ,check your Email',Colors.green);
    } else {
      msg(response.body,Colors.red);

    }
  } catch (error) {
    print('Error during registration: $error');
  }
}

 Future<void> registerUser(User user,Function(String,Color) msg) async {
try {
final response = await http.post(
Uri.parse(register),
headers: <String, String>{
'Content-Type': 'application/json',
},
body: jsonEncode(user.toJson2()),
);

if (response.statusCode == 200) {
msg('Code Activate Sended ,check your Email',Colors.green);
} else {
  msg(response.body,Colors.red);

}
} catch (error) {
print('Error during registration: $error');
}
}
Future<void> saveTokenToSharedPreferences(String token) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('token', token);
}
Future<String?> getTokenFromSharedPreferences() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('token');
}
Future<void> login(String email, String username, String password, Function(String) updateError, Function(Map<String, dynamic>,String) success) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      final response = await http.post(
        Uri.parse(loginurl),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(<String, String>{
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final user = data['user'];
        
        final myToken = data['mytoken'];
        success(user,myToken);
      } else {
        updateError(response.body);
      }
    } catch (e) {
      print('Error during login: $e');
    }

}
