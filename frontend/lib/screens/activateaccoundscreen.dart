import 'package:bridgewearaa/const/colors.dart';
import 'package:bridgewearaa/controlleur/usercontrolleur.dart';
import 'package:bridgewearaa/models/user.dart';
import 'package:bridgewearaa/screens/accueil.dart';
import 'package:bridgewearaa/screens/loadingscreen.dart';
import 'package:bridgewearaa/screens/signup.dart';
import 'package:bridgewearaa/widget/CustomErormsg.dart';
import 'package:flutter/material.dart';

class activateaccountscreen extends StatefulWidget {
  final String email;
  const activateaccountscreen({super.key, this.email=""});
  @override
  _activateaccountscreenstate createState() => _activateaccountscreenstate();
}

class _activateaccountscreenstate extends State<activateaccountscreen> {
  late PageController _pageController;
  int _currentPageIndex = 0;
  User user=User(id: "",firstname: "", secondname: "", email: "", phone: "", picture: "", password: "",role: "client");
  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentPageIndex);
  }
  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentPageIndex = index;
    });
  }


  String getAllControllerValues(List<TextEditingController> controllers) {
    String values = "";
    for (TextEditingController controller in controllers) {
      values+=controller.text;
    }
    return values;
  }

  List<TextEditingController> _controllers = List.generate(6, (index) => TextEditingController());
  FocusNode _currentFocusNode = FocusNode();
  bool loading=false;
  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    double screenWidth = mediaQueryData.size.width;
    double screenHeight = mediaQueryData.size.height;
    double fontSize = MediaQuery.of(context).size.shortestSide * 0.06;
    double marginValue = MediaQuery.of(context).size.width * 0.02;

    return Scaffold(

      body:  Container(
        color: bgcolorprimary,
        child: Center(
          child: SingleChildScrollView(
            child:
            Column(

              children: [

                Padding(
                    padding: const EdgeInsets.only(top: 0),
                    child: Container(
                      height: screenHeight*0.5,
                      child:   Image.asset(
                        "images/step333.png",
                        height: screenHeight*0.2,
                        width: screenWidth*0.6,

                      ),
                    )

                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: Column(

                    textDirection: TextDirection.ltr,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Confirmer Your Email',
                            style: TextStyle(
                              color:primarytheme,
                              fontSize: fontSize*0.7,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: screenHeight*0.005,
                      ),
                      Row(
                        children: [
                          Text('We will send a 6 digit code to '+ widget.email ,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: fontSize*0.45,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text('X-X-X-X-X-X',
                            style: TextStyle(
                              color:primarytheme,
                              fontSize: fontSize*0.45,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(
                        height: screenHeight*0.03,
                      ),
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
                      SizedBox(
                        height: screenHeight*0.03,
                      ),

                      Row(
                        children: [
                          Expanded(child: ClipRRect(
                            borderRadius: const BorderRadius.all(Radius.circular(10)),
                            child: SizedBox(
                              height: screenHeight*0.08,
                              child: ElevatedButton(
                                onPressed: () {
                                  activateUser(widget.email,getAllControllerValues(_controllers), (msg, cl, icon) =>{
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            backgroundColor: cl,
                                            content:                               Customerrormsg(icon: icon,message:msg,bgcolor:cl,)

                                        )),
                                    if(cl==Colors.green){

                                      Navigator.popUntil(
                                        context,
                                            (route) => route.isFirst,
                                      ),
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => loadingscreen(),
                                        ),
                                      )
                                    }
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:primarytheme,
                                ),
                                child:  Text(
                                  'Valider ',
                                  style: TextStyle(
                                    color: bgcolorprimary,
                                    fontSize: fontSize*0.7,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                          ),),
                        ],
                      )
                      ,
                      SizedBox(
                        height: screenHeight*0.02,
                      ),



                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(16.0),
        color: bgcolorprimary,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            3,
                (index) => GestureDetector(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 4.0),
                width: screenWidth * 0.05,
                height: screenHeight * 0.01,

                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _currentPageIndex == index ? index!=1?primarytheme:Colors.black : Colors.grey,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}