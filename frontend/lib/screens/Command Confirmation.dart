import 'package:bridgewearaa/models/commande.dart';
import 'package:bridgewearaa/models/product.dart';
import 'package:bridgewearaa/screens/accueil.dart';
import 'package:bridgewearaa/screens/bag.dart';
import 'package:bridgewearaa/screens/buttons.dart';

import 'package:bridgewearaa/services/data.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class commandconfirmation extends StatefulWidget {

  const commandconfirmation({super.key});
  @override
  State<commandconfirmation> createState() => _commandconfirmationstate();
}

class _commandconfirmationstate extends State<commandconfirmation> {
  TextEditingController codepromo=TextEditingController();
  int index=0;

  @override
  Widget build(BuildContext context) {
    // Set the color of the status bar
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ));
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    double screenWidth = mediaQueryData.size.width;
    double screenHeight = mediaQueryData.size.height;
    double fontSize = MediaQuery.of(context).size.shortestSide * 0.05;
    double marginValue = MediaQuery.of(context).size.width * 0.02;
    List<commande> listcommande=context.read<DataService>().listcommandes;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            SvgPicture.asset("assets/icons/livraison.svg",height:
            screenHeight*0.3,),
            SizedBox(height: screenHeight*0.02,),

            Container(
              width: screenWidth*0.6,
              child: Column(
                children: [
                  Text("Your Order has been succesful",style: TextStyle(
                      fontSize: fontSize*0.8,
                      fontWeight: FontWeight.bold
                  ),),
                  SizedBox(height: screenHeight*0.01,),

                  Text( textAlign: TextAlign.center,"Thank you for the order you have made, we will contact you as soon as possible to confirm your command .",style: TextStyle(
                      fontSize: fontSize*0.65,
                      fontWeight: FontWeight.w400
                  ),),
                  SizedBox(height: screenHeight*0.02,),

                  SizedBox(
                    width: screenWidth*0.55,
                    height: screenHeight*0.05,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => bag()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                      ),
                      child:  Text(
                        'Track Order',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: fontSize*0.7,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight*0.02,),

                  SizedBox(
                    width: screenWidth*0.4,
                    height: screenHeight*0.05,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.popUntil(context, (route) => route.isFirst);
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => accueil()),
                        );
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                        side: MaterialStateProperty.all<BorderSide>(
                          BorderSide(color: Colors.blueAccent, width: 1.0),
                        ),
                        // Other style properties can be modified as needed
                      ),
                      child:  Text(
                        'Continue Shopping',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.blueAccent,
                          fontSize: fontSize*0.7,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );

  }
}
