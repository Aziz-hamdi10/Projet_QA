import 'package:bridgewearaa/Webpart/constaints.dart';
import 'package:bridgewearaa/Webpart/model.dart';
import 'package:bridgewearaa/Webpart/widgets/orderitem.dart';
import 'package:bridgewearaa/controlleur/commandcontrolleur.dart';
import 'package:bridgewearaa/models/commande.dart';
import 'package:bridgewearaa/models/product.dart';
import 'package:bridgewearaa/models/user.dart';
import 'package:bridgewearaa/services/data.dart';
import 'package:bridgewearaa/widget/commanditem.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';


class orderList extends StatefulWidget {
  final bool showDesktop;
final String iduser;
  const orderList({Key? key, this.showDesktop = false,required this.iduser}) : super(key: key);

  @override
  _OrderListState createState() => _OrderListState();
}

class _OrderListState extends State<orderList> {
    getdata() async{

 getallcmd((list) => {
      setState(() {
        context.read<DataService>().listcommandes=list;
       
      })
      
    });
  }
 
   void initState() {
    super.initState();
    getdata();
  




  }
  @override
  Widget build(BuildContext context) {
    return Container(
      color: primaryLight.withAlpha(100),
      padding: EdgeInsets.symmetric(horizontal: componentPadding),
      child: Column(
        children: [
          Container(
            height: topBarHeight,
            child: Row(
              children: [
                widget.showDesktop
                    ? SizedBox.shrink()
                    : IconButton(
                        icon: Icon(
                          Icons.arrow_back,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                Expanded(
                  child: Center(
                    child: Text(
                      'Latest Orders',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: Provider.of<DataService>(context)
                    .listcommandes
                    .map((e) => orderitem(e,false))
                    .toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}