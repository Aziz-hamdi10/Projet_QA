import 'package:bridgewearaa/screens/signup.dart';
import 'package:bridgewearaa/services/data.dart';
import 'package:bridgewearaa/widget/CustomConfirmation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:bridgewearaa/Webpart/constaints.dart';
import 'package:provider/provider.dart';


class DrawerMenu extends StatefulWidget {
  const DrawerMenu({Key? key, required this.change, required this.index}) : super(key: key);
  final String index;
  final Function change;

  @override
  _DrawerMenuState createState() => _DrawerMenuState();
}

class _DrawerMenuState extends State<DrawerMenu> {
  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    final bool _isDesktop = _size.width >= screenLg;

    return Container(
      width: _isDesktop ? sideBarDesktopWidth : sideBarMobileWidth,
      child: Drawer(
        child: ListView(
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                vertical: 24,
                horizontal: _isDesktop ? 24 : 12,
              ),
              child: Image.asset("images/bridgewear55.png"),
            ),
            DrawerListTile(
              title: _isDesktop ? 'Dash Board' : "",
              svgSrc: 'icons/Dashboard.svg',
              active: widget.index == "Dashboard",
              tap: () {
                widget.change("Dashboard");
              },
            ),
            DrawerListTile(
              title: _isDesktop ? 'Brands' : '',
              svgSrc: 'assets/icons/marque.svg',
              active: widget.index == "Brands",
              tap: () {
                widget.change("Brands");
              },
            ),
            DrawerListTile(
              title: _isDesktop ? 'Category' : '',
              svgSrc: 'assets/icons/Category.svg',
              active: widget.index == "Category",
              tap: () {
                widget.change("Category");
              },
            ),
            DrawerListTile(
              title: _isDesktop ? 'Colors' : '',
              svgSrc: 'assets/icons/color.svg',
              active: widget.index == "Colors",
              tap: () {
                widget.change("Colors");
              },
            ),
            DrawerListTile(
              title: _isDesktop ? 'Sizes' : '',
              svgSrc: '/icons/size.svg',
              active: widget.index == "Sizes",
              tap: () {
                widget.change("Sizes");
              },
            ),
            DrawerListTile(
              title: _isDesktop ? 'Delievry' : '',
              svgSrc: 'assets/icons/delievry7.svg',
              active: widget.index == "Delievry",
              tap: () {
                widget.change("Delievry");
              },
            ),
            DrawerListTile(
              title: _isDesktop ? 'Moderators' : '',
              svgSrc: 'assets/icons/Message.svg',
              active: widget.index == "Moderators",
              tap: () {
                widget.change("Moderators");
              },
            ),
            DrawerListTile(
              title: _isDesktop ? 'Customers' : '',
              svgSrc: 'assets/icons/user.svg',
              active: widget.index == "Customers",
              tap: () {
                widget.change("Customers");
              },
            ),
          
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10 * 2),
              child: Divider(
                color: Colors.grey,
                thickness: 0.2,
              ),
            ),
            DrawerListTile(
              title: _isDesktop ? 'Settings' : '',
              active: widget.index == "Settings",
              svgSrc: '/icons/Setting.svg',
              tap: () {
                widget.change("Settings");
              },
            ),
            DrawerListTile(
              title: _isDesktop ? 'Logout' : '',
              svgSrc: 'icons/Logout.svg',
              active: false,
              tap: () {
                customconfimation(context, 'Logout', 'Are you sure you want to Logout', () {
                  setState(() {
                    deleteuserData("userData");
                                        deleteuserData("token");

                    context.read<DataService>().user = null;
                  });
                  Navigator.popUntil(
                    context,
                    (route) => route.isFirst,
                  );
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => logiun(),
                    ),
                  );
                },Colors.red);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({Key? key,required this.active,  this.title, required this.svgSrc, required this.tap}) : super(key: key);
  final String?title;
  final String  svgSrc;
  final VoidCallback tap;
  final bool active ;

  @override
  Widget build(BuildContext context) {
        final Size _size = MediaQuery.of(context).size;
    final bool _isDesktop = _size.width >= screenLg;

    return Padding(
      padding:  EdgeInsets.all(!_isDesktop?8.0:0),
      child: ListTile(
        onTap: tap,
        horizontalTitleGap: 0.0,
        leading: SvgPicture.asset(svgSrc,color:active?Colors.blueAccent:Colors.grey,height: 20,width: 20,),
        title: Text(title!,style: TextStyle(color:active?Colors.blueAccent: Colors.grey),),
      ),
    );
  }
}