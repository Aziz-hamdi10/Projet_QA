
import 'package:bridgewearaa/controlleur/productcontrolleur.dart';
import 'package:bridgewearaa/models/categorie.dart';
import 'package:bridgewearaa/models/frais.dart';
import 'package:bridgewearaa/models/promotion.dart';
import 'package:bridgewearaa/screens/menu2.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:bridgewearaa/config.dart';
import 'package:bridgewearaa/controlleur/commandcontrolleur.dart';
import 'package:bridgewearaa/models/adress.dart';
import 'package:bridgewearaa/models/commande.dart';
import 'package:bridgewearaa/models/product.dart';
import 'package:bridgewearaa/screens/Command%20Confirmation.dart';
import 'package:bridgewearaa/screens/DebitCardScreen.dart';
import 'package:bridgewearaa/screens/buttons.dart';

import 'package:bridgewearaa/services/data.dart';
import 'package:bridgewearaa/widget/CustomErormsg.dart';
import 'package:bridgewearaa/widget/changeadresswidget.dart';
import 'package:bridgewearaa/widget/paymentmethod.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class buyproduct extends StatefulWidget {

  final String idprd;
  final String? addcmd;

  const buyproduct({super.key,required this.idprd,this.addcmd});
  @override
  State<buyproduct> createState() => _buyproductState();
}

class _buyproductState extends State<buyproduct> {
  TextEditingController codepromo=TextEditingController();
  TextEditingController postalcode=TextEditingController();
  TextEditingController street=TextEditingController();
  TextEditingController city=TextEditingController();
  TextEditingController state=TextEditingController();
  promotion p=promotion(iddepartement:categorie(image: "",id: "",dateadd: DateTime.now(),name: ""), id: "id", etat: "etat", code: "", title: "", datestart: DateTime.now(), dateend: DateTime.now(), percentage: 0);
  bool loading2=false;
  String? urltrs;
  Product? prd;
  int index=0;

  bool loading=false;
  getdata(fn,fn2,fn3)async{
   await getproductbyidproduct((pr) => {
     fn(pr)
    }, widget.idprd);

   await getfrais((p0) =>{
     fn3(p0)
   });
   p=findFirstPromotionByCategoryId(context.read<DataService>().listpromotion,prd!.Categorie!.id)!;
   if(p!=null)
     codepromo.text=p!.code;

  }
  @override
  void initState() {
    super.initState();
    getdata((pr) {
      setState(() {
        prd = pr;
        loading2 = true;
      });
      getfrais((p0) =>{
        context.read<DataService>().delivcharge=p0
      });
      getadress((newadr)=>{
        context.read<DataService>().adr=newadr
      }, context.read<DataService>().user!.id);
      if (widget.addcmd != null && widget.addcmd == "true") {
        commande cmd = commande(fr:context.read<DataService>().delivcharge ,prixtotal: prd!.SeelingPrice+context.read<DataService>().delivcharge.value-p.percentage,datefinished: null,
            datetaked: null,
            city: context.read<DataService>().adr.city,
            postalCode: context.read<DataService>().adr.postalCode,
            state: context.read<DataService>().adr.state,
            street: context.read<DataService>().adr.street,
            idbuyer: context
                .read<DataService>()
                .user!
                .id,
            id: "",
            datecancel: null,
            dateadd: DateTime.now(),
            datedelievry: null,
            dateconfirm: null,
            etat: "Waiting Confirmation",
            prd: prd!);
        context
            .read<DataService>()
            .listcommandes
            .add(cmd);
        addcommand(cmd, (message, color) {
          setState(() {
            if(color==Colors.green){
              context.read<DataService>().listproductenuser.remove(prd!);
            }
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    backgroundColor: color,
                    content: Customerrormsg(
                      icon: Icons.check, message: message, bgcolor: color,)

                ))
            ;
          });
        });
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => commandconfirmation(),));


        GoRouter.of(context).go('/');

        GoRouter.of(context).pushReplacement('/commandconfirmation');
      }
      else {
        if (widget.addcmd == "false")
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.red,
                content: Customerrormsg(icon: Icons.check,
                    message: "Payment fails",
                    bgcolor: Colors.red),
              )
          );
      }
    }, (newadr) {
      setState(() {
        context.read<DataService>().adr = newadr;
        context
            .read<DataService>()
            .adr = newadr;
      });
    }, (frais) {
      setState(() {
        context.read<DataService>().delivcharge = frais;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    // Set the color of the status bar
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ));
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    double screenWidth = mediaQueryData.size.width;
    double screenHeight = mediaQueryData.size.height;
    double fontSize = MediaQuery.of(context).size.shortestSide * 0.05;
    double marginValue = MediaQuery.of(context).size.width * 0.02;
    List<commande> listcommande=context.read<DataService>().listcommandes;
    return loading2?Scaffold(
      appBar: AppBar(




        title: Text("Buying",style: TextStyle(color: Colors.black),),
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

          SingleChildScrollView(
            child: Center(
              child: Padding(
                  padding:  EdgeInsets.all(marginValue),
                  child:  Column(
                    children: [
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
                              offset: Offset(0, 3), // Change the offset as needed
                            ),

                          ],
                        ),
                        child:Column(
                          children: [
                            Expanded(
                              child: Container(

                                child: Row(
                                  children: [
                                    Padding(
                                      padding:EdgeInsets.all(marginValue),
                                      child: Expanded(child:
                                      ClipRRect(  // Use ClipRRect to apply border radius to the image
                                        borderRadius: BorderRadius.all(Radius.circular(10)),
                                        child: Image.network(
                                          url+"/getimage/"+prd!.imgaenames[0], // Assuming you want to display the first image

                                        ),
                                      )),
                                    ),


                                    Flexible(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            prd!.name + "  " + prd!.SeelingPrice.toStringAsFixed(1) + " DT",
                                            style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(height: screenHeight * 0.01),
                                          Text(
                                            prd!.Brand.title + " - Size " + prd!.Size.name,
                                            style: TextStyle(fontSize: fontSize * 0.7, color: Colors.grey, fontWeight: FontWeight.w500),
                                          ),
                                          Text(
                                            "Category : " + prd!.Categorie!.name,
                                            style: TextStyle(fontSize: fontSize * 0.7, color: Colors.grey, fontWeight: FontWeight.w500),
                                          ),

                                          Text(
                                            "State : " + prd!.state,
                                            style: TextStyle(fontSize: fontSize * 0.7, color: Colors.grey, fontWeight: FontWeight.w500),
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                "Color : " + prd!.cl!.name,
                                                style: TextStyle(fontSize: fontSize * 0.7, color: Colors.grey, fontWeight: FontWeight.w500),
                                              ),
                                              SizedBox(width: screenWidth * 0.01),
                                              Icon(Icons.circle, size: fontSize * 0.9, color: prd!.cl?.coleur),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),


                                  ],
                                ),
                              ),
                            ),
                          ],
                        ) ,
                      ),
                      SizedBox(height: screenHeight*0.01,),
                      paymentmethod(price: prd!.SeelingPrice,fn:(n){
                        setState(() {
                          index=n;
                        });
                      }),
                      SizedBox(height: screenHeight*0.02,),

                      Container(
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

                              Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Home Adress" ,style: TextStyle(fontSize: fontSize*0.8,fontWeight: FontWeight.bold),),
                                  Container(

                                    child: Padding(
                                    padding:  EdgeInsets.all(marginValue),
                                    child: InkWell(
                                        onTap: () {

                                          showModalBottomSheet(
                                              context: context,
                                              builder: (context) =>
                                                  ChangeAddress(fn: (state,city,postalcode,street){
                                                    setState(() {
                                                      context.read<DataService>().adr!.state=state;
                                                      context.read<DataService>().adr!.city=city;
                                                      context.read<DataService>().adr!.postalCode=postalcode;
                                                      context.read<DataService>().adr!.street=street;
                                                    });
                                                    Navigator.pop(context);


                                                  }))
                                          ;
                                        },
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                          children: [
                                            Text(context.read<DataService>().adr.state!=''?"Change":"Add Adress",style:
                                            TextStyle(fontWeight: FontWeight.w500,fontSize: fontSize*0.7,
                                                color:Colors.blueAccent,decoration: TextDecoration.underline),
                                            ),

                                            Icon(context.read<DataService>().adr.state!=''?Icons.change_circle_outlined:Icons.add,color:Colors.blueAccent)
                                              ,

                                          ],
                                        )
                                    ),
                                  ),

                                  )],
                              ),

                              Text(context.read<DataService>().adr!.postalCode+" "+context.read<DataService>().adr!.street,style: TextStyle(fontSize: fontSize*0.6,color: Colors.grey,fontWeight: FontWeight.w500),),
                              Text(context.read<DataService>().adr!.street,style: TextStyle(fontSize: fontSize*0.6,color: Colors.grey,fontWeight: FontWeight.w500),),

                              Text(context.read<DataService>().adr!.state,style: TextStyle(fontSize: fontSize*0.6,color: Colors.grey,fontWeight: FontWeight.w500),),

                              Text(context.read<DataService>().adr!.city,style: TextStyle(fontSize: fontSize*0.6,color: Colors.grey,fontWeight: FontWeight.w500),),




                            ],

                          ),
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

                              Text("Promo Code" ,style: TextStyle(fontSize: fontSize*0.8,fontWeight: FontWeight.bold),),
                              TextField(
                                  controller: codepromo,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: Colors.black.withOpacity(0.7),
                                    fontSize: fontSize * 0.7,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  onChanged: (value){

                                  },
                                  decoration: InputDecoration(
                                      icon: Icon(Icons.qr_code,size: fontSize*1.2,color: Colors.black,),

                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(10)),
                                        borderSide: BorderSide(
                                            width: screenWidth * 0.0015,
                                            color: Colors.black.withOpacity(0.5)
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(10)),
                                        borderSide: BorderSide(
                                            width: screenWidth * 0.0015,
                                            color: Colors.blueAccent.withOpacity(0.5)
                                        ),
                                      )
                                      ,

                                      suffixIcon: Padding(
                                        padding:  EdgeInsets.all(marginValue),
                                        child: ElevatedButton(
                                          onPressed: () {
                                            setState(() {
                                              p=findFirstPromotionByCode(context.read<DataService>().listpromotion, codepromo.text)!;
                                            });
                                          },
                                          style: ButtonStyle(
                                            backgroundColor: MaterialStateProperty.all<Color>(codepromo.text.length==5? Colors.blueAccent:Colors.white),
                                            side: MaterialStateProperty.all<BorderSide>(
                                              BorderSide(color:codepromo.text.length==5?Colors.blueAccent: Colors.white, width: screenWidth*0.002),
                                            ),
                                          ),
                                          child: Text("Apply",style: TextStyle(
                                              fontSize: fontSize*0.7,color:codepromo.text.length==5?Colors.white: Colors.black.withOpacity(0.7)
                                          ),),

                                        ),
                                      )
                                  )


                              )
                            ],

                          ),
                        ),

                      ),

                      SizedBox(height: screenHeight*0.02,),

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

                              Text("Price Details" ,style: TextStyle(fontSize: fontSize*0.8,fontWeight: FontWeight.bold),),
                              Divider(),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                children: [
                                  Text("Price ",style: TextStyle(fontSize: fontSize*0.6,color: Colors.grey,fontWeight: FontWeight.w500),),
                                  Text(prd!.SeelingPrice.toStringAsFixed(3)+" DT",style: TextStyle(fontSize: fontSize*0.6,color: Colors.grey,fontWeight: FontWeight.w500),),
                                ],
                              ),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                children: [
                                  Text("Discount",style: TextStyle(fontSize: fontSize*0.6,color: Colors.grey,fontWeight: FontWeight.w500),),
                                  Text(p!=null?"-"+p!.percentage.toStringAsFixed(0)+" DT":"0 DT",style: TextStyle(fontSize: fontSize*0.6,color: Colors.grey,fontWeight: FontWeight.w500),),

                                ],
                              ),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                children: [
                                  Text("Delievery Charge",style: TextStyle(fontSize: fontSize*0.6,color: Colors.grey,fontWeight: FontWeight.w500),),
                                  Text(context.read<DataService>().delivcharge.value.toString()+" DT",style: TextStyle(fontSize: fontSize*0.6,color: Colors.grey,fontWeight: FontWeight.w500),),
                                ],
                              ),
                              Divider(),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Total ammount" ,style: TextStyle(color: Colors.blueAccent,fontSize: fontSize*0.8,fontWeight: FontWeight.bold),),
                                  Text((prd!.SeelingPrice+context.read<DataService>().delivcharge.value-p!.percentage).toStringAsFixed(3)+" DT" ,style: TextStyle(color: Colors.blueAccent,fontSize: fontSize*0.8,fontWeight: FontWeight.bold),),

                                ],
                              ),


                            ],

                          ),
                        ),

                      ),
                      Padding(
                        padding:  EdgeInsets.fromLTRB(0, marginValue+5, 0, marginValue),
                        child: Center(
                          child: Container(
                            width:screenWidth*0.4,
                            child: ElevatedButton(
                              onPressed: () async {
                                if(!loading)
                                  {
                                  if(context.read<DataService>().adr.state!="")  {
                                      setState(() {
                                        loading = !loading;
                                      });
                                      if (index == 1) {
                                        commande cmd = commande(
                                          fr: context.read<DataService>().delivcharge,
                                            prixtotal: context.read<DataService>().delivcharge.value+prd!.SeelingPrice-p!.percentage,

                                            street: context.read<DataService>().adr!.street,
                                            postalCode: context.read<DataService>().adr!.postalCode,
                                            city: context.read<DataService>().adr!.city,
                                            state: context.read<DataService>().adr!.state,
                                            datefinished: null,
                                            datetaked: null,
                                            idbuyer: context
                                                .read<DataService>()
                                                .user!
                                                .id,
                                            id: "",
                                            datecancel: null,
                                            dateadd: DateTime.now(),
                                            datedelievry: null,
                                            dateconfirm: null,
                                            etat: "Waiting Confirmation",
                                            prd: prd!);
                                        context
                                            .read<DataService>()
                                            .listcommandes
                                            .add(cmd);
                                        await payment(
                                            widget.idprd,
                                            prd!.SeelingPrice+context.read<DataService>().delivcharge.value-p!.percentage,
                                            context
                                                .read<DataService>()
                                                .user!
                                                .email,
                                            context
                                                .read<DataService>()
                                                .user!
                                                .phone,
                                            context
                                                .read<DataService>()
                                                .user!
                                                .firstname,
                                            context
                                                .read<DataService>()
                                                .user!
                                                .secondname,
                                            (p0, p1) => {
                                                  setState(() {
                                                    urltrs = p0;
                                                  }),
                                                }).then((value) {
                                          launchURL(urltrs!);
                                          setState(() {
                                            loading = !loading;
                                          });
                                        });
                                      } else {
                                        commande cmd = commande(
                                          fr:  context.read<DataService>().delivcharge,
                                          prixtotal: context.read<DataService>().delivcharge.value+prd!.SeelingPrice-p!.percentage,
                                            datefinished: null,
                                            datetaked: null,
                                            city: context.read<DataService>().adr.city,
                                            postalCode: context.read<DataService>().adr.postalCode,
                                            state: context.read<DataService>().adr.state,
                                            street: context.read<DataService>().adr.street,
                                            idbuyer: context
                                                .read<DataService>()
                                                .user!
                                                .id,
                                            id: "",
                                            datecancel: null,
                                            dateadd: DateTime.now(),
                                            datedelievry: null,
                                            dateconfirm: null,
                                            etat: "Waiting Confirmation",
                                            prd: prd!);
                                        context
                                            .read<DataService>()
                                            .listcommandes
                                            .add(cmd);
                                        addcommand(cmd, (message, color) {
                                          setState(() {
                                            if(color==Colors.green){
                                              context.read<DataService>().listproductenuser.remove(prd!);
                                            }
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                                    backgroundColor: color,
                                                    content: Customerrormsg(
                                                      icon: Icons.check,
                                                      message: message,
                                                      bgcolor: color,
                                                    )));
                                          });
                                        });
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  commandconfirmation(),
                                            ));

                                        GoRouter.of(context).go('/');

                                        GoRouter.of(context).pushReplacement(
                                            '/commandconfirmation');
                                      }
                                    }
                                else{
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                        backgroundColor: Colors.red,
                                        content: Customerrormsg(
                                          icon: Icons.cancel,
                                          message: "Adress required !",
                                          bgcolor: Colors.red,
                                        )));
                                  }
                                  }



                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                   "Buy it",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: fontSize+5,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "LALEZAR"
                                    ),
                                  ),
                                  if(loading)
                                  Padding(
                                    padding:  EdgeInsets.all(5),
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                    ),
                                  )
                                ],
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blueAccent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                              ),
                            ),
                          ),
                        ),

                      )
                    ],
                  )
              ),
            ),
          )






      ),
    ):
    Scaffold(body: Center(child: CircularProgressIndicator()));

  }
}
void launchURL(String url) async {

  if (await canLaunch(url)) {
    await launch(url,

   );
  } else {
    throw 'Could not launch $url';
  }
}