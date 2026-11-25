
import 'package:bridgewearaa/config.dart';
import 'package:bridgewearaa/controlleur/commentairecontrolleur.dart';
import 'package:bridgewearaa/models/user.dart';
import 'package:bridgewearaa/services/data.dart';
import 'package:bridgewearaa/widget/CustomConfirmation.dart';
import 'package:bridgewearaa/widget/CustomErormsg.dart';
import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:provider/provider.dart';

import 'package:flutter_svg/flutter_svg.dart';


import '../models/commentaire.dart';

import 'package:flutter/material.dart';

class commenter extends StatefulWidget {
  const commenter({
    Key? key,
    required this.cmt,
    required this.marginValue,
    required this.screenHeight,
    required this.screenWidth,
    required this.fontSize,
    required this.modify,
    required this.delete,
  }) : super(key: key);

  final Commentaire cmt;
  final double marginValue;
  final double screenHeight;
  final double screenWidth;
  final double fontSize;
  final Function delete ;
  final Function modify;
  @override
  _CommenterState createState() => _CommenterState();
}

class _CommenterState extends State<commenter> {
  bool visibility = false;
  TextEditingController commenter=TextEditingController();
  bool modif=false;
  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    double screenWidth = mediaQueryData.size.width;
    double screenHeight = mediaQueryData.size.height;
    double fontSize = MediaQuery.of(context).size.shortestSide * 0.05;
    double marginValue = MediaQuery.of(context).size.width * 0.02;
    DateTime now = DateTime.now();

    String formatTimeDifference(DateTime pastTime) {
      Duration difference = now.difference(pastTime);
      if (difference.inDays > 365) {
        int years = (difference.inDays / 365).floor();
        return '$years year${years > 1 ? 's' : ''} ago';
      } else if (difference.inDays > 30) {
        int months = (difference.inDays / 30).floor();
        return '$months month${months > 1 ? 's' : ''} ago';
      } else if (difference.inDays > 0) {
        return '${difference.inDays} day${difference.inDays > 1 ? 's' : ''} ago';
      } else if (difference.inHours > 0) {
        int hours = difference.inHours;
        int minutes = difference.inMinutes.remainder(60);
        if (minutes > 0) {
          return '$hours h $minutes min ago';
        }
        return '$hours hour${hours > 1 ? 's' : ''} ago';
      } else if (difference.inMinutes > 0) {
        return '${difference.inMinutes} min ago';
      } else {
        return 'just now';
      }
    }

    return Container(
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Divider(),
              Padding(
                padding: EdgeInsets.all(widget.marginValue),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        ClipOval(
                          child: widget.cmt.user!.picture.toLowerCase().endsWith('.svg+xml')?
                          SvgPicture.network(
                            url + "/getimage/" + widget.cmt.user!.picture,
                            fit:BoxFit.cover,
                            height: widget.screenHeight * 0.05,
                            width: widget.screenHeight * 0.05,

                            // Placeholder widget while loading, if needed
                            placeholderBuilder: (BuildContext context) => CircularProgressIndicator(),

                          ):
                          Image.network(
                            url+"/getimage/"+widget.cmt.user!.picture, // Assuming you want to display the first image
                            fit:BoxFit.cover,
                            height: widget.screenHeight * 0.05,
                            width: widget.screenHeight * 0.05,
                          ),


                        ),
                        SizedBox(width: widget.screenWidth * 0.02),
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Flexible(
                            child: Text(
                              widget.cmt.user!.firstname + " " + widget.cmt.user!.secondname,
                              style: TextStyle(fontSize: widget.fontSize * 0.65),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          formatTimeDifference(widget.cmt.date),
                          style: TextStyle(fontSize: widget.fontSize * 0.6, color: Colors.black.withOpacity(0.5)),
                        ),
                        if (widget.cmt.user?.id == context.read<DataService>().user?.id)
                          FittedBox(
                            fit: BoxFit.contain,
                            child:  PopupMenuButton<String>(
                              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                                PopupMenuItem<String>(
                                  value: 'delete',
                                  child: Text('Delete',style: TextStyle(fontSize: fontSize*0.7),),
                                  onTap: () {
    customconfimation(context, 'Delete Comment ?', 'Are you sure you want to delete this Comment?', () {
      Deletecmnt(context.read<DataService>().token!,widget.cmt.id,(msg,color) =>{
        Navigator.pop(context),
if(color==Colors.green){
  widget.delete()
},
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                backgroundColor: color,
                content:Customerrormsg(icon: Icons.done,message: msg,bgcolor: color,)

            ))






      });
    },Colors.red);
                                    }


                                ),
                                PopupMenuItem<String>(
                                  value: 'modify',
                                  child: Text('Modify',style: TextStyle(fontSize: fontSize*0.7),),
                                  onTap: (){
                                    setState(() {
                                      modif=!modif;
                                    });
                                  },
                                ),
                              ],
                              onSelected: (String value) {
                                if (value == 'delete') {
                                } else if (value == 'modify') {
                                }
                              },
                              icon: Icon(
                                Icons.more_horiz,
                                color: Colors.blue,
                              ),
                            ),
                          ),


                      ],
                    )
                  ],
                ),
              ),
            !modif?  Padding(
                padding: EdgeInsets.all(widget.marginValue * 0.7),
                child: Container(
                  width: widget.screenWidth * 0.9,
                  child: Text(
                    widget.cmt.message,
                    style: TextStyle(fontSize: widget.fontSize * 0.6),
                  ),
                ),
              ):
           Padding(
             padding: const EdgeInsets.all(8.0),
               child: TextField(
                    onChanged: (value) {
                      setState(() {

                      });
                    },

                    controller: commenter,
                    decoration: InputDecoration(
                      hintText: 'Modify Your Comment', // You can customize the hint text here
                      border: InputBorder.none,
                      suffixIcon: InkWell(
                          onTap: (){
if(commenter.text.isNotEmpty&&commenter.text!=widget.cmt.message){
  customconfimation(context, 'Modify Comment ?', 'Are you sure you want to Modify this Comment?', () {
    modifycmt(widget.cmt,commenter.text,context.read<DataService>().token!,(msg,color,cmt) =>{
      Navigator.pop(context),
      if(color==Colors.green){
        widget.modify(cmt),
    setState(() {
      modif=!modif;

    }),
      },

      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              backgroundColor: color,
              content:Customerrormsg(icon: Icons.done,message: msg,bgcolor: color,)

          ))






    });
  },Colors.blueAccent);
}
                          },
                          child: Icon(Icons.send,color: commenter.text.isNotEmpty&&commenter.text!=widget.cmt.message?Colors.blueAccent:Colors.grey,))
                    ),
                    style: TextStyle(fontSize: fontSize * 0.7), // Set your desired font size
                  ),
           ),


              Divider(height: widget.screenHeight * 0.01),
            ],
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Visibility(
              visible: visibility,
              child: Container(
                decoration:BoxDecoration(
                  color: Colors.white,

                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5), // Change the shadow color as needed
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // Change the offset as needed
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(onTap: (){


                      }, child: Row(
                        children: [
                          Text('Delete',style: TextStyle(fontSize: fontSize*0.7),),
                          Icon(Icons.delete,size: fontSize*0.7,)
                        ],
                      )),
                      InkWell(onTap: (){

                      }, child: Row(
                        children: [
                          Text('Modifier',style: TextStyle(fontSize: fontSize*0.7),),
                          Icon(Icons.change_circle_outlined,size: fontSize*0.7,)

                        ],
                      )),

                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}




