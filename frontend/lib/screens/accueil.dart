import 'dart:convert';

import 'package:bridgewearaa/config.dart';
import 'package:bridgewearaa/controlleur/colorcontrolleur.dart';
import 'package:bridgewearaa/controlleur/productcontrolleur.dart';
import 'package:bridgewearaa/controlleur/promotioncontrolleur.dart';
import 'package:bridgewearaa/controlleur/sizecontrolleur.dart';
import 'package:bridgewearaa/controlleur/tokencontroller.dart';
import 'package:bridgewearaa/controlleur/usercontrolleur.dart';
import 'package:bridgewearaa/models/size.dart';
import 'package:bridgewearaa/models/user.dart';
import 'package:bridgewearaa/screens/addproductscreen.dart';
import 'package:bridgewearaa/screens/productdetails.dart';
import 'package:bridgewearaa/services/data.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:bridgewearaa/screens/Seeting.dart';
import 'package:bridgewearaa/screens/menu.dart';
import 'package:bridgewearaa/widget/bottomnavbar.dart';
import 'package:bridgewearaa/widget/navbar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:bridgewearaa/screens/likes.dart';
import 'package:bridgewearaa/screens/menu2.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:provider/provider.dart';

import 'package:bridgewearaa/screens/notification.dart';
class accueil extends StatefulWidget {
  final String? token;
  const accueil({super.key, this.token=""});

  @override
  State<accueil> createState() => _accueilState();
}

class _accueilState extends State<accueil> {
  int index=0;
  User? u;
  getdata(Function add) async{
    if(widget.token!=""){
      getProductsgen((l) =>{
        context.read<DataService>().listproductenuser=l
      }, widget.token!).then((value) => {
        add()

      });


    }
    getProducts((l) =>{
      context.read<DataService>().listproduct=l
    }, context.read<DataService>().user!.id).then((value) => {
      add()

    });
    getcolors((l) =>{
      context.read<DataService>().listcolors=l
    }).then((value) => {
      add()

    });
    getpromotionactive( (list) =>{

      context.read<DataService>().listpromotion=list
    });

  }
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    getcolors( (list) =>{

      context.read<DataService>().listcolors=list
    });
    getdata((){
      setState(() {
        index++;
      });
    });






  }
  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    double screenWidth = mediaQueryData.size.width;
    double screenHeight = mediaQueryData.size.height;
    double fontSize = MediaQuery.of(context).size.shortestSide * 0.05;
    double marginValue = MediaQuery.of(context).size.width * 0.02;
    final List<PreferredSizeWidget> appBarList = [
      navbar(),
      likesappbar(),
addproductappbar(),
      notificationappbar(),
      Seetingappbar()

    ];
    final List<Widget> bodyapplist = [
      menubody(),
      likesbody(),
      addproductscreen(done: (){
        setState(() {
          _selectedIndex=0;
        });
      },),
      Notificationbody(),
      Seetingbody()
    ];
 
    return index==0?LoadingScreen2():

      Scaffold(

      appBar: appBarList[_selectedIndex],
      body: bodyapplist[_selectedIndex],

      bottomNavigationBar:     SalomonBottomBar(
          currentIndex: _selectedIndex,

          unselectedItemColor: const Color(0xff757575),
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          items: _navBarItems

      ),

    );

  }


}
final _navBarItems = [
  SalomonBottomBarItem(
    icon:  SvgPicture.asset("assets/icons/Home.svg"),
    activeIcon:  SvgPicture.asset("assets/icons/Home-active.svg",color: Colors.blueAccent,),
    title:  Text("Home"),
  ),
  SalomonBottomBarItem(
    icon: SvgPicture.asset("assets/icons/Heart.svg") ,
    activeIcon:  SvgPicture.asset("assets/icons/Heart.svg",color: Colors.blueAccent,),
    title: const Text("Likes"),
  ),
  SalomonBottomBarItem(
    icon: Icon(Icons.center_focus_strong),

    title: Text('POST'), // Empty string inside Text widget
  ),
  SalomonBottomBarItem(
    icon: SvgPicture.asset("assets/icons/Notification.svg") ,
    activeIcon:  SvgPicture.asset("assets/icons/Notification-active.svg",color: Colors.blueAccent,),
    title: const Text("Notification"),
  ),
  SalomonBottomBarItem(
    icon: const Icon(Icons.settings),
    title: const Text("Seeting"),
  ),
];

