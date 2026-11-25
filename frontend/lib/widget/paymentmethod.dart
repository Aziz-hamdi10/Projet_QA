import 'package:bridgewearaa/models/commande.dart';
import 'package:bridgewearaa/models/product.dart';
import 'package:bridgewearaa/screens/DebitCardScreen.dart';
import 'package:bridgewearaa/screens/buttons.dart';
import 'package:bridgewearaa/screens/inputs.dart';
import 'package:bridgewearaa/screens/searchscreen.dart';
import 'package:bridgewearaa/services/data.dart';
import 'package:bridgewearaa/widget/commanditem.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
class paymentmethod extends StatefulWidget {
  final double price;
  final Function fn;
  const paymentmethod({super.key,required this.price,required this.fn});

  @override
  State<paymentmethod> createState() => _paymentmethodState();
}

class _paymentmethodState extends State<paymentmethod> {
  int index=0;

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    double screenWidth = mediaQueryData.size.width;
    double screenHeight = mediaQueryData.size.height;
    double fontSize = MediaQuery.of(context).size.shortestSide * 0.05;
    double marginValue = MediaQuery.of(context).size.width * 0.02;
    return                   Container(
      height: screenHeight*0.12  ,
      width: screenWidth*0.9,

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius: BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5), // Change the shadow color as needed
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3), // Change the offset as needed
          ),

        ],
      ),
      child:
      Padding(
        padding:  EdgeInsets.all(marginValue),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Payment method",style: TextStyle(fontSize: fontSize*0.7,fontWeight: FontWeight.bold),)
            ,
            SizedBox(height: screenHeight*0.01,)
            ,

            Row(
              children: [
                Expanded(child: Container(
                  decoration: BoxDecoration(
                      color: index==0?Colors.blueAccent:Colors.white,
                      border: Border.all(
                          color: Colors.grey
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(10))

                  ),

                  child: Padding(
                    padding:  EdgeInsets.all(marginValue),
                    child: Column(
                      children: [
                        Center(child: InkWell(
                          onTap: () {
                            setState(() {
                              index=0;
                              widget.fn(0);
                            });
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(Icons.motorcycle_outlined,color: index==0?Colors.white:Colors.black),
                              Text("Cash",style:
                              TextStyle(fontWeight: FontWeight.w900,fontSize: fontSize*0.8,
                                  color: index==0?Colors.white:Colors.black),
                              ),
                              index!=0?
                              Icon(Icons.circle_outlined,color:Colors.black)
                                  :
                              Icon(Icons.check_circle_rounded,color:Colors.white),


                            ],
                          ),
                        ),   ),

                      ],
                    ),
                  ),
                )
                ),
                SizedBox(width: screenWidth*0.02,),
                Container(
                  decoration: BoxDecoration(
                      color: index==1?Colors.blueAccent:Colors.white,
                      border: Border.all(
                          color: Colors.grey
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(10))

                  ),
                  child: Padding(
                    padding:  EdgeInsets.all(marginValue),
                    child: Column(
                      children: [
                        Center(child: InkWell(
                            onTap: () {

                            setState(() {
                              index=1;
                              widget.fn(1);

                            });
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,

                              children: [
                                SvgPicture.asset("assets/icons/paiment.svg",height: fontSize,color:index==1?Colors.white:Colors.black,),
                                Text("Card E-dinar",style:
                                TextStyle(fontWeight: FontWeight.w500,fontSize: fontSize*0.7,
                                    color: index==1?Colors.white:Colors.black),
                                ),
                                index!=1?
                                Icon(Icons.circle_outlined,color:Colors.black)
                                    :
                                Icon(Icons.check_circle_rounded,color:Colors.white),

                              ],
                            )
                        ),
                        ),
                      ],
                    ),
                  ),
                )

              ],
            )
          ],
        ),
      ),
    );
    ;
  }
}
