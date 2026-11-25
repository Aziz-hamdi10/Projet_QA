import 'package:bridgewearaa/Webpart/widgets/Deliveryitem.dart';
import 'package:bridgewearaa/Webpart/widgets/orderitem.dart';
import 'package:bridgewearaa/config.dart';
import 'package:bridgewearaa/controlleur/commandcontrolleur.dart';
import 'package:bridgewearaa/controlleur/productcontrolleur.dart';
import 'package:bridgewearaa/controlleur/usercontrolleur.dart';
import 'package:bridgewearaa/models/commande.dart';
import 'package:bridgewearaa/models/productgenerale.dart';
import 'package:bridgewearaa/models/user.dart';
import 'package:bridgewearaa/screens/buttons.dart';
import 'package:bridgewearaa/screens/menu2.dart';
import 'package:bridgewearaa/screens/productdetails.dart';
import 'package:bridgewearaa/screens/subscribesandfollowwidget.dart';
import 'package:bridgewearaa/services/data.dart';
import 'package:bridgewearaa/widget/CustomConfirmation.dart';
import 'package:bridgewearaa/widget/CustomErormsg.dart';
import 'package:bridgewearaa/widget/commanditem.dart';
import 'package:bridgewearaa/widget/commenter.dart';
import 'package:bridgewearaa/widget/productitem.dart';
import 'package:bridgewearaa/widget/rattingbar.dart';
import 'package:bridgewearaa/widget/rattingmsg.dart';
import 'package:bridgewearaa/widget/rattingtotal.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import  'package:givestarreviews/givestarreviews.dart';
import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';


class userscren extends StatefulWidget {
  final String user;
  const userscren({super.key,required this.user});

  @override
  State<userscren> createState() => _userscrenState();
}

class _userscrenState extends State<userscren> {
  int index=0;
  int nbrfollow=0;
  int nbrsubs=0;
  User user=User(id: "id", firstname: "firstname", secondname: "secondname", email: "email", phone: "phone", picture: "picture", password: "password",role: "");
  bool verif=false;
  int nbr=0;
  List<Productgen> listproductuser=[];

  void initState() {
    super.initState();
    getNumberOfFollows(widget.user, (x)=>{
      setState(() {
        nbrfollow=x;
        nbr++;
      })
    }


    );
    if(context.read<DataService>().user!.role=="delievry")
    {
   getcmdbystate((p0) =>{
setState(() {
      listcommand=p0;  
      })
},context.read<DataService>().token!,"all");
    }
    else{
   getallcmd((p0) =>{
setState(() {
      listcommand=p0;
      })
});
    }
 
    getuserbyid(widget.user, (x)=>{
      setState(() {
        user=x;
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
  List<commande>listcommand=[];
  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    double screenWidth = mediaQueryData.size.width;
    double screenHeight = mediaQueryData.size.height;
   
 if(screenHeight<screenWidth){
           screenWidth = mediaQueryData.size.height;
     screenHeight = mediaQueryData.size.width;

    }
      double fontSize = MediaQuery.of(context).size.shortestSide * 0.05;
    double marginValue = screenWidth * 0.02;
     
  
    return nbr<5
        ? LoadingScreen2()
    :   Scaffold(
      body: SingleChildScrollView(
    
          child:
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding:  EdgeInsets.all(marginValue*0.5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                       
    Container(
      width: screenWidth * 0.25,
      height: screenWidth * 0.25,
      decoration: BoxDecoration(
      shape: BoxShape.circle,),
      child:  ClipOval(
        child: user!.picture.toLowerCase().endsWith('.svg+xml')?
                                SvgPicture.network(
                                  url + "/getimage/" +user!.picture,
                                  fit:BoxFit.cover,
                               
      
                                      placeholderBuilder: (BuildContext context) => CircularProgressIndicator(),
      
                                ):
                                Image.network(
                                    url+"/getimage/"+user!.picture, 
                                    fit:BoxFit.cover,
                               
      
                                ),
      ),
      ),
                          
                         
                         
                        
                        SizedBox(height: screenHeight*0.01,),
                        Text(user.firstname+" "+user!.secondname,style: TextStyle(fontSize: fontSize*0.9,fontWeight: FontWeight.bold),),
    
                      ],
                    ),
                    SizedBox(height: screenHeight*0.02,),
                    if(user.role!="delievry")
                         Padding(
                          padding:  EdgeInsets.all(marginValue*0.5),
                          child:
    
    
    
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              
                              Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(listproductuser.length.toString(),style: TextStyle(fontSize: fontSize*0.9),),
                                  Text("Product",style: TextStyle(color: Colors.grey,fontSize: fontSize*0.6),)
    
                                ],
    
                              ),
                              SizedBox(
                                width: screenWidth*0.02,
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
    
    
                                    }), 
                                  );
                                },
                                child: Column(
                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
    
                                  children: [
                                    Text(nbrsubs.toString(),style: TextStyle(fontSize: fontSize*0.9),),
    
                                    Text("followers",style: TextStyle(color: Colors.grey,fontSize: fontSize*0.6),)
    
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
                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
    
                                  children: [
                                    Text(nbrfollow.toString(),style: TextStyle(fontSize: fontSize*0.9),),
    
                                    Text("Following",style: TextStyle(color: Colors.grey,fontSize: fontSize*0.6),)
    
                                  ],
    
                                ),
                              ),
    
    
    
    
    
    
                            ],
                          ),
    
                        ),
                  
    
                  ],
                ),
              ),
    
              Divider(
                height: screenHeight*0.01,
              ),
              if(user.role=="client"||user.role=="")
              Column(
                children: [
                  Padding(padding: EdgeInsets.all(marginValue*0.7),
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
                                  child: 
                                  Text("Products ("+listproductuser.length.toString()+")",style:
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
                                      index=2;
                                    });
                                  },
                                  child: 
                                  Text("Orders ("+listcommand.length.toString()+")",style:
                                  TextStyle(fontWeight: FontWeight.w900,fontSize: fontSize*0.8,
                                      color: index==2?Colors.blue:Colors.black),                            ),
                              ),   ),
                              SizedBox(
                                height: screenHeight*0.02,
                              ),
                            Container(
                              height:index==2? 3:1,
                              color:index==2?Colors.blue: Colors.grey,
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
                 if(user.role.toLowerCase()=="delievry")
              Column(
                children: [
                  Padding(padding: EdgeInsets.all(marginValue*0.7),
                    child: Row(
                      children: [
                       Expanded(child: Container(
                          child: Column(
                            children: [
                              Center(child: InkWell(
                            onTap: () {
                              setState(() {
                                index=1;
                              });
                            },
                            child:                                   Text("Orders ("+listcommand.length.toString()+")",style:


                            TextStyle(fontWeight: FontWeight.w900,fontSize: fontSize*0.8,
                            color: Colors.blue),
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
              if(user.role=="client"||user.role=="")
            if(index==0)
              Wrap(
        spacing: screenWidth*0.01,
        runSpacing: 8.0,
        children:
    List.generate(  listproductuser.length
      , (index)  {
      List<Productgen> listproduct=   listproductuser;
      return  InkWell(
        onTap: () {
                       showDialog(
               context: context,
  builder: (BuildContext context) {
    return AlertDialog(
      content: Container(
        width: screenWidth*0.8,
        child: productdetails(p: listproduct[index].id,)),
     
    );
  },
);
  
    
        },
        child: Padding(
          padding:  EdgeInsets.all(marginValue),
    
          child: Container(
            width: screenWidth*0.4,
    
            child: Column(
              children: [
    
              
                    ClipRRect(
                      borderRadius: BorderRadius.only(topRight: Radius.circular(10), topLeft: Radius.circular(10)),
                      child: Image.network(
                        url+"/getimage/"+listproduct[index].imgaename, // Assuming you want to display the first image
                        fit: BoxFit.cover,
                      )
                    )
                 
                ,
                Padding(
                  padding:  EdgeInsets.all(marginValue),
                  child: Row(
    
                    children: [
                      ClipOval(
    
                        child:
                        listproduct[index].user.picture.toLowerCase().endsWith('.svg+xml')?
                        SvgPicture.network(
                          url + "/getimage/" +listproduct[index].user.picture,
      fit: BoxFit.fill,height: screenHeight*0.04,width: screenHeight*0.04,
                          placeholderBuilder: (BuildContext context) => CircularProgressIndicator(),
    
                        ):
                        Image.network(
                          url+"/getimage/"+listproduct[index].user.picture,
                          fit: BoxFit.fill,height: screenHeight*0.04,width: screenHeight*0.04,) ,
    
                        ),
    
    
    
                      SizedBox(width: screenWidth*0.02,),
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Flexible(
                          child: Row(
                            children: [
                              Text(
                                listproduct[index].user.firstname+" " + listproduct[index].user.secondname,
                                style: TextStyle(fontSize:fontSize*0.6),
                              ),
                              SizedBox(width: screenWidth*0.02,),
               
                    
                              
                            ],
                          ),
                        ),
                      ),
                    ],
    
                  ),
                ),
                Container(
                  width: screenWidth*0.3  ,
                  child: Padding(
                    padding:  EdgeInsets.all(marginValue),
                    child: Stack(
                      children: [ Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
    
                          Expanded(child: Text(listproduct[index].name,style: TextStyle(fontSize: fontSize*0.6)
                          )
                          ),
                          Positioned(
                              right: 0,
                              child: Container(
                                width: screenWidth*0.3 * 0.3,
                                child: Expanded(
                                  child: FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Column(
                                      children: [
                                        Text(
                                          listproduct[index].SeelingPrice.toStringAsFixed(0)+" DT",
                                          style: TextStyle(fontWeight: FontWeight.bold,
                                            fontSize: fontSize*0.9,
                                            color: Colors.blueAccent
    
                                          ),),
                                        Text(
                                          listproduct[index].Originalprice.toStringAsFixed(0)+" DT",
                                          style: TextStyle(fontWeight: FontWeight.bold,
                                            decoration: TextDecoration.lineThrough,
                                                                                        fontSize: fontSize*0.9,
                                          ),),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                          )
                        ],
    
                      ),
                 
                      ],
                    ),
                  ),
                ),
                       Padding(
                         padding:  EdgeInsets.all(marginValue),
                         child: Container(
                                    decoration: BoxDecoration(
                                      color: getColorForCmdEtat(listproduct[index].state).withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    child: Center(
                                      child: Padding(
                                        padding: EdgeInsets.all(5),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: [
                                            Icon(Icons.circle, size: 16, color: getColorForCmdEtat(listproduct[index].state)),
                                            FittedBox(
                                              fit: BoxFit.scaleDown,
                                              child: Text(
                                                listproduct[index].state,
                                                style: TextStyle(fontSize: 15,color: getColorForCmdEtat(listproduct[index].state),fontWeight: FontWeight.bold),
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
    
    
            decoration: BoxDecoration(
              color: Colors.white,
    
              borderRadius: BorderRadius.circular(10.0), // Adjust the radius as needed
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
        ),
      );
     
    })
    
    
    
        ,
      )
    
              else
              if(index==1)
    
    
              rating(screenWidth: screenWidth, fontSize: fontSize, screenHeight: screenHeight, marginValue: marginValue)
              else
              Wrap(
children: 
List.generate(listcommand.length, (index) {

  return deleivryitem(listcommand[index]);
} ),)
    
    
    else
Wrap(
children: 
List.generate(listcommand.length, (index) {

  return deleivryitem(listcommand[index]);
} ),)
    
            ],
          ),
        ),
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
  });

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
        Rattingtotal(listavis: [],marginValue: marginValue, fontSize: fontSize),
        Commenter(marginValue: marginValue, screenHeight: screenHeight, screenWidth: screenWidth, fontSize: fontSize),
      ],
    );
  }
}

class Commenter extends StatelessWidget {
  const Commenter({
    super.key,
    required this.marginValue,
    required this.screenHeight,
    required this.screenWidth,
    required this.fontSize,
  });

  final double marginValue;
  final double screenHeight;
  final double screenWidth;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.all(marginValue),
      child: Wrap(
        children: [
      ],
      ),
    );
  }
}


