import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class Bottombar extends StatefulWidget {
  const Bottombar({Key? key}) : super(key: key);

  @override
  State<Bottombar> createState() => _BottombarState();
}

class _BottombarState extends State<Bottombar> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return
      SalomonBottomBar(
          currentIndex: _selectedIndex,

          unselectedItemColor: const Color(0xff757575),
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          items: _navBarItems
    );
  }
}

final _navBarItems = [
  SalomonBottomBarItem(
    icon: const Icon(Icons.home),
    title:  Text("Home"),
  ),
  SalomonBottomBarItem(
    icon: const Icon(Icons.favorite_border),
    title: const Text("Likes"),
  ),
  SalomonBottomBarItem(
    icon: Icon(Icons.center_focus_strong),
    title: Text('POST'), // Empty string inside Text widget
  ),
  SalomonBottomBarItem(
    icon: const Icon(Icons.notifications),
    title: const Text("Notification"),
  ),
  SalomonBottomBarItem(
    icon: const Icon(Icons.settings),
    title: const Text("Seeting"),
  ),
];
class SimpleBottomNavigation extends StatefulWidget {
  const SimpleBottomNavigation({Key? key}) : super(key: key);

  @override
  State<SimpleBottomNavigation> createState() => _SimpleBottomNavigationState();
}

class _SimpleBottomNavigationState extends State<SimpleBottomNavigation> {
  BottomNavigationBarType _bottomNavType = BottomNavigationBarType.fixed;
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return  BottomNavigationBar(
          currentIndex: _selectedIndex,
          selectedItemColor: const Color.fromRGBO(19, 150, 206, 0.9),
          unselectedItemColor: const Color(0xff757575),
          type: _bottomNavType,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          items: _navBarItems2
    );
  }
}

final _navBarItems2 = [
  BottomNavigationBarItem(
    icon: Icon(Icons.home_outlined),
    activeIcon: Icon(Icons.home_rounded,color: Colors.blue,),
    label: 'Home',

  ),
  BottomNavigationBarItem(

    icon: const Icon(Icons.favorite_border),
    activeIcon: Icon(Icons.favorite,color: Colors.blue,),
    label: 'Likes',


  ),
  BottomNavigationBarItem(

    icon: Icon(Icons.center_focus_strong),
    activeIcon: Icon(Icons.center_focus_strong),
    label: 'POST',


  ),
  BottomNavigationBarItem(
    icon: const Icon(Icons.notifications_none),
    activeIcon: Icon(Icons.notifications,color: Colors.blue,),
    label: 'Notification',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.settings),
    activeIcon: Icon(Icons.settings,color: Colors.blue,),
    label: 'Seeting',
  ),

];