import 'package:bridgewearaa/const/colors.dart';
import 'package:bridgewearaa/controlleur/usercontrolleur.dart';
import 'package:bridgewearaa/screens/emailsendscreen.dart';
import 'package:bridgewearaa/screens/inputs.dart';
import 'package:bridgewearaa/screens/loading.dart';
import 'package:bridgewearaa/screens/signin.dart';
import 'package:bridgewearaa/services/data.dart';
import 'package:bridgewearaa/widget/CustomErormsg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class forgotpasswordscreen extends StatefulWidget {
  const forgotpasswordscreen({super.key});

  @override
  State<forgotpasswordscreen> createState() => _forgotpasswordscreenState();
}

class _forgotpasswordscreenState extends State<forgotpasswordscreen> {
  final TextEditingController _emailController = TextEditingController();
  String? erormsg;
  bool loading=false;
  void updateVerification(String value,Function fn) async {
    setState(() {
      erormsg=fn(value);
    });
  }
  void updateVerification2(String value) async {
    bool result = await checkEmailAvailability(value);
    setState(() {
      if(result){
        erormsg="Wrong Email";
      }else{
        erormsg=validateEmail(value);
      }
    });
  }

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
    return

      Scaffold(
        appBar: AppBar(



        ),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Column(

              children: [

                         Center(
                           child: Padding(
                             padding:  EdgeInsets.all(marginValue*4),
                             child: SvgPicture.asset("assets/icons/forgotpassword3.svg",height: screenHeight*0.25,),
                           ),
                         ),
                SizedBox(height: screenHeight*0.01,)   ,
                Padding(
                  padding:  EdgeInsets.all(marginValue),
                  child: Container(
                      width: screenWidth*0.9,
                      child: Text("Don't worry sometimes people can forgot too . enter your email and we will send you a password reset link .",style: TextStyle(fontSize: fontSize*0.75,fontWeight: FontWeight.w800,color: Colors.grey) )),
                )
                ,
                                   SizedBox(height: screenHeight*0.01,)   ,

                Padding(
                  padding:  EdgeInsets.all(marginValue),
                  child: TextField(
                    obscureText: false,
                    controller: _emailController,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Colors.blueAccent,
                      fontSize: fontSize * 0.7,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                    decoration: InputDecoration(
                      labelText: "E-mail",
                      labelStyle: TextStyle(
                        color: erormsg!=null ? Colors.red : Colors.blueAccent,
                        fontSize: fontSize * 0.7,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                      ),
                      enabledBorder:  OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(
                          width: 1,
                          color:Colors.blueAccent,
                        ),
                      ),

                      prefixIcon: Icon(Icons.send, color:erormsg!=null?Colors.red: Colors.blueAccent,),

                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(
                          width: 1,
                          color:Colors.red,

                        ),

                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(
                          width: 1,
                          color:primary,
                        ),
                      ),
                      errorText: erormsg!=null?erormsg:null,
                      errorStyle: TextStyle(
                        fontSize: fontSize*0.5,
                        fontWeight: FontWeight.w600,
                      ),

                    ),

                    onChanged: (value) {
                      updateVerification2(value);
                    },
                  ),
                )
,
                SizedBox(height: screenHeight*0.02,),

                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          onPressed: () {
                            if((erormsg==""||erormsg==null)&&_emailController.text.isNotEmpty) {
                              setState(() {
                                loading = true;
                              });
                            sendcode(_emailController.text, (msg, cl) => {
                            ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                            backgroundColor: cl,
                            content: Customerrormsg(icon: Icons.check, message: msg, bgcolor: cl),
                            ),
                            )

                            })
                                .then((value) => {
                                      setState(() {
                                        loading = false;
                                      }),
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              emailsendscreen(email:_emailController.text),
                                        ),
                                      )
                                    });
                          } else{
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      backgroundColor: Colors.red,
                                      content:                               Customerrormsg(icon: Icons.cancel_outlined,message:"Required Email !",bgcolor: Colors.red,)

                                  ))
                              ;
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
                                borderRadius: BorderRadius.circular(10.0),
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

      );
  }
}
Future<String?> validateEmail2(String? email)async {
  if (email == null || email.isEmpty) {
    return 'Email is required';
  } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email)) {
    return 'Invalid email format';
  }
  else{
bool? v=await checkEmailAvailability(email);
    if(v==true){
      return 'Used Email';

    }
  }
  return null;
}
