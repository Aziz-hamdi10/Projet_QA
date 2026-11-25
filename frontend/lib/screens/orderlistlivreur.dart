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


class orderListlivreur extends StatefulWidget {
  final bool showDesktop;
  final String iduser;
  const orderListlivreur({Key? key, this.showDesktop = false,required this.iduser}) : super(key: key);

  @override
  _OrderListState createState() => _OrderListState();
}

class _OrderListState extends State<orderListlivreur> {
  List<commande> listcommandavaible=[];
  List<commande> listcommandCanceled=[];
  List<commande> listcommandFinished=[];
bool loading=false;
  getdata(Function fn) async{
if(context.read<DataService>().token!=null)
  {
      getcmdbystate((list) => {
      setState(() {
        context.read<DataService>().listcommandes=list;

      })

    },context.read<DataService>().token!,"all");
    getcmdbystate((list) => {
      setState(() {
        listcommandFinished=list;

      })

    },context.read<DataService>().token!,"Finished");
    getcmdbystate((list) => {
      setState(() {
        listcommandCanceled=list;

      })

    },context.read<DataService>().token!,"Canceled");
    getcmdbystate((list) => {
      setState(() {
        listcommandavaible=list;

      })

    },context.read<DataService>().token!,"Confirmed").then((value) =>{
      fn()
    });
  }

  }
  void initState() {
    super.initState();
    getdata((){
      setState(() {
        loading=true;
      });
    });





  }
  int index=0;
  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    double screenWidth = mediaQueryData.size.width;
    double screenHeight = mediaQueryData.size.height;
    double fontSize = MediaQuery.of(context).size.shortestSide * 0.05;
    double marginValue = MediaQuery.of(context).size.width * 0.02;
    return SafeArea(
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(

          children: [
            Padding(padding: EdgeInsets.all(marginValue),
              child: Row(
                children: [
                  Expanded(child: Container(
                    child: InkWell(
                      onTap: (){
                        setState(() {
                          index=0;
                          loading=false;
                          getdata((){

                            loading=true;

                          });
                        });

                      },
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 5,left: 5),
                            child: Center(child:
                               FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text("All("+context.read<DataService>().listcommandes.length.toString()+ ")",style:
                                TextStyle(fontWeight: FontWeight.w900,fontSize: fontSize*0.8,
                                    color: index==0?Colors.blue:Colors.black),                            ),
                              ),
                              ),
                          ),
                          SizedBox(
                            height: screenHeight*0.02,
                          ),
                          Container(
                            height:index==0? 3:1,
                            color:index==0?Colors.blue: Colors.grey,
                          )
                        ],
                      ),
                    ),
                  )
                  ),
                  Expanded(child: Container(
                    child: InkWell(
                      onTap: (){
                        setState(() {
                          index=1;
                          loading=false;
                          getdata((){

                            loading=true;

                          });
                        });

                      },
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 5,left: 5),
                            child: Center(child: InkWell(
                              onTap: () {
                                setState(() {
                                  index=1;
                                });
                              },
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text("Available("+listcommandavaible.length.toString()+")",style:
                                TextStyle(fontWeight: FontWeight.w900,fontSize: fontSize*0.8,
                                    color: index==1?Colors.blue:Colors.black),                            ),
                              ),
                            ),   ),
                          ),
                          SizedBox(
                            height: screenHeight*0.02,
                          ),
                          Container(
                            height:index==1? 3:1,
                            color:index==1?Colors.blue: Colors.grey,
                          )
                        ],
                      ),
                    ),
                  )
                  ),
                  Expanded(child: Container(
                    child: InkWell(
                      onTap: (){
                        setState(() {
                          index=2;
                          loading=false;
                          getdata((){

                            loading=true;

                          });
                        });

                      },
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 5,left: 5),
                            child: Center(
                                child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text("Canceled("+listcommandCanceled.length.toString()+")",style:
                                  TextStyle(fontWeight: FontWeight.w900,fontSize: fontSize*0.8,
                                      color: index==2?Colors.blue:Colors.black),
                                  ),
                                )

                            ),
                          ),
                          SizedBox(
                            height: screenHeight*0.02,
                          ),
                          Container(
                            height:index==2? 3:1,
                            color:index==2?Colors.blue: Colors.grey,
                          )
                        ],
                      ),
                    ),
                  )
                  ),
                  Expanded(child: Container(
                    child: InkWell(
                      onTap: (){
                        setState(() {
                          index=3;
                          loading=false;
                          getdata((){

                            loading=true;

                          });
                        });

                      },
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 5,left: 5),
                            child: Center(child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text("Finished("+listcommandFinished.length.toString()+")",style:
                                TextStyle(fontWeight: FontWeight.w900,fontSize: fontSize*0.8,
                                    color: index==3?Colors.blue:Colors.black),                            ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: screenHeight*0.02,
                          ),
                          Container(
                            height:index==3? 3:1,
                            color:index==3?Colors.blue: Colors.grey,
                          )
                        ],
                      ),
                    ),
                  )
                  ),


                ],
              ),

            ),
            loading?
            Expanded(
              child: index==0?SingleChildScrollView(
                child: Column(
                  children: context.read<DataService>().listcommandes
                      .map((e) => orderitem(e,true))
                      .toList(),
                ),
              ):
              index==1?
              SingleChildScrollView(
                child: Column(
                  children: listcommandavaible
                      .map((e) => orderitem(e,true))
                      .toList(),
                ),
              ):index==2?
              SingleChildScrollView(
                child: Column(
                  children: listcommandCanceled
                      .map((e) => orderitem(e,true))
                      .toList(),
                ),
              ):SingleChildScrollView(
                child: Column(
                  children: listcommandFinished
                      .map((e) => orderitem(e,true))
                      .toList(),
                ),
              )
              ,
            ):
            CircularProgressIndicator()
          ],
        ),
      ),
    );
  }
}