import 'package:bridgewearaa/const/colors.dart';
import 'package:bridgewearaa/controlleur/productcontrolleur.dart';
import 'package:bridgewearaa/controlleur/usercontrolleur.dart';
import 'package:bridgewearaa/models/productgenerale.dart';
import 'package:bridgewearaa/screens/buttons.dart';
import 'package:bridgewearaa/screens/menu2.dart';
import 'package:bridgewearaa/services/data.dart';
import 'package:bridgewearaa/widget/CustomErormsg.dart';
import 'package:bridgewearaa/widget/commenter.dart';
import 'package:bridgewearaa/widget/rattingbar.dart';
import 'package:bridgewearaa/widget/rattingmsg.dart';
import 'package:bridgewearaa/widget/rattingtotal.dart';
import 'package:bridgewearaa/widget/useritem.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import  'package:givestarreviews/givestarreviews.dart';
import 'package:custom_rating_bar/custom_rating_bar.dart';

import '../models/user.dart';

class subscribeandfollow extends StatefulWidget {
  final String? iduser;
  final int index1;
  final Function fn1;
  final Function fn2;

  const subscribeandfollow({required this.fn1,required this.fn2,required this.index1,super.key,required this.iduser});

  @override
  State<subscribeandfollow> createState() => _subscribeandfollowstate();
}

class _subscribeandfollowstate extends State<subscribeandfollow> {
  List<User>listsubs=[];
  List<User>listfollows=[];
  List<User>listfollowsreaded=[];
  List<User>listsubsadded=[];

  bool _isLoading = false;
  ScrollController _scrollController1 = ScrollController();
  ScrollController _scrollController2 = ScrollController();
  int index=0;
  @override
  void initState() {
    super.initState();
    index=widget.index1;
    _loadData2();
    _isLoading=false;
    _loadData1();

    _scrollController1.addListener(_scrollListener1);
    _scrollController2.addListener(_scrollListener2);
    getfollowing((list) =>{
      setState(() {
        listfollows=list;
      })

    }, context.read<DataService>().user!.id);
    getsubs((list) =>{
      setState(() {
        listsubs=list;
      })

    }, context.read<DataService>().user!.id);








  }
  @override
  void dispose() {
    _scrollController1.dispose();
    _scrollController2.dispose();

    super.dispose();
  }

  void _scrollListener1() {
    if (_scrollController1.position.pixels ==
        _scrollController1.position.maxScrollExtent) {
      _loadData1();
    }
  }

  void _scrollListener2() {
    if (_scrollController2.position.pixels ==
        _scrollController2.position.maxScrollExtent) {
      _loadData2();
    }
  }

  Future<void> _loadData1() async {
    if (!_isLoading) {
      setState(() {
        _isLoading = true;
      });

      // Simulating fetching data from an API
      await Future.delayed(Duration(seconds: 2));
      if (listfollows.length < 6) {
        setState(() {
          List<User> newData = listfollows.take(listfollows.length).toList();
          listfollows.removeRange(0, listfollows.length);
          listfollowsreaded.addAll(newData);
          _isLoading = false;
        });
      } else {

        setState(() {
          List<User> newData = listfollows.take(6).toList();
          print(listfollows.length);
          listfollows.removeRange(0, 6);
          listfollowsreaded.addAll(newData);
          _isLoading = false;
        });
      }


    }
  }
  Future<void> _loadData2() async {
    if (!_isLoading) {
      setState(() {
        _isLoading = true;
      });

      // Simulating fetching data from an API
      await Future.delayed(Duration(seconds: 2));
      if (listsubs.length < 6) {
        setState(() {
          List<User> newData = listsubs.take(listsubs.length).toList();
          listsubs.removeRange(0, listsubs.length);
          listsubsadded.addAll(newData);

          _isLoading = false;
        });
      } else {

        setState(() {
          List<User> newData = listsubs.take(6).toList();
          print(listsubs.length);
          listsubs.removeRange(0, 6);
          listsubsadded.addAll(newData);
          _isLoading = false;
        });
      }


    }
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    double screenWidth = mediaQueryData.size.width;
    double screenHeight = mediaQueryData.size.height;
    double fontSize = MediaQuery.of(context).size.shortestSide * 0.05;
    double marginValue = MediaQuery.of(context).size.width * 0.02;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(marginValue),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    child: Column(
                      children: [
                        Center(
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                index = 0;
                              });
                            },
                            child: Padding(
                              padding: EdgeInsets.all(marginValue * 0.7),
                              child: Text(
                                "Subscribers",
                                style: TextStyle(
                                  fontWeight: FontWeight.w900,
                                  fontSize: fontSize * 0.8,
                                  color: index == 0 ? Colors.blue : Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: screenHeight * 0.02,
                        ),
                        Container(
                          height: index == 0 ? 3 : 1,
                          color: index == 0 ? Colors.blue : Colors.grey,
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    child: Column(
                      children: [
                        Center(
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                index = 1;
                              });
                            },
                            child: Padding(
                              padding: EdgeInsets.all(marginValue * 0.7),
                              child: Text(
                                "Subscriptions",
                                style: TextStyle(
                                  fontWeight: FontWeight.w900,
                                  fontSize: fontSize * 0.8,
                                  color: index == 1 ? Colors.blue : Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: screenHeight * 0.02,
                        ),
                        Container(
                          height: index == 1 ? 3 : 1,
                          color: index == 1 ? Colors.blue : Colors.grey,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: index == 0
                ? ListView(
              controller: _scrollController2,
              children: [
                Wrap(
                  children: List.generate(
                    listsubsadded.length,
                        (index1) {
                      return useritem(user: listsubsadded[index1],fn:widget.fn1,index: 0,);
                    },
                  ),
                ),
                if (_isLoading)
                  Center(
                    child: CircularProgressIndicator(),
                  ),
              ],
            ):
            ListView(
    controller: _scrollController1,
    children: [
    Wrap(
    children: List.generate(
    listfollowsreaded.length,
    (x) {
    return useritem(user: listfollowsreaded[x],fn:widget.fn2,index: 1,);
    },
    ),
    ),
    if (_isLoading)
    Center(
    child: CircularProgressIndicator(),
    ),
    ],
    )

    ),

        ],
      ),
    );

  }
}


