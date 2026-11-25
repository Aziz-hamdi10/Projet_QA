import 'package:flutter/material.dart';

class ActiveProjectCard extends StatefulWidget {
  const ActiveProjectCard({
    required this.child,
    required this.title,
    required this.onPressedSeeAll,
    Key? key,
  }) : super(key: key);

  final String title;
  final Widget child;
  final Function() onPressedSeeAll;

  @override
  _ActiveProjectCardState createState() => _ActiveProjectCardState();
}

class _ActiveProjectCardState extends State<ActiveProjectCard> {
  @override
  Widget build(BuildContext context) {
                        MediaQueryData mediaQueryData = MediaQuery.of(context);
    double screenWidth2 = mediaQueryData.size.width;
    double screenHeight = mediaQueryData.size.height;
        final Size _size = MediaQuery.of(context).size;
    if(screenHeight<screenWidth2){
           screenWidth2 = mediaQueryData.size.height;
     screenHeight = mediaQueryData.size.width;

    }
        double fontSize = MediaQuery.of(context).size.shortestSide * 0.05;

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                titleT(widget.title,fontSize),
                seeAllButton(onPressed: widget.onPressedSeeAll,size: fontSize*0.5),
              ],
            ),
            const Divider(
              thickness: 1,
              height: 10,
            ),
            const SizedBox(height: 10),
            widget.child,
          ],
        ),
      ),
    );
  }

  Widget titleT(String value,double size) {
    return Text(
      value,
      style:  TextStyle(fontWeight: FontWeight.bold,fontSize: size),
    );
  }

  Widget seeAllButton({required Function() onPressed,required double size,}) {
    return TextButton(
      onPressed: onPressed,
      child: 
         Row(
          children: [
            Icon(Icons.add),
             Text("Add",style: TextStyle(fontSize: size),),
          ],
        ),
      
      style: TextButton.styleFrom(),
    );
  }
}