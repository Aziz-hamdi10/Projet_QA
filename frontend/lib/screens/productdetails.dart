import 'dart:io';
import 'dart:ui';

import 'package:bridgewearaa/config.dart';
import 'package:bridgewearaa/controlleur/productcontrolleur.dart';
import 'package:bridgewearaa/models/brand.dart';
import 'package:bridgewearaa/models/commentaire.dart';
import 'package:bridgewearaa/models/product.dart';
import 'package:bridgewearaa/models/productgenerale.dart';
import 'package:bridgewearaa/models/size.dart';
import 'package:bridgewearaa/screens/Profile.dart';
import 'package:bridgewearaa/screens/buttons.dart';
import 'package:bridgewearaa/screens/buyproduct.dart';
import 'package:bridgewearaa/screens/updateproductscreen.dart';
import 'package:bridgewearaa/services/data.dart';
import 'package:bridgewearaa/widget/CustomConfirmation.dart';
import 'package:bridgewearaa/widget/CustomErormsg.dart';
import 'package:bridgewearaa/widget/bottomnavbar.dart';
import 'package:bridgewearaa/widget/commenter.dart';
import 'package:bridgewearaa/widget/custom_button.dart';
import 'package:bridgewearaa/widget/navbar.dart';
import 'package:bridgewearaa/widget/rattingmsg.dart';
import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../controlleur/commentairecontrolleur.dart';

class productdetails extends StatefulWidget {
  final String p;
  const productdetails({super.key,required this.p});

  @override
  State<productdetails> createState() => _productdetailsState();
}

class _productdetailsState extends State<productdetails> {
  PageController _pageController = PageController(initialPage: 0);
  ScrollController _scrollController = ScrollController();
  TextEditingController commentaire = TextEditingController();
  bool isLoading = true;

  Product prd=Product(commentaires: [], iduser:null, imgaenames: [], Originalprice: 10, SeelingPrice: 150, state: "state", Brand: brand(datedadd: DateTime.now(), id: "id", title: "title", image: "image"), department: "department", Categorie: null, Size: size(id: "id", name: "name", dateadd: DateTime.now()), numberlikes: 0, id: "id", name: "name", description: "description", imageUrl: []);
  int _currentImageIndex = 0;
  @override
  void initState() {
    super.initState();
    getproductbyidproduct((p0) => {
      setState(() {
        prd=p0;
        isLoading = false; // Set isLoading to false when data is fetched

      })
    }, widget.p);
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
  if(screenWidth>screenHeight){
           screenWidth = mediaQueryData.size.height;
       screenHeight = mediaQueryData.size.width;
      }
    _scrollController.addListener(() {
      int newIndex = (_scrollController.position.pixels / (screenWidth * 0.7)).round();
      if (newIndex != _currentImageIndex) {
        setState(() {
          _currentImageIndex = newIndex;
        });
      }
    });


    return
      isLoading
          ? LoadingScreen2():
      Scaffold(

      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Stack(
                  children:[ Column(
                    children: [
                      Container(
                        width: screenWidth,
                        height: screenHeight * 0.4,
                        child: Stack(
                          children: [

                            Positioned(

                                child: Container(
                                    width: screenWidth,
                                    height: screenHeight * 0.4,
                                    child:
                                    SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      controller: _scrollController,

                                      child:
                                      Wrap(
spacing: marginValue,
                                        children:
                                        List.generate(prd.imgaenames.length, (index){
                                          return ClipRRect(  // Use ClipRRect to apply border radius to the image
                                            borderRadius: BorderRadius.all(Radius.circular(10)),
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Row(
                                                children: [
                                                  Image.network(
                                                    url+"/getimage/"+prd.imgaenames[index], // Assuming you want to display the first image
                                                    width: screenWidth*0.7,
                                                    height: screenHeight*0.35,

                                                  ),

                                                ],
                                              ),
                                            ),
                                          );
                                        }
                                        )
                                        ,

                                      ),
                                    )
                                )

                            ),
                            Positioned(
                              top: 50,
                              left: 15,
                              child: ClipOval(
                                child: Container(
                                  color: Colors.white,
                                  width: screenWidth*0.08,
                                  height: screenWidth*0.08,
                                  child: Center(
                                    child: IconButton(
                                      onPressed: () {
                                        Navigator.pop(context);

                                      },
                                      icon: Icon(Icons.arrow_back_ios,color: Colors.blue,
                                        size: fontSize,),

                                    ),
                                  ),
                                ),
                              ),
                            ),
                            if(prd.iduser!.id==context.read<DataService>().user!.id&&prd.state.toLowerCase()=="available")
                            Positioned(
                              top: 50,
                              right: 15,
                              child: ClipOval(
                                child: Container(
                                  color: Colors.white,
                                  width: screenHeight * 0.05,
                                  height: screenHeight * 0.05,
                                  child: Center(
                                    child:
                                    FittedBox(
                                      fit: BoxFit.contain,
                                      child:  PopupMenuButton<String>(
                                    itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                                  PopupMenuItem<String>(
                                    value: 'delete',
                                    child: Text('Delete',style: TextStyle(fontSize: fontSize*0.7),),
                                    onTap: () {
                                      customconfimation(context, 'Delete Product ?', 'Are you sure you want to delete this post?', () {
                                        Deleteproductbyid((msg,color) =>{
                                          Navigator.pop(context),
                                          Navigator.pop(context),

                                          ScaffoldMessenger.of(context).showSnackBar(
                                              SnackBar(
                                             backgroundColor: color,
                                             content:Customerrormsg(icon: Icons.done,message: msg,bgcolor: color,)

    ))






                                        }, prd.id);
                                      }
                                       ,Colors.red);

                                    },
                                  ),
                                    PopupMenuItem<String>(
                                      value: 'modify',
                                      child: Text('Modify',style: TextStyle(fontSize: fontSize*0.7),),
                                      onTap: (){
                                        Navigator.push(context, MaterialPageRoute(builder:(context) => updateproductscreen(p:prd,modif: (p0){

                                          setState(() {
                                            prd=p0;

                                          });

                                        }), ));
                                      },
                                    ),
                                    ],
                                    onSelected: (String value) {
                              if (value == 'delete') {
                              } else if (value == 'modify') {
                              }
                              },
                                icon: Icon(
                                  Icons.more_horiz,
                                  color: Colors.blue,
                                ),
                              ),
                                    ),
                                  ),
                                ),
                              ),
                            ),


                            Positioned(
                              bottom: 20,
                              right: 50,
                              child: Padding(
                                  padding:  EdgeInsets.all(marginValue),
                                  child: Container(
                                    width: screenWidth*0.1,
                                    decoration: BoxDecoration(
                                        color: Colors.blue,

                                        borderRadius: BorderRadius.all(Radius.circular(10))
                                    ),
                                    child: Center(child: Padding(
                                      padding:  EdgeInsets.all(3),
                                      child: Text((_currentImageIndex+1).toString()+"/"+prd.imgaenames.length.toString(),style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: fontSize*0.6),),
                                    )),
                                  )
                              ),
                            ),


                          ],
                        ),
                      ),
                      SizedBox(
                        height: screenHeight*0.005,
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children:
                          List.generate(prd.imgaenames.length, (index) {
                            return  Padding(
                              padding: EdgeInsets.all(marginValue),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Expanded(
                                  child: Container(

                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: index==_currentImageIndex?Colors.blueAccent:Colors.transparent,
                                        width: screenWidth*0.007,
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child:ClipRRect(  // Use ClipRRect to apply border radius to the image
                                      borderRadius: BorderRadius.all(Radius.circular(10)),
                                      child: Image.network(
                                        url+"/getimage/"+prd.imgaenames[index], // Assuming you want to display the first image
                                        fit: BoxFit.cover,
                                        height: screenWidth*0.2,
                                      ),
                                    ),
                                  ),
                                )
                                ,
                              ),
                            )
                            ;
                          }),
                        ),
                      )

                      ,
                      Padding(
                        padding:  EdgeInsets.all(marginValue),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>  profile(user: prd.iduser!.id,)),
                            );
                          },
                          child: Row(
                            children: [
                              ClipOval(

                          child:prd.iduser!.picture.toLowerCase().endsWith('.svg+xml')?
                          SvgPicture.network(
                            url + "/getimage/" + prd.iduser!.picture,
                            fit:BoxFit.cover,
                            height: screenHeight*0.05,

                            // Placeholder widget while loading, if needed
                            placeholderBuilder: (BuildContext context) => CircularProgressIndicator(),

                          ):
                          Image.network(
                            url+"/getimage/"+prd.iduser!.picture, // Assuming you want to display the first image
                            fit:BoxFit.cover,
                            height: screenHeight*0.05,
                          ),

                              ),

                              Padding(
                                padding:  EdgeInsets.all(marginValue),
                                child: Text(prd.iduser!.firstname+" " + prd.iduser!.secondname,style: TextStyle(fontSize: fontSize*0.7),),
                              ),
                              Spacer(),

                              Padding(
                                padding:  EdgeInsets.all(marginValue),
                                child: Container(

                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle, // Use BoxShape.circle to make it a circle
                                  ),
                                  child: Center(
                                    child:
                                    InkWell(
                                      onTap: () {
                                        if(context.read<DataService>().user!.id!=prd.iduser!.id&&context.read<DataService>().user!.role!="admin")

                                          setState(() {
                                            if(searchProductById(prd.id, context.read<DataService>().listproductliked )){
                                              removeProductById(prd.id,context.read<DataService>().listproductliked);
                                              prd.numberlikes--;
                                            }
                                            else{
                                              context.read<DataService>().listproductliked.add(Productgen (state: "available", user: prd.iduser!, imgaename: prd.imgaenames[0], Originalprice: prd.Originalprice, SeelingPrice: prd.SeelingPrice, id: prd.id, name: prd.name));
                                              prd.numberlikes++;
                                            }

                                            addToWishlist(context.read<DataService>().user!.id,prd.id,(likemsg) {
                                              setState(() {
                                                ScaffoldMessenger.of(context).showSnackBar(
                                                    SnackBar(
                                                        backgroundColor: Colors.pinkAccent,
                                                        content:                               Customerrormsg(icon: Icons.done,message:likemsg,bgcolor: Colors.pinkAccent,)

                                                    ))
                                                ;
                                              });
                                            },
                                                  (dislikemsg) {
                                                setState(() {
                                                  context.read<DataService>().listproductliked.remove(this.widget.p);

                                                  ScaffoldMessenger.of(context).showSnackBar(
                                                      SnackBar(
                                                          backgroundColor: Colors.grey,
                                                          content:                               Customerrormsg(icon: Icons.check,message:dislikemsg,bgcolor: Colors.grey,)

                                                      ))
                                                  ;
                                                });
                                              },);
                                          });
                                      },
                                      child:
                                      Column(
                                        children: [
                                          SvgPicture.asset("assets/icons/Heart.svg",                                color:searchProductById(prd.id, context.read<DataService>().listproductliked )? Colors.red:Colors.black
                                          ),

                                          Text(prd.numberlikes.toString(),style: TextStyle(fontSize: fontSize*0.7),)
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding:  EdgeInsets.all(marginValue),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [


                            Padding(
                              padding:  EdgeInsets.all(marginValue),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(prd.name,style: TextStyle(fontSize: fontSize*1.2,fontWeight: FontWeight.bold)),
                                  Padding(
                                    padding:  EdgeInsets.fromLTRB(marginValue, marginValue*0.5, 0, 0),
                                    child: Text(prd.description,style: TextStyle(fontSize: fontSize*0.7,)),
                                  ),
                                ],
                              ),
                            ) ,
                            Padding(
                              padding:  EdgeInsets.all(marginValue),
                              child: Column(
                                children: [
                                  Text(
                                    prd.Originalprice.toStringAsFixed(1)+" DT",
                                    style: TextStyle(fontWeight: FontWeight.bold,
                                        decoration: TextDecoration.lineThrough,
                                        fontSize: fontSize*0.7
                                    ),),
                                  Text(prd.SeelingPrice.toStringAsFixed(1)+" DT",style: TextStyle(fontSize: fontSize,fontWeight: FontWeight.bold),),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),

                      Divider(),
                      Container(
                        child: Wrap(
                            children:[
                              Padding(
                                padding:  EdgeInsets.all(marginValue),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                    border: Border.all(color: Colors.black,
                                        width: screenWidth*0.002),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.white.withOpacity(0), // Color of the shadow
                                        spreadRadius: 2, // Spread radius
                                        blurRadius: 5, // Blur radius
                                        offset: Offset(0, 3), // Offset in x and y direction
                                      ),
                                    ],
                                  ),


                                  child: Padding(
                                    padding:  EdgeInsets.all(marginValue),
                                    child: Column(
                                      children: [
                                        Text("Color :",style: TextStyle(fontSize: fontSize*0.7,color: Colors.blueAccent,fontWeight: FontWeight.bold),),
                                        Wrap(
                                          spacing: 5,
                                          children: [
                                            Text(prd.cl!.name,style: TextStyle(fontSize: fontSize*0.7,color: Colors.black),),
                                            prd.cl!.name.toLowerCase()!="multicolor"?
                                            Icon(Icons.circle,size: fontSize,color: prd.cl?.coleur,):
                                            CircleAvatar(
                                              radius: fontSize*0.5,

                                              child: Image.asset("assets/images/multiclr.png"),)
                                          ],
                                        ),

                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding:  EdgeInsets.all(marginValue),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                    border: Border.all(color: Colors.black,
                                        width: screenWidth*0.002),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.white.withOpacity(0), // Color of the shadow
                                        spreadRadius: 2, // Spread radius
                                        blurRadius: 5, // Blur radius
                                        offset: Offset(0, 3), // Offset in x and y direction
                                      ),
                                    ],
                                  ),


                                  child: Padding(
                                    padding:  EdgeInsets.all(marginValue),
                                    child: Column(
                                      children: [
                                        Text("Brand :",style: TextStyle(fontSize: fontSize*0.7,color: Colors.blueAccent,fontWeight: FontWeight.bold),),
                                        Wrap(
                                          children: [
                                            Text(prd.Brand.title,style: TextStyle(fontSize: fontSize*0.7,color: Colors.black),),
                                          ],
                                        ),

                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding:  EdgeInsets.all(marginValue),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                    border: Border.all(color: Colors.black,
                                        width: screenWidth*0.002),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.white.withOpacity(0), // Color of the shadow
                                        spreadRadius: 2, // Spread radius
                                        blurRadius: 5, // Blur radius
                                        offset: Offset(0, 3), // Offset in x and y direction
                                      ),
                                    ],
                                  ),


                                  child: Padding(
                                    padding:  EdgeInsets.all(marginValue),
                                    child: Column(
                                      children: [
                                        Text("State",style: TextStyle(fontSize: fontSize*0.7,color: Colors.blueAccent,fontWeight: FontWeight.bold),),
                                        Text(prd.state,style: TextStyle(fontSize: fontSize*0.7,color: Colors.black),),

                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding:  EdgeInsets.all(marginValue),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                    border: Border.all(color: Colors.black,
                                        width: screenWidth*0.002),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.white.withOpacity(0), // Color of the shadow
                                        spreadRadius: 2, // Spread radius
                                        blurRadius: 5, // Blur radius
                                        offset: Offset(0, 3), // Offset in x and y direction
                                      ),
                                    ],
                                  ),


                                  child: Padding(
                                    padding:  EdgeInsets.all(marginValue),
                                    child: Column(
                                      children: [
                                        Text("Categerie",style: TextStyle(fontSize: fontSize*0.7,color: Colors.blueAccent,fontWeight: FontWeight.bold),),
                                        Text(prd.Categorie!.name,style: TextStyle(fontSize: fontSize*0.7,color: Colors.black),),

                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding:  EdgeInsets.all(marginValue),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                    border: Border.all(color: Colors.black,
                                        width: screenWidth*0.002),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.white.withOpacity(0), // Color of the shadow
                                        spreadRadius: 2, // Spread radius
                                        blurRadius: 5, // Blur radius
                                        offset: Offset(0, 3), // Offset in x and y direction
                                      ),
                                    ],
                                  ),


                                  child: Padding(
                                    padding:  EdgeInsets.all(marginValue),
                                    child: Column(
                                      children: [
                                        Text("Size",style: TextStyle(fontSize: fontSize*0.7,color: Colors.blueAccent,fontWeight: FontWeight.bold),),
                                        Text(prd.Size.name,style: TextStyle(fontSize: fontSize*0.7,color: Colors.black),),

                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ]
                        ),
                      ),
                                                           if(context.read<DataService>().user!.role!="admin")

                      Padding(
                        padding:  EdgeInsets.all(marginValue),
                        child:                                    Row(
                          children: [
                            ClipOval(
                              child: prd.iduser!.picture.toLowerCase().endsWith('.svg+xml')?
                              SvgPicture.network(
                                url + "/getimage/" + prd.iduser!.picture,
                                fit:BoxFit.cover,
                                height: screenHeight*0.05,

                                // Placeholder widget while loading, if needed
                                placeholderBuilder: (BuildContext context) => CircularProgressIndicator(),

                              ):
                              Image.network(
                                url+"/getimage/"+context.read<DataService>().user!.picture, // Assuming you want to display the first image
                                fit:BoxFit.cover,
                                height: screenHeight*0.05,
                              ),
                            ),
                            SizedBox(width: screenWidth * 0.02),

                            Expanded(
                              child: TextField(
                                onChanged: (value) {
                                  setState(() {
                                    commentaire.text=value;

                                  });
                                },
                                controller: commentaire,
                                decoration: InputDecoration(
                                  hintText: 'Your Comment', // You can customize the hint text here
                                  border: InputBorder.none,
                                ),
                                style: TextStyle(fontSize: fontSize * 0.7), // Set your desired font size
                              ),
                            ),
                            IconButton(
                                onPressed:(){
                                  if(commentaire.value.text!=""){
                                    Commentaire c=Commentaire(idproduct: prd.id,user: context.read<DataService>().user, id: "id", firstname: "firstname", message: commentaire.text, date: DateTime.now());
                                    setState(() {
                                      commentaire.text="";
                                      ajoutcommentaire(c,   (dislikemsg,color,cmt) {
                                        setState(() {

if(cmt!=null){

  prd.commentaires.add(cmt);

}
                                          ScaffoldMessenger.of(context).showSnackBar(
                                              SnackBar(
                                                  backgroundColor: color,
                                                  content:                               Customerrormsg(icon: Icons.done,message:dislikemsg,bgcolor: color,)

                                              ))
                                          ;
                                        });
                                      });
                                    });
                                  }


                                }, icon: Icon(Icons.send,color:commentaire.value.text==""? Colors.grey:Colors.blueAccent,size: fontSize,))
                          ],
                        ),


                      ),


                      Wrap(
                        children: List.generate(prd.commentaires.length, (index){
                          return                       commenter(
                          modify: (cmt){
                            setState(() {
                              prd.commentaires[index]=cmt;
                            });
                          }
                          ,delete:(){
                            setState(() {
                              prd.commentaires.remove(prd.commentaires[index]);
                            });
                          },cmt: prd.commentaires[index],marginValue: marginValue, screenHeight: screenHeight, screenWidth: screenWidth, fontSize: fontSize);
                        }),
                      )




                    ],
                  ),]
              ),
            ),
          ),
          if(prd.state=="Available"&&context.read<DataService>().user!.id!=prd.iduser!.id&&context.read<DataService>().user!.role.toLowerCase()!="admin")
            Padding(
              padding:  EdgeInsets.all(marginValue),
              child:              button(onclick: (){
                Navigator.push(context, MaterialPageRoute(builder:(context) => buyproduct(idprd: prd.id), ));
              },color: Colors.blueAccent.withOpacity(0.7), width: screenWidth*0.8, label: "Buy Now!", height: screenHeight*0.07)
              ,
            )
        ],
      ),


    );
  }
}
class LoadingScreen2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:     Center(
        child: CircularProgressIndicator(),
    ),
    );
  }
}
