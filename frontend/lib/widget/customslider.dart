import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomSlider extends StatefulWidget {
  const CustomSlider({Key? key}) : super(key: key);

  @override
  State<CustomSlider> createState() => _CustomSliderState();
}

class _CustomSliderState extends State<CustomSlider> {
  double slider = 30;
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
            children: [

              Text(
                "Size",
      style: TextStyle(fontSize: fontSize,fontWeight: FontWeight.bold),),


            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Column(
          children: [




          ],
        )
      ],
    );
  }
}