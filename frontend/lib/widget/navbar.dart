import 'package:bridgewearaa/Webpart/pages/userscreen.dart';
import 'package:bridgewearaa/config.dart';
import 'package:bridgewearaa/screens/Profile.dart';
import 'package:bridgewearaa/screens/bag.dart';
import 'package:bridgewearaa/services/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class navbar2 extends StatefulWidget {
  const navbar2({super.key});

  @override
  State<navbar2> createState() => _navbarState();
}

class _navbarState extends State<navbar2> {
  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    double screenWidth = mediaQueryData.size.width;
    double screenHeight = mediaQueryData.size.height;
    double marginValue = MediaQuery.of(context).size.width * 0.02;

    return
      Padding(
        padding:  EdgeInsets.all(marginValue),
        child:
      Column(
        children: [
          Container(
              color: Colors.white,
              height: 50,
              width: screenWidth,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:  EdgeInsets.all(marginValue),
                    child: ClipOval(


                      child: Image.asset("images/aziz.png",
                        width: screenWidth*0.09,
                      ),


                    ),
                  ),

                  Image.asset(
                    "images/navbarlogo.png"

                    ,
                    height: screenHeight*0.07,


                  ),

                  ClipOval(


                    child: SvgPicture.asset(
                      "assets/icons/Bag.svg"
                    )


                  ),




                ],
              ),




          ),
          Divider(
            height: screenHeight*0.005,
          )
        ],
      ));
  }
}
class navbar extends StatelessWidget implements PreferredSizeWidget {

  @override
  static const IconData shopping_bag_outlined = IconData(0xf37d, fontFamily: 'MaterialIcons');

  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    double screenWidth = mediaQueryData.size.width;
    double screenHeight = mediaQueryData.size.height;
    double fontSize = MediaQuery.of(context).size.shortestSide * 0.05;
    double marginValue = MediaQuery.of(context).size.width * 0.02;
    return  AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      title: Image.asset(
        "images/navbarlogo.png"

        ,
        height: screenHeight*0.06,
      ),centerTitle: true,
      leading:
       IconButton(

            icon:
             ClipOval(
               child: context.read<DataService>().user!.picture.toLowerCase().endsWith('.svg+xml')?
               SvgPicture.network(
                 url + "/getimage/" + context.read<DataService>().user!.picture,
                   fit:BoxFit.cover,

                 // Placeholder widget while loading, if needed
                 placeholderBuilder: (BuildContext context) => CircularProgressIndicator(),

               ):
               Image.network(
                 url+"/getimage/"+context.read<DataService>().user!.picture, // Assuming you want to display the first image
fit:BoxFit.cover
               ),),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => profile(user: context.read<DataService>().user!.id)),
              );
            },
          )

    ,



      actions: [
        Padding(
          padding: EdgeInsets.only(right: marginValue),
        child:
            IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder:(context) => bag(), ));
              },
              icon:  SvgPicture.asset(
                  "assets/icons/Bag.svg",
                width: screenWidth*0.2,
              ),
            )

        )
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
class navbarliv extends StatelessWidget implements PreferredSizeWidget {

  @override
  static const IconData shopping_bag_outlined = IconData(0xf37d, fontFamily: 'MaterialIcons');

  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    double screenWidth = mediaQueryData.size.width;
    double screenHeight = mediaQueryData.size.height;
    double fontSize = MediaQuery.of(context).size.shortestSide * 0.05;
    double marginValue = MediaQuery.of(context).size.width * 0.02;
    return  AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      title: Image.asset(
        "images/navbarlogo.png"

        ,
        height: screenHeight*0.06,
      ),centerTitle: true,
      leading:
      IconButton(

        icon:
        ClipOval(
          child: context.read<DataService>().user!.picture.toLowerCase().endsWith('.svg+xml')?
          SvgPicture.network(
            url + "/getimage/" + context.read<DataService>().user!.picture,
            fit:BoxFit.cover,

            // Placeholder widget while loading, if needed
            placeholderBuilder: (BuildContext context) => CircularProgressIndicator(),

          ):
          Image.network(
              url+"/getimage/"+context.read<DataService>().user!.picture, // Assuming you want to display the first image
              fit:BoxFit.cover
          ),),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder:(context) => Scaffold(
              appBar: AppBar(
                elevation: 0,
                backgroundColor: Colors.white,

                leading:    IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },

                    icon:  Icon(Icons.close  ,
                        size: fontSize*1.5,
                        color: Colors.black)

                ),





              ),
              body: userscren(user: context.read<DataService>().user!.id)), ));

        },
      )

      ,




    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
