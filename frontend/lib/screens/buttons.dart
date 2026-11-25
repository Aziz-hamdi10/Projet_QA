import 'package:bridgewearaa/screens/inputs.dart';
import 'package:bridgewearaa/screens/loading.dart';
import 'package:flutter/material.dart';

class button extends StatefulWidget {
  final double height;
  final double width;
  final String label;
  final Color color;
  final Function? onclick;
  const button({this.onclick,super.key,required this.color,required this.width,required this.label, required this.height});

  @override
  State<button> createState() => _buttonState();
}

class _buttonState extends State<button> {

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);

    double screenWidth = mediaQueryData.size.width;
    double screenHeight = mediaQueryData.size.height;
    double fontSize = MediaQuery.of(context).size.shortestSide * 0.05;
    double marginValue = MediaQuery.of(context).size.width * 0.02;
    return               Padding(
      padding:  EdgeInsets.fromLTRB(0, marginValue+5, 0, marginValue),
      child: Center(
        child: Container(
          height: this.widget.height,
          width: this.widget.width,
          child: ElevatedButton(
            onPressed: () {
                this.widget.onclick!();
            },
            child: Text(
              this.widget.label,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: fontSize+5,
                  fontWeight: FontWeight.bold,
                  fontFamily: "LALEZAR"
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: this.widget.color,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
            ),
          ),
        ),
      ),

    );
  }
}
