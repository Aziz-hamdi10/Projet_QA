import 'package:wave_linear_progress_indicator/wave_linear_progress_indicator.dart';
import 'package:flutter/material.dart';

class rattingbar extends StatefulWidget {
  final String text;
  final double value;
  const   rattingbar({super.key,required this.text,required this.value});

  @override
  State<rattingbar> createState() => _rattingbarState();
}

class _rattingbarState extends State<rattingbar> {
  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    double screenWidth = mediaQueryData.size.width;
    double screenHeight = mediaQueryData.size.height;
    double fontSize = MediaQuery.of(context).size.shortestSide * 0.05;
    double marginValue = MediaQuery.of(context).size.width * 0.02;

    return  Row(
      children: [
        Text(this.widget.text,style: TextStyle(fontSize: fontSize*0.7),),
        SizedBox(width: screenWidth*0.01),

        SizedBox(
          width: screenWidth*0.4,
          child: LinearProgressIndicator(
            value:this.widget.value,
            minHeight: screenHeight*0.015,
            backgroundColor: Colors.grey,
            borderRadius: BorderRadius.circular(5),
          ),
        ),
      ],
    );
  }
}
