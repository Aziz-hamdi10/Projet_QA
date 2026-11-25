import 'package:bridgewearaa/screens/buttons.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class debitcardscreen extends StatefulWidget {
  final double price;
  final Function? fn;
  const debitcardscreen({super.key,required this.price, required this.fn});

  @override
  State<debitcardscreen> createState() => _debitcardscreenState();
}

class _debitcardscreenState extends State<debitcardscreen> {
  TextEditingController nameonethecard=TextEditingController();
  TextEditingController cardnumber=TextEditingController();
  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    double screenWidth = mediaQueryData.size.width;
    double screenHeight = mediaQueryData.size.height;
    double fontSize = MediaQuery.of(context).size.shortestSide * 0.05;
    double marginValue = MediaQuery.of(context).size.width * 0.02;
    return Scaffold(
      appBar:
      AppBar(
        title: Text("Credit/Debit Card",style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,

      ),
      body:
      SingleChildScrollView(

        child: Column(

          children: [

            Center(
                child: SvgPicture.asset("assets/icons/paiment.svg",height: screenHeight*0.1,)),
            SizedBox(height: screenHeight*0.02,),
            Container(
              width: screenWidth*0.9,


              child: Padding(
                padding:  EdgeInsets.all(marginValue),
                child:                      TextField(
                  controller: nameonethecard,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: fontSize * 0.7,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                  ),
                  decoration: InputDecoration(
                    labelText: "Name On The Card",
                    labelStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: fontSize *0.7,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                    ),

                    focusedBorder: InputBorder.none,
                    // Set errorText and errorBorder based on the validation result
                    errorStyle: TextStyle(
                      fontSize: fontSize*0.5,
                      fontWeight: FontWeight.w600,
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(
                        width: screenWidth * 0.003,
                        color: Colors.red,
                      ),
                    ),
                  ),


                ),

              ),

            ),
            SizedBox(height: screenHeight*0.01,),

            Container(
              width: screenWidth*0.9,


              child: Padding(
                padding:  EdgeInsets.all(marginValue),
                child:                      TextField(
                  controller: cardnumber,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: fontSize * 0.7,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                  ),
                  decoration: InputDecoration(
                    labelText: "Card Number",
                    labelStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: fontSize * 0.7,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                    ),

                    focusedBorder: InputBorder.none,
                    // Set errorText and errorBorder based on the validation result
                    errorStyle: TextStyle(
                      fontSize: fontSize*0.5,
                      fontWeight: FontWeight.w600,
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(
                        width: screenWidth * 0.003,
                        color: Colors.red,
                      ),
                    ),
                  ),


                ),

              ),

            ),
            SizedBox(height: screenHeight*0.01,),

            Container(
              width: screenWidth*0.9,

              child:   Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [

                  Container(

                    width: screenWidth*0.4,




                    child: Padding(

                      padding:  EdgeInsets.all(marginValue),

                      child:                      TextField(

                        controller: cardnumber,

                        textAlign: TextAlign.left,

                        style: TextStyle(

                          color: Colors.black,

                          fontSize: fontSize * 0.7,

                          fontFamily: 'Poppins',

                          fontWeight: FontWeight.w400,

                        ),

                        decoration: InputDecoration(

                          labelText: "Card Number",

                          labelStyle: TextStyle(

                            color: Colors.grey,

                            fontSize: fontSize * 0.7,

                            fontFamily: 'Poppins',

                            fontWeight: FontWeight.w600,

                          ),



                          focusedBorder: InputBorder.none,


                          errorStyle: TextStyle(

                            fontSize: fontSize*0.5,

                            fontWeight: FontWeight.w600,

                          ),

                          errorBorder: OutlineInputBorder(

                            borderRadius: BorderRadius.all(Radius.circular(10)),

                            borderSide: BorderSide(

                              width: screenWidth * 0.003,

                              color: Colors.red,

                            ),

                          ),

                        ),





                      ),



                    ),



                  ),

                  Container(

                    width: screenWidth*0.4,




                    child: Padding(

                      padding:  EdgeInsets.all(marginValue),

                      child:                      TextField(

                        controller: cardnumber,

                        textAlign: TextAlign.left,

                        style: TextStyle(

                          color: Colors.black,

                          fontSize: fontSize * 0.7,

                          fontFamily: 'Poppins',

                          fontWeight: FontWeight.w400,

                        ),

                        decoration: InputDecoration(

                          labelText: "Card Number",

                          labelStyle: TextStyle(

                            color: Colors.grey,

                            fontSize: fontSize * 0.7,

                            fontFamily: 'Poppins',

                            fontWeight: FontWeight.w700,

                          ),



                          focusedBorder: InputBorder.none,

                          // Set errorText and errorBorder based on the validation result

                          errorStyle: TextStyle(

                            fontSize: fontSize*0.5,

                            fontWeight: FontWeight.w600,

                          ),

                          errorBorder: OutlineInputBorder(

                            borderRadius: BorderRadius.all(Radius.circular(10)),

                            borderSide: BorderSide(

                              width: screenWidth * 0.003,

                              color: Colors.red,

                            ),

                          ),

                        ),





                      ),



                    ),



                  ),



                ],

              ),
            ),
            button(onclick: this.widget.fn, color: Colors.blueAccent.withOpacity(0.7), width: screenWidth*0.4, label: "Valid", height: screenHeight*0.05)


          ],
        ),
      ),
    );
  }
}
