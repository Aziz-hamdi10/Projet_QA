import 'package:bridgewearaa/services/data.dart';
import 'package:bridgewearaa/widget/Pricerange.dart';
import 'package:bridgewearaa/widget/brandsflitrer.dart';
import 'package:bridgewearaa/widget/couleursfiltred.dart';
import 'package:bridgewearaa/widget/custom_button.dart';
import 'package:bridgewearaa/widget/customcategorie.dart';
import 'package:bridgewearaa/widget/sizefilter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import 'categoriefiltred.dart';

class custombottomSheetFilter extends StatefulWidget {
  final TextEditingController prixmin;
  final TextEditingController prixmax;

  final Function charge;
  const custombottomSheetFilter({super.key,required this.charge,required this.prixmax,required this.prixmin});
  @override
  State<custombottomSheetFilter> createState() => _State();
}

class _State extends State<custombottomSheetFilter> {

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    double screenWidth = mediaQueryData.size.width;
    double screenHeight = mediaQueryData.size.height;
    double fontSize = MediaQuery.of(context).size.shortestSide * 0.05;
    double marginValue = MediaQuery.of(context).size.width * 0.02;


    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(marginValue),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [


                brandsfiltrer(listbrandsfiltrerd:context.read<DataService>().listbrandfiltrer),
                SizedBox(height: screenHeight*0.01,),
                categoriefiltred(listcategoriefiltred:context.read<DataService>().listcategoriefiltred)
                ,
                SizedBox(height: screenHeight*0.01,),
                sizefilter(listfitrer:context.read<DataService>().listsizefilter)
,
                SizedBox(height: screenHeight*0.01,),
                Colorsfiltred(listcouleursfiltred:context.read<DataService>().listcolorsfiltred)
                ,
                SizedBox(height: screenHeight*0.01,),

PriceRangeWidget(prixmin: this.widget.prixmin,prixmax: this.widget.prixmax,)
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(marginValue),
          child: Row(
            children: [
              Expanded(
                child: CustomButton(
                  onTap: () {
                    setState(() {
                      context.read<DataService>().listsizefilter.clear();
                      context.read<DataService>().listbrandfiltrer.clear();
                    });
                    this.widget.charge();
                    Navigator.pop(context);

                  },
                  text: "Cancel",
                  color: Colors.grey,
                  textColor: Colors.white,
                ),
              ),
              SizedBox(
                width: screenWidth * 0.02,
              ),
              Expanded(
                child: CustomButton(
                  onTap: () {
                    this.widget.charge();
                    Navigator.pop(context);

                  },
                  text: "Done",
                  color: Colors.blueAccent,
                  textColor: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
