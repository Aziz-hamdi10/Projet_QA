import 'package:bridgewearaa/config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

void customconfimationprofile(BuildContext context, String title,String picture, String description, Function fn) {
  // Show a confirmation dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      MediaQueryData mediaQueryData = MediaQuery.of(context);
      double screenWidth = mediaQueryData.size.width;
      double screenHeight = mediaQueryData.size.height;
      double fontSize = MediaQuery.of(context).size.shortestSide * 0.05;
      double marginValue = MediaQuery.of(context).size.width * 0.02;
      return AlertDialog(
        title: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        content: SizedBox(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding:  EdgeInsets.all(marginValue),
                child: ClipOval(
                  child: picture.endsWith('.svg+xml')
                      ? SvgPicture.network(
                    url + "/getimage/" + picture,
                    height: screenHeight * 0.1,
                    placeholderBuilder: (BuildContext context) =>
                        CircularProgressIndicator(),
                  )
                      : Image.network(
                    url + "/getimage/" + picture,
                    height: screenHeight * 0.1,
                  ),
                ),
              ),
              Text(description, style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
        ),
        actions: [
          ButtonBar(
            alignment: MainAxisAlignment.center,
            // Center the buttons
            children: [
              TextButton(
                onPressed: () {
                  fn(); // Call the function passed as a parameter
                },
                child: Text(
                  'Remove',
                  style: TextStyle(color: Colors.red),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: Text(
                  'Cancel',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ],
          ),
        ],
      );

    },
  );
}

void customconfimation(BuildContext context, String title, String description, Function fn,Color cl) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      MediaQueryData mediaQueryData = MediaQuery.of(context);
      double screenWidth = mediaQueryData.size.width;
      double screenHeight = mediaQueryData.size.height;
      if(screenWidth>screenHeight){
           screenWidth = mediaQueryData.size.height;
       screenHeight = mediaQueryData.size.width;
      }
      double fontSize = MediaQuery.of(context).size.shortestSide * 0.05;
      double marginValue = screenWidth * 0.02;
      return AlertDialog(
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.center),
        content: Text(description, style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                child: Padding(
                  padding: EdgeInsets.all(5),
                  child: Text("Cancel",style: TextStyle(color: Colors.black)),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                  overlayColor: MaterialStateProperty.all<Color>(Colors.transparent),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0), // Adjust border radius as needed
                    ),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
              ),
              SizedBox(width: screenWidth*0.02),
              ElevatedButton(
                child: Padding(
                  padding: EdgeInsets.all(5),
                  child: Text("Confirm",style: TextStyle(color: Colors.white)),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(cl),
                  overlayColor: MaterialStateProperty.all<Color>(Colors.transparent),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0), // Adjust border radius as needed
                    ),
                  ),
                ),
                onPressed: () {
                  fn();
                },
              ),
            ],
          ),
        ],
      );

    },
  );
}
