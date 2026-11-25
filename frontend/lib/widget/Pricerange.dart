import 'package:flutter/material.dart';
class PriceRangeWidget extends StatefulWidget {
  final TextEditingController prixmin;
  final TextEditingController prixmax;
  const PriceRangeWidget({super.key,required this.prixmin,required this.prixmax});

  @override
  State<PriceRangeWidget> createState() => _PriceRangeWidgetState();
}

class _PriceRangeWidgetState extends State<PriceRangeWidget> {

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    double screenWidth = mediaQueryData.size.width;
    double screenHeight = mediaQueryData.size.height;
    double fontSize = MediaQuery.of(context).size.shortestSide * 0.05;
    double marginValue = MediaQuery.of(context).size.width * 0.02;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Prices",
              style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold),
            ),


          ],
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              width: screenWidth*0.3,
              child: TextField(
                controller: this.widget.prixmin,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Min Price'),
              ),
            ),
            Container(
              width: screenWidth*0.3,
              child: TextField(
                controller: this.widget.prixmax,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Max Price',labelStyle:
                TextStyle(fontSize: fontSize)),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

