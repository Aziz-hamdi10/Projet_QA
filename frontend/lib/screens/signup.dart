import 'dart:async';
import 'dart:convert';
import 'package:bridgewearaa/config.dart';
import 'package:bridgewearaa/controlleur/usercontrolleur.dart';
import 'package:bridgewearaa/screens/MenuLivreur.dart';
import 'package:bridgewearaa/screens/activateaccoundscreen.dart';
import 'package:bridgewearaa/screens/forgetpassword.dart';
import 'package:bridgewearaa/widget/CustomErormsg.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;

import 'package:bridgewearaa/const/colors.dart';
import 'package:bridgewearaa/screens/accueil.dart';
import 'package:bridgewearaa/screens/buttons.dart';
import 'package:bridgewearaa/screens/inputs.dart';
import 'package:bridgewearaa/screens/loading.dart';
import 'package:bridgewearaa/screens/signin.dart';
import 'package:bridgewearaa/services/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../models/user.dart';

bool isUsernameValid(String username) {
  return username.isNotEmpty && username.length >= 3
  ;
}

bool isEmailValid(String email) {
  RegExp emailRegex = RegExp(r"^[a-zA-Z0-9]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  return emailRegex.hasMatch(email);
}

String? isPasswordValid(String password) {
  return password.isNotEmpty && password.length >= 6?null:"Wrong Password";
}

bool isNameValid(String name) {
  return name.isNotEmpty;
}

bool isPhoneNumberValid(String phoneNumber) {
  RegExp phoneRegex = RegExp(r'^\+216\d{8}$');
  return phoneRegex.hasMatch(phoneNumber);
}

class logiun extends StatefulWidget {
  const logiun({super.key});

  @override
  State<logiun> createState() => _logiunState();
}

class _logiunState extends State<logiun> {
  bool loading=false;
  bool view=true;
  bool eroremail=false;
  bool erorpassword=false;
  String errormsg="";
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
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
      backgroundColor: bgcolorprimary,
      body: SingleChildScrollView(
        child:Stack(
          children: [

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [




                Container(
                  decoration: BoxDecoration(
                      color:primarytheme,

                      borderRadius: BorderRadius.only(bottomRight: Radius.circular(500))
                  ),
                  child: Center(
                    child: Image.asset(
                      "images/BridgeWear5.png"
                      ,
                      height: screenHeight*0.45,
                      width:screenWidth ,
                                   ),
                  ),
                ),
                const SizedBox(
                  height: 18,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: Column(
                    textDirection: TextDirection.ltr,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       Text(
                        'Log In',
                        style: TextStyle(
                          color:primarytheme,
                          fontSize: fontSize,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                       SizedBox(
                        height: screenHeight*0.05,
                      ),
                      inputlogin(verif: isEmailValid,
                       errmsg: "Wrong  Email",cl:primarytheme,icon: Icons.email,input: _emailController, label: "E-mail", pass: false,change: null)
                       ,SizedBox(
                        height: screenHeight*0.02,
                      ),
                      inputlogin(errmsg: "Wrong password",cl:primary,icon: Icons.lock,input: _passController, label: "Password", pass: view,change:(){
                        setState(() {
                          view=!view;
                        });
                      }),
                      SizedBox(
                        height: screenHeight*0.02,
                      ),
                      if(errormsg.isNotEmpty)
                      Center(
                        child: Text(errormsg,style: TextStyle(fontSize: fontSize*0.7,color: Colors.red),),
                      ),

                      SizedBox(
                        height: screenHeight*0.02,
                      ),
                      Center(
                        child: ClipRRect(
                          borderRadius: const BorderRadius.all(Radius.circular(10)),
                          child: SizedBox(
                            width: screenWidth*0.5,
                            height: screenHeight*0.08,
                            child: ElevatedButton(
                              onPressed: () {
    if (_emailController.text.isEmpty || _emailController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              backgroundColor: Colors.red,
              content:                               Customerrormsg(icon: Icons.cancel_outlined,message:"Required Data !",bgcolor: Colors.red,)

          ))
      ;
    } else {
      setState(() {
        loading=true;
      });
      login(_emailController.text, _emailController.text, _passController.text, (errorMessage) {
        setState(() {
          loading=true;

          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  backgroundColor: Colors.red,
                  content:                               Customerrormsg(icon: Icons.cancel_outlined,message:errorMessage,bgcolor: Colors.red,)

              ));
        });
      },(user,token) async {


        if(user['state']=="notActive"){

          await sendcode(user['email'], (errorMessage, cl) {
            setState(() {
              loading=true;

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: cl,
                  content: Customerrormsg(icon: Icons.check, message: errorMessage, bgcolor: cl),
                ),
              );
            });
          },).then((value) => {
            loading=false,
          Navigator.push(
          context,
          MaterialPageRoute(
          builder: (context) => activateaccountscreen(email:user['email']),
          ),
          )
          });

        }
        else
        if((user['state']=="Blocked")){
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  backgroundColor: Colors.red,
                  content:                               Customerrormsg(icon: Icons.cancel_outlined,message:"Account Blocked !",bgcolor: Colors.red,)

              ));
          setState(() {
            loading=false;
          });
        }
        else
        {
          setState(() {
            saveTokenToSharedPreferences(token);

            context.read<DataService>().user=User.fromJson(user);
            context.read<DataService>().token=token;
          });

          Navigator.popUntil(
            context,
                (route) => route.isFirst,
          );

          if(user['role'] == "delievry"){
            GoRouter.of(context).go(
                '/'); // Navigate to the root route

            GoRouter.of(context).pushReplacement(
                '/menulivreur/' + token);
          }
          else {
        if(user['role'] == "client")
        {
                                          GoRouter.of(context).go(
                                              '/'); // Navigate to the root route

                                          GoRouter.of(context).pushReplacement(
                                              '/accueil/' + token);
                                        }
        else{
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.red,
              content: Customerrormsg(icon: Icons.check, message: "Wrong Email !", bgcolor: Colors.red),
            ),
          );
        }
                                      }
                                      }

      }).then((value) =>{
        loading=false
      });

    }


                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor:primarytheme,
                              ),
                              child:  Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    'Sign In',
                                    style: TextStyle(
                                      color:bgcolorprimary,
                                      fontSize: fontSize*0.7,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  if(loading)
                                  CircularProgressIndicator(color: Colors.white,),

                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                       SizedBox(
                        height: screenHeight*0.02,
                      ),
                      Row(
                        children: [
                           Text(
                            'Don’t have an account?',
                            style: TextStyle(
                              color: bgcolorsecondary,
                              fontSize: fontSize*0.6,
                              fontFamily: 'Poppins',
                            ),
                          ),
                           SizedBox(
                            width: screenWidth*0.01,
                          ),
                          InkWell(
                            onTap: () {
                              GoRouter.of(context).push('/signup');
                            },
                            child:  Text(
                              'Sign Up',
                              style: TextStyle(
                                color:primary,
                                fontSize: fontSize*0.6,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                       SizedBox(
                        height: screenHeight*0.01,
                      ),
                       InkWell(
                         onTap: (){
                           Navigator.push(
                             context,
                             MaterialPageRoute(
                               builder: (context) => forgotpasswordscreen(),
                             ),
                           );

                         },
                         child: Text(
                          'Forget Password?',
                          style: TextStyle(
                            color: bgcolorsecondary,
                            fontSize: fontSize*0.55,
                            fontFamily: 'Poppins',
                          ),
                      ),
                       ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ) ,
      )
      ,
    );
  }
}

class signupscroll extends StatefulWidget {
  final String email;
  final int position;
  const signupscroll({super.key, this.email="",this.position=0});
  @override
  _signupscrollsState createState() => _signupscrollsState();
}

class _signupscrollsState extends State<signupscroll> {
   PageController _pageController=PageController(initialPage: 0);
  int _currentPageIndex = 0;
  User user=User(id: "",firstname: "", secondname: "", email: "", phone: "", picture: "", password: "",role: "client");
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _currentPageIndex = widget.position;

      email.text = widget.email;
    });
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

  Future<void> _onItemTapped(int index) async {
    bool canNavigate = false;

    switch (_currentPageIndex) {
      case 0:
          if(isEmailValid(email.value.text)&&isPasswordValid(password.value.text)==null&&isPasswordValid(confirm.value.text)==null&&password.text==confirm.text){
          canNavigate = true;
          user.password=password.text;

        }
        else{

           canNavigate = false;

        }
        break;
      case 1:
        if(isEmailValid(email.value.text)&&isNameValid(nom.value.text)&&isNameValid(prenom.value.text)&&isPhoneNumberValid(phone.value.text)&&password.text==confirm.text){
    user.email = email.text;
    user.firstname = nom.text;
    user.secondname = prenom.text;
    user.phone = phone.text;
    setState(() {
      loading=true;

    });
          await registerUser(user, (errorMessage, cl) {
            setState(() {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: cl,
                  content: Customerrormsg(icon: Icons.check, message: errorMessage, bgcolor: cl),
                ),
              );
            });
          },).then((value) => {
loading=false,
              canNavigate = true,
          });

        }
        else{
          canNavigate = false;

        }
      case 2:
        canNavigate = true;
        break;
    }

    if (canNavigate) {
      _pageController.animateToPage(
        index,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              backgroundColor: Colors.red,
              content:                               Customerrormsg(icon: Icons.cancel,message:'Please complete the required fields or fix the validation error.',bgcolor: Colors.red,)

          ))
      ;

    }
  }


  String? validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return 'Password is required';
    } else if (password.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    return null;
  }
  bool validatePassword2(String? password) {
    if (password == null || password.isEmpty) {
      return false;
    } else if (password.length < 6) {
      return false;
    }
    return true;
  }

  String? validateConfirmPassword(String? confirmPassword, ) {
    if (confirmPassword == null || confirmPassword.isEmpty) {
      return 'Confirm Password is required';
    } else if (confirmPassword != password.text) {
      return 'Passwords do not match';
    }
    return null;
  }
  String? erormsg;
  void updateVerification(String value,Function fn) async {
    setState(() {
      erormsg=fn(value);
    });
  }
  String? validatename(String? name) {
    if (name == null || name.isEmpty) {
      return 'name is required';
    } else if (name.length < 6) {
      return 'name must be at least 6 characters long';
    }
    return null;
  }

  TextEditingController nom = TextEditingController();
  TextEditingController prenom = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController pic = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirm = TextEditingController();
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

      body: PageView(
        controller: _pageController,
        onPageChanged: _onPageChanged,
        physics: NeverScrollableScrollPhysics(),

        children: [
          Container(
              color: bgcolorprimary,
              child: SingleChildScrollView(
                child:
                Column(

                  children: [

                   Container(

                     child: Image.asset(
                          "images/BridgeWear6.png",
                          height: screenHeight*0.5,
                          width: screenWidth,
                        ),
                   ),


                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      child: Column(

                        textDirection: TextDirection.ltr,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Sign up',
                            style: TextStyle(
                              color:primarytheme,
                              fontSize: fontSize,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            height: screenHeight*0.05,
                          ),
                          inputsignup(errmsg2:"Used Email !" ,errmsg:validateEmail ,verif:checkEmailAvailability,cl:primarytheme,input: email, label: "Email", pass: false),
                          SizedBox(
                            height: screenHeight*0.03,
                          ),
                          Row(
                            children: [
                              Expanded(child:
                              TextField(
                                obscureText: true,
                                controller: password,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  color: primary,
                                  fontSize: fontSize * 0.7,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w400,
                                ),
                                decoration: InputDecoration(
                                  labelText: "Password",
                                  labelStyle: TextStyle(
                                    color: erormsg!=null ? Colors.red : primary,
                                    fontSize: fontSize * 0.7,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w600,
                                  ),
                                  enabledBorder:  OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                    borderSide: BorderSide(
                                      width: 1,
                                      color:primary,
                                    ),
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
                                  updateVerification(value,validatePassword);
                                },
                              )
                              ),
                              SizedBox(width: screenWidth*0.05,),
                              Expanded(child:

                              TextField(
                                obscureText: true,
                                controller: confirm,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  color: primary,
                                  fontSize: fontSize * 0.7,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w400,
                                ),
                                decoration: InputDecoration(
                                  labelText: "Confirm Password",
                                  labelStyle: TextStyle(
                                    color: erormsg!=null ? Colors.red : primary,
                                    fontSize: fontSize * 0.7,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w600,
                                  ),
                                  enabledBorder:  OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                    borderSide: BorderSide(
                                      width: 1,
                                      color:primary,
                                    ),
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
  updateVerification(value,validateConfirmPassword);
                                },
                              )
                              )

                            ],
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
                                      _onItemTapped(1);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:primarytheme,
                                    ),
                                    child:  Text(
                                      'Next ',
                                      style: TextStyle(
                                        color: bgcolorprimary,
                                        fontSize: fontSize*0.7,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w500,
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

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,

                            children: [
                               Text(
                                'Already Have an account ?',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: fontSize*0.6,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                              SizedBox(
                                width: screenWidth*0.01,
                              ),
                              InkWell(
                                onTap: () {
    GoRouter.of(context).push('/login');
                                },
                                child:  Text(
                                  'Login',
                                  style: TextStyle(
                                    color:primarytheme,
                                    fontSize: fontSize*0.6,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),


                        ],
                      ),
                    ),
                  ],
                ),
              )
          ),
          Container(
              color:primary,
              child: SingleChildScrollView(
                child:
                Column(

                  children: [

                    Padding(
                      padding: const EdgeInsets.only(top: 0),
                      child: Image.asset(
                        "images/BridgeWear5.png",
                        height: screenHeight*0.5,
                        width: screenWidth,
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      child: Column(

                        textDirection: TextDirection.ltr,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Step 2 of 3',
                            style: TextStyle(
                              color: bgcolorprimary,
                              fontSize: fontSize,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            'Please enter your data!',
                            style: TextStyle(
                              color: bgcolorprimary,
                              fontSize: fontSize*0.5,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            height: screenHeight*0.03,
                          ),
                          Row(
                            children: [
                              Expanded(child:
                              inputsignup(errmsg2:" at least 5 characters" ,errmsg:validatename,verif: isNameValid,cl:bgcolorprimary,input: nom, label: "First Name", pass: false),
                              ),
                              SizedBox(width: screenWidth*0.05,),
                              Expanded(child: inputsignup(errmsg2: " at least 5 characters",errmsg:validatename,verif: isNameValid,cl: bgcolorprimary,input: prenom,label: "Second Name",pass: false,),)

                            ],
                          ),
                          SizedBox(
                            height: screenHeight*0.03,
                          ),
                          Row(
                            children: [
                              Expanded(child:
                              inputsignup(errmsg2: "Phone need to be +216 00-000-000",errmsg:validatename,verif: isPhoneNumberValid,cl:bgcolorprimary,input: phone, label: "Phone", pass: false),
                              ),

                            ],
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
                                      if(!loading){
                                      _onItemTapped(2);
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: bgcolorprimary,
                                    ),
                                    child:  Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        Text(
                                          'Continuer ',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: fontSize*0.7,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        if(loading)
                                        CircularProgressIndicator(color: primary,),
                                      ],
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


              )
          ),
          Container(
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
                      padding: const EdgeInsets.symmetric(horizontal: 20),
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
                              Text('We will send a 6 digit code to '+ email.text ,
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
                                width: screenWidth*0.12,
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
                            activateUser(email.value.text,getAllControllerValues(_controllers), (msg, cl, icon) =>{
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
                                builder: (context) => logiun(),
                              ),
                            )
                              }
                            });
                                                                           },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:primarytheme,
                                    ),
                                    child:  Text(
                                      'Valider',
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
        ],
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(16.0),
        color: _currentPageIndex==1?primarytheme:bgcolorprimary,
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
String getAllControllerValues(List<TextEditingController> controllers) {
  String values = "";
  for (TextEditingController controller in controllers) {
    values+=controller.text;
  }
  return values;
}