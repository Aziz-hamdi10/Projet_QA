import 'package:bridgewearaa/services/data.dart';
import 'package:flutter/material.dart';
import 'package:bridgewearaa/Webpart/constaints.dart';
import 'package:bridgewearaa/Webpart/pages/news.dart';
import 'package:provider/provider.dart';

class TopBar extends StatelessWidget {
  final bool _showDesktop;
  final String title;
  const TopBar([this._showDesktop = false, this.title=""]);

  @override
  Widget build(BuildContext context) {
       MediaQueryData mediaQueryData = MediaQuery.of(context);
    double screenWidth = mediaQueryData.size.width;
    double screenHeight = mediaQueryData.size.height;
    double fontSize = MediaQuery.of(context).size.shortestSide * 0.05;
    double marginValue = MediaQuery.of(context).size.width * 0.02;
  if(screenWidth>screenHeight){
           screenWidth = mediaQueryData.size.height;
       screenHeight = mediaQueryData.size.width;
      }
        final Size _size = MediaQuery.of(context).size;

        final bool _isDesktop = _size.width >= screenLg;

    return Container(
      height: topBarHeight,
      padding: EdgeInsets.symmetric(horizontal: componentPadding),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    title,
                    style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.w600),
                  ),
                ),
                Positioned(
                  child: Container(
                    height: 4,
                    width: 60,
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(4)),
                  ),
                  bottom: 0,
                  left: 0,
                )
              ],
            ),
          ),
          Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
       
            IconButton(
              icon: Icon(
                Icons.notifications_outlined,
                color: Theme.of(context).primaryColor,
                                size: fontSize,

              ),
              onPressed: () {},
            ),
            this._showDesktop
                ? SizedBox.shrink()
                : IconButton(
                    icon: Icon(
                      Icons.article_outlined,
                      color: Theme.of(context).primaryColor,
                                      size: fontSize,

                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => NewsPage(iduser: context.read<DataService>().user!.id,)),
                      );
                    },
                  )
          ])
        ],
      ),
    );
  }
}
