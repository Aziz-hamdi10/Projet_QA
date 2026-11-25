import 'package:bridgewearaa/config.dart';
import 'package:bridgewearaa/screens/signup.dart';
import 'package:bridgewearaa/services/data.dart';
import 'package:bridgewearaa/widget/CustomConfirmation.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:bridgewearaa/screens/edit_screen.dart';
import 'package:bridgewearaa/widget/forward_button.dart';
import 'package:bridgewearaa/widget/setting_item.dart';
import 'package:bridgewearaa/widget/setting_switch.dart';
import 'package:flutter/material.dart';
class Seetingappbar extends StatelessWidget implements PreferredSizeWidget {
  @override

  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    double screenWidth = mediaQueryData.size.width;
    double screenHeight = mediaQueryData.size.height;
    double fontSize = MediaQuery.of(context).size.shortestSide * 0.05;
    double marginValue = MediaQuery.of(context).size.width * 0.02;
    return  AppBar(
      automaticallyImplyLeading: false, // Set this to false to remove the back arrow

      title:Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.settings,color: Colors.white,size: fontSize,),
          SizedBox(width: screenWidth*0.02,),
          Text("Seeting",style: TextStyle(fontSize: fontSize),),
        ],
      ),
      centerTitle: true,
      elevation: 1,

    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
class Seetingbody extends StatefulWidget {
  const Seetingbody({super.key});

  @override
  State<Seetingbody> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<Seetingbody> {
  bool isDarkMode = false;

  @override
  Widget build(BuildContext context) {

     MediaQueryData mediaQueryData = MediaQuery.of(context);
    double screenWidth = mediaQueryData.size.width;
    double screenHeight = mediaQueryData.size.height;
    final Size _size = MediaQuery.of(context).size;
    final bool _isDesktop = _size.width >= 600;
    if (screenHeight < screenWidth) {
      screenWidth = mediaQueryData.size.height;
      screenHeight = mediaQueryData.size.width;
    }
    double fontSize = MediaQuery.of(context).size.shortestSide * 0.05;

    double marginValue = screenWidth* 0.02;
    return  SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.all(marginValue),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

               SizedBox(height: screenHeight*0.05),
               Text(
                "Account",
                style: TextStyle(
                  fontSize: fontSize,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: screenHeight*0.01),
              SizedBox(
                width: double.infinity,
                child: Row(
                  children: [
                    ClipOval(child: Container(child:

                context.read<DataService>().user!.picture.toLowerCase().endsWith('.svg+xml')?
                SvgPicture.network(
                  url + "/getimage/" + context.read<DataService>().user!.picture,
                          width: screenHeight*0.1,
                  placeholderBuilder: (BuildContext context) => CircularProgressIndicator(),

                ):
                Image.network(
                    url+"/getimage/"+context.read<DataService>().user!.picture, 
                    fit:BoxFit.cover,
                  width: screenHeight*0.1,

                )           ,)),
                  SizedBox(width: screenWidth*0.05),
                     Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          context.read<DataService>().user!.firstname+" "+context.read<DataService>().user!.secondname,
                          style: TextStyle(
                            fontSize: fontSize,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                       
                      ],
                    ),
                    const Spacer(),
                    ForwardButton(
                      onTap: () {
                        if(context.read<DataService>().user!.role=="admin")
                        {
                               showDialog(
              context: context,
              builder: (BuildContext context) {
                return Dialog(
                  child: Material(
                    child: EditAccountScreen(
                     
                    ),
                  ),
                );
              },
            );
                    
                        }
                        else
                        {
Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const EditAccountScreen(),
                          ),
                        );
                        }
                      },
                    )
                  ],
                ),
              ),
              const SizedBox(height: 40),
               Text(
                "Settings",
                style: TextStyle(
                  fontSize: fontSize,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 20),
              SettingItem(
                title: "Language",

                icon: Icons.language,
                bgColor: Colors.orange.shade100,
                iconColor: Colors.orange,
                value: "English",
                onTap: () {},
              ),
               SizedBox(height: screenHeight*0.02),
              SettingItem(
                title: "Notifications",
                icon:Icons.notifications,
                bgColor: Colors.blue.shade100,
                iconColor: Colors.blue,
                onTap: () {},
              ),
              SizedBox(height: screenHeight*0.02),
              SettingSwitch(
                title: "Dark Mode",
                icon: Icons.sunny,
                bgColor: Colors.purple.shade100,
                iconColor: Colors.purple,
                value: isDarkMode,
                onTap: (value) {
                  setState(() {
                    isDarkMode = value;
                  });
                },
              ),
              SizedBox(height: screenHeight*0.02),
              SettingItem(
                title: "Help",
                icon: Icons.help_outline_rounded,
                bgColor: Colors.green.shade100,
                iconColor: Colors.green,
                onTap: () {},
              ),
              SizedBox(height: screenHeight*0.02),
              if(context.read<DataService>().user!.role.toLowerCase()=="client"||context.read<DataService>().user!.role.toLowerCase()=="delievry")
              Center(
                child: SizedBox(
                  width: screenWidth * 0.9,
                  child: ElevatedButton(
                    onPressed: () {
                      customconfimation(context, 'Logout', 'Are you sure you want to Logout', () {
                        setState(() {
                          deleteuserData("userData");
                          deleteuserData("token");

                        });
                        GoRouter.of(context).go('/');

                        GoRouter.of(context).pushReplacement('/login');

                      },Colors.red);
                    },
                    child: Padding(
                      padding: EdgeInsets.all(marginValue * 1.5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding:  EdgeInsets.all(marginValue),
                            child: SvgPicture.asset("assets/icons/Log Out.svg",),
                          ),
                          Text("Logout",style: TextStyle(color: Colors.black),),

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
        ),
      ),

    );
  }
}
