import 'package:bridgewearaa/config.dart';
import 'package:bridgewearaa/controlleur/usercontrolleur.dart';
import 'package:bridgewearaa/models/user.dart';
import 'package:bridgewearaa/screens/Profile.dart';
import 'package:bridgewearaa/services/data.dart';
import 'package:bridgewearaa/widget/CustomConfirmation.dart';
import 'package:bridgewearaa/widget/CustomErormsg.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';

class useritem extends StatefulWidget {
  final User user;
  const useritem({required this.index,super.key,required this.user,required this.fn});
  final Function fn;
  final int  index;

  @override
  State<useritem> createState() => _useritemState();
}

class _useritemState extends State<useritem> {
  bool issubs=true;
  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    double screenWidth = mediaQueryData.size.width;
    double screenHeight = mediaQueryData.size.height;
    double fontSize = MediaQuery.of(context).size.shortestSide * 0.05;
    double marginValue = MediaQuery.of(context).size.width * 0.02;
    return                 Padding(
      padding:  EdgeInsets.all(marginValue),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(

            children: [
              InkWell(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) => profile(user: widget.user.id), // Without invoking the function
                  );
                },
                child: ClipOval(

                  child:
                  widget.user.picture.toLowerCase().endsWith('.svg+xml')?
                  SvgPicture.network(
                    url + "/getimage/" + widget.user.picture,
                      height: screenHeight*0.07,
                    placeholderBuilder: (BuildContext context) => CircularProgressIndicator(),

                  ):
                  Image.network(
                    url+"/getimage/"+widget.user.picture, // Assuming you want to display the first image
                      height: screenHeight*0.07
                  ),
                ),
              ),
              Padding(
                padding:  EdgeInsets.all(marginValue),
                child: Text(widget.user.firstname+" "+widget.user.secondname,style: TextStyle(fontSize: fontSize),),
              ),

            ],
          ),


          ElevatedButton(
            onPressed: () {
              if(widget.index==0)
                if(issubs) {
                  print("x");
                customconfimationprofile(context, 'Remove follower?',widget.user.picture,
                    'Are you sure you want to Remove '+widget.user.firstname+" "+widget.user.secondname, () {
                  unsubscribe(
                      widget.user.id,
                      context.read<DataService>().user!.id,
                      (p0) => {
                            setState(() {
                              widget.fn(-1);

                              issubs = !issubs;

                              Navigator.pop(context);
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                      backgroundColor: Colors.green,
                                      content: Customerrormsg(
                                        icon: Icons.check,
                                        message: "Unsubscribed",
                                        bgcolor: Colors.green,
                                      )));
                            })
                          });
                });
              } else{
                  subscripe(context.read<DataService>().user!.id,this.widget.user!.id,(addsubs) {
                    setState(() {
                      widget.fn(1);
                      issubs=!issubs;
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              backgroundColor: Colors.green,
                              content:                               Customerrormsg(icon: Icons.check,message:addsubs,bgcolor: Colors.green,)

                          ))
                      ;
                    });
                  },
                  );
                }
              else
                customconfimation(context, 'Confirmation', 'Unfollow '+widget.user.firstname+" "+widget.user.secondname+'?', () {
                  unsubscribe(context.read<DataService>().user!.id,widget.user.id,  (p0) =>{
                    setState(() {
                      if(issubs){
                        widget.fn(-1);

                      }
                      else{
                        widget.fn(1);

                      }
                      issubs=!issubs;

                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              backgroundColor: Colors.green,
                              content:                               Customerrormsg(icon: Icons.check,message:widget.user.firstname+" "+widget.user.secondname+" has been successfully unfollowed.",bgcolor: Colors.green,)

                          ))
                      ;

                    })
                  });
                },Colors.red);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor:issubs?Colors.grey[300]:Colors.blueAccent,
            ),
            child:  Text(
              issubs?'Remove ':'Follow',
              style: TextStyle(
                color: Colors.black,
                fontSize: fontSize*0.7,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w700,
              ),
            ),
          ),

        ],
      ),
    );
    ;
  }
}
