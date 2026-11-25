import 'package:bridgewearaa/config.dart';
import 'package:bridgewearaa/models/brand.dart';
import 'package:bridgewearaa/screens/searchscreen.dart';
import 'package:bridgewearaa/services/data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';

class brands extends StatefulWidget {
  int? pos;
  bool? onclick;

   brands({super.key,this.pos=-1,this.onclick});

  @override
  State<brands> createState() => _brandsState();
}

class _brandsState extends State<brands> {
  @override
  Widget build(BuildContext context) {

    MediaQueryData mediaQueryData = MediaQuery.of(context);
    double screenWidth = mediaQueryData.size.width;
    double screenHeight = mediaQueryData.size.height;
    double fontSize = MediaQuery.of(context).size.shortestSide * 0.05;
    double marginValue = MediaQuery.of(context).size.width * 0.02;
    List<brand> listbrand=context.read<DataService>().brands;
    return Column(
      children: [
        Padding(
          padding:  EdgeInsets.all(marginValue),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Text("Popular Brands",style: TextStyle(fontSize: fontSize,fontWeight: FontWeight.bold),),
              ),
              Container(
                child: Text("View all",style: TextStyle(color: Colors.blue),),
              )
            ],
          ),
        ),

        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child:Row(
            children: [
              SizedBox(width: screenHeight*0.025,),

              Wrap(
                spacing:screenWidth*0.02,
                children:
                  List.generate(listbrand.length, (index) {
                    return InkWell(
                      onTap: () {
                        if(this.widget.onclick==true){
                          setState(() {
                            this.widget.pos=index;

                          });
                        }
                        else{
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>  SearchScreen(dp: [],br: [listbrand[index]],list:context.read<DataService>().listproduct)),
                          );
                        }

                      },
                      child: Container(
                        height: screenHeight * 0.1,
                        width: screenHeight * 0.1,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey.withOpacity(0.3),
                          border: Border.all(color: this.widget.pos == index ? Colors.blueAccent : Colors.transparent, width: screenWidth * 0.005),
                        ),
                        child: ClipOval(

                          child:ClipOval(

                            child:
                            listbrand[index].image.toLowerCase().endsWith('.svg+xml')?
                            SvgPicture.network(
                              url + "/getimage/" + listbrand[index].image,
                              // Placeholder widget while loading, if needed
                              placeholderBuilder: (BuildContext context) => CircularProgressIndicator(),

                            ):
                            Image.network(
                              url+"/getimage/"+listbrand[index].image, // Assuming you want to display the first image

                            ),
                          ),
                        ),
                      ),

                    );
                  })




                ,
              ),


            ],
          ),
        ),

      ],
    );
  }
}
