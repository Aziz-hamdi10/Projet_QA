
import 'package:bridgewearaa/config.dart';
import 'package:bridgewearaa/controlleur/notificationcontrolleur.dart';
import 'package:bridgewearaa/models/notification.dart';
import 'package:bridgewearaa/screens/Profile.dart';
import 'package:bridgewearaa/screens/accueil.dart';
import 'package:bridgewearaa/screens/order%20detail.dart';
import 'package:bridgewearaa/screens/productdetails.dart';
import 'package:bridgewearaa/services/data.dart';
import 'package:bridgewearaa/widget/bottomnavbar.dart';
import 'package:bridgewearaa/widget/commanddetail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class notificationappbar extends StatelessWidget implements PreferredSizeWidget {
  @override

  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    double screenWidth = mediaQueryData.size.width;
    double screenHeight = mediaQueryData.size.height;
    double fontSize = MediaQuery.of(context).size.shortestSide * 0.05;
    double marginValue = MediaQuery.of(context).size.width * 0.02;
    return  AppBar(
      automaticallyImplyLeading: false,

      title:Text("Notification",style: TextStyle(fontSize: fontSize),),
      centerTitle: true,
      elevation: 1,

    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class Notificationbody extends StatefulWidget {

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<Notificationbody> {
  List<notification> notifications = [



  ];
  void initState() {
    super.initState();


    getnotifications((list) => {
      setState(() {
        notifications=list;
      })
    },context.read<DataService>().user!.id);






  }

  @override
  Widget build(BuildContext context) {

    MediaQueryData mediaQueryData = MediaQuery.of(context);
    double screenWidth = mediaQueryData.size.width;
    double screenHeight = mediaQueryData.size.height;
    double fontSize = MediaQuery.of(context).size.shortestSide * 0.05;
    double marginValue = MediaQuery.of(context).size.width * 0.02;

    return Stack(

      children: [


        Padding(
          padding:  EdgeInsets.all(marginValue*2),
          child: Center(
            child:               ListView(
              children: [
                Center(
                  child: Padding(
                    padding:  EdgeInsets.all(marginValue),
                    child: Wrap(
                      spacing: screenWidth*0.05, // Adjust spacing as needed
                      runSpacing: screenHeight*0.02, // Adjust run spacing as needed
                      children: List.generate(
                        notifications.length,
                            (index) {
                          return InkWell(
                            onTap: () {
                              if(notifications[index].title.toLowerCase()=="like"||notifications[index].title.toLowerCase()=="comment")
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>  productdetails(p: notifications[index].link.toLowerCase()),
                              ));
                              else{
                                if(notifications[index].title.toLowerCase()=="command"){
                                  if(context.read<DataService>().user!.role=="client")
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>  commanddetail(c: notifications[index].link.toLowerCase())),
                                  );


                                }
                                else{
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>  profile(user: notifications[index].link.toLowerCase())),
                                  );
                                }
                              }
                            },
                            child: Container(
                              width: screenWidth*0.9,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5), // Color of the shadow
                                    spreadRadius: 2, // Spread radius
                                    blurRadius: 5, // Blur radius
                                    offset: Offset(0, 3), // Offset in x and y direction
                                  ),
                                ],
                              ),


                              child: Padding(
                                padding:  EdgeInsets.all(marginValue),
                                child: Container(
                                  child:                                   Row(
                                    mainAxisAlignment: MainAxisAlignment.start
                                    ,

                                    children: [
                                      Stack(
                                        alignment: Alignment.bottomRight,
                                        children: [
                                          // User Profile Picture
                                          ClipOval(
                                            child: SizedBox(
                                              width: screenWidth * 0.15,
                                              height: screenWidth * 0.15,
                                              child: notifications[index]
                                                  .usernotif
                                                  .picture
                                                  .endsWith(".svg+xml")
                                                  ? SvgPicture.network(
                                                url + "/getimage/" + notifications[index].usernotif.picture,
                                                fit: BoxFit.cover,
                                              )
                                                  : Image.network(
                                                url + "/getimage/" + notifications[index].usernotif.picture,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),

                                          // Notification Icon (Like or Comment)
                                          ClipOval(
                                            child: Container(
                                              width: fontSize*1.2,
                                              height: fontSize*1.2,
                                              color: notifications[index].title.toLowerCase() == "like" ?
                                             Colors.red :
                                              notifications[index].title.toLowerCase() == "comment" ?
                                              Colors.green :
                                              notifications[index].title.toLowerCase() == "command" ?
                                              Colors.green :
Colors.blueAccent,                                              child: Padding(
                                                padding: EdgeInsets.all(4.0),
                                                child: SvgPicture.asset(
                                                  notifications[index].title.toLowerCase() == "like" ?
                                                  "assets/icons/Heart.svg" :
                                                  notifications[index].title.toLowerCase() == "comment" ?
                                                  "assets/icons/comment.svg" :
                                                  notifications[index].title.toLowerCase() == "command" ?
                                                  "assets/icons/order.svg":
                                                  "assets/icons/Profile.svg",

                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding:  EdgeInsets.all(marginValue),
                                        child: Container(
                                            width: screenWidth*0.6
                                            ,
                                            child: Text(notifications[index].usernotif.firstname +" "+notifications[index].message,style: TextStyle(fontSize: fontSize*0.7,color: Colors.black),)),
                                      ),
                                    ],
                                  ),

                                )
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            )
            ,
          ),
        ),




      ],
    );

  }
}
