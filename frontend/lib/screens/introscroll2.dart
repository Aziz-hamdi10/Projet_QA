import 'dart:async';

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
    double marginValue = MediaQuery.of(context).size.width * 0.02;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: screenHeight*0.5,
            child: Image.asset(this.widget.image)
        ),
        Center(

          child: Padding(
            padding:  EdgeInsets.all(marginValue),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                 Container(
                    width: screenWidth*0.5,
                    child: Flexible(
                      child: Text(

                        this.widget.title,textAlign: TextAlign.center,
                        style: TextStyle(

                            color: Colors.black.withOpacity(0.9),
                            fontSize:fontSize*1.2,
                            fontFamily: "RussoOne"

                        ),
                      ),
                    ),
                  ),

                SizedBox(height: screenHeight*0.02,),
                Container(
                  width: screenWidth*0.8,
                  child: Flexible(
                    child: Text(

                      this.widget.description,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          letterSpacing: 0.5,
                          color: Colors.black.withOpacity(0.9),
                          fontSize:fontSize*0.75,
                          fontFamily: "Sansation"

                      ),
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

class introscreen2 extends StatefulWidget {
  const introscreen2({super.key});

  @override
  State<introscreen2> createState() => _introscreen2State();
}

class _introscreen2State extends State<introscreen2> {
  int _currentPage = 0;
  bool islast=false;
  final PageController _pageController = PageController();
  void _onPageChanged(int index) {



    setState(() {
      _currentPage = index;
      startAutoScroll();
      if(_currentPage==8){

          islast=true;
          autoScrollTimer!.cancel();

       }
      else{

          islast=false;


      }
    });
  }

  Timer? autoScrollTimer;

  void startAutoScroll() {
    // Check if the timer is already active
    if (autoScrollTimer != null && autoScrollTimer!.isActive) {
      // Timer is active, cancel it
      autoScrollTimer!.cancel();
    }

    // Start a new timer
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
    double fontSize = MediaQuery.of(context).size.shortestSide * 0.05;
    double marginValue = MediaQuery.of(context).size.width * 0.02;
    return Scaffold(
        body: Container(
            color: Colors.white,

            child: Column(
                children: [
                  Container(
                    child:
                        Flexible(
                child: PageView(
                  controller: _pageController,
                  onPageChanged: _onPageChanged,

                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                            height: screenHeight*0.6,

                            child: Image.asset('images/BridgeWear6.png')
                        ),
                        Padding(
                          padding:  EdgeInsets.all(marginValue),
                          child: Container(

                            child: Flexible(
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
                        ),



                      ],
                    ),
                    pageviewitem(image: "images/intro2.png", description: "The One shopping-fashion Application for all ! Shop with confidence using our secure and reliable platform.", title:"bridgewearaa"),
                    pageviewitem(image: "images/intro4.png", description: "Discover, Shop, and Slay with Our Stylish Collection .", title:"Explore Your Style Journey"),
                    pageviewitem(image: "images/intro3.png", description: "Explore, select, and purchase effortlessly. Browse our collections and enjoy a smooth shopping experience with just a click", title:"Seamless Shopping"),
                    pageviewitem(image: "images/intro6.png", description: "Securely Pay Online with Cards Or Choose Cash-on-Delivery", title:"Secure Payment Options"),
                    pageviewitem(image: "images/intro7.png", title: "Delivery ", description:"Enjoy swift and secure delivery services covering every corner of Tunisia. "),
                    pageviewitem(image: "images/intro8.png", title: "Get your money with Cards ", description:"Swiftly pay for your order using secure card transactions. Enjoy hassle-free shopping with just a tap."),
                    pageviewitem(image: "images/intro9.png", title: "Snap & Sell", description:"Snap a pic of your items, list them for sale, and relax. Once sold, our delivery partner will pick them up right from your doorstep"),
                    pageviewitem(image: "images/intro5.png", description: "Sign up or log in now to unlock an exquisite world of fashion and discover the latest trends", title:"Discover our Application now !"),


                  ],
                ),
            )

                  ),


                  SizedBox( height: screenHeight*0.03,),

                  Padding(
                    padding:  EdgeInsets.all(marginValue),
                    child: islast?

                    Row(
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
                                  Navigator.pushNamed(context, "/login");
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color.fromRGBO(4, 97, 103, 1).withOpacity(0.1),
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
                                  Navigator.pushNamed(context, "/signup");

                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color.fromRGBO(4, 97, 103, 1),
                                ),
                                child:  Text(
                                  'Sign Up ',
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


                      ],
                    ):Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: screenHeight*0.07,
                          child: TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, "/login");
                            },

                            child:  Text(
                              'Skip',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: fontSize*0.8,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),


                        Padding(
                          padding:  EdgeInsets.all(marginValue),
                          child: SmoothPageIndicator(controller: _pageController, count: 9, effect: WormEffect(
                            dotColor: Colors.grey,
                            activeDotColor: Color.fromRGBO(4, 97, 103, 1),
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
                        SizedBox(
                          height: screenHeight*0.07,
                          child: TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, "/signup");

                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                            ),
                            child:  Text(
                              'Next',
                              style: TextStyle(
                                color: Color.fromRGBO(4, 97, 103, 1),
                                fontSize: fontSize*0.8,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),




                      ],
                    )
                  ),
                  Padding(
                    padding:  EdgeInsets.all(marginValue),
                    child: Text(
                      'Shopping Application',
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        color:Color.fromRGBO(4, 97, 103, 1),
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
