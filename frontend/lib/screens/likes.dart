import 'dart:ui';

import 'package:bridgewearaa/controlleur/productcontrolleur.dart';
import 'package:bridgewearaa/models/product.dart';
import 'package:bridgewearaa/screens/menu2.dart';
import 'package:bridgewearaa/services/data.dart';
import 'package:bridgewearaa/widget/bottomnavbar.dart';
import 'package:bridgewearaa/widget/navbar.dart';
import 'package:bridgewearaa/widget/productitem.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:flutter_svg/flutter_svg.dart';
class likesappbar extends StatelessWidget implements PreferredSizeWidget {
  @override
  static const IconData shopping_bag_outlined = IconData(0xf37d, fontFamily: 'MaterialIcons');

  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    double screenWidth = mediaQueryData.size.width;
    double screenHeight = mediaQueryData.size.height;
    double fontSize = MediaQuery.of(context).size.shortestSide * 0.05;
    double marginValue = MediaQuery.of(context).size.width * 0.02;
    return  AppBar(
      automaticallyImplyLeading: false,




      title: Text("WishList",style: TextStyle(color: Colors.white),),
      centerTitle: true,
      backgroundColor: Colors.blueAccent.withOpacity(0.5),

    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}


class likesbody extends StatefulWidget {
  const likesbody({super.key});

  @override
  State<likesbody> createState() => _likesState();
}

class _likesState extends State<likesbody> {
  PageController _pageController = PageController(initialPage: 0);
  int position=0;
  @override
  Widget build(BuildContext context) {
    // Set the color of the status bar
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ));
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    double screenWidth = mediaQueryData.size.width;
    double screenHeight = mediaQueryData.size.height;
    double fontSize = MediaQuery.of(context).size.shortestSide * 0.05;
    double marginValue = MediaQuery.of(context).size.width * 0.02;


      return SafeArea(
          child: context.read<DataService>().listproductliked.isNotEmpty?
          SingleChildScrollView(
            child:
            Column(
              mainAxisAlignment: MainAxisAlignment.center,

              children: [

                Center(child:

                products(listproduct: context.read<DataService>().listproductliked,height: 0 ,width:screenWidth*0.4,)


                ),
              ],
            )

          ):

              Center(
                child: Container(

                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        "assets/icons/Paper Bag.svg",
                        width: screenWidth * 0.4,
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      Text(
                        "Your Wishlist is Empty !",
                        style: TextStyle(
                          fontSize: fontSize * 1.5,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                        softWrap: true, // Allow text to wrap to the next line
                        textAlign: TextAlign.center, // Center-align the text
                      ),
                      SizedBox(height: screenHeight * 0.02),

                      Container(
                        width: screenWidth * 0.9, // Set your desired maximum width
                        child:  Text(
                          "Tap on the heart on your favorite items to add them to your wishlist",
                          style: TextStyle(
                            fontSize: fontSize*0.8,
                            color: Colors.black.withOpacity(0.7),
                          ),
                          softWrap: true,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ),





      );

  }
}
