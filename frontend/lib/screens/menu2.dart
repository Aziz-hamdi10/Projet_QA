import 'dart:typed_data';
import 'dart:ui';

import 'package:bridgewearaa/config.dart';
import 'package:bridgewearaa/controlleur/productcontrolleur.dart';
import 'package:bridgewearaa/models/categorie.dart';
import 'package:bridgewearaa/models/product.dart';
import 'package:bridgewearaa/models/productgenerale.dart';
import 'package:bridgewearaa/screens/accueil.dart';
import 'package:bridgewearaa/screens/productdetails.dart';
import 'package:bridgewearaa/screens/searchscreen.dart';
import 'package:bridgewearaa/services/data.dart';
import 'package:bridgewearaa/services/imagecompress.dart';
import 'package:bridgewearaa/widget/bottomnavbar.dart';
import 'package:bridgewearaa/widget/brands.dart';
import 'package:bridgewearaa/widget/navbar.dart';
import 'package:bridgewearaa/widget/productitem.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:provider/provider.dart';
import 'package:image/image.dart' as img;
import 'package:shimmer/shimmer.dart';
import 'package:flutter_svg/flutter_svg.dart';

class menu2 extends StatefulWidget {
  const menu2({super.key});

  @override
  State<menu2> createState() => _menuState();
}

class _menuState extends State<menu2> {
  bool isAppBarVisible = true;

  @override
  Widget build(BuildContext context) {

    MediaQueryData mediaQueryData = MediaQuery.of(context);
    double screenWidth = mediaQueryData.size.width;
    double screenHeight = mediaQueryData.size.height;
    double fontSize = MediaQuery.of(context).size.shortestSide * 0.05;
    double marginValue = MediaQuery.of(context).size.width * 0.02;
    return MyScrollingScreen();
  }
}

class MyScrollingScreen extends StatefulWidget {
  @override
  _MyScrollingScreenState createState() => _MyScrollingScreenState();
}
TextEditingController searchController = TextEditingController();

class _MyScrollingScreenState extends State<MyScrollingScreen> {
  bool isAppBarVisible = true;
  bool isSearchVisible = false;
  bool isVisible = false;
  final PageController _pageController = PageController();



  @override



  @override
  Widget build(BuildContext context) {

    MediaQueryData mediaQueryData = MediaQuery.of(context);
    double screenWidth = mediaQueryData.size.width;
    double screenHeight = mediaQueryData.size.height;
    double fontSize = MediaQuery.of(context).size.shortestSide * 0.05;
    double marginValue = MediaQuery.of(context).size.width * 0.02;
    return Scaffold(
      appBar: navbar(),

      body: Container(
        color: Colors.white,

        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding:  EdgeInsets.all(marginValue),
                    child: TextField(
                      controller: searchController,
                      onChanged: (value) {
                        setState(() {});
                      },
                      decoration: InputDecoration(
                        fillColor: Colors.blueGrey,
                        hintText: 'Search Product',
                        hintStyle: TextStyle(color: Colors.grey,fontSize: fontSize*0.7),

                        prefixIcon: Icon(Icons.search, color: Colors.grey[600],size: fontSize*1.3,),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:  EdgeInsets.all(marginValue),
                  child: Container(
                    width: screenWidth*0.12,
                      height: screenWidth*0.12,

                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.1),

                        borderRadius: BorderRadius.all(Radius.circular(10))
                    ),
                      child: Center(
                        child: Icon(

                          Icons.fit_screen,
                          size: fontSize*1.2,
                          color: Colors.grey[600]
                          ,
                        ),
                      ),

                  ),
                ) ,
                Padding(
                  padding:  EdgeInsets.all(marginValue),
                  child: Container(
                    width: screenWidth*0.12,
                    height: screenWidth*0.12,

                    decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.1),

                        borderRadius: BorderRadius.all(Radius.circular(10))
                    ),
                    child: Center(
                      child: Image.asset("images/filter.png",
                      )
                    ),

                  ),
                )


              ],
            ),




            Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    isAppBarVisible=!isAppBarVisible;
                  });
                },
                child: SingleChildScrollView(
                  child: Padding(
                    padding:  EdgeInsets.all(marginValue),
                    child: Column(
                      children: [
                        Container(
                          height:screenHeight*0.25,
                          width: screenWidth*0.95,

                          child: Stack(
                            children: [
                              Container(

                                child: PageView(
                                  controller: _pageController,
                                  children: [
                                    Padding(
                                      padding:  EdgeInsets.all(marginValue),
                                      child: Container(

                                          decoration: BoxDecoration(
                                            color: Colors.white,

                                            borderRadius: BorderRadius.circular(10.0), // Adjust the radius as needed
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey.withOpacity(0.5), // Change the shadow color as needed
                                                spreadRadius: 5,
                                                blurRadius: 7,
                                                offset: Offset(0, 3), // Change the offset as needed
                                              ),
                                            ],
                                          ),


                                          child: Row(
                                            children: [
                                              Padding(
                                                padding:  EdgeInsets.all(marginValue),
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Text("50%OFF",style: TextStyle(color: Colors.black,fontSize: fontSize*2,fontWeight: FontWeight.bold),),
                                                    Text("ON Hand Clock",style: TextStyle(color: Colors.black,fontSize: fontSize),),
                                                    ElevatedButton(onPressed: () {

                                                    }, child: Text("Click Here"),
                                                    )

                                                  ],
                                                ),
                                              )
                                              ,
                                              Expanded(child: Image.asset("images/clock.png"))
                                            ],
                                          )
                                      ),
                                    ),
                                    Padding(
                                      padding:  EdgeInsets.all(marginValue),
                                      child: Container(

                                          width: screenWidth*0.8,
                                          decoration: BoxDecoration(
                                            color: Colors.white,

                                            borderRadius: BorderRadius.circular(10.0), // Adjust the radius as needed
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey.withOpacity(0.5), // Change the shadow color as needed
                                                spreadRadius: 5,
                                                blurRadius: 7,
                                                offset: Offset(0, 3), // Change the offset as needed
                                              ),
                                              
                                            ],
                                          ),


                                          child: Row(
                                            children: [
                                              Padding(
                                                padding:  EdgeInsets.all(marginValue),
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Text("50%OFF",style: TextStyle(color: Colors.black,fontSize: fontSize*2,fontWeight: FontWeight.bold),),
                                                    Text("ON Hand Clock",style: TextStyle(color: Colors.black,fontSize: fontSize),),
                                                    ElevatedButton(onPressed: () {

                                                    }, child: Text("Click Here"),
                                                    )

                                                  ],
                                                ),
                                              )
                                              ,
                                              Expanded(child: Image.asset("images/clock.png"))
                                            ],
                                          )
                                      ),
                                    ),

                                  ],
                                ),
                              ),
                              Positioned(
                                bottom: 15,
                                left: screenWidth*0.95*0.4,
                                child: Padding(
                                  padding:  EdgeInsets.all(marginValue),
                                  child: SmoothPageIndicator(controller: _pageController, count: 3, effect: WormEffect(
                                    dotColor: Colors.grey,
                                    activeDotColor: Colors.blue,
                                    dotHeight: screenWidth*0.02,
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
                              ),

                            ],
                          ),
                        ),
                        SizedBox(height: screenHeight*0.01,),
                        brands(),
                        SizedBox(height: screenHeight*0.01,),
                        product(),
                        SizedBox(height: screenHeight*0.04,),
                        departments(),
                        SizedBox(height: screenHeight*0.04,),

departments2()
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Bottombar(),
    );
  }
}
class departments extends StatefulWidget {
  const departments({super.key});

  @override
  State<departments> createState() => _departmentsState();
}

class _departmentsState extends State<departments> {
  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    double screenWidth = mediaQueryData.size.width;
    double screenHeight = mediaQueryData.size.height;
    double fontSize = MediaQuery.of(context).size.shortestSide * 0.05;
    double marginValue = MediaQuery.of(context).size.width * 0.02;
    return Column(
      children: [
        Padding(
          padding:  EdgeInsets.all(marginValue),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Text("Shop by Departement",style: TextStyle(fontSize: fontSize,fontWeight: FontWeight.bold),),
              ),
              Container(
                child: Text("View all",style: TextStyle(decoration: TextDecoration.underline,color: Colors.blue),),
              )
            ],
          ),
        ),

        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child:Row(
            children: [
              Wrap(
                spacing: marginValue,
                children: List.generate(context.read<DataService>().categories.length, (index){
                  return departementitem(dp: context.read<DataService>().categories[index]);
                }),
              )


            ],
          ),
        ),
      ],
    );
  }
}
class departementitem extends StatefulWidget {
  final categorie dp;
  const departementitem({super.key,required this.dp});

  @override
  State<departementitem> createState() => _departementitemState();
}

class _departementitemState extends State<departementitem> {
  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    double screenWidth = mediaQueryData.size.width;
    double screenHeight = mediaQueryData.size.height;
    double fontSize = MediaQuery.of(context).size.shortestSide * 0.05;
    double marginValue = MediaQuery.of(context).size.width * 0.02;
    return  InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>  SearchScreen(dp: [widget.dp],br: [],list:context.read<DataService>().listproduct)),
        );
      },
      child: Column(
        children: [
          ClipOval(
            child:
            Container(
              width: screenHeight*0.1,
              height: screenHeight*0.1,

              decoration: BoxDecoration(

                boxShadow: [
                  BoxShadow(

                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 5,
                    blurRadius: 10,
                    offset: Offset(0, 3),

                  ),

                ],
              ),
              child:  widget.dp.image.toLowerCase().endsWith('.svg+xml')?
              SvgPicture.network(
                url + "/getimage/" + widget.dp.image,
                placeholderBuilder: (BuildContext context) => CircularProgressIndicator(),

              ):
              Image.network(
                url+"/getimage/"+widget.dp.image,


              ),
            ),

          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(widget.dp.name.toUpperCase(),style: TextStyle(fontSize: fontSize*0.5,fontWeight: FontWeight.bold),),
          )

        ],
      ),
    );
  }
}

class products extends StatefulWidget {
  final List<Productgen> listproduct;
  final double width;
  final double height;



  const products({super.key,required this.listproduct,required this.width,required this.height});

  @override
  State<products> createState() => _productsState();
}




class _productsState extends State<products> {



@override
void initState() {
  super.initState();


}
  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    double screenWidth = mediaQueryData.size.width;
    double screenHeight = mediaQueryData.size.height;
    double fontSize = MediaQuery.of(context).size.shortestSide * 0.05;
    double marginValue = MediaQuery.of(context).size.width * 0.02;


    return  Wrap(
      spacing: screenWidth*0.05,
      runSpacing: 8.0,
      children:
List.generate(  this.widget.listproduct.length
    , (index)  {
  List<Productgen> listproduct=    this.widget.listproduct;
  return
    productitem(p: listproduct[index],delete:(){

  },width: this.widget.width,height: this.widget.height,);
})



      ,
    );
  }
}

class product extends StatefulWidget {
  const product({super.key});

  @override
  State<product> createState() => _productState();
}

class _productState extends State<product> {
  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    double screenWidth = mediaQueryData.size.width;
    double screenHeight = mediaQueryData.size.height;
    double fontSize = MediaQuery.of(context).size.shortestSide * 0.05;
    double marginValue = MediaQuery.of(context).size.width * 0.02;
    return Column(
      children: [
        Padding(
          padding:  EdgeInsets.all(marginValue),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Text("Recommended for you",style: TextStyle(fontSize: fontSize,fontWeight: FontWeight.bold),),
              ),
              Container(
                child: Text("View all",style: TextStyle(color: Colors.blue),),
              ),

            ],
          ),
        ),


        products(listproduct: context.read<DataService>().listproductenuser,height: 0 ,width:screenWidth*0.4,)



      ],
    );
  }
}


class departments2 extends StatefulWidget {
  const departments2({super.key});

  @override
  State<departments2> createState() => _departments2State();
}

class _departments2State extends State<departments2> {
  @override
  Widget build(BuildContext context) {

    MediaQueryData mediaQueryData = MediaQuery.of(context);
    double screenWidth = mediaQueryData.size.width;
    double screenHeight = mediaQueryData.size.height;
    double fontSize = MediaQuery.of(context).size.shortestSide * 0.05;
    double marginValue = MediaQuery.of(context).size.width * 0.02;
    return Column(
      children: [

        Padding(
          padding:  EdgeInsets.all(marginValue),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Text("Shop by Departement",style: TextStyle(fontSize: fontSize,fontWeight: FontWeight.bold),),
              ),
              Container(
                child: Text("View all",style: TextStyle(decoration: TextDecoration.underline,color: Colors.blue),),
              )
            ],
          ),
        ),

        SizedBox(height: screenHeight*0.01,),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            ClipOval(
              child: Stack(
                children: [
                  Container(
                    width: screenHeight*0.1,
                    height: screenHeight*0.1,

                    decoration: BoxDecoration(

                      boxShadow: [
                        BoxShadow(

                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 5,
                          blurRadius: 10,
                          offset: Offset(0, 3),

                        ),

                      ],
                    ),
                    child: ClipRRect(
                      child: Image.asset(
                        'images/shoes.png',
                      ),
                    ),
                  ),
                  Positioned.fill(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 1.5, sigmaY: 0.5),
                      child: Container(
                        color: Colors.white.withOpacity(0),
                      ),
                    ),
                  ),

                  Positioned(
                    top: screenHeight*0.1 * 0.4,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Flexible(
                        child: Text(
                          'SHOES',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: fontSize*0.7,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ClipOval(
              child: Stack(
                children: [
                  Container(
                    width: screenHeight*0.1,
                    height: screenHeight*0.1,

                    decoration: BoxDecoration(

                      boxShadow: [
                        BoxShadow(

                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 5,
                          blurRadius: 10,
                          offset: Offset(0, 3),

                        ),

                      ],
                    ),
                    child: ClipRRect(
                      child: Image.asset(
                        'images/product.png',
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Positioned.fill(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 0.5, sigmaY: 0.5),
                      child: Container(
                        color: Colors.white.withOpacity(0),
                      ),
                    ),
                  ),

                  Positioned(
                    top: screenHeight*0.1 * 0.4,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Flexible(
                        child: Text(
                          'MEN',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: fontSize*0.7,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ClipOval(
              child: Stack(
                children: [
                  Container(
                    width: screenHeight*0.1,
                    height: screenHeight*0.1,

                    decoration: BoxDecoration(

                      boxShadow: [
                        BoxShadow(

                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 5,
                          blurRadius: 10,
                          offset: Offset(0, 3),

                        ),

                      ],
                    ),
                    child: ClipRRect(
                      child: Image.asset(
                        'images/shoes.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned.fill(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 1.5, sigmaY: 0.5),
                      child: Container(
                        color: Colors.white.withOpacity(0),
                      ),
                    ),
                  ),

                  Positioned(
                    top: screenHeight*0.1 * 0.4,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Flexible(
                        child: Text(
                          'KIDS',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: fontSize*0.7,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ClipOval(
              child: Stack(
                children: [
                  Container(
                    width: screenHeight*0.1,
                    height: screenHeight*0.1,

                    decoration: BoxDecoration(

                      boxShadow: [
                        BoxShadow(

                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 5,
                          blurRadius: 10,
                          offset: Offset(0, 3),

                        ),

                      ],
                    ),
                    child: ClipRRect(
                      child: Image.asset(
                        'images/shoes.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned.fill(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 1.5, sigmaY: 0.5),
                      child: Container(
                        color: Colors.white.withOpacity(0),
                      ),
                    ),
                  ),

                  Positioned(
                    top: screenHeight*0.1 * 0.4,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Flexible(
                        child: Text(
                          'WOMEN',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: fontSize*0.7,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ClipOval(
              child: Stack(
                children: [
                  Container(
                    width: screenHeight*0.1,
                    height: screenHeight*0.1,

                    decoration: BoxDecoration(

                      boxShadow: [
                        BoxShadow(

                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 5,
                          blurRadius: 10,
                          offset: Offset(0, 3),

                        ),

                      ],
                    ),
                    child: ClipRRect(
                      child: Image.asset(
                        'images/shoes.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned.fill(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 1.5, sigmaY: 0.5),
                      child: Container(
                        color: Colors.white.withOpacity(0),
                      ),
                    ),
                  ),

                  Positioned(
                    top: screenHeight*0.1 * 0.4,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Flexible(
                        child: Text(
                          'ACCES',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: fontSize*0.7,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),


          ],
        ),
      ],
    );
  }
}
