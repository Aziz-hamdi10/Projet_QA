import 'package:bridgewearaa/Webpart/components/orders_list.dart';
import 'package:bridgewearaa/Webpart/layout/topbar.dart';
import 'package:bridgewearaa/Webpart/pages/drawer_menu.dart';
import 'package:flutter/material.dart';

import '../constaints.dart';
class MainLayout extends StatefulWidget {
  final Widget child;
  final String iduser;
  final String index;
  final Function fn;
  MainLayout({Key? key,required this.fn,required this.index, required this.child, required this.iduser}) : super(key: key);

  @override
  _MainLayoutState createState() => _MainLayoutState();
}
class _MainLayoutState extends State<MainLayout> {
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

    final _showDesktop = _size.width >= screenXxl;
    return Scaffold(
        body: SafeArea(
      child: Row(
        children: [
          DrawerMenu(index: widget.index,change: (newindex){
            setState(() {
              widget.fn(newindex);
            });
          }),
          Expanded(
            child: Column(
              children: [
                TopBar(_showDesktop,widget.index),
                Expanded(
                    child: SingleChildScrollView(
                        child: Padding(
                  child: this.widget.child,
                  padding: EdgeInsets.all(componentPadding),
                )))
              ],
            ),
          ),
          Container(
            width: _showDesktop ? newsPageWidth : 0,
            child: orderList(showDesktop: _showDesktop,iduser:widget.iduser),
          )
        ],
      ),
    ));
  }

}


