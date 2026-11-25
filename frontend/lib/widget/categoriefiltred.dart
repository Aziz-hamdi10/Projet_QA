import 'package:bridgewearaa/config.dart';
import 'package:bridgewearaa/models/brand.dart';
import 'package:bridgewearaa/models/categorie.dart';
import 'package:bridgewearaa/services/data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/brand.dart';
import 'package:flutter_svg/flutter_svg.dart';

class categoriefiltred extends StatefulWidget {
  int? pos;
  bool? onclick;
  List<categorie> listcategoriefiltred;

  categoriefiltred({super.key,this.pos=-1,this.onclick,required this.listcategoriefiltred});

  @override
  State<categoriefiltred> createState() => _brandsfiltrerState();
}

class _brandsfiltrerState extends State<categoriefiltred> {
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    Text(
                      "Popular Categorie",


                      style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold),

                    ),
                    if(this.widget.listcategoriefiltred.isNotEmpty)
                      Container(

                        child: Padding(
                          padding: EdgeInsets.all(marginValue),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                this.widget.listcategoriefiltred.clear();

                              });
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "All Delete",
                                  style: TextStyle(decoration: TextDecoration.underline,fontSize: fontSize * 0.6, fontWeight: FontWeight.bold),
                                ),
                                SizedBox(width: screenWidth * 0.01),
                                Icon(Icons.delete,color: Colors.red,size: fontSize,)
                              ],
                            ),
                          ),
                        ),
                      )
                  ],
                ),
                Wrap(
                  runSpacing: marginValue, // Set the runSpacing property to define the spacing between lines
                  children: List.generate(this.widget.listcategoriefiltred.length, (index) {
                    return Padding(
                      padding: EdgeInsets.all(marginValue),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.blueAccent.withOpacity(0.5),
                          border: Border.all(color: Colors.black.withOpacity(0.5)),
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(marginValue),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                this.widget.listcategoriefiltred[index].name,
                                style: TextStyle(fontSize: fontSize * 0.6, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(width: screenWidth * 0.01),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    this.widget.listcategoriefiltred.remove(this.widget.listcategoriefiltred[index]);
                                  });
                                },
                                child: Icon(Icons.cancel),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ],
            )

        ),
        const SizedBox(
          height: 20,
        ),
        Column(
          children: [

            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child:Row(
                children: [
                  SizedBox(width: screenHeight*0.025,),

                  Wrap(
                    spacing:screenWidth*0.02,
                    children:
                    List.generate(context.read<DataService>().categories.length, (index) {
                      List<categorie> listcategorie=    context.read<DataService>().categories;
                      return Stack(
                        alignment: Alignment.topRight,
                        children: [
                          InkWell(
                            onTap: () {
                              if(!this.widget.listcategoriefiltred.contains(listcategorie[index]))
                                setState(() {
                                  this.widget.listcategoriefiltred.add(listcategorie[index]);

                                });
                              else{
                                setState(() {
                                  this.widget.listcategoriefiltred.remove(listcategorie[index]);

                                });

                              }

                            },
                            child:  Container(
                              height: screenHeight * 0.1,
                              width: screenHeight * 0.1,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.grey.withOpacity(0.3),
                                border: Border.all(color: this.widget.pos == index ? Colors.blueAccent : Colors.transparent, width: screenWidth * 0.005),
                              ),
                              child: ClipOval(

                                child:
                                listcategorie[index].image.toLowerCase().endsWith('.svg+xml')?
                                SvgPicture.network(
                                  url + "/getimage/" + listcategorie[index].image,
                                  // Placeholder widget while loading, if needed
                                  placeholderBuilder: (BuildContext context) => CircularProgressIndicator(),

                                ):
                                Image.network(
                                  url+"/getimage/"+listcategorie[index].image, // Assuming you want to display the first image

                                ),
                              ),
                            ),
                          ),
                          if(this.widget.listcategoriefiltred.contains(listcategorie[index]))
                            CircleAvatar(
                              radius: fontSize * 0.5,
                              backgroundColor: Colors.blueAccent,
                              child: FittedBox(
                                fit: BoxFit.scaleDown, // This ensures the icon fits within the CircleAvatar
                                child: Icon(Icons.check, color: Colors.white),
                              ),
                            )

                        ],
                      );
                    })




                    ,
                  ),


                ],
              ),
            )


          ],
        )
      ],
    );
  }
}
