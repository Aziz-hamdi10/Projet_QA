import 'package:bridgewearaa/const/colors.dart';
import 'package:bridgewearaa/controlleur/usercontrolleur.dart';
import 'package:bridgewearaa/screens/inputs.dart';
import 'package:bridgewearaa/screens/modifpasswordscreen.dart';
import 'package:bridgewearaa/screens/signin.dart';
import 'package:bridgewearaa/screens/signup.dart';
import 'package:bridgewearaa/services/data.dart';
import 'package:bridgewearaa/widget/CustomErormsg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class emailsendscreen extends StatefulWidget {
  final String email;
  const emailsendscreen({super.key,required this.email});

  @override
  State<emailsendscreen> createState() => emailsendscreenstate();
}

class emailsendscreenstate extends State<emailsendscreen> {
  List<TextEditingController> _controllers = List.generate(6, (index) => TextEditingController());
  FocusNode _currentFocusNode = FocusNode();

  String? erormsg;
  bool loading=false;
  void updateVerification(String value,Function fn) async {
    setState(() {
      erormsg=fn(value);
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
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Padding(
                    padding: EdgeInsets.all(marginValue * 2),
                    child: SvgPicture.asset("assets/icons/emailsended.svg", height: screenHeight * 0.25),
                  ),
                ),
                SizedBox(height: screenHeight * 0.01),
                Padding(
                  padding: EdgeInsets.all(marginValue),
                  child: Container(
                    width: screenWidth * 0.9,
                    child: Text("Password Reset Email Sent", textAlign: TextAlign.center,style: TextStyle(fontSize: fontSize*1.1,fontWeight: FontWeight.bold),), // Align text in the center
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(marginValue),
                  child: Container(
                    width: screenWidth * 0.9,
                    child: Text(
                      "Your account Security is Our Priority! We've sent You a Secure Link to Safety Change Your Password and Keep Your Acconut Protected.",
                      textAlign: TextAlign.center, // Align text in the center
                      style: TextStyle(fontSize: fontSize * 0.75, fontWeight: FontWeight.w800, color: Colors.grey),
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(
                    6,
                        (index) => SizedBox(
                      width: screenWidth*0.1,
                      child: TextField(
                        controller: _controllers[index],
                        focusNode: index == 0 ? _currentFocusNode : null,
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        maxLength: 1,
                        onChanged: (value) {
                          if (value.isNotEmpty && index < 5) {
                            FocusScope.of(context).nextFocus();
                          } else if (value.isEmpty && index > 0) {
                            FocusScope.of(context).previousFocus();
                          }
                        },
                        decoration: InputDecoration(
                          counterText: '',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: screenHeight * 0.02),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          onPressed: () {
      activateUser(widget.email,getAllControllerValues(_controllers), (msg, cl, icon) =>
      {

        if(cl==Colors.green){
        showModalBottomSheet(
        context: context,

        builder: (context) =>modifpasswordscreen(email: widget.email,)

        // Without invoking the function

      ),
        }else{
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  backgroundColor: cl,
                  content:                               Customerrormsg(icon: icon,message:msg,bgcolor:cl,)

              )),
        }
      });

                          },
                          child: Padding(
                            padding: EdgeInsets.all(marginValue * 2),
                            child: Text("Done", style: TextStyle(color: Colors.white, fontSize: fontSize * 0.8)),
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
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              loading=true;
                            });
                            sendcode(widget.email, (msg, cl) => {
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
                            });                          },
                          child: Padding(
                            padding: EdgeInsets.all(marginValue * 2),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text("Resend Email", style: TextStyle(color: Colors.grey, fontSize: fontSize * 0.8)),
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


      );
  }
}
