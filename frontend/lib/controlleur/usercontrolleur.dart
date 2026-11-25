import 'package:bridgewearaa/config.dart';
import 'package:bridgewearaa/controlleur/productcontrolleur.dart';
import 'package:bridgewearaa/models/user.dart';
import 'package:bridgewearaa/services/data.dart';
import 'package:http_parser/http_parser.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';

 Future<void> getNumberOfSubscribers(String userId,Function (int)  change) async {

  final response = await http.get(Uri.parse(getnumbersubsurl+userId));

  if (response.statusCode == 200) {
   final jsonData = json.decode(response.body);
   change( jsonData['numberOfSubscribers']);
  } else {
   throw Exception('Failed to load number of follows');

  }
}
Future<void> getDeliveries(String token, Function(List<User>) change) async {
  try {
    final response = await http.get(
      Uri.parse(getusersurl+token),
      headers: {
        'Authorization': 'Bearer $token', 
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      List<User> users = jsonData.map((json) => User.fromJson(json)).toList();
      change(users);
    } else {
      throw Exception('Failed to load user information');
    }
  } catch (error) {
    throw Exception('Error fetching user: $error');
  }
}
Future<void> getmoderateurs(String token, Function(List<User>) change) async {
  try {
    final response = await http.get(
      Uri.parse(getmoderateursurl+token),
      headers: {
        'Authorization': 'Bearer $token', 
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      List<User> users = jsonData.map((json) => User.fromJson(json)).toList();
      change(users);
    } else {
      throw Exception('Failed to load user information');
    }
  } catch (error) {
    throw Exception('Error fetching user: $error');
  }
}

Future<void> getUsersByToken(String token, Function(List<User>) change) async {
  try {
    final response = await http.get(

      Uri.parse("http://192.168.100.228:3000/user/getdeleivry/"+token), 
           headers: {
        'Authorization': 'Bearer $token', 
      },
    
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      List<User> users = jsonData.map((json) => User.fromJson(json)).toList();
      change(users);
    } else {
      throw Exception('Failed to load user information');
    }
  } catch (error) {
    throw Exception('Error fetching users: $error');
  }
}

Future<void> getuserbytoken(String token, Function(User) change) async {
  try {
    final response = await http.get(
      Uri.parse(getuserbytokenurl),

      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': token,
      },
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      change(User.fromJson(jsonData));
    } else {
      throw Exception('Failed to load user information');
    }
  } catch (error) {
    throw Exception('Error fetching user: $error');
  }
}

Future<void> getuserbyid(String userId,Function (User)  change) async {

 final response = await http.get(Uri.parse(getuserbyidurl+userId));

 if (response.statusCode == 200) {
  final jsonData = json.decode(response.body);
  change(User.fromJson(jsonData) );
 } else {
  throw Exception('Failed to load number of follows');

 }
}
Future<void> getuserbyidcmd(String idcmd,Function (User)  change) async {

  final response = await http.get(Uri.parse(url+"/order/getuser/"+idcmd));

  if (response.statusCode == 200) {
    final jsonData = json.decode(response.body);
    print(jsonData);
    change(User.fromJson(jsonData['User']) );
  } else {
    throw Exception('Failed to load number of follows');

  }
}
Future<void> getusers(String userId,Function (List<User>)  change) async {

 final response = await http.get(Uri.parse(getusersurl+userId));

 if (response.statusCode == 200) {
  final List<dynamic> jsonData = json.decode(response.body);
    List<User> Users = jsonData.map((json) => User.fromJson(json)).toList();
  change(Users );
 } else {
  throw Exception('Failed to load Users');

 }
}
Future<void> getNumberOfFollows(String iduser ,Function (int)  change )  async {
 final response = await http.get(Uri.parse(getnumberfollowsurl+iduser));

 if (response.statusCode == 200) {
  final jsonData = json.decode(response.body);
  change( jsonData['numberOfFollows']);
 }
 else {
  throw Exception('Failed to load number of follows');

 }
}
Future<void> getfollowing(Function (List<User>) remplir ,String id )  async {
 final response = await http.get(Uri.parse(getfollowsurl+id));

 if (response.statusCode == 200) {
  final List<dynamic> jsonData = json.decode(response.body);
  List<User> users = jsonData.map((json) => User.fromJson(json)).toList();
  remplir(users);
 } else {
  remplir([]);
 }
}
Future<void> modifyUserProfile(String id,String email, String firstName, String lastName, String phone, String password, XFile? profilePicture,Function update) async {
 try {
  var request = http.MultipartRequest('POST', Uri.parse(modifyprofileurl));
  request.fields['id'] = id;

  request.fields['email'] = email;
  request.fields['firstname'] = firstName;
  request.fields['secondname'] = lastName;
  if(DataService().user!=null)
  if(password!=DataService().user!.password){
   request.fields['password'] = password;
  }

  request.fields['phone'] = phone;


  if (profilePicture != null) {
      List<int> bytes = await profilePicture!.readAsBytes();
    request.files.add(http.MultipartFile.fromBytes('Profilepicture', bytes, filename: profilePicture!.name,contentType:  new MediaType('image',getMimeType(profilePicture))));
  
   
  }

  // Send the request
  final streamedResponse = await request.send();

  // Check if the request was successful
  if (streamedResponse.statusCode == 200) {
   final responseString = await streamedResponse.stream.bytesToString();
   User? u=User.fromJson(json.decode(responseString));

   saveUserData(u);
   update(u);
  } else {
   print('Failed to modify profile: ${streamedResponse.statusCode}');
  }
 } catch (error) {
  print('Error modifying profile: $error');
 }
}



Future<void> modifyuserid(String userid, String state, Function(String,Color,IconData)fn) async {
    final url = Uri.parse(updateuserstaterurl+userid);
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({'newState': state});

    try {
      final response = await http.put(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      fn('User modified successfully',Colors.green,Icons.check);
    } else {
  
      fn('Failed to modify User',Colors.red,Icons.cancel_outlined);
    }
  } catch (e) {
    fn('Error',Colors.red,Icons.cancel_outlined);

  }
}

Future<void> getsubs(Function (List<User>) remplir ,String id )  async {
 final response = await http.get(Uri.parse(getsubsurl+id));

 if (response.statusCode == 200) {
  final List<dynamic> jsonData = json.decode(response.body);
  List<User> users = jsonData.map((json) => User.fromJson(json)).toList();
  remplir(users);
 } else {
  remplir([]);
 }
}
Future<void> isFollowingUser(String currentUser, String targetUser,Function(bool) change) async {
 final url = Uri.parse(checksubsurl);

 final headers = {'Content-Type': 'application/json'};
 final body = jsonEncode({"currentUser": currentUser, "targetUser": targetUser});
 try {



   final response = await http.post(url, headers: headers, body: body);

  if (response.statusCode == 200) {
   Map<String, dynamic> data = json.decode(response.body);
   change(data['isFollowing']);

  } else {
   // If the server returns an error response, throw an exception.
   throw Exception('Failed to check if user is following: ${response.statusCode}');
  }
 } catch (error) {
  // Handle errors
  print('Error: $error');
  change(false);
 }
}

Future<void> subscripe(String subscriberId, String subscribedToId,Function(String) subs) async {
 final url = Uri.parse(subsurl);
 final headers = {'Content-Type': 'application/json'};
 final body = jsonEncode({'subscriberId': subscriberId, 'subscribedToId': subscribedToId});

 try {
  final response = await http.post(url, headers: headers, body: body);

  if (response.statusCode == 201) {
   subs('Abonne');
  }
 } catch (error) {
  print('Internal Server Error: $error');
 }
}
Future<void> unsubscribe(String subscriberId, String subscribedToId, Function(String) unsub) async {
 final url = Uri.parse(removesubsurl);
 final headers = {'Content-Type': 'application/json'};
 final body = jsonEncode({'subscriberId': subscriberId, 'subscribedToId': subscribedToId});

 try {
  final response = await http.delete(url, headers: headers, body: body);

  if (response.statusCode == 200) {
   unsub('Unsubscribed');
  } else {
   print('Failed to unsubscribe: ${response.statusCode}');
  }
 } catch (error) {
  print('Internal Server Error: $error');
 }
}

Future<void> deleteuser(Function (String,Color,IconData icon) delete,String id )  async {
  final response = await http.delete(Uri.parse(deletuserurl+id));

  if (response.statusCode == 200) {

    delete("User Deleted with Success",Colors.green,Icons.check);
  } else {
    delete("Unthrized User",Colors.red,Icons.error);
  }
}
Future<void> adduser(User u,Function(String,Color) added) async {
  try {
final response = await http.post(
Uri.parse(adduserurl),
headers: <String, String>{
'Content-Type': 'application/json',
},
body: jsonEncode(u.toJson2()),
);


    if (response.statusCode == 201) {
      added('User added !',Colors.green);
    } else if (response.statusCode == 200) {
      added('User added !',Colors.green);
    } else {

      print('Failed to add User ${response.statusCode}');
    }
  } catch (error) {
    print('Internal Server Error: $error');
  }
}
Future<void> activateUser(String email, String code, Function(String, Color, IconData) msg) async {
  final String apiUrl = activateuserurl;

  try {
    final response = await http.post(
      Uri.parse(activateuserurl),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "email": email,
        "code": code
      }),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseBody = jsonDecode(response.body);
      final String message = responseBody['message'];
      msg(message, Colors.green, Icons.check);
    } else if (response.statusCode == 404 || response.statusCode == 400) {
      final String errorMessage = jsonDecode(response.body)['error'];
      msg(errorMessage, Colors.red, Icons.cancel);
    } else {
      print('Error activating user: ${response.statusCode}');
    }
  } catch (error) {
    print('Error activating user: $error');
  }
}

Future<void> fogetpassword(String email, String password, Function(String, Color, IconData) msg) async {
  final String apiUrl = activateuserurl;

  try {
    final response = await http.post(
      Uri.parse(forgetpasswordurl),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "email": email,
        "password": password
      }),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseBody = jsonDecode(response.body);
      final String message = responseBody['message'];
      msg(message, Colors.green, Icons.check);
    } else if (response.statusCode == 404 || response.statusCode == 400) {
      final String errorMessage = jsonDecode(response.body)['error'];
      msg(errorMessage, Colors.red, Icons.cancel);
    } else {
      print('Error : ${response.statusCode}');
    }
  } catch (error) {
    print('Error : $error');
  }
}
Future<void> modifypassword(String email,String currentpassword, String newpassword, Function(String, Color, IconData) msg) async {
print(currentpassword);
  try {
    final response = await http.post(
      Uri.parse(modifypasswordurl),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "email": email,
        "currentPassword": currentpassword,
        "newPassword": newpassword,
      }),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseBody = jsonDecode(response.body);
      final String message = responseBody['message'];
      msg(message, Colors.green, Icons.check);
    } else if (response.statusCode == 404 || response.statusCode == 400) {
      final String errorMessage = jsonDecode(response.body)['error'];
      msg(errorMessage, Colors.red, Icons.cancel);
    } else {
      print('Error : ${response.statusCode}');
    }
  } catch (error) {
    print('Error : $error');
  }
}

String? validateEmail(String? email) {
  if (email == null || email.isEmpty) {
    return 'Email is required';
  } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email)) {
    return 'Invalid email format';
  }
  else{

    if(checkEmailAvailability(email)==true){
      return 'Used Email';

    }
  }
  return null;
}
Future<int> getnmbruserbyrole(String role) async {
  final apiUrl = getnmbruserurl; 

  try {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'role': role}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['userCount'];
    } else {
      throw Exception('Failed to load user count');
    }
  } catch (error) {
    throw Exception('Error fetching user count: $error');
  }
}