import 'package:bridgewearaa/models/avis.dart';
import 'package:bridgewearaa/widget/rattingbar.dart';
import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:flutter/material.dart';

import '../controlleur/aviscontrolleur.dart';

class Rattingtotal extends StatefulWidget {
  const Rattingtotal({
    Key? key,
    required this.marginValue,
    required this.fontSize,
    required this.listavis,
  }) : super(key: key);

  final double marginValue;
  final double fontSize;
  final List<avis> listavis;

  @override
  _RattingtotalState createState() => _RattingtotalState();
}

class _RattingtotalState extends State<Rattingtotal> {
  List<double> listcount = List.filled(5, 0);
  List<double> countRatings(List<avis> avisList) {
    List<double> counts = List.filled(5, 0);

    for (var avis in avisList) {
      double rating = avis.rating;
      if (rating >= 0 && rating <= 1) {
        counts[0]++;
      } else if (rating > 1 && rating <= 2) {
        counts[1]++;
      } else if (rating > 2 && rating <= 3) {
        counts[2]++;
      } else if (rating > 3 && rating < 4) {
        counts[3]++;
      } else if (rating >= 4 && rating <= 5) {
        counts[4]++;
      }
    }

    return counts;
  }
  double moy=0;
  @override
  void initState() {
    super.initState();
    moy=calculateAverageRating(widget.listavis);
    listcount=countRatings(widget.listavis);
  }
  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    double screenWidth = mediaQueryData.size.width;
    double screenHeight = mediaQueryData.size.height;

    if (screenHeight < screenWidth) {
      screenWidth = mediaQueryData.size.height;
      screenHeight = mediaQueryData.size.width;
    }

    double fontSize = MediaQuery.of(context).size.shortestSide * 0.05;
    double marginValue = screenWidth * 0.02;

    return Padding(
      padding: EdgeInsets.all(marginValue),
      child: Container(
        width: screenWidth * 0.9,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 10,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 4,
              child: Column(
                children: [
                  Text(
                    moy.toStringAsFixed(1),
                    style: TextStyle(fontSize: fontSize * 3),
                  ),
                  Padding(
                    padding: EdgeInsets.all(marginValue),
                    child: RatingBar.readOnly(
                      filledColor: Colors.blueAccent,
                      filledIcon: Icons.star,
                      emptyIcon: Icons.star_border,
                      initialRating: moy,
                      maxRating: 5,
                      size: screenWidth * 0.07,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 4,
              child: Column(
                children: [
                  rattingbar(text: "5", value: listcount[4]/10),
                  SizedBox(height: screenHeight * 0.005),
                  rattingbar(text: "4", value:  listcount[3]/10),
                  SizedBox(height: screenHeight * 0.005),
                  rattingbar(text: "3", value: listcount[2]/10),
                  SizedBox(height: screenHeight * 0.005),
                  rattingbar(text: "2", value: listcount[1]/10),
                  SizedBox(height: screenHeight * 0.005),
                  rattingbar(text: "1", value: listcount[0]/10),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}