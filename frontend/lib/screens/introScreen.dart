import 'dart:async';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:bridgewearaa/const/colors.dart';
import 'package:bridgewearaa/services/data.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
class pageviewitem extends StatefulWidget {
  final String title ;
  final String description;
  final String image;
  const pageviewitem({super.key,required this.image,required this.description,required this.title});

  @override
  State<pageviewitem> createState() => _pageviewitemState();
}

class _pageviewitemState extends State<pageviewitem> {

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    double screenWidth = mediaQueryData.size.width;
    double screenHeight = mediaQueryData.size.height;
    double fontSize = MediaQuery.of(context).size.shortestSide * 0.05;
    bool _isDesktop = false;

        if(screenHeight<screenWidth){
           screenWidth = mediaQueryData.size.height;
     screenHeight = mediaQueryData.size.width;
     _isDesktop=true;

    }
        double marginValue = screenWidth * 0.02;


    return _isDesktop?Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Container(
              height: screenHeight*0.6,
              child: Image.asset(this.widget.image,
                            width: screenWidth*0.5,
)
          ),
        ),
       Expanded(
         child: Container(
           child: Padding(
                padding:  EdgeInsets.all(marginValue),
                child: Column(
mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(

                      this.widget.title,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: Colors.black.withOpacity(0.9),
                          fontSize:fontSize*0.9,
                          fontFamily: "RussoOne"

                      ),
                    ),
                    SizedBox(height: screenHeight*0.01,),
                    Container(
                      width: screenWidth*0.8,
                      child: Text(

                        this.widget.description,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            letterSpacing: 0.5,
                            color: Colors.black.withOpacity(0.9),
                            fontSize:fontSize*0.7,
                            fontFamily: "Sansation"

                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight*0.001,),
         
         
                  ],
                ),
              ),
         ),
       ),
        

      ],
    )
  : Stack(
      children: [
        Container(
            height: screenHeight*0.6,

            child: Image.asset(this.widget.image)
        ),
        Positioned(
          left: 10,
          bottom: 10,
          child: Padding(
            padding:  EdgeInsets.all(marginValue),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: screenWidth*0.5,
                  child: Text(

                    this.widget.title,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: Colors.black.withOpacity(0.9),
                        fontSize:fontSize*0.9,
                        fontFamily: "RussoOne"

                    ),
                  ),
                ),
                SizedBox(height: screenHeight*0.01,),
                Container(
                  width: screenWidth*0.8,
                  child: Text(

                    this.widget.description,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        letterSpacing: 0.5,
                        color: Colors.black.withOpacity(0.9),
                        fontSize:fontSize*0.7,
                        fontFamily: "Sansation"

                    ),
                  ),
                ),
                SizedBox(height: screenHeight*0.001,),


              ],
            ),
          ),
        ),



      ],
    );
  }
}

class introscreen extends StatefulWidget {
  const introscreen({super.key});

  @override
  State<introscreen> createState() => _introscreenState();
}

class _introscreenState extends State<introscreen> {
  int _currentPage = 0;
  bool showText=true;
  final PageController _pageController = PageController();
  void _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
      startAutoScroll();
    });
  }
  List<Widget> imageWidgets = [ Image.asset('images/bridgewear5.png'),Image.asset('images/BridgeWear6.png')];

  Timer? autoScrollTimer;

  void startAutoScroll() {

    if (autoScrollTimer != null && autoScrollTimer!.isActive) {
      autoScrollTimer!.cancel();
    }

    autoScrollTimer = Timer.periodic(Duration(seconds: 5), (timer) {
      if (_currentPage < 8) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }  @override
  void initState() {
    super.initState();

    startAutoScroll();
  }
  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    double screenWidth = mediaQueryData.size.width;
    double screenHeight = mediaQueryData.size.height;
    if(screenHeight<screenWidth){
           screenWidth = mediaQueryData.size.height;
     screenHeight = mediaQueryData.size.width;

    }
    double fontSize = MediaQuery.of(context).size.shortestSide * 0.05;
    double marginValue = MediaQuery.of(context).size.width * 0.02;
    return Scaffold(
      body: Container(
          color: primarytheme,

          child: Column(
        children: [
          Flexible(
            child: Container(
              decoration: BoxDecoration(
                  color: bgcolorprimary,


                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(50))
              ),
              child:                 PageView(
                controller: _pageController,
                onPageChanged: _onPageChanged,

                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(

                          child: Image.asset('images/BridgeWear6.png')
                      ),
                      Padding(
                        padding:  EdgeInsets.all(marginValue),
                        child: Container(

                          child: Text(

                            "Welcome !",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: Colors.black.withOpacity(0.9),
                              fontFamily: "Sansita",
                              fontSize:fontSize*1.5,

                            ),
                          ),
                        ),
                      ),



                    ],
                  ),
                  pageviewitem(image: "images/intro2.png", description: "The One shopping-fashion Application for all ! Shop with confidence using our secure and reliable platform.", title:"bridgewearaa"),
                  pageviewitem(image: "images/intro4.png", description: "Discover, Shop, and Slay with Our Stylish Collection .", title:"Explore Your Style Journey"),
                  pageviewitem(image: "images/intro5.png", description: "Sign up or log in now to unlock an exquisite world of fashion and discover the latest trends", title:"Discover our Application now !"),
                  pageviewitem(image: "images/intro3.png", description: "Explore, select, and purchase effortlessly. Browse our collections and enjoy a smooth shopping experience with just a click", title:"Seamless Shopping"),
                  pageviewitem(image: "images/intro6.png", description: "Securely Pay Online with Cards Or Choose Cash-on-Delivery", title:"Secure Payment Options"),
                  pageviewitem(image: "images/intro7.png", title: "Delivery ", description:"Enjoy swift and secure delivery services covering every corner of Tunisia. "),
                  pageviewitem(image: "images/intro8.png", title: "Get your money with Cards ", description:"Swiftly pay for your order using secure card transactions. Enjoy hassle-free shopping with just a tap."),
                  pageviewitem(image: "images/intro9.png", title: "Snap & Sell", description:"Snap a pic of your items, list them for sale, and relax. Once sold, our delivery partner will pick them up right from your doorstep"),


                ],
              )

            ),
          ),
          SizedBox( height: screenHeight*0.03,),
          Padding(
            padding:  EdgeInsets.all(marginValue),
            child: SmoothPageIndicator(controller: _pageController, count: 9, effect: WormEffect(
              dotColor: Colors.grey,
              activeDotColor: Colors.white,
              dotHeight: screenHeight*0.02,
              dotWidth: screenWidth*0.02
            ,),onDotClicked: (index) {
    // Move to the clicked page
    _pageController.animateToPage(
    index,
    duration: Duration(milliseconds: 500),
    curve: Curves.easeInOut,
    );
    },
            ),
          ),
          SizedBox( height: screenHeight*0.03,),
          Padding(
            padding:  EdgeInsets.all(marginValue),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(width: screenWidth*0.1,),
                Expanded(
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(30)),
                    child: SizedBox(
                      height: screenHeight*0.07,
                      child: ElevatedButton(
                        onPressed: () {

                          GoRouter.of(context).push('/login');                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primarytheme.withOpacity(0.1),
                        ),
                        child:  Text(
                          'Log In ',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: fontSize*0.8,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: screenWidth*0.1,),

                Expanded(
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(30)),
                    child: SizedBox(
                      height: screenHeight*0.07,
                      child: ElevatedButton(
                        onPressed: () {

    GoRouter.of(context).push('/signup');

                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                        ),
                        child:  Text(
                          'Sign Up ',
                          style: TextStyle(
                            color:primarytheme,
                            fontSize: fontSize*0.8,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: screenWidth*0.1,),


              ],
            ),
          ),
          Padding(
            padding:  EdgeInsets.all(marginValue),
            child: Text(
              'Shopping Application',
              style: TextStyle(
                decoration: TextDecoration.underline,
                color: Colors.white,
                fontSize: fontSize*0.6,
                fontFamily: 'Poppins',
              ),
            ),
          ),


        ])
      )
    );
  }
}
