import 'dart:io';
import 'dart:typed_data';
import 'package:bridgewearaa/config.dart';
import 'package:bridgewearaa/services/data.dart';
import 'package:bridgewearaa/widget/CustomErormsg.dart';
import 'package:provider/provider.dart';

import 'package:bridgewearaa/controlleur/productcontrolleur.dart';
import 'package:bridgewearaa/models/product.dart';
import 'package:bridgewearaa/screens/productdetails.dart';
import 'package:bridgewearaa/services/imagecompress.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../models/productgenerale.dart';
class LoadingScreen extends StatelessWidget {
  final Future<void> loadingFuture;
  final StatefulWidget nextScreen;
  final String id;
  final dynamic parameter;
  LoadingScreen({required this.parameter,required this.id,required this.loadingFuture, required this.nextScreen});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: loadingFuture,
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Display a loading indicator while waiting for the future to complete
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            // Display an error message if the future throws an error
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            if (parameter != null) {
              WidgetsBinding.instance!.addPostFrameCallback((_) {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => nextScreen,
                  ),
                );
              });
            }

            return Container(); // Return an empty container while navigating
          }
        },
      ),
    );
  }
}
class NextScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Replace this with your actual screen content
    return Scaffold(
      appBar: AppBar(
        title: Text('Next Screen'),
      ),
      body: Center(
        child: Text('Next Screen Content'),
      ),
    );
  }
}

class productitem extends StatefulWidget {
  final Productgen p;
  final Function delete;
  final double width;
  final double height;
  const productitem({super.key,required this.p,required this.height,required this.width,
    required this.delete
  });

  @override
  State<productitem> createState() => _productitemState();
}

class _productitemState extends State<productitem> {
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
              builder: (context) =>productdetails(p: widget.p.id,))
                  ,
        );

      },
      child: Padding(
        padding:  EdgeInsets.all(marginValue),

        child: Container(
          width: this.widget.width,

          child: Column(
            children: [

              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(topRight: Radius.circular(10), topLeft: Radius.circular(10)),
                    child: Image.network(

                      url+"/getimage/"+widget.p.imgaename, // Assuming you want to display the first image
                      fit: BoxFit.cover,
                    )
                  )
                  ,
                  if(context.read<DataService>().user!.id!=widget.p.user!.id)

                    Positioned(
                    top: 10,
                    right: 10,
                    child: ClipOval(

                      child: Container(
                        color: Colors.white,
                        height: screenHeight*0.035
                        ,
                        width:  screenHeight*0.035
                        ,
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              if(searchProductById(this.widget.p.id, context.read<DataService>().listproductliked )){
                                removeProductById(this.widget.p.id,context.read<DataService>().listproductliked);
                              }
                              else{
                                context.read<DataService>().listproductliked.add(Productgen(state:"available" ,user:this.widget.p.user!, imgaename: this.widget.p.imgaename, Originalprice: this.widget.p.Originalprice, SeelingPrice: this.widget.p.SeelingPrice, id: this.widget.p.id, name: this.widget.p.name));
                              }
                              addToWishlist(context.read<DataService>().user!.id,this.widget.p.id,(likemsg) {
                                setState(() {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          backgroundColor: Colors.pinkAccent,
                                          content:                               Customerrormsg(icon: Icons.done,message:likemsg,bgcolor: Colors.pinkAccent,)

                                      ))
                                  ;
                                });
                              },
                                    (dislikemsg) {
                                setState(() {
                                  context.read<DataService>().listproductliked.remove(this.widget.p);

                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          backgroundColor: Colors.grey,
                                          content:                               Customerrormsg(icon: Icons.done,message:dislikemsg,bgcolor: Colors.grey,)

                                      ))
                                  ;
                                });
                              },);
                            });

                          },
                          child: Center(
                            child: SvgPicture.asset("assets/icons/Heart.svg",
                                fit: BoxFit.fitWidth,
                                color:searchProductById(this.widget.p.id, context.read<DataService>().listproductliked )? Colors.red:Colors.black
                            ),
                          ),
                        ),
                      ),
                    ),

                  )
                ],
              ),
              Padding(
                padding:  EdgeInsets.all(marginValue),
                child: Row(

                  children: [
                    ClipOval(

                      child:
                      widget.p.user.picture.toLowerCase().endsWith('.svg+xml')?
                      SvgPicture.network(
                        url + "/getimage/" +widget.p.user.picture,
    fit: BoxFit.fill,height: screenHeight*0.03,width: screenHeight*0.03,
    // Placeholder widget while loading, if needed
                        placeholderBuilder: (BuildContext context) => CircularProgressIndicator(),

                      ):
                      Image.network(
                        url+"/getimage/"+widget.p.user.picture, // Assuming you want to display the first image
                        fit: BoxFit.fill,height: screenHeight*0.03,width: screenHeight*0.03,) ,

                      ),



                    SizedBox(width: screenWidth*0.02,),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child:Text(
                        widget.p.user.firstname+" " + widget.p.user.secondname,
                        style: TextStyle(fontSize:fontSize*0.5), // Set your desired font size
                      ),
                    ),
                  ],

                ),
              ),
              Container(
                width: this.widget.width,
                child: Padding(
                  padding:  EdgeInsets.all(marginValue),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(child: FittedBox(child: Text(this.widget.p.name,style: TextStyle(fontSize: fontSize*0.6)))),
                      Container(
                          width: this.widget.width * 0.3,
                          child:FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Column(
                              children: [
                                Text(
                                  this.widget.p.SeelingPrice.toStringAsFixed(0)+" DT",
                                  style: TextStyle(fontWeight: FontWeight.bold,
                                      fontSize: fontSize,
                                      color: Colors.blueAccent

                                  ),),
                                Text(
                                  this.widget.p.Originalprice.toStringAsFixed(0)+" DT",
                                  style: TextStyle(fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.lineThrough,
                                  ),),
                              ],
                            ),
                          )
                      )
                    ],

                  ),
                ),
              ),
            ],
          ),


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

        ),
      ),
    );
  }
}