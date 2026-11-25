import 'package:bridgewearaa/screens/buttons.dart';
import 'package:bridgewearaa/widget/CustomErormsg.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ChangeAddress extends StatefulWidget {

  final Function fn;
  const ChangeAddress({super.key, required this.fn});

  @override
  State<ChangeAddress> createState() => _ChangeAdressstate();
}

class _ChangeAdressstate extends State<ChangeAddress> {
  TextEditingController state=TextEditingController();
  TextEditingController street=TextEditingController();
  TextEditingController city=TextEditingController();

  TextEditingController postalcode=TextEditingController();
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
        title: Text("Update Adress",style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,

      ),
      body:
      SingleChildScrollView(

        child: Column(

          children: [

            Center(
                child: SvgPicture.asset("assets/icons/location2.svg",height: screenHeight*0.1,)),
            SizedBox(height: screenHeight*0.02,),
            Container(
              width: screenWidth*0.9,


              child: Padding(
                padding:  EdgeInsets.all(marginValue),
                child:                      TextField(
                  controller: postalcode,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: fontSize * 0.7,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                  ),
                  decoration: InputDecoration(
                    labelText: "Postal Code",
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
                  controller: street,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: fontSize * 0.7,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                  ),
                  decoration: InputDecoration(
                    labelText: "Street",
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

                        controller: city,

                        textAlign: TextAlign.left,

                        style: TextStyle(

                          color: Colors.black,

                          fontSize: fontSize * 0.7,

                          fontFamily: 'Poppins',

                          fontWeight: FontWeight.w400,

                        ),

                        decoration: InputDecoration(

                          labelText: "City",

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

                  Container(

                    width: screenWidth*0.4,




                    child: Padding(

                      padding:  EdgeInsets.all(marginValue),

                      child:                      TextField(

                        controller: state,

                        textAlign: TextAlign.left,

                        style: TextStyle(

                          color: Colors.black,

                          fontSize: fontSize * 0.7,

                          fontFamily: 'Poppins',

                          fontWeight: FontWeight.w400,

                        ),

                        decoration: InputDecoration(

                          labelText: "State",

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
            button(onclick:(){
      if(postalcode.text.isNotEmpty&&state.text.isNotEmpty&&street.text.isNotEmpty&&city.text.isNotEmpty) {
                    this.widget.fn!(
                        state.text, city.text, postalcode.text, street.text);
                  } else{
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                backgroundColor: Colors.red,
                content:                               Customerrormsg(icon: Icons.cancel,message:"Required Data !",bgcolor:Colors.red,)

            ));

      }
            }, color: Colors.blueAccent.withOpacity(0.7), width: screenWidth*0.4, label: "Valid", height: screenHeight*0.05)


          ],
        ),
      ),
    );
  }
}
