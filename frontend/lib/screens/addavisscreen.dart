import 'package:bridgewearaa/controlleur/aviscontrolleur.dart';
import 'package:bridgewearaa/controlleur/usercontrolleur.dart';
import 'package:bridgewearaa/models/avis.dart';
import 'package:bridgewearaa/screens/signup.dart';
import 'package:bridgewearaa/services/data.dart';
import 'package:bridgewearaa/widget/CustomConfirmation.dart';
import 'package:bridgewearaa/widget/CustomErormsg.dart';
import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:flutter/material.dart';

class addavisscreen extends StatefulWidget {
  final double numberetoile;
  final String idcmd;
  final Function change;
  const addavisscreen({required this.change,super.key,required this.numberetoile, required this.idcmd});

  @override
  State<addavisscreen> createState() => _modifpasswordscreenState();
}

class _modifpasswordscreenState extends State<addavisscreen> {
  @override
  void initState() {
    super.initState();
    ratting=widget.numberetoile;
  }
  TextEditingController password = TextEditingController();
  TextEditingController currentpassword = TextEditingController();

  TextEditingController confirm = TextEditingController();
  String? erormsg;
  String? errormsgp;
  double ratting=0;
  bool loading=false;

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    double screenWidth = mediaQueryData.size.width;
    double screenHeight = mediaQueryData.size.height;
    if(screenWidth>screenHeight){
      double x=screenWidth;
      screenWidth=screenHeight;
      screenWidth=x;
    }
    double fontSize = MediaQuery.of(context).size.shortestSide * 0.05;
    double marginValue = MediaQuery.of(context).size.width * 0.02;
    return Scaffold(
      appBar: AppBar(title: Text("Feed Back",style: TextStyle(color: Colors.black),),centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,),
      body: SingleChildScrollView(
        child: Container(
          child:                           Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding:  EdgeInsets.all(marginValue*2),
                    child: RatingBar(
                      alignment: Alignment.center,
                      initialRating: widget.numberetoile,
                      size: fontSize*2,

                      filledIcon:Icons.star, emptyIcon: Icons.star, onRatingChanged: (double ) {


                    },
                    ),
                  ),

                  Container(


                    child: Padding(
                      padding:  EdgeInsets.all(marginValue),
                      child:                     TextField(
                        controller: password,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: fontSize * 0.7,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                        ),
                        maxLines: 5,
                        decoration: InputDecoration(

                          hintText: "Write here what you think about the seller, what you like",
                          labelStyle: TextStyle(
                            color: erormsg != null ? Colors.red : Colors.grey,
                            fontSize: fontSize * 0.7,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(
                              width: 1,
                              color: Colors.red,
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          errorText: erormsg != null ? erormsg : null,
                          errorStyle: TextStyle(
                            fontSize: fontSize * 0.5,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        onChanged: (value) {
                          // Handle the text change
                        },
                      ),


                    ),

                  ),

                  SizedBox(height: screenHeight*0.01,),

                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                            onPressed: () async {



if(password.text.isEmpty) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                        backgroundColor: Colors.red,
                                        content: Customerrormsg(
                                          icon: Icons.cancel,
                                          message:
                                              'Please complete the required fields or fix the validation error.',
                                          bgcolor: Colors.red,
                                        )));
                              }
else{
  avis a=avis(date: DateTime.now(),description: password.text, idcommand: "idcommand", rating: ratting)
;
  addavis(widget.idcmd, password.text, ratting, (p0, cl) => {
   widget.change(a),

    Navigator.pop(context),
  ScaffoldMessenger.of(context).showSnackBar(
  SnackBar(
  backgroundColor: cl,
  content:                               Customerrormsg(icon: Icons.done,message: "Rating added with success",bgcolor: cl,)

  ))

  });
}
                            },
                            child: Padding(
                              padding: EdgeInsets.all(marginValue * 2),
                              child:Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Text("Submit",style: TextStyle(color: Colors.white,fontSize: fontSize*0.8),),
                                  if(loading)
                                    CircularProgressIndicator(color: Colors.white,)
                                ],
                              ),

                            ),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(Colors.blueAccent),
                              overlayColor: MaterialStateProperty.all<Color>(Colors.transparent),

                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0), // Adjust border radius as needed
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight*0.005,),

                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Padding(
                              padding: EdgeInsets.all(marginValue * 2),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text("Cancel", style: TextStyle(color: Colors.grey, fontSize: fontSize * 0.8)),
                                  if(loading)
                                    CircularProgressIndicator(color: Colors.blueAccent,)
                                ],
                              ),
                            ),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                              overlayColor: MaterialStateProperty.all<Color>(Colors.transparent),
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0), // Adjust border radius as needed
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),


                ],
              ),
            ),
          ),

        ),
      ),

    );
  }
}
