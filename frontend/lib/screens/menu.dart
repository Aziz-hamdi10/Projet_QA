import 'dart:ui';

import 'package:bridgewearaa/config.dart';
import 'package:bridgewearaa/controlleur/productcontrolleur.dart';
import 'package:bridgewearaa/controlleur/promotioncontrolleur.dart';
import 'package:bridgewearaa/controlleur/usercontrolleur.dart';
import 'package:bridgewearaa/models/categorie.dart';
import 'package:bridgewearaa/models/notification.dart';
import 'package:bridgewearaa/models/promotion.dart';
import 'package:bridgewearaa/screens/likes.dart';
import 'package:bridgewearaa/screens/menu2.dart';
import 'package:bridgewearaa/screens/notification.dart';
import 'package:bridgewearaa/screens/searchscreen.dart';
import 'package:bridgewearaa/services/data.dart';
import 'package:bridgewearaa/widget/bottomnavbar.dart';
import 'package:bridgewearaa/widget/brands.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:bridgewearaa/widget/custom_Text_Form_fild.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
class menubody extends StatefulWidget {
  const menubody({super.key});

  @override
  State<menubody> createState() => _menuState();
}

class _menuState extends State<menubody> {
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



  @override
void initState() {
    super.initState();

    getProducts((p0) => {
      context.read<DataService>().listproduct=p0
    }, context.read<DataService>().user!.id);
  }


  @override
  Widget build(BuildContext context) {

    MediaQueryData mediaQueryData = MediaQuery.of(context);
    double screenWidth = mediaQueryData.size.width;
    double screenHeight = mediaQueryData.size.height;
    double fontSize = MediaQuery.of(context).size.shortestSide * 0.05;
    double marginValue = MediaQuery.of(context).size.width * 0.02;
    int nbrfollow=0;

    return Container(
        color: Colors.white,

        child: Column(
          children: [
            Divider(height: 1,),
            AnimatedContainer(
              duration: Duration(milliseconds: 500),
              height: isSearchVisible ? screenHeight*0.08 : 0,
              child: isSearchVisible ?  Container(
                color: Colors.white,
                child: Padding(
                  padding:  EdgeInsets.fromLTRB(marginValue, 0 , marginValue, 0),
                  child: Row(
                    children: [

                      Expanded(
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>  SearchScreen(dp: [],br: [],list:context.read<DataService>().listproduct)),
                            );
                          },
                          child: CostomTextFormFild(
                            hint: "Search",
                            prefixIcon: Icons.search,
                            suffixIcon: Icons.camera,
                            filled: true,
                            enabled: false,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                              setState(() {
                                isSearchVisible=false;
                              });
                        },
                        icon:
                          Icon(Icons.cancel_outlined,size: fontSize,)
                      ),
                    ],
                  ),
                ),
              ):null,
            ),
            if (isAppBarVisible)

                  Container(
                    color: Colors.white,
                    width: screenWidth,
                    child: Row(
                      children: [
                        Expanded(
                          child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                              MaterialPageRoute(
                                  builder: (context) =>  SearchScreen(dp: context.read<DataService>().categories,br: [],list:context.read<DataService>().listproduct))
                              );


                                                   },
                            child: Text(
                              "ALL",
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                        Expanded(
                          child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>  SearchScreen(dp: [categorie(dateadd: DateTime.now(), id: "id", image: "image", name: "MEN")],br: [],list:context.read<DataService>().listproduct))
                              );                            },
                            child: Text(
                              "MEN",
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                        Expanded(
                          child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>  SearchScreen(dp: [categorie(dateadd: DateTime.now(), id: "id", image: "image", name: "WOMEN")],br: [],list:context.read<DataService>().listproduct))
                              );                            },
                            child: Text(
                              "WOMEN",
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                        Expanded(
                          child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>  SearchScreen(dp: [categorie(dateadd: DateTime.now(), id: "id", image: "image", name: "KIDS")],br: [],list:context.read<DataService>().listproduct))
                              );                            },
                            child: Text(
                              "KIDS",
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                        if(!isSearchVisible)

                          TextButton(
                          onPressed: () {
                            setState(() {
                              isSearchVisible=true;
                            });
                          },
                          child: Icon(Icons.search, color: Colors.black),
                        ),
                      ],
                    ),
                  ),



            Divider(height: 0,),

            Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    isAppBarVisible=!isAppBarVisible;
                  });
                },
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: screenHeight*0.01,),
                      // Your scrollable content

                       Visibility(
                         visible: context.read<DataService>().listpromotion.isNotEmpty,
                        child:SingleChildScrollView(
                          child: Container(
                            child:
                            Container(
                              height: screenHeight*0.25,
                              child: Row(
                                children: List.generate(context.read<DataService>().listpromotion.length, (index){
                                  return  Padding(
                                    padding: const EdgeInsets.all(8.0),
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
                                                  Text(context.read<DataService>().listpromotion[index].percentage.toStringAsFixed(0)+"%OFF",style: TextStyle(color: Colors.black,fontSize: fontSize*2,fontWeight: FontWeight.bold),),
                                                  Text(context.read<DataService>().listpromotion[index].iddepartement.name,style: TextStyle(color: Colors.black,fontSize: fontSize),),
                                                  ElevatedButton(onPressed: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>  SearchScreen(dp: [context.read<DataService>().listpromotion[index].iddepartement],br: [],list:context.read<DataService>().listproduct)),
                                                    );
                                                  }, child: Text("Click Here"),
                                                  )

                                                ],
                                              ),
                                            )
                                            ,
                                            Expanded(child:
                                            context.read<DataService>().listpromotion[index].iddepartement.image.toLowerCase().endsWith('.svg+xml')?
                                            SvgPicture.network(
                                              url + "/getimage/" +   context.read<DataService>().listpromotion[index].iddepartement.image,

                                              // Placeholder widget while loading, if needed
                                              placeholderBuilder: (BuildContext context) => CircularProgressIndicator(),

                                            ):
                                            Image.network(
                                              url+"/getimage/"+ context.read<DataService>().listpromotion[index].iddepartement.image, // Assuming you want to display the first image

                                            ),
                                            )
                                          ],
                                        )
                                    ),
                                  );
                                })








                                ,
                              ),
                            ),
                          ),
                          scrollDirection: Axis.horizontal,
                        ),

                        ),
                      SizedBox(height: screenHeight*0.01,),
                      brands(),
                      product(),
                      departments()

                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );

  }
}

class article extends StatefulWidget {
  const article({super.key});

  @override
  State<article> createState() => _articleState();
}

class _articleState extends State<article> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView();
  }
}

