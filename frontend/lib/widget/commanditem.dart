import 'dart:io';

import 'package:bridgewearaa/Webpart/widgets/orderitem.dart';
import 'package:bridgewearaa/config.dart';
import 'package:bridgewearaa/controlleur/aviscontrolleur.dart';
import 'package:bridgewearaa/models/avis.dart';
import 'package:bridgewearaa/models/commande.dart';
import 'package:bridgewearaa/screens/addavisscreen.dart';
import 'package:bridgewearaa/widget/commanddetail.dart';
import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class commandeitem extends StatefulWidget {
  final commande c;
  final String?sales;
  const commandeitem({required this.c,super.key,this.sales});

  @override
  State<commandeitem> createState() => _commandeitemState();
}

class _commandeitemState extends State<commandeitem> {
  avis? a;
  getdata(fn)async{
    getAvis((p0) => {
      fn(p0),
    },widget.c.id);
  }
  @override
  void initState() {
    super.initState();
    if(widget.c.etat=="Finished"||widget.c.etat=="Canceled")
    getdata((p0){
      setState(() {
        a=p0;
      });
    });

  }
  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    double screenWidth = 0;
    double screenHeight = 0;
    if(mediaQueryData.size.width>mediaQueryData.size.height){
screenWidth=mediaQueryData.size.height/3;
screenHeight=mediaQueryData.size.width/3;
    }
    else{
screenWidth=mediaQueryData.size.width;
screenHeight=mediaQueryData.size.height;
    }

    double fontSize = MediaQuery.of(context).size.shortestSide * 0.05;
    double marginValue = screenWidth * 0.02;
    commande c=widget.c;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>  commanddetail(c: c.id),
              ),
            );

          },
          child:           Container(
            height: screenHeight * 0.2,

            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Flexible(
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(marginValue),
                            child: Expanded(
                              child: ClipRRect(
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                child: Image.network(
                                  url + "/getimage/" + widget.c.prd.imgaenames[0],
                                ),
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 3,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text(
                                    this.widget.c.prd.name + "  " + this.widget.c.prixtotal.toStringAsFixed(1) + " DT",
                                    style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text(
                                    this.widget.c.prd.Brand.title + " - Size " + this.widget.c.prd.Size.name,
                                    style: TextStyle(fontSize: fontSize * 0.7, color: Colors.grey, fontWeight: FontWeight.w500),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                SizedBox(height: screenHeight * 0.01),
                                FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text(
                                    "Ordered On " + DateFormat('dd MMM yyyy HH:mm').format(this.widget.c.dateadd),
                                    style: TextStyle(fontSize: fontSize * 0.7, color: Colors.grey, fontWeight: FontWeight.w500),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                SizedBox(height: screenHeight * 0.01),
                                Container(
                                  decoration: BoxDecoration(
                                    color: getColorForCmdEtat(this.widget.c.etat).withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: Center(
                                    child: Padding(
                                      padding: EdgeInsets.all(marginValue),
                                      child: Row(
                                        children: [
                                          Icon(Icons.circle, size: fontSize * 0.5, color: getColorForCmdEtat(this.widget.c.etat)),
                                          SizedBox(width: screenWidth * 0.01),
                                          FittedBox(
                                            fit: BoxFit.scaleDown,
                                            child: Text(
                                              this.widget.c.etat,
                                              style: TextStyle(fontSize: fontSize * 0.7,color: getColorForCmdEtat(this.widget.c.etat)),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              if(a!=null)
                              Padding(
                                padding:  EdgeInsets.all(8.0),
                                child: RatingBar.readOnly(filledIcon: Icons.star, emptyIcon: Icons.star,alignment: Alignment.center,size: fontSize*1.2,initialRating: a!.rating,filledColor: Colors.blueAccent),
                              )
                              ],
                            ),
                          ),
                          Icon(Icons.navigate_next, size: fontSize * 1.5, color: Colors.grey),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),



        ),
        SizedBox(height: screenHeight*0.01,),
        if(widget.c.datefinished!=null||widget.c.datecancel!=null)
          if(a==null&&widget.sales==null)
        Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child:    Column(
              children: [
Padding(
  padding: const EdgeInsets.all(8.0),
  child:   Text("We'd love to hear your feedback. Please let us know How your order have been",textAlign:TextAlign.center,style: TextStyle(fontSize: fontSize*0.7,color: Colors.blueAccent),),
),
                Padding(
                  padding:  EdgeInsets.all(10),
                  child: RatingBar(
                    alignment: Alignment.center,
                    initialRating: 4,
                    size: fontSize*1.7,

                    filledIcon:Icons.star, emptyIcon: Icons.star, onRatingChanged: (double ) {
                    showModalBottomSheet(
                        context: context,

                        builder: (context) =>Container(
                            height: screenHeight*0.5,
                            child: addavisscreen(change: (Avis){
                              setState(() {
a=Avis;
                              });
                            },idcmd: widget.c.id,numberetoile: double,))

                      // Without invoking the function

                    );

                  },
                  ),
                ),
              ],
            )
        )
      ],
    );
  }
}


List<String> _getmsganddate(DateTime? cancel,DateTime? verif) {
 return[];
}
Color getColorForCmdEtat(String etat) {
  switch (etat.toLowerCase()) {
    case 'waiting confirmation':
      return Colors.grey;
    case 'not valide':
      return Colors.grey;
    case 'canceled':
      return Colors.red;
    case 'No livreur':
      return Color.fromRGBO(254, 186, 11, 1);
    case 'traitement':
      return Color.fromRGBO(254, 186, 11, 1);
    case 'Tocken':
      return Color.fromRGBO(204, 221, 8, 1);
  // Add more cases as needed
    default:
      return Colors.green;
  }
}