import 'package:bridgewearaa/services/data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class sizefilter extends StatefulWidget {
  final List<String> listfitrer;
  const sizefilter({Key? key,required this.listfitrer}) : super(key: key);

  @override
  State<sizefilter> createState() => _CustomSliderState();
}

class _CustomSliderState extends State<sizefilter> {
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
                    "Size",
                    style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold),
                  ),

                  if(this.widget.listfitrer.isNotEmpty)
                    Container(

                      child: Padding(
                        padding: EdgeInsets.all(marginValue),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              this.widget.listfitrer.clear();

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
                runSpacing: marginValue,
                children: List.generate(this.widget.listfitrer.length, (index) {
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
                              this.widget.listfitrer[index].toUpperCase(),
                              style: TextStyle(fontSize: fontSize * 0.6, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(width: screenWidth * 0.01),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  this.widget.listfitrer.remove(this.widget.listfitrer[index]);
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
                    List.generate(context.read<DataService>().listsize.length, (index) {
                      List<String> listsize=    context.read<DataService>().listsize;
                      return Stack(
                        alignment: Alignment.topRight,
                        children: [
                          InkWell(
                            onTap: () {
                              if(!this.widget.listfitrer.contains(listsize[index]))
                                setState(() {
                                  this.widget.listfitrer.add(listsize[index]);

                                });
                              else{
                                setState(() {
                                  this.widget.listfitrer.remove(listsize[index]);

                                });

                              }

                            },
                            child: Container(
                              decoration: BoxDecoration(

                                  shape: BoxShape.circle,
                                  color: Colors.grey.withOpacity(0.3),
                                  border: Border.all(color:this.widget.listfitrer.contains(listsize[index])?Colors.blueAccent:Colors.transparent,width: screenWidth*0.005)
                              ),
                              child: CircleAvatar(
                                radius: screenWidth*0.1,
                                backgroundColor: Colors.transparent,
                                child: Text(listsize[index].toUpperCase(),textAlign: TextAlign.center,style: TextStyle(color: Colors.black,fontSize: fontSize,fontWeight: FontWeight.bold),),

                              ),
                            ),
                          ),
                          if(this.widget.listfitrer.contains(listsize[index]))
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