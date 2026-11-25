import 'package:bridgewearaa/Webpart/constaints.dart';
import 'package:bridgewearaa/Webpart/pages/userscreen.dart';
import 'package:bridgewearaa/Webpart/widgets/colorsscreen.dart';
import 'package:bridgewearaa/config.dart';
import 'package:bridgewearaa/const/colors.dart';
import 'package:bridgewearaa/controlleur/colorcontrolleur.dart';
import 'package:bridgewearaa/controlleur/usercontrolleur.dart';
import 'package:bridgewearaa/models/size.dart';
import 'package:bridgewearaa/models/user.dart';
import 'package:bridgewearaa/screens/Profile.dart';
import 'package:bridgewearaa/screens/inputs.dart';
import 'package:bridgewearaa/screens/signup.dart';
import 'package:bridgewearaa/services/data.dart';
import 'package:bridgewearaa/widget/CustomConfirmation.dart';
import 'package:bridgewearaa/widget/CustomErormsg.dart';
import 'package:bridgewearaa/widget/active_project_card.dart';
import 'package:bridgewearaa/widget/tableau.dart';

import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
class Clientwidget extends StatefulWidget {
  String role;
  final List<User> listuser;
  Clientwidget({Key? key,required this.listuser,required this.role}) : super(key: key);

  @override
  _userwidgetstate createState() => _userwidgetstate();
}
class _userwidgetstate extends State<Clientwidget> {
   @override
  void initState() {
    super.initState();
   
  }
  String index="Dashboard";
   @override
  Widget build(BuildContext context) {
     MediaQueryData mediaQueryData = MediaQuery.of(context);
    double screenWidth = mediaQueryData.size.width;
    double screenHeight = mediaQueryData.size.height;
    double fontSize = MediaQuery.of(context).size.shortestSide * 0.05;
    double marginValue = MediaQuery.of(context).size.width * 0.02;
  if(screenWidth>screenHeight){
           screenWidth = mediaQueryData.size.height;
       screenHeight = mediaQueryData.size.width;
      }
        final Size _size = MediaQuery.of(context).size;

        final bool _isDesktop = _size.width >= screenLg;
    return 
   Container(
          height: screenLg*0.8,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Expanded(
                child: tableau(listuser: widget.listuser,role: widget.role,)));}

}

class livreurwidget extends StatefulWidget {
  String role;
  final List<User> listuser;
  livreurwidget({Key? key,required this.listuser,required this.role}) : super(key: key);

  @override
  _livreurwidgetstate createState() => _livreurwidgetstate();
}
class _livreurwidgetstate extends State<livreurwidget> {
   @override
  void initState() {
    super.initState();
   
  }
  String index="Dashboard";
   @override
  Widget build(BuildContext context) {
     MediaQueryData mediaQueryData = MediaQuery.of(context);
    double screenWidth = mediaQueryData.size.width;
    double screenHeight = mediaQueryData.size.height;
    double fontSize = MediaQuery.of(context).size.shortestSide * 0.05;
    double marginValue = MediaQuery.of(context).size.width * 0.02;
  if(screenWidth>screenHeight){
           screenWidth = mediaQueryData.size.height;
       screenHeight = mediaQueryData.size.width;
      }
        final Size _size = MediaQuery.of(context).size;

        final bool _isDesktop = _size.width >= screenLg;
    return 
   Container(
          height: screenLg*0.8,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Expanded(
                child: tableau(listuser: widget.listuser,role: widget.role,)));}

}

class modwidget extends StatefulWidget {
  String role;
  final List<User> listuser;
  modwidget({Key? key,required this.listuser,required this.role}) : super(key: key);

  @override
  _modwidgetstate createState() => _modwidgetstate();
}
class _modwidgetstate extends State<modwidget> {
   @override
  void initState() {
    super.initState();
   
  }
  String index="Dashboard";
   @override
  Widget build(BuildContext context) {
     MediaQueryData mediaQueryData = MediaQuery.of(context);
    double screenWidth = mediaQueryData.size.width;
    double screenHeight = mediaQueryData.size.height;
    double fontSize = MediaQuery.of(context).size.shortestSide * 0.05;
    double marginValue = MediaQuery.of(context).size.width * 0.02;
  if(screenWidth>screenHeight){
           screenWidth = mediaQueryData.size.height;
       screenHeight = mediaQueryData.size.width;
      }
        final Size _size = MediaQuery.of(context).size;

        final bool _isDesktop = _size.width >= screenLg;
    return 
   Container(
          height: screenLg*0.8,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Expanded(
                child: tableau(listuser: widget.listuser,role: widget.role,)));}

}

class DiscussionInfoDetail extends StatelessWidget {
  const DiscussionInfoDetail({Key? key, required this.info,required this.delete}) : super(key: key);

  final User info;
  final Function delete;
  @override
  Widget build(BuildContext context) {
       final Size _size = MediaQuery.of(context).size;
    final bool _isDesktop = _size.width >= screenLg;
  MediaQueryData mediaQueryData = MediaQuery.of(context);
    double screenWidth = mediaQueryData.size.width;
    double screenHeight = mediaQueryData.size.height;
    if(screenHeight<screenWidth){
           screenWidth = mediaQueryData.size.height;
     screenHeight = mediaQueryData.size.width;

    }
    double fontSize = MediaQuery.of(context).size.shortestSide * 0.05;
    double marginValue = MediaQuery.of(context).size.width * 0.02;
    return Container(
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.all(marginValue/2),
      child: 
    _isDesktop?
Row(
        children: [
          InkWell(
            onTap: (){
                            if(info.role!="moderateur")

              showDialog(
               context: context,
  builder: (BuildContext context) {
    return AlertDialog(
      content: Container(
      width: screenWidth*0.9,
        child: userscren(user: info.id)),
     
    );
  },
);
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: info!.picture.toLowerCase().endsWith('.svg+xml')?
                              SvgPicture.network(
                                url + "/getimage/" +info!.picture,
                                      height: screenHeight*0.1,
                width: screenHeight*0.1,
                fit: BoxFit.cover,
          
                                          placeholderBuilder: (BuildContext context) => CircularProgressIndicator(),
          
                              ):
                              Image.network(
                                  url+"/getimage/"+info!.picture, // Assuming you want to display the first image
                                      height: screenHeight*0.1,
                width: screenHeight*0.1,
                fit: BoxFit.cover,
          
                              ),            
              
             
            ),
          ),
          Expanded(
            child: Padding(
              padding:  EdgeInsets.symmetric(horizontal: marginValue),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    info.firstname+" "+info.secondname!,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: fontSize,
                      fontWeight: FontWeight.w600
                    ),
                  ),

                  Text(
                    "info.date!",
                    style: TextStyle(
                        color: Colors.black.withOpacity(0.5),
                      fontSize: fontSize*0.7,
                    ),
                  ),
                ],
              ),
            ),
          ),
                                            if(info.role.toLowerCase()=="client")

           Padding(
              padding:  EdgeInsets.only(left: marginValue),
              child: RatingBar.readOnly(
                filledColor: Colors.blueAccent,
                size: fontSize,
                filledIcon: Icons.star,
                emptyIcon: Icons.star_border,
                initialRating: 4.3,
                maxRating: 5,

              ),
            ), 
Container(
                                  color: Colors.white,
                                  width: screenHeight * 0.05,
                                  height: screenHeight * 0.05,
                                  child: Center(
                                    child:
                                    FittedBox(
                                      fit: BoxFit.contain,
                                      child:  PopupMenuButton<String>(
                                    itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                                  PopupMenuItem<String>(
                                    value: 'delete',
                                    child: Text('Delete',style: TextStyle(fontSize: fontSize*0.7),),
                                    onTap: () {
                                      delete();

                                    },
                                  ),
                                  if(info.role!="moderateur")
                                    PopupMenuItem<String>(
                                      value: 'Details',
                                      child: Text('Details',style: TextStyle(fontSize: fontSize*0.7),),
                                      onTap: (){
                                        
                                      },
                                    ),
                                    ],
                                    onSelected: (String value) {
                              if (value == 'delete') {
                              } else if (value == 'Details') {
                              }
                              },
                                icon: Icon(
                                  Icons.more_vert_rounded,
                                  color: Colors.blue,
                                ),
                              ),
                                    ),
                                  ),
                                ),
           ],
      )
    :Row(
        children: [
          InkWell(
            onTap: (){
              showDialog(
               context: context,
  builder: (BuildContext context) {
    return AlertDialog(
      content: Container(
        child: userscren(user: info.id)),
     
    );
  },
);
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: info!.picture.toLowerCase().endsWith('.svg+xml')?
                              SvgPicture.network(
                                url + "/getimage/" +info!.picture,
                                    height: screenHeight*0.1,
                width: screenHeight*0.1,
                fit: BoxFit.cover,
          
                                placeholderBuilder: (BuildContext context) => CircularProgressIndicator(),
          
                              ):
                              Image.network(
                                  url+"/getimage/"+info!.picture, 
                                      height: screenHeight*0.1,
                width: screenHeight*0.1,
                fit: BoxFit.cover,
          
                              ),
              
                   
            ),
          ),
          Expanded(
            child: Padding(
              padding:  EdgeInsets.symmetric(horizontal: marginValue),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    info.firstname+" "+info.secondname!,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: fontSize,
                      fontWeight: FontWeight.w600
                    ),
                  ),

                  Text(
                    "info.date!",
                    style: TextStyle(
                        color: Colors.black.withOpacity(0.5),
                      fontSize: fontSize*0.7,
                    ),
                  ),
                   Padding(
              padding:  EdgeInsets.only(left: marginValue),
              child: RatingBar.readOnly(
                filledColor: Colors.blueAccent,
                size: fontSize,
                filledIcon: Icons.star,
                emptyIcon: Icons.star_border,
                initialRating: 4.3,
                maxRating: 5,

              ),
            ), 
                ],
              ),
            ),
          ),
          
Container(
                                  color: Colors.white,
                                  width: screenHeight * 0.05,
                                  height: screenHeight * 0.05,
                                  child: Center(
                                    child:
                                    FittedBox(
                                      fit: BoxFit.contain,
                                      child:  PopupMenuButton<String>(
                                    itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                                  PopupMenuItem<String>(
                                    value: 'delete',
                                    child: Text('Delete',style: TextStyle(fontSize: fontSize*0.7),),
                                    onTap: () {
                              
delete();
                                    },
                                  ),
                                    PopupMenuItem<String>(
                                      value: 'Details',
                                      child: Text('Details',style: TextStyle(fontSize: fontSize*0.7),),
                                      onTap: (){
                                        
                                      },
                                    ),
                                    ],
                                    onSelected: (String value) {
                              if (value == 'delete') {
                              } else if (value == 'Details') {
                              }
                              },
                                icon: Icon(
                                  Icons.more_horiz,
                                  color: Colors.blue,
                                ),
                              ),
                                    ),
                                  ),
                                ),
                                    ],
      ),
 
    
    );
  }

}

class adduserwidget extends StatefulWidget {
  final String? role;
  final Function changed;
  const adduserwidget({
     required this.changed,
   required this.role,
    Key? key,
 
  }) : super(key: key);

  @override
  _adduserwidgetState createState() => _adduserwidgetState();
}

class _adduserwidgetState extends State<adduserwidget> {
  @override
  void initState() {
    super.initState();
    
   
  }
  String texterror="";
      TextEditingController name=TextEditingController();
final _colornotifier= ValueNotifier(Colors.green);

    TextEditingController _nameinputcontroller = TextEditingController();
    TextEditingController password = TextEditingController();
    TextEditingController confirm = TextEditingController();
    TextEditingController firstname = TextEditingController();
    TextEditingController secondname = TextEditingController();
    TextEditingController email = TextEditingController();

     String? _isnamevalid;
     String? erremail;
     String? errFirstname;
     String? errlastname;
     String? errpassword;
     String? errconfirmpassword;
bool isPasswordValid(String password) {
  return password.isNotEmpty && password.length >= 6;
}

String? validateEmail2(String? email) {
  if (email == null || email.isEmpty) {
    return 'Email is required';
  } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email)) {
    return 'Invalid email format';
  }

  return null;
}
  void updateVerification(String value) async {
      if (email == null || value.isEmpty) {
        setState(() {
              erremail= 'Email is required';

        });
  } else {
      if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
    setState(() {
          erremail= 'Invalid email format';

    });
  }
  else{
  bool result = await checkEmailAvailability(value);
    setState(() {
      print(result);
      if(result==false){
        erremail="Email Used";
      }else{
        erremail=null;
      }
    });
  }
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
  String? validatename(String? name) {
    if (name == null || name.isEmpty) {
      return 'name is required';
    } else if (name.length < 6) {
      return 'name must be at least 6 characters long';
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
    double fontSize = MediaQuery.of(context).size.shortestSide * 0.05;
    double marginValue = MediaQuery.of(context).size.width * 0.02;
  if(screenWidth>screenHeight){
           screenWidth = mediaQueryData.size.height;
       screenHeight = mediaQueryData.size.width;
      }
        final Size _size = MediaQuery.of(context).size;

        final bool _isDesktop = _size.width >= screenLg;

    return  Padding(
      padding:  EdgeInsets.all(0),
      child: Container(
        width: screenWidth*0.7,
            child:Column(
  mainAxisAlignment: MainAxisAlignment.center,
  crossAxisAlignment: CrossAxisAlignment.center,
      children: [
         Column(

          children: [
                    Container(
              width: screenWidth*0.9,


              child: Padding(
                      padding:  EdgeInsets.all(marginValue*0.5),
                child:                      TextField(
                  onChanged: (value){

                   setState(() {
                     updateVerification(value);
                   });
                  },
                  controller: email,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: fontSize * 0.7,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                  ),
                  decoration: InputDecoration(
                    labelText: "Email",
                    labelStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: fontSize *0.7,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                    ),
          errorText:  erremail,

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
              width: screenWidth*0.9,


              child: Padding(
                      padding:  EdgeInsets.all(marginValue*0.5),
                child:                      TextField(
                  controller: firstname,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: fontSize * 0.7,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                  ),
                  decoration: InputDecoration(
                    labelText: "First Name",
                    labelStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: fontSize *0.7,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                    ),

                    focusedBorder: InputBorder.none,
                    errorStyle: TextStyle(
                      fontSize: fontSize*0.5,
                      fontWeight: FontWeight.w600,
                    ),
                    errorText: errFirstname,
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(
                        width: screenWidth * 0.003,
                        color: Colors.red,
                      ),
                    ),
                  ),

  onChanged: (value){
              setState(() {
                errFirstname=validatename(value);
              });
            },
                ),

              ),

            ),
            SizedBox(height: screenHeight*0.01,),

            Container(
              width: screenWidth*0.9,


              child: Padding(
                      padding:  EdgeInsets.all(marginValue*0.5),
                child:                      TextField(
                  controller: secondname,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: fontSize * 0.7,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                  ),
                  decoration: InputDecoration(
                    labelText: "Last Name",
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
                    errorText: errlastname,
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(
                        width: screenWidth * 0.003,
                        color: Colors.red,
                      ),
                    ),
                  ),
            onChanged: (value){
              setState(() {
                errlastname=validatename(value);
              });
            },

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

                    width: screenWidth*0.3,




                    child: Padding(

                      padding:  EdgeInsets.all(marginValue*0.5),

                      child:                      TextField(

                        controller: password,

                        textAlign: TextAlign.left,

                        style: TextStyle(

                          color: Colors.black,

                          fontSize: fontSize * 0.7,

                          fontFamily: 'Poppins',

                          fontWeight: FontWeight.w400,

                        ),
  
                        decoration: InputDecoration(

                          labelText: "Password",

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
errorText: errpassword,
                          errorBorder: OutlineInputBorder(

                            borderRadius: BorderRadius.all(Radius.circular(10)),

                            borderSide: BorderSide(

                              width: screenWidth * 0.003,

                              color: Colors.red,

                            ),

                          ),

                        ),
onChanged: (value){
  setState(() {
      errpassword=validatePassword(value);
    errconfirmpassword=validateConfirmPassword(confirm.text);
  });


},




                      ),



                    ),



                  ),

                  Container(

                    width: screenWidth*0.3,




                    child: Padding(

                      padding:  EdgeInsets.all(marginValue*0.5),

                      child:                      TextField(

                        controller: confirm,

                        textAlign: TextAlign.left,

                        style: TextStyle(

                          color: Colors.black,

                          fontSize: fontSize * 0.7,

                          fontFamily: 'Poppins',

                          fontWeight: FontWeight.w400,

                        ),
                        
onChanged: (value){
  setState(() {
    errconfirmpassword=validateConfirmPassword(value);
      errpassword=validatePassword(password.text);
  });
},
                        decoration: InputDecoration(

                          labelText: "Confirm Password",

                          labelStyle: TextStyle(

                            color: Colors.grey,

                            fontSize: fontSize * 0.7,

                            fontFamily: 'Poppins',

                            fontWeight: FontWeight.w700,

                          ),


errorText: errconfirmpassword,
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


          ],
        ),
     

                   
        SizedBox(height: screenHeight*0.02),
    
                      Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close',style: TextStyle(color: Colors.red,fontSize: fontSize*0.7),),
            ),
              TextButton(
                  onPressed: () {
                 if(errFirstname==null&&errlastname==null&&erremail==null&&errconfirmpassword==null&&errpassword==null){
          User u=User(etat: "notActive",id: "id", firstname: firstname.text, secondname: secondname.text, email: email.text, phone: "phone", picture: "user.jpg", password: password.text, role: widget.role!);
       setState(() {
        widget.changed(u);
              adduser(u, (msg, color1) =>{
               
                
                Navigator.pop(context),
        ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            backgroundColor: color1,
            content:                               Customerrormsg(icon: Icons.done,message: msg,bgcolor: color1,)

        ))
            
        
               });
       });
  }
       },
          child: Text('Add',style: TextStyle(fontSize: fontSize*0.7),),
        ),
          ],
        ),
                         
               
      ],
    )

      
      
          ),
    )
      ;
  }
  
  

}
