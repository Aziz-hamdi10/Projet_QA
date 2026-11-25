import 'package:bridgewearaa/screens/buttons.dart';
import 'package:bridgewearaa/screens/inputs.dart';
import 'package:bridgewearaa/screens/loading.dart';
import 'package:flutter/material.dart';
bool isEmailValid(String email) {
  RegExp emailRegex = RegExp(r"^[a-zA-Z0-9]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  return emailRegex.hasMatch(email)&&email.isNotEmpty;
}
class signin extends StatefulWidget {
  const signin({super.key});

  @override
  State<signin> createState() => _signinState();
}

class _signinState extends State<signin> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    double screenWidth = mediaQueryData.size.width;
    double screenHeight = mediaQueryData.size.height;
    double fontSize = MediaQuery.of(context).size.shortestSide * 0.05;
    double marginValue = MediaQuery.of(context).size.width * 0.02;
    LinearGradient myGradient = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Color.fromRGBO(231, 247, 248, 1), Color.fromRGBO(145, 193, 228, 0.89)], // Replace with your gradient colors
    );

   return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent, // Make AppBar background transparent
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: myGradient,
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.menu,
            color: Colors.black,
            size: 40.0,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Image.asset(
          "images/bridgewear.png",

        ),
        centerTitle: true,
      ),
      body:
      Container(
        height: screenHeight,
        decoration: BoxDecoration(
          gradient: myGradient,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              inputsignin(fontfm: "marvel",input: email, label: "Email", texthover: "Exemple@gmail.com", pass: false),
              inputsignin(fontfm: "",input: password, label: "Mot de passe", texthover: "**************", pass: true),

              Padding(
                padding:  EdgeInsets.all(marginValue),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: GestureDetector(
                    onTap: () {},
                    child: Text(
                      "Forgot Password ?",
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontSize: fontSize,
                        fontFamily: "LALEZAR",
                        color: Colors.black,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ),
              ),
              button(color: Color.fromRGBO(4, 97, 103, 1), width: screenWidth*0.8, label: "Log in", height: screenHeight*0.07)
,
              Padding(
                padding: const EdgeInsets.fromLTRB(0.0,20.0,0,0),
                child: Row(
                  children: [
                    Expanded(
                      child: Divider(
                        color: Colors.black,
                        height: 20,
                        thickness: 2,
                        indent: 20,
                        endIndent: 10, // Adjust the endIndent as needed
                      ),
                    ),
                    Text(
                      'OR',
                      style: TextStyle(
                          fontSize: fontSize,
                          fontWeight: FontWeight.bold,
                          fontFamily: "LALEZAR"
                      ),  maxLines: 1,
                    ),
                    Expanded(
                      child: Divider(
                        color: Colors.black,
                        height: 20,
                        thickness: 2,
                        indent: 10, // Adjust the indent as needed
                        endIndent: 20,
                      ),
                    ),
                  ],
                ),
              ),
              button(color: Color.fromRGBO(158, 161, 123, 0.89), width: screenWidth*0.55, label: "Créer un compte", height: screenHeight*0.07)
              ,

            ],
          ),
        ),
      )

   );

  }
}
