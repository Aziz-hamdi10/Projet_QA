import 'package:bridgewearaa/controlleur/usercontrolleur.dart';
import 'package:bridgewearaa/screens/signup.dart';
import 'package:bridgewearaa/services/data.dart';
import 'package:bridgewearaa/widget/CustomConfirmation.dart';
import 'package:bridgewearaa/widget/CustomErormsg.dart';
import 'package:flutter/material.dart';

class modifpasswordscreen extends StatefulWidget {
  final String email;
  final bool oldpassword;
  const modifpasswordscreen({super.key,required this.email,this.oldpassword=false});

  @override
  State<modifpasswordscreen> createState() => _modifpasswordscreenState();
}

class _modifpasswordscreenState extends State<modifpasswordscreen> {
  TextEditingController password = TextEditingController();
  TextEditingController currentpassword = TextEditingController();

  TextEditingController confirm = TextEditingController();
  String? erormsg;
  String? errormsgp;

  bool loading=false;
  void updateVerification(String value,Function fn) async {
    setState(() {
      erormsg=fn(value);
    });
  }

  void updateVerificationpassword(String email,String password) async {
    bool result = await checkpassword(email,password);

    setState(() {
if(result){

  errormsgp=null;
}
else{
  errormsgp="Wrong password";
}
});
  }
  String? validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return 'Password is required';
    } else if (password.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    return null;
  }
  String? validateConfirmPassword(String? confirmPassword, ) {
    if (confirmPassword == null || confirmPassword.isEmpty) {
      return 'Confirm Password is required';
    } else if (confirmPassword != password.text) {
      return 'Passwords do not match';
    }
    return null;
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
    return Scaffold(
      appBar: AppBar(title: Text("Modif Password",style: TextStyle(color: Colors.black),),centerTitle: true,
      elevation: 0,
      backgroundColor: Colors.white,),
      body: Container(
            child:                           Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if(widget.oldpassword)
                    Container(
                      width: screenWidth*0.9,


                      child: Padding(
                        padding:  EdgeInsets.all(marginValue),
                        child:                      TextField(
                          controller: currentpassword,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: fontSize * 0.7,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                          ),
                          obscureText: true,

                          decoration: InputDecoration(
                            labelText: "Current Password",
                            labelStyle: TextStyle(
                              color: errormsgp!=null ? Colors.red : Colors.grey,
                              fontSize: fontSize * 0.7,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                            ),



                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(
                                width: 1,
                                color:Colors.red,

                              ),

                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10)),

                            ),
                            errorText: errormsgp!=null?errormsgp:null,
                            errorStyle: TextStyle(
                              fontSize: fontSize*0.5,
                              fontWeight: FontWeight.w600,
                            ),

                          ),

                          onChanged: (value) {
                            updateVerificationpassword(widget.email,value);
                          },

                        ),

                      ),

                    ),
                    if(widget.oldpassword)
                      SizedBox(width: screenWidth*0.1,),
                    Container(
                      width: screenWidth*0.9,


                      child: Padding(
                        padding:  EdgeInsets.all(marginValue),
                        child:                      TextField(
                          controller: password,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: fontSize * 0.7,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                          ),
                          obscureText: true,

                          decoration: InputDecoration(
                            labelText: "New Password",
                            labelStyle: TextStyle(
                              color: erormsg!=null ? Colors.red : Colors.grey,
                              fontSize: fontSize * 0.7,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                            ),



                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(
                                width: 1,
                                color:Colors.red,

                              ),

                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10)),

                            ),
                            errorText: erormsg!=null?erormsg:null,
                            errorStyle: TextStyle(
                              fontSize: fontSize*0.5,
                              fontWeight: FontWeight.w600,
                            ),

                          ),

                          onChanged: (value) {
                            updateVerification(value,validatePassword);
                          },

                        ),

                      ),

                    ),
                    SizedBox(width: screenWidth*0.1,),


                    Container(
                      width: screenWidth*0.9,


                      child: Padding(
                        padding:  EdgeInsets.all(marginValue),
                        child:                      TextField(
                          controller: confirm,
                          obscureText: true,

                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: fontSize * 0.7,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                          ),
                          decoration: InputDecoration(
                            labelText: "Confirm New Password",
                            labelStyle: TextStyle(
                              color: erormsg!=null ? Colors.red : Colors.grey,
                              fontSize: fontSize * 0.7,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                            ),



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
                              ),
                            ),
                            errorText: erormsg!=null?erormsg:null,
                            errorStyle: TextStyle(
                              fontSize: fontSize*0.5,
                              fontWeight: FontWeight.w600,
                            ),

                          ),

                          onChanged: (value) {
                            updateVerification(value,validateConfirmPassword);
                          },

                        ),

                      ),

                    ),

                    SizedBox(height: screenHeight*0.02,),

                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
                              onPressed: () async {
                                if(!widget.oldpassword)
                                if(isPasswordValid(password.value.text)==null&&isPasswordValid(confirm.value.text)==null&&password.text==confirm.text){
                                  fogetpassword(
                                  widget.email,
                                  password.text,
                                  (msg, cl, icon) => {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                backgroundColor: cl,
                                                content: Customerrormsg(
                                                  icon: icon,
                                                  message: msg,
                                                  bgcolor: cl,
                                                ))),
                                        if (cl == Colors.green)
                                          {
                                            Navigator.popUntil(
                                              context,
                                              (route) => route.isFirst,
                                            ),
                                            Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => logiun(),
                                              ),
                                            )
                                          }
                                        else
                                          {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                                    backgroundColor: cl,
                                                    content: Customerrormsg(
                                                      icon: icon,
                                                      message: msg,
                                                      bgcolor: cl,
                                                    ))),
                                          }
                                      });
                            }
                                else{
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          backgroundColor: Colors.red,
                                          content:                               Customerrormsg(icon: Icons.cancel,message:'Please complete the required fields or fix the validation error.',bgcolor: Colors.red,)

                                      ))
                                  ;

                                }
                                else{
                                  if(await checkpassword(widget.email, currentpassword.text)&&isPasswordValid(password.value.text)==null&&isPasswordValid(confirm.value.text)==null&&password.text==confirm.text){

                                    customconfimation(context, 'Confirmation', 'Are you sure you Modify your password?', () {
                                      Navigator.pop(context);
                                      modifypassword(
                                          widget.email,
                                          currentpassword.text,
                                          password.text,

                                              (msg, cl, icon) => {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                                backgroundColor: cl,
                                                content: Customerrormsg(
                                                  icon: icon,
                                                  message: msg,
                                                  bgcolor: cl,
                                                ))),
                                            if (cl == Colors.green)
                                              {
                                                Navigator.pop(context)
                                              }
                                            else
                                              {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(SnackBar(
                                                    backgroundColor: cl,
                                                    content: Customerrormsg(
                                                      icon: icon,
                                                      message: msg,
                                                      bgcolor: cl,
                                                    ))),
                                              }
                                          });                                    },Colors.blueAccent);
                                  }
                                  else{
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            backgroundColor: Colors.red,
                                            content:                               Customerrormsg(icon: Icons.cancel,message:'Please complete the required fields or fix the validation error.',bgcolor: Colors.red,)

                                        ))
                                    ;

                                  }
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

    );
  }
}
