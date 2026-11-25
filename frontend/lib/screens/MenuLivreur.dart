import 'dart:convert';

import 'package:bridgewearaa/Webpart/components/orders_list.dart';
import 'package:bridgewearaa/config.dart';
import 'package:bridgewearaa/controlleur/colorcontrolleur.dart';
import 'package:bridgewearaa/controlleur/productcontrolleur.dart';
import 'package:bridgewearaa/controlleur/sizecontrolleur.dart';
import 'package:bridgewearaa/controlleur/tokencontroller.dart';
import 'package:bridgewearaa/controlleur/usercontrolleur.dart';
import 'package:bridgewearaa/models/size.dart';
import 'package:bridgewearaa/models/user.dart';
import 'package:bridgewearaa/screens/addproductscreen.dart';
import 'package:bridgewearaa/screens/orderlistlivreur.dart';
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
class MenuLivreur extends StatefulWidget {
  final String? token;
  const

  MenuLivreur({super.key, this.token=""});

  @override
  State<MenuLivreur> createState() => _accueilState();
}

class _accueilState extends State<MenuLivreur> {
  int index=0;
  User? u;
  getdata(Function add) async{
    if(widget.token!=""){
      getuserbytoken(widget.token!,(l) =>{
        context.read<DataService>().user=l
      }).then((value) => {
        add()

      });


    }


  }
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
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
      navbarliv(),
      notificationappbar(),

      Seetingappbar()

    ];
    final List<Widget> bodyapplist = [
      if(context.read<DataService>().user!=null)
      orderListlivreur(iduser: context.read<DataService>().user!.id),
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
    title:  Text("Orders"),
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

