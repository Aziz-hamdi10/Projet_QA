import 'package:bridgewearaa/config.dart';
import 'package:bridgewearaa/controlleur/usercontrolleur.dart';
import 'package:bridgewearaa/models/avis.dart';
import 'package:bridgewearaa/models/user.dart';
import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class rattingmsg extends StatefulWidget {
  const rattingmsg({
    super.key,
    required this.marginValue,
    required this.screenHeight,
    required this.screenWidth,
    required this.fontSize,
    required this.Avis,
  });

  final double marginValue;
  final double screenHeight;
  final double screenWidth;
  final double fontSize;
  final avis Avis;

  @override
  _RattingmsgState createState() => _RattingmsgState();
}

class _RattingmsgState extends State<rattingmsg> {
  String getTimeDifference(DateTime avisDate) {
    DateTime now = DateTime.now();
    Duration diff = now.difference(avisDate);

    if (diff.inDays > 0) {
      return diff.inDays == 1 ? '1 day ago' : '${diff.inDays} days ago';
    } else if (diff.inHours > 0) {
      return diff.inHours == 1 ? '1 hr ago' : '${diff.inHours} hrs ago';
    } else if (diff.inMinutes > 0) {
      return diff.inMinutes == 1 ? '1 min ago' : '${diff.inMinutes} mins ago';
    } else {
      return 'just now';
    }
  }
  getdata(fn)async{
    await getuserbyidcmd(widget.Avis.idcommand, (p0) =>{
      fn(p0)
    });
  }
  bool loading=true;
  User? u;
  @override
  void initState() {
    super.initState();
    getdata(
        (usr){
          setState(() {
            u=usr;
          });
        }
    );

        }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: u!=null?Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(widget.marginValue),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    ClipOval(
                      child: u!.picture.toLowerCase().endsWith('.svg+xml')?
                      SvgPicture.network(
                        url + "/getimage/" +u!.picture,
                        fit:BoxFit.cover,
                        height: widget.screenHeight * 0.05,
                        width: widget.screenHeight * 0.05,

                        // Placeholder widget while loading, if needed
                        placeholderBuilder: (BuildContext context) => CircularProgressIndicator(),

                      ):
                      Image.network(
                        url+"/getimage/"+u!.picture, // Assuming you want to display the first image
                        fit:BoxFit.cover,
                        height: widget.screenHeight * 0.05,
                        width: widget.screenHeight * 0.05,
                      ),
                    ),

                    SizedBox(width: widget.screenWidth * 0.02),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        u!.firstname,
                        style: TextStyle(fontSize: widget.fontSize * 0.7), // Set your desired font size
                      ),
                    ),
                  ],
                ),
                Text(
                  getTimeDifference(widget.Avis.date),
                  style: TextStyle(
                    fontSize: widget.fontSize * 0.6,
                    color: Colors.black.withOpacity(0.5),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: widget.marginValue),
            child: RatingBar.readOnly(
              filledColor: Colors.blueAccent,
              size: widget.fontSize,
              filledIcon: Icons.star,
              emptyIcon: Icons.star_border,
              initialRating: widget.Avis.rating,
              maxRating: 5,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(widget.marginValue),
            child: Container(
              width: widget.screenWidth * 0.9,
              child: Text(widget.Avis.description),
            ),
          ),
          Divider(height: widget.screenHeight * 0.01),
        ],
      ):CircularProgressIndicator(),
    );
  }
}
  String getTimeDifference(DateTime avisDate) {
    DateTime now = DateTime.now();
    Duration diff = now.difference(avisDate);

    if (diff.inDays > 0) {
      return diff.inDays == 1 ? '1 day ago' : '${diff.inDays} days ago';
    } else if (diff.inHours > 0) {
      return diff.inHours == 1 ? '1 hr ago' : '${diff.inHours} hrs ago';
    } else if (diff.inMinutes > 0) {
      return diff.inMinutes == 1 ? '1 min ago' : '${diff.inMinutes} mins ago';
    } else {
      return 'just now';
    }
  }
