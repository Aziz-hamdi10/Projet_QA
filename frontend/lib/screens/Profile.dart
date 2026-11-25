import 'package:bridgewearaa/config.dart';
import 'package:bridgewearaa/controlleur/aviscontrolleur.dart';
import 'package:bridgewearaa/controlleur/productcontrolleur.dart';
import 'package:bridgewearaa/controlleur/usercontrolleur.dart';
import 'package:bridgewearaa/models/avis.dart';
import 'package:bridgewearaa/models/productgenerale.dart';
import 'package:bridgewearaa/screens/buttons.dart';
import 'package:bridgewearaa/screens/edit_screen.dart';
import 'package:bridgewearaa/screens/menu2.dart';
import 'package:bridgewearaa/screens/productdetails.dart';
import 'package:bridgewearaa/screens/subscribesandfollowwidget.dart';
import 'package:bridgewearaa/services/data.dart';
import 'package:bridgewearaa/widget/CustomConfirmation.dart';
import 'package:bridgewearaa/widget/CustomErormsg.dart';
import 'package:bridgewearaa/widget/commenter.dart';
import 'package:bridgewearaa/widget/rattingbar.dart';
import 'package:bridgewearaa/widget/rattingmsg.dart';
import 'package:bridgewearaa/widget/rattingtotal.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import  'package:givestarreviews/givestarreviews.dart';
import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../models/user.dart';

class profile extends StatefulWidget {
  final String user;
  const profile({super.key,required this.user});

  @override
  State<profile> createState() => _profileState();
}

class _profileState extends State<profile> {
  int index=0;
  int nbrfollow=0;
  int nbrsubs=0;
  User user=User(id: "id", firstname: "firstname", secondname: "secondname", email: "email", phone: "phone", picture: "picture", password: "password",role: "");
  bool verif=false;
  int nbr=0;
  List<Productgen> listproductuser=[];
  List<avis> listavis=[];
  getdata()async{
   await getuserbyid(widget.user, (x)=>{
      setState(() {
        user=x;
        nbr++;

      })
    }
    ).then((value) =>{
      getAvisuser((p0) =>{
        setState(() {
         listavis=p0;
         rattingmoy=calculateAverageRating(listavis);

        })
      }, user!.id),
   });
  }
  double rattingmoy=0;
  void initState() {
    super.initState();
    getdata();
    getNumberOfFollows(widget.user, (x)=>{
      setState(() {
        nbrfollow=x;
        nbr++;
      })
    }


    );



    getNumberOfSubscribers(widget.user, (x)=>{
      setState(() {
        nbrsubs=x;
        nbr++;

      })
    }

    );
    getProductsbyid((list) => {
      setState(() {
       listproductuser=list;
       nbr++;

      })
    },widget.user);
    isFollowingUser(context.read<DataService>().user!.id,widget.user,(x)=>{
      setState(() {
        verif=x;
        nbr++;

      })

    });





  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    double screenWidth = mediaQueryData.size.width;
    double screenHeight = mediaQueryData.size.height;
    double fontSize = MediaQuery.of(context).size.shortestSide * 0.05;
    double marginValue = MediaQuery.of(context).size.width * 0.02;

    return nbr<5
        ? LoadingScreen2()
    :Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,

        leading:    IconButton(
            onPressed: () {
              Navigator.pop(context);
            },

            icon:  Icon(Icons.close  ,
                size: fontSize*1.5,
                color: Colors.black)

        ),





      ),
      body:
      SingleChildScrollView(

        child:
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding:  EdgeInsets.all(marginValue),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Stack(
                        alignment: Alignment.bottomRight,
                        children: [

                          ClipOval(
                            child: user!.picture.toLowerCase().endsWith('.svg+xml')?
                            SvgPicture.network(
                              url + "/getimage/" +user!.picture,
                              fit:BoxFit.cover,
                              height: screenHeight*0.15,


                              // Placeholder widget while loading, if needed
                              placeholderBuilder: (BuildContext context) => CircularProgressIndicator(),

                            ):
                            Image.network(
                                url+"/getimage/"+user!.picture, // Assuming you want to display the first image
                                fit:BoxFit.cover,
                              height: screenHeight*0.15,

                            ),
                          ),
                          if(widget.user==context.read<DataService>().user!.id)
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>  EditAccountScreen(),
                                ),
                              );
                            },
                            child: CircleAvatar(
                              radius: fontSize*0.8,
                              backgroundColor: Colors.green,
                              child: Icon(Icons.edit,color: Colors.white,),
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: screenHeight*0.01,),
                      Text(user.firstname+" "+user!.secondname,style: TextStyle(fontSize: fontSize,fontWeight: FontWeight.bold),),

                    ],
                  ),
                  SizedBox(height: screenHeight*0.02,),
                  Column(
                    children: [
                      Padding(
                        padding:  EdgeInsets.all(marginValue*2),
                        child:



                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [

                            Column(
                              children: [
                                Text(listproductuser.length.toString(),style: TextStyle(fontSize: fontSize),),
                                SizedBox(height: screenHeight*0.005,),
                                Text("Product",style: TextStyle(color: Colors.grey,fontSize: fontSize*0.7),)

                              ],

                            ),
                            SizedBox(
                              width: screenWidth*0.025,
                            ),
                            InkWell(
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (context) => subscribeandfollow(index1: 0,iduser: "user",fn1 :(int x){
                                    setState(() {
                                      nbrsubs=nbrsubs+x;

                                    });
                                  },fn2:(int x){
                                    nbrfollow=nbrfollow+x;


                                  }), // Without invoking the function
                                );
                              },
                              child: Column(
                                children: [
                                  Text(nbrsubs.toString(),style: TextStyle(fontSize: fontSize),),
                                  SizedBox(height: screenHeight*0.005,),

                                  Text("followers",style: TextStyle(color: Colors.grey,fontSize: fontSize*0.7),)

                                ],

                              ),
                            ),
                            SizedBox(
                              width: screenWidth*0.025,
                            ),
                            InkWell(
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (context) => subscribeandfollow(index1: 1,iduser: "user",fn1 :(int x){
                                    setState(() {
                                      nbrsubs=nbrsubs+x;

                                    });
                                  },fn2:(int x){
                                    setState(() {
                                      nbrfollow=nbrfollow+x;


                                    });
                                  }),                                );
                              },
                              child: Column(
                                children: [
                                  Text(nbrfollow.toString(),style: TextStyle(fontSize: fontSize),),
                                  SizedBox(height: screenHeight*0.005,),

                                  Text("Following",style: TextStyle(color: Colors.grey,fontSize: fontSize*0.7),)

                                ],

                              ),
                            ),






                          ],
                        ),

                      ),
                      if(user!.id!=context.read<DataService>().user!.id)
                        verif==false?
                        Center(
                        child: Container(
                          height: screenHeight*0.05,
                          width: screenWidth*0.3,
                          child: ElevatedButton(
                            onPressed: () {
                              subscripe(context.read<DataService>().user!.id,user!.id,(addsubs) {
                                setState(() {
                                  nbrsubs++;

                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          backgroundColor: Colors.green,
                                          content:                               Customerrormsg(icon: Icons.check,message:addsubs,bgcolor: Colors.green,)

                                      ))
                                  ;
                                });
                              },
                              );
                              setState(() {
                                verif=true;
                              });
                            },

                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Icon(Icons.add_reaction,size: fontSize,),
    FittedBox(
    fit: BoxFit.cover,
    child: Text(
     "Follow" ,
    textAlign: TextAlign.center,
    style: TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
    fontFamily: "LALEZAR"
    ),
    ),
    ),

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
                      ):
                        Center(
                          child:Container(
                            height: screenHeight * 0.05,
                            width: screenWidth * 0.3,
                            child: ElevatedButton(
                              onPressed: () {
                                customconfimationprofile(context, 'Remove follower?',user.picture,
                                    'Are you sure you want to Remove '+user.firstname+" "+user.secondname, () {
                                      unsubscribe(
                                          context.read<DataService>().user!.id,
                                          user.id,

                                          (p0) => {
                                            setState(() {
                                              nbrsubs--;
                                             verif=false;

                                              Navigator.pop(context);
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(SnackBar(
                                                  backgroundColor: Colors.green,
                                                  content: Customerrormsg(
                                                    icon: Icons.check,
                                                    message: "Unsubscribed",
                                                    bgcolor: Colors.green,
                                                  )));
                                            })
                                          });
                                    });
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  FittedBox(
                                    fit: BoxFit.cover,
                                    child: Text(
                                      "followed",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.blueAccent,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "LALEZAR",
                                      ),
                                    ),
                                  ),
                                  Icon(Icons.check, size: fontSize, color: Colors.blueAccent),
                                ],
                              ),
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                  side: BorderSide(color: Colors.blueAccent,width: screenWidth*0.002), // Add border color
                                ),
                              ),
                            ),
                          )
                          ,
                        ),

                    ],
                  ),

                ],
              ),
            ),

            Divider(
              height: screenHeight*0.01,
            ),
            Column(
              children: [
                Padding(padding: EdgeInsets.all(marginValue),
                  child: Row(
                    children: [
                      Expanded(child: Container(
                        child: Column(
                          children: [
                            Center(child: InkWell(
                                onTap: () {
                                  setState(() {
                                    index=0;
                                  });
                                },
                                child: Text("Products ("+listproductuser.length.toString()+")",style:
                                TextStyle(fontWeight: FontWeight.w900,fontSize: fontSize*0.8,
                                    color: index==0?Colors.blue:Colors.black),                            ),
                            ),   ),
                            SizedBox(
                              height: screenHeight*0.02,
                            ),
                          Container(
                            height:index==0? 3:1,
                            color:index==0?Colors.blue: Colors.grey,
                          )
                          ],
                        ),
                      )
                      ),
                      Expanded(child: Container(
                        child: Column(
                          children: [
                            Center(child: InkWell(
                          onTap: () {
                            setState(() {
                              index=1;
                            });
                          },
                          child: Text("Rating",style:
                          TextStyle(fontWeight: FontWeight.w900,fontSize: fontSize*0.8,
                          color: index==1?Colors.blue:Colors.black),
                          )
                            ),
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
                      )
                      ),
                    ],
                  ),

                ),
              ],
            ),
          if(index==0)
            products(listproduct: listproductuser, width: screenWidth*0.4, height: 0)
            else


            rating(listavis: listavis,screenWidth: screenWidth, fontSize: fontSize, screenHeight: screenHeight, marginValue: marginValue)



          ],
        ),
      )
      ,

    );
  }
}

class rating extends StatelessWidget {
  const rating({
    super.key,
    required this.screenWidth,
    required this.fontSize,
    required this.screenHeight,
    required this.marginValue,
    required this.listavis,
  });
  final List<avis> listavis;
  final double screenWidth;
  final double fontSize;
  final double screenHeight;
  final double marginValue;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: screenWidth*0.8,
            child: Text("Rating and review are verified and are"
                " from people who command a product from the same user "
                ,style: TextStyle(fontSize: fontSize*0.7,fontWeight: FontWeight.w500),textAlign: TextAlign.center,)),

         SizedBox(height: screenHeight*0.02),
        Rattingtotal(listavis: listavis,marginValue: marginValue, fontSize: fontSize),
        Wrap(
          children: List.generate(listavis.length, (index) {
            return rattingmsg( Avis: listavis[index],marginValue: marginValue, screenHeight: screenHeight, screenWidth: screenWidth, fontSize: fontSize);

          }),
        )

      ],
    );
  }
}



