import 'dart:io';

import 'package:bridgewearaa/config.dart';
import 'package:bridgewearaa/controlleur/commandcontrolleur.dart';
import 'package:bridgewearaa/controlleur/productcontrolleur.dart';
import 'package:bridgewearaa/models/brand.dart';
import 'package:bridgewearaa/models/commande.dart';
import 'package:bridgewearaa/models/frais.dart';
import 'package:bridgewearaa/models/product.dart';
import 'package:bridgewearaa/models/size.dart';
import 'package:bridgewearaa/screens/productdetails.dart';
import 'package:bridgewearaa/services/data.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class commanddetail extends StatefulWidget {
  final String c;
  const commanddetail({required this.c,super.key});

  @override
  State<commanddetail> createState() => _commandetailstate();
}

class _commandetailstate extends State<commanddetail> {
    commande c=commande(fr: frais(value: 10, id: "id"),prixtotal:0 ,state: "",city: "",postalCode: "",street: "", datefinished: null,datetaked: null,idbuyer: "idbuyer", prd:Product(Categorie:null,state: "",description: "",id: "",commentaires: [],iduser: null,name: "",imageUrl: [],numberlikes: 0,Size: size(id: "id", name: "name", dateadd: DateTime.now()),imgaenames: [],Originalprice: 0,SeelingPrice: 0,department: "",Brand:brand(datedadd: DateTime.now(), id: "id", title: "title", image: "image"),cl: null,liked: null), etat: "etat", dateconfirm: null, datedelievry: null, datecancel: null, id: "id", dateadd: DateTime.now());
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getcommandbyidcmd((p0) => {
      setState(() {
        c=p0;
        isLoading = false; // Set isLoading to false when data is fetched

      })
    }, widget.c);
  }
  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    double screenWidth = mediaQueryData.size.width;
    double screenHeight = mediaQueryData.size.height;
    double fontSize = MediaQuery.of(context).size.shortestSide * 0.05;
    double marginValue = MediaQuery.of(context).size.width * 0.02;
    return isLoading
        ? LoadingScreen2():
      Scaffold(
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
            child:

            Padding(
              padding:  EdgeInsets.all(marginValue),
              child: Center(
                child: InkWell(
                  onTap: () {


                  },
                  child: Column(
                    children: [
                      Container(
                        height: screenHeight*0.2,
                        width: screenWidth*0.9,

                        decoration: BoxDecoration(
                          color: Colors.white,

                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5), // Change the shadow color as needed
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: Offset(0, 3), // Change the offset as needed
                            ),

                          ],
                        ),
                        child:Column(
                          children: [
                            Expanded(
                              child: Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(marginValue),
                                      child: Expanded(
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.all(Radius.circular(10)),
                                          child: Image.network(
                                            url+"/getimage/"+c.prd.imgaenames[0],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Flexible(
                                      flex: 3,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Flexible(
                                            child: Text(
                                              c.prd.name+"  "+c.prixtotal.toStringAsFixed(1)+" DT",
                                              style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          Flexible(
                                            child: Text(
                                              c.prd.Brand.title+" - Size "+c.prd.Size.name,
                                              style: TextStyle(fontSize: fontSize*0.7, color: Colors.grey, fontWeight: FontWeight.w500),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          SizedBox(height: screenHeight*0.01),
                                          Flexible(
                                            child: Text(
                                              "Ordered On "+DateFormat('dd MMM yyyy HH:mm').format(c.dateadd),
                                              style: TextStyle(fontSize: fontSize*0.7, color: Colors.grey, fontWeight: FontWeight.w500),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          SizedBox(height: screenHeight*0.01),
                                          Padding(
                                            padding:  EdgeInsets.all(marginValue*0.7),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: _getColorForCmdEtat(c.etat).withOpacity(0.1),
                                                borderRadius: BorderRadius.circular(10.0),
                                              ),
                                              child: Center(
                                                child: Padding(
                                                  padding: EdgeInsets.all(marginValue),
                                                  child: Row(
                                                    children: [
                                                      Icon(Icons.circle, size: fontSize*0.5, color: _getColorForCmdEtat(c.etat)),
                                                      SizedBox(width: screenWidth*0.01),
                                                      Flexible(
                                                        child: Text(
                                                          c.etat,
                                                          style: TextStyle(fontSize: fontSize*0.7, color: _getColorForCmdEtat(c.etat)),
                                                          maxLines: 1,
                                                          overflow: TextOverflow.ellipsis,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),

                      ),

                        SizedBox(height: screenHeight*0.02,),

                        Container(
                          width: screenWidth*0.9,
                          child: Padding(
                            padding:  EdgeInsets.all(marginValue),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Wrap(


                                  children: [
                                    Padding(
                                      padding:  EdgeInsets.all(marginValue),
                                      child: Container(
                                        width: fontSize,
                                        child: Column(
                                          children: [
                                            ClipOval(child: Container
                                              (
                                                height: fontSize,
                                                color: Colors.green,
                                                child: Icon(Icons.check,color: Colors.white,))),
                                            if(c.datecancel!=null||c.dateconfirm!=null)

                                              Container(
                                              height: screenHeight*0.02,
                                              width: screenWidth*0.005,
                                              color:  Colors.green.withOpacity(0.5),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),


                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("Order On" ,style: TextStyle(fontSize: fontSize*0.8,fontWeight: FontWeight.bold),),
                                        Text(DateFormat('dd MMM yyyy HH:mm').format(c.dateadd),style: TextStyle(fontSize: fontSize*0.6,color: Colors.grey,fontWeight: FontWeight.w500),),

                                      ],
                                    ),
                                  ],
                                ),
                                if(c.dateconfirm!=null)

                                  Wrap(


                                    children: [
                                      Padding(
                                        padding:  EdgeInsets.all(marginValue),
                                        child: Container(
                                          width: fontSize,
                                          child: Column(
                                            children: [

                                              ClipOval(child: Container
                                                (
                                                  height: fontSize,
                                                  color: Colors.green,
                                                  child: Icon(Icons.check,color: Colors.white,))),
                                              if(c.datecancel!=null||c.datetaked!=null)

                                                Container(
                                                height: screenHeight*0.025,
                                                width: screenWidth*0.005,
                                                color:  Colors.green.withOpacity(0.5),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),

                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text("Order Confirmed" ,style: TextStyle(fontSize: fontSize*0.7,fontWeight:FontWeight.w500),),

                                          Text(DateFormat('dd MMM yyyy HH:mm').format(c.dateconfirm!),style: TextStyle(fontSize: fontSize*0.6,color: Colors.grey,fontWeight: FontWeight.w500),),

                                        ],
                                      ),
                                    ],
                                  ),
                                if(c.datetaked!=null)

                                Wrap(


                                  children: [
                                    Padding(
                                      padding:  EdgeInsets.all(marginValue),
                                      child: Container(
                                        width: fontSize,
                                        child: Column(
                                          children: [

                                            ClipOval(child: Container
                                              (
                                                height: fontSize,
                                                color: Colors.green,
                                                child: Icon(Icons.check,color: Colors.white,))),
                                            if(c.datecancel!=null||c.datedelievry!=null)

                                              Container(
                                              height: screenHeight*0.025,
                                              width: screenWidth*0.005,
                                              color:  Colors.green.withOpacity(0.5),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("Order Taked" ,style: TextStyle(fontSize: fontSize*0.8,fontWeight: FontWeight.bold),),
                                        Text(DateFormat('dd MMM yyyy HH:mm').format(c.datetaked!),style: TextStyle(fontSize: fontSize*0.6,color: Colors.grey,fontWeight: FontWeight.w500),),

                                      ],
                                    ),
                                  ],
                                ),
                if(c.datedelievry!=null)
                                Wrap(


                                  children: [
                                    Padding(
                                      padding:  EdgeInsets.all(marginValue),
                                      child: Container(
                                        width: fontSize,
                                        child: Column(
                                          children: [

                                            Row(
                                              children: [

                                                ClipOval(child: Container
                                                  ( width: fontSize,
                                                    height: fontSize,
                                                    color: Colors.green,
                                                    child: Icon(Icons.motorcycle_outlined,color: Colors.white,size: fontSize*0.8,))),
                                              ],
                                            ),
                                            if(c.datecancel!=null||c.datefinished!=null)

                                              Container(
                                              height: screenHeight*0.025,
                                              width: screenWidth*0.005,
                                              color:  Colors.green.withOpacity(0.5),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),


                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("Delivered " ,style: TextStyle(fontSize: fontSize*0.8,fontWeight: FontWeight.bold),),

                                        Text(DateFormat('dd MMM yyyy HH:mm').format(c.datetaked!),style: TextStyle(fontSize: fontSize*0.6,color: Colors.grey,fontWeight: FontWeight.w500),),

                                      ],
                                    ),
                                  ],
                                ),

if(c.datecancel!=null)
                                Wrap(

                                  children: [
                                    Padding(
                                      padding:  EdgeInsets.all(marginValue),
                                      child: ClipOval(child: Container
                                        ( width: fontSize,
                                          height: fontSize,
                                          color: Colors.red,
                                          child: Center(child: Icon(Icons.cancel_outlined,color: Colors.white,size: fontSize*0.8,)))),
                                    ),

                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("Canceled " ,style: TextStyle(fontSize: fontSize*0.8,fontWeight: FontWeight.bold),),
                                        Text(DateFormat('dd MMM yyyy HH:mm').format(c.datecancel!),style: TextStyle(fontSize: fontSize*0.6,color: Colors.grey,fontWeight: FontWeight.w500),),

                                      ],
                                    ),
                                  ],
                                ),
                                if(c.datefinished!=null)
                                  Wrap(

                                    children: [
                                      Padding(
                                        padding:  EdgeInsets.all(marginValue),
                                        child: ClipOval(child: Container
                                          ( width: fontSize,
                                            height: fontSize,
                                            color: Colors.green,
                                            child: Center(child: Icon(Icons.grade,color: Colors.white,size: fontSize*0.8,)))),
                                      ),

                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text("Finished " ,style: TextStyle(fontSize: fontSize*0.8,fontWeight: FontWeight.bold),),
                                          Text(DateFormat('dd MMM yyyy HH:mm').format(c.datefinished!),style: TextStyle(fontSize: fontSize*0.6,color: Colors.grey,fontWeight: FontWeight.w500),),

                                        ],
                                      ),
                                    ],
                                  ),



                              ],
                            ),
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,

                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5), // Change the shadow color as needed
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: Offset(0, 3), // Change the offset as needed
                              ),

                            ],
                          ),




                        ),


                        SizedBox(height: screenHeight*0.02,),

                        Container(
                          height: screenHeight*0.15,
                          width: screenWidth*0.9,

                          decoration: BoxDecoration(
                            color: Colors.white,

                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5), // Change the shadow color as needed
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: Offset(0, 3),
                                // Change the offset as needed
                              ),

                            ],
                          ),
                          child: Padding(
                            padding:  EdgeInsets.all(marginValue),
                            child:   Column(

                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [

                                Text("Home Adress" ,style: TextStyle(fontSize: fontSize*0.8,fontWeight: FontWeight.bold),),

                                Text(c.postalCode,style: TextStyle(fontSize: fontSize*0.6,color: Colors.grey,fontWeight: FontWeight.w500),),

                                Text(c.street,style: TextStyle(fontSize: fontSize*0.6,color: Colors.grey,fontWeight: FontWeight.w500),),

                                Text(c.state,style: TextStyle(fontSize: fontSize*0.6,color: Colors.grey,fontWeight: FontWeight.w500),),
                                Text(c.city,style: TextStyle(fontSize: fontSize*0.6,color: Colors.grey,fontWeight: FontWeight.w500),),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Default delivery adress" ,style: TextStyle(color: Colors.blueAccent,fontSize: fontSize*0.8,fontWeight: FontWeight.bold),),
                                    Icon(Icons.check_circle,color: Colors.blue,size: fontSize,)
                                  ],
                                ),


                              ],

                            ),
                          ),

                        ),


                    ],
                  ),

                ),
              ),
            )







        ),
      );
  }
}
Color _getColorForCmdEtat(String etat) {
  switch (etat.toLowerCase()) {
    case 'waiting confirmation':
      return Colors.grey;
    case 'not valide':
      return Colors.grey;
    case 'canceled':
      return Colors.red;
    case 'No livreur':
      return Color.fromRGBO(254, 186, 11, 1);
    case 'traitement':
      return Color.fromRGBO(254, 186, 11, 1);
    case 'Tocken':
      return Color.fromRGBO(204, 221, 8, 1);
  // Add more cases as needed
    default:
      return Colors.green;
  }
}