import 'package:bridgewearaa/Webpart/model.dart';
import 'package:bridgewearaa/config.dart';
import 'package:bridgewearaa/const/colors.dart';
import 'package:bridgewearaa/controlleur/commandcontrolleur.dart';
import 'package:bridgewearaa/controlleur/usercontrolleur.dart';
import 'package:bridgewearaa/models/commande.dart';
import 'package:bridgewearaa/models/user.dart';
import 'package:bridgewearaa/services/data.dart';
import 'package:bridgewearaa/widget/CustomConfirmation.dart';
import 'package:bridgewearaa/widget/CustomErormsg.dart';
import 'package:bridgewearaa/widget/Skelton.dart';
import 'package:bridgewearaa/widget/commanditem.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class orderdetails extends StatefulWidget {
  final commande data;
  const orderdetails(this.data);

  @override
  _OrderItemState createState() => _OrderItemState();
}

class _OrderItemState extends State<orderdetails> {
  User user=User(id: "id", firstname: "firstname", secondname: "secondname", email: "email", phone: "phone", picture: "picture", password: "password",role: "");
  bool loading=false;
  void initState() {
    super.initState();

    getuserbyid(widget.data.idbuyer, (x)=>{
      setState(() {
        loading=true;
        user=x;
      })
    }


    );





  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    double screenWidth = mediaQueryData.size.width;
    double screenHeight = mediaQueryData.size.height;
    double fontSize = MediaQuery.of(context).size.shortestSide * 0.05;
    double marginValue = MediaQuery.of(context).size.width * 0.02;
    return Scaffold(
      appBar: AppBar(




        title: Text("Order Detail",style: TextStyle(color: Colors.black),),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(icon:  Icon(Icons.arrow_back_ios_sharp,color: Colors.black,

        )
          ,
          onPressed:  () {
            Navigator.pop(context);
          },),

      ),

      body: SafeArea(
        child: Padding(
          padding:  EdgeInsets.all(20.0),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(16),
                margin: EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  color: Colors.blueAccent.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 80,
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: primary,
                        image: DecorationImage(
                          image: NetworkImage(url + "/getimage/" + widget.data.prd.imgaenames[0]),
                          fit: BoxFit.cover, // or any other BoxFit option you prefer
                        ),
                      ),

                    ),

                    SizedBox(
                      width: 14,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                widget.data.prd.name,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              Text(
                                widget.data.prixtotal.toStringAsFixed(3)+" DT",
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                              ),

                            ],
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Text(
                            widget.data.prd.name,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Text(
                            "Ordered On " + DateFormat('dd MMM yyyy HH:mm').format(widget.data.dateadd),
                            style: TextStyle(
                                fontWeight: FontWeight.w300,
                                fontStyle: FontStyle.italic,
                                fontSize: 12),
                          )
                          ,

                          if(widget.data.dateconfirm!=null)
                            SizedBox(
                              height: 4,
                            ),
                          if(widget.data.dateconfirm!=null)

                            Text(
                              "Confirmed  On " + DateFormat('dd MMM yyyy HH:mm').format(widget.data.dateconfirm!),
                              style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontStyle: FontStyle.italic,
                                  fontSize: 12),
                            ),
                          if(widget.data.datetaked!=null)
                            SizedBox(
                              height: 4,
                            ),
                          if(widget.data.datetaked!=null)

                            Text(
                              "Taked  On " + DateFormat('dd MMM yyyy HH:mm').format(widget.data.datetaked!),
                              style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontStyle: FontStyle.italic,
                                  fontSize: 12),
                            ),
                          if(widget.data.datedelievry!=null)
                            SizedBox(
                              height: 4,
                            ),
                          if(widget.data.datedelievry!=null)

                            Text(
                              "Delievred  On " + DateFormat('dd MMM yyyy HH:mm').format(widget.data.datedelievry!),
                              style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontStyle: FontStyle.italic,
                                  fontSize: 12),
                            ),
                          if(widget.data.datefinished!=null)
                            SizedBox(
                              height: 4,
                            ),
                          if(widget.data.datefinished!=null)

                            Text(
                              "Finished  On " + DateFormat('dd MMM yyyy HH:mm').format(widget.data.datefinished!),
                              style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontStyle: FontStyle.italic,
                                  fontSize: 12),
                            ),



                          if(widget.data.datecancel!=null)
                            SizedBox(
                              height: 4,
                            ),
                          if(widget.data.datecancel!=null)

                            Text(
                              "Canceled On " + DateFormat('dd MMM yyyy HH:mm').format(widget.data.datecancel!),
                              style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontStyle: FontStyle.italic,
                                  fontSize: 12),
                            ),



                          SizedBox(
                            height: 6,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: getColorForCmdEtat(widget.data.etat).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Center(
                              child: Padding(
                                padding: EdgeInsets.all(5),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Icon(Icons.circle, size: 16, color: getColorForCmdEtat(widget.data.etat)),
                                    FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Text(
                                        widget.data.etat,
                                        style: TextStyle(fontSize: 15,color: getColorForCmdEtat(widget.data.etat),fontWeight: FontWeight.bold),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),

                        ],
                      ),
                    )
                  ],
                ),
              ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.all(16),
                      margin: EdgeInsets.only(bottom: 24),
                      decoration: BoxDecoration(
                        color: Colors.blueAccent.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: loading?Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text("The Seller",style: TextStyle(fontWeight: FontWeight.bold),),
                          ),
                          Container(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: widget.data.prd.iduser!.picture.toLowerCase().endsWith('.svg+xml')?
                              SvgPicture.network(
                                url + "/getimage/" +widget.data.prd.iduser!.picture,
                                height: 50,
                                fit:BoxFit.cover,


                                // Placeholder widget while loading, if needed
                                placeholderBuilder: (BuildContext context) => CircularProgressIndicator(),

                              ):
                              Image.network(
                                url + "/getimage/" + widget.data.prd.iduser!.picture,
                                height: 50,

                              ),
                            ),
                          ),
                          SizedBox(height: 10,),
                          Text(widget.data.prd.iduser!.firstname+" "+widget.data.prd.iduser!.secondname ),
                          SizedBox(height: 5,),
                          Container(
                              child: Text("Phone : "+widget.data.prd.iduser!.phone,style: TextStyle(fontSize: 12),))
                        ],
                      ):
                      Center(child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Skeleton(height: 10,width: 50,),
                          ),
                          Container(
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(50.0),

                                child: Skeleton(
                                  height: 50,
                                  width: 50,
                                )
                            ),
                          ),
                          SizedBox(height: 10,),
                          Skeleton(height: 10,width: 70,),
                          SizedBox(height: 5,),
                          Skeleton(height: 10,width: 120,),
                        ],
                      ))

                    ),

                    Container(
                      padding: EdgeInsets.all(16),
                      margin: EdgeInsets.only(bottom: 24),
                      decoration: BoxDecoration(
                        color: Colors.blueAccent.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: loading?Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text("The buyer",style: TextStyle(fontWeight: FontWeight.bold),),
                          ),
                          Container(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(50.0),

                              child: user!.picture.toLowerCase().endsWith('.svg+xml')?
                              SvgPicture.network(
                                url + "/getimage/" +user!.picture,
                                height: 50,
                                fit:BoxFit.cover,


                                placeholderBuilder: (BuildContext context) => CircularProgressIndicator(),

                              ):
                              Image.network(
                                height: 50,

                                url + "/getimage/" + user.picture,
                                loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                                  if (loadingProgress == null) {
                                    return child;
                                  } else {
                                    return Center(
                                      child: CircularProgressIndicator(

                                      ),
                                    );
                                  }
                                },
                              )
                            ),
                          ),
                          SizedBox(height: 10,),
                          Text(user!.firstname+" "+user!.secondname ),
                          SizedBox(height: 5,),
                          FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text("Phone : "+user!.phone,style: TextStyle(fontSize: 12),))
                        ],
                      ):
                      Center(child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Skeleton(height: 10,width: 50,),
                          ),
                          Container(
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(50.0),

                                child: Skeleton(
                                  height: 50,
                                  width: 50,
                                )
                            ),
                          ),
                          SizedBox(height: 10,),
                          Skeleton(height: 10,width: 70,),
                          SizedBox(height: 5,),
                          Skeleton(height: 10,width: 120,),
                        ],
                      ))
                      ,
                    )
                  ],
                ),
              Container(
                height: screenHeight*0.15,
                width: screenWidth*0.9,

                decoration: BoxDecoration(
                  color: Colors.blueAccent.withOpacity(0.2),

                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blueAccent.withOpacity(0.2),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                      // Change the offset as needed
                    ),

                  ],
                ),
                child: Padding(
                  padding:  EdgeInsets.all(marginValue),
                  child:  loading? Column(

                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [

                      Text("Home Adress" ,style: TextStyle(fontSize: fontSize*0.8,fontWeight: FontWeight.bold),),
                      Text(widget.data.postalCode,style: TextStyle(fontSize: fontSize*0.6,fontWeight: FontWeight.w500),),

                      Text(widget.data.state,style: TextStyle(fontSize: fontSize*0.6,color: Colors.black,fontWeight: FontWeight.w500),),

                      Text(widget.data.street,style: TextStyle(fontSize: fontSize*0.6,fontWeight: FontWeight.w500),),

                      Text(widget.data.city,style: TextStyle(fontSize: fontSize*0.6,fontWeight: FontWeight.w500),),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Default delivery adress" ,style: TextStyle(color: Colors.blueAccent,fontSize: fontSize*0.8,fontWeight: FontWeight.bold),),
                          Icon(Icons.check_circle,color: Colors.blue,size: fontSize,)
                        ],
                      ),


                    ],

                  ):
                  Column(

                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [

Skeleton(width: 100,height: 10,),
                      Text("2249 Wardia Monom",style: TextStyle(fontSize: fontSize*0.6,color: Colors.black,fontWeight: FontWeight.w500),),

                      Text("Mosqué Bilel Tunis",style: TextStyle(fontSize: fontSize*0.6,fontWeight: FontWeight.w500),),

                      Text("Tunisia",style: TextStyle(fontSize: fontSize*0.6,fontWeight: FontWeight.w500),),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Default delivery adress" ,style: TextStyle(color: Colors.blueAccent,fontSize: fontSize*0.8,fontWeight: FontWeight.bold),),
                          Icon(Icons.check_circle,color: Colors.blue,size: fontSize,)
                        ],
                      ),


                    ],

                  )

                ),

              ),

            ],
          ),
        ),
      ),
    );
  }
}
