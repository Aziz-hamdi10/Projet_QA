

import 'dart:io';
import 'dart:typed_data';

import 'package:bridgewearaa/models/brand.dart';
import 'package:bridgewearaa/models/color.dart';
import 'package:bridgewearaa/models/categorie.dart';
import 'package:bridgewearaa/models/product.dart';
import 'package:shimmer/shimmer.dart';
import '../models/productgenerale.dart';
import 'package:bridgewearaa/widget/CustomErormsg.dart';

import 'package:bridgewearaa/screens/productdetails.dart';
import 'package:bridgewearaa/services/data.dart';
import 'package:bridgewearaa/services/imagecompress.dart';
import 'package:bridgewearaa/widget/brands.dart';
import 'package:bridgewearaa/widget/brandsflitrer.dart';
import 'package:bridgewearaa/widget/custom_Text_Form_fild.dart';
import 'package:bridgewearaa/widget/custom_button.dart';
import 'package:bridgewearaa/widget/customcategorie.dart';
import 'package:bridgewearaa/widget/customsheet.dart';
import 'package:bridgewearaa/widget/customslider.dart';
import 'package:bridgewearaa/widget/productitem.dart';
import 'package:bridgewearaa/widget/sizefilter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../config.dart';
import 'package:bridgewearaa/controlleur/productcontrolleur.dart';

class SearchScreen extends StatefulWidget {
  final List<Product> list;
  final  List<brand> br;
  final List<categorie> dp;
     SearchScreen({ required this.dp, required this.br,Key? key,required this.list}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController prixmin = TextEditingController();
  TextEditingController prixmax = TextEditingController();
  TextEditingController searchController = TextEditingController();
  static List previousSearchs = [];
  String orderby = '';
  List<String> listorderby=["Price: High to Low","Price: Low to High"];
  bool order=false;
  List<double> widthproduct=[0.8,0.4,0.25,];
  int pos=1;
  late List<Product> listproductfiltred=[];
  @override
  void initState() {
    super.initState();

    context.read<DataService>().listcolorsfiltred=[];
    context.read<DataService>().listsizefilter=[];
    context.read<DataService>().listbrandfiltrer=[];
    context.read<DataService>().listcategoriefiltred=[];

    listproductfiltred = widget.list;
    prixmin.text='0';
    if(widget.br.isNotEmpty){
      context.read<DataService>().listbrandfiltrer.addAll(widget.br);
    }
    if(widget.dp.isNotEmpty){
      context.read<DataService>().listcategoriefiltred.addAll(widget.dp);
    }
    _search();

  }
  void _likeproduct(Product p){
    if(p.liked==false){


      setState(() {
        p.liked=true;
        p.numberlikes++;
      });


    }
    else{


      setState(() {
        p.liked=false;
        p.numberlikes--;
      });

    }
  }
  String categorie="all";

  void _search(){
    setState(() {


      listproductfiltred = List.from(context.read<DataService>().listproduct);
      listproductfiltred=filterProductsByName(listproductfiltred,searchController.text);

      if(context.read<DataService>().listcolorsfiltred.isNotEmpty)
        listproductfiltred=filterProductsByColor(listproductfiltred, context.read<DataService>().listcolorsfiltred);
      if(context.read<DataService>().listsizefilter.isNotEmpty)
        listproductfiltred=filterProductsBySize(listproductfiltred, context.read<DataService>().listsizefilter);
      if(context.read<DataService>().listbrandfiltrer.isNotEmpty)
        listproductfiltred=filterProductsByBrand(listproductfiltred, context.read<DataService>().listbrandfiltrer);
      if(context.read<DataService>().listcategoriefiltred.isNotEmpty)
        listproductfiltred=filterProductsBycategorie(listproductfiltred, context.read<DataService>().listcategoriefiltred);

      if(prixmax.text.isNotEmpty&&prixmin.text.isNotEmpty)
      {
        if(prixmax.text.isEmpty)
          listproductfiltred=filterProductsByPrice(listproductfiltred,double.tryParse(prixmin.text) ??0.0,double.tryParse(prixmax.text) ?? double.infinity);
        else{
          listproductfiltred=filterProductsByPrice(listproductfiltred,double.tryParse(prixmin.text) ?? 0.0,double.tryParse(prixmax.text) ?? double.infinity);

        }


      }
      if(categorie.toLowerCase()!='all'){
        listproductfiltred=filterProductsByCategorie(listproductfiltred, categorie);
      }

    });
    if(searchController.text.isNotEmpty){
      listproductfiltred=  filtrerproductbysearch(listproductfiltred,searchController.text);
    }
    if(orderby!=""){
      listproductfiltred=orderByPrix(listproductfiltred, orderby);
    }

  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    double screenWidth = mediaQueryData.size.width;
    double screenHeight = mediaQueryData.size.height;
    double fontSize = MediaQuery.of(context).size.shortestSide * 0.05;
    double marginValue = MediaQuery.of(context).size.width * 0.02;
    List<brand> listbrandsfiltrerd=context.read<DataService>().listbrandfiltrer;
    List<String> listsize=context.read<DataService>().listsizefilter;
    List<color> listcouleurfiltred=context.read<DataService>().listcolorsfiltred;
    List<Product>listproduct=context.read<DataService>().listproduct;
    List<String> listhotsearch=["Cargo Pants","Hoodie"];


    void charge(){
      setState(() {
        listbrandsfiltrerd=context.read<DataService>().listbrandfiltrer;
        listsize=context.read<DataService>().listsizefilter;
_search();
      });

    }
    void changeWidth(int pos1) {
      setState(() {
        pos = pos1;

      });
    }

    return SafeArea(
        child: Scaffold(
          body:  Column(
              children: [

                Container(
                  color: Colors.white,
                  child: Padding(
                    padding:  EdgeInsets.all(marginValue),
                    child: Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(
                              Icons.arrow_back_ios,
                              color: Colors.blueAccent,
                            )),
                        Expanded(
                          child: CostomTextFormFild(
                            hint: "Search",
                            prefixIcon: Icons.search_sharp,
                            controller: searchController,
                            filled: true,
                            suffixIcon: searchController.text.isEmpty
                                ? null
                                : Icons.cancel_sharp,
                            onChanged: (value){
                              _search();
                            },
                            onTapSuffixIcon: () {
                              searchController.clear();
                              _search();

                            },
                 
                            onEditingComplete: () {
                              setState(() {
                                previousSearchs.add(searchController.text);

                              });

                            },

                          ),
                        ),
                        IconButton(
                            onPressed: () {
                              setState(() {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (context) => custombottomSheetFilter(charge: (){
                                    setState(() {
                                      _search();

                                  });},prixmax: prixmax,prixmin: prixmin), // Without invoking the function
                                );
                              });
                            },
                            icon:
                              Stack(
                                alignment: Alignment.bottomRight,
                                children: [
                                  SvgPicture.asset("assets/icons/Filter.svg",height: fontSize*1.2,width: fontSize*1.1,color: Colors.black,),
                                  if(context.read<DataService>().listcategoriefiltred.isNotEmpty||listsize.isNotEmpty||listbrandsfiltrerd.isNotEmpty||listcouleurfiltred.isNotEmpty)
                                  CircleAvatar(
                                    backgroundColor: Colors.transparent,
                                    radius: 5,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle
                                            ,
                                        color: Colors.red,

                                      ),
                                      height: screenHeight*0.02,
                                      width: screenHeight*0.02,
                                      child: Center(
                                        child: FittedBox(
                                          fit: BoxFit.scaleDown, // This ensures the text fits within the container
                                          child: Text(
                                            (context.read<DataService>().listcategoriefiltred.length+listsize.length+listbrandsfiltrerd.length+listcouleurfiltred.length).toString(),
                                            style: TextStyle(color: Colors.white, fontSize: fontSize, fontWeight: FontWeight.bold),
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

                 SizedBox(
                  height: screenHeight*0.01,
                ),

                Container(
                  color: Colors.white,
                  child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,

                      itemCount: previousSearchs.length,
                      itemBuilder: (context, index) => previousSearchsItem(index)),
                ),
                const SizedBox(
                  height: 8,
                ),

                // Search Suggestions
                if(listsize.isEmpty&&listbrandsfiltrerd.isEmpty&&listcouleurfiltred.isEmpty&&searchController.text.isNotEmpty)

                  Container(
                  width: double.infinity,
                  color: Colors.white,
                  padding:  EdgeInsets.all(marginValue),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding:  EdgeInsets.all(marginValue),
                         child: Row(
                          children: [
                            SvgPicture.asset("assets/icons/flame-icon.svg",height: fontSize,width: fontSize,color: Colors.red,),
                            SizedBox(width: screenWidth*0.02,),
                            Text(
                              "Hot Searches",
                              style:TextStyle(fontWeight: FontWeight.bold,fontSize: fontSize,color: Colors.grey)
                            ),
                          ],
                        ),
                      ),
                       SizedBox(
                        height: screenHeight*0.02,
                      ),
                      Wrap(
                        spacing: screenWidth*0.02,
                        runSpacing: screenHeight*0.01,
                        children:
                        List.generate(listhotsearch.length, (index) {
                          return InkWell(
                            onTap:(){
                              setState(() {
                                searchController.text=listhotsearch[index];
                                _search();
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.grey.withOpacity(0.2)
                                      ,
                                  borderRadius: BorderRadius.circular(10.0),



                              ),
                              child: Padding(
                                padding:  EdgeInsets.all(marginValue),
                                child: Text(listhotsearch[index],style: TextStyle(fontSize: fontSize*0.6,fontWeight: FontWeight.bold),),
                              ),
                            ),
                          );
                        })


                        ,
                      )

                    ],
                  ),
                )
                else
                  Container(
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding:  EdgeInsets.all(marginValue),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Result",style: TextStyle(fontSize: fontSize*0.8,fontWeight: FontWeight.bold),),
                              Text(listproductfiltred.length.toString()+" Product",style: TextStyle(fontSize: fontSize*0.8,color: Colors.black.withOpacity(0.7)),),


                            ],
                          ),
                        ),
                        Spacer(),
//orderby
                        InkWell(
                          onTap: () {
                            setState(() {
                              order=!order;
                            });

                          },
                          child: Container(
                              width: screenWidth*0.2,
                              child: Row(
                                children: [
                                  Text("Sort",style: TextStyle(fontSize: fontSize*0.7,fontWeight:FontWeight.w400),),
                                  Icon(!order?Icons.arrow_drop_down:Icons.arrow_drop_up)

                                ],
                              )

                          ),
                        ),
                       //widthproduct
                       Padding(
                         padding:  EdgeInsets.all(marginValue),
                         child: Wrap(
                            spacing: screenWidth*0.02,
                           children: [

                             InkWell(onTap: () {
                                changeWidth(0);
                             },
                                 child:
                                 SvgPicture.asset("assets/icons/grid1.svg",color: pos==0?Colors.blueAccent:Colors.grey[300],
                                   height: screenHeight*0.03)
                             ),
                             InkWell(onTap: () {
                               changeWidth(1);

                             },
                                 child:
                                 SvgPicture.asset("assets/icons/grid2.svg",color: pos==1?Colors.blueAccent:Colors.grey[300],
                                   height: screenHeight*0.03,)
                             ),

                             InkWell(onTap: () {
                               changeWidth(2);
                             },
                                 child:
                                 SvgPicture.asset("assets/icons/grid3.svg",color: pos==2?Colors.blueAccent:Colors.grey[300],
                                   height: screenHeight*0.03,)
                             ),


                           ],
                         ),
                       ),





                        if(context.read<DataService>().listbrandfiltrer.isNotEmpty||context.read<DataService>().listcolorsfiltred.isNotEmpty||context.read<DataService>().listsizefilter.isNotEmpty)
                        IconButton(onPressed:() =>{
                          setState(() {
                            context.read<DataService>().listbrandfiltrer.clear();
                            context.read<DataService>().listsizefilter.clear();
                            context.read<DataService>().listcolorsfiltred.clear();
                            searchController.text="";

                            charge();
_search();
                          })

                        } , icon: Icon(Icons.cancel_outlined))

                      ],
                    ),
                  ),
                Expanded(
                  child: Stack(
                    children: [
                      listproductfiltred.isNotEmpty?
                      SingleChildScrollView(child: Column(
                        children: [
    Wrap(
    spacing: screenWidth*0.05,
    runSpacing: 8.0,
    children:
    List.generate(  listproductfiltred.length
    , (index)  {
      Product p=listproductfiltred[index];
          return  InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>  productdetails(p: p.id,)),
              );

            },
            child: Padding(
              padding:  EdgeInsets.all(marginValue),

              child: Container(
                width:screenWidth* widthproduct[pos],

                child: Column(
                      children: [

                        Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.only(topRight: Radius.circular(10), topLeft: Radius.circular(10)),
                              child: Image.network(
                                url+"/getimage/"+p.imgaenames[0], // Assuming you want to display the first image
                                fit: BoxFit.cover,

                              ),
                            )
,

                            Positioned(
                              top: 10,
                              right: 10,
                              child: ClipOval(

                                child: Container(
                                  color: Colors.white,
                                  height: screenHeight*0.035
                                  ,
                                  width:  screenHeight*0.035
                                  ,
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        if(searchProductById(p.id, context.read<DataService>().listproductliked )){
                                          removeProductById(p.id,context.read<DataService>().listproductliked);
                                        }
                                        else{
                                          context.read<DataService>().listproductliked.add(Productgen(state: "available",user: p.iduser!, imgaename: p.imgaenames[0], Originalprice: p.Originalprice, SeelingPrice: p.SeelingPrice, id: p.id, name: p.name));
                                        }
                                        addToWishlist(context.read<DataService>().user!.id,p.id,(likemsg) {
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
                                              removeProductById(p.id,context.read<DataService>().listproductliked);

                                              ScaffoldMessenger.of(context).showSnackBar(
                                                  SnackBar(
                                                      backgroundColor: Colors.grey,
                                                      content:                               Customerrormsg(icon: Icons.done,message:dislikemsg,bgcolor: Colors.grey,)

                                                  ))
                                              ;
                                            });
                                          },);
                                      });


                                    },
                                    child: Center(
                                      child: SvgPicture.asset("assets/icons/Heart.svg",
                                          fit: BoxFit.fitWidth,
                                          color:searchProductById(p.id, context.read<DataService>().listproductliked )? Colors.red:Colors.black
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                            )
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.all(marginValue),
                          child: Row(
                            children: [
                              ClipOval(child:
          Image.network(

          url+"/getimage/"+p.iduser!.picture, // Assuming you want to display the first image
            fit: BoxFit.fill,
            height: screenHeight * 0.03,
            width: screenHeight * 0.03,
          )
                             ,
                              ),
                              SizedBox(width: screenWidth * 0.02),
                              Expanded(
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Text(
                                        p.iduser!.firstname+" "+p.iduser!.secondname,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: screenWidth*widthproduct[pos],
                          child: Padding(
                            padding:  EdgeInsets.all(marginValue),
                            child: Stack(
                              children: [ Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [

                                  Expanded(child: Text(p.name,style: TextStyle(fontSize: fontSize*0.6)
                                  )
                                  ),
                                  Positioned(
                                      right: 0,
                                      child: Container(
                                        width:(screenWidth*widthproduct[pos]) * 0.3,
                                        child: Expanded(
                                          child: FittedBox(
                                            fit: BoxFit.scaleDown,
                                            child: Text(
                                            p.SeelingPrice.toString()+" DT",
                                              style: TextStyle(fontWeight: FontWeight.bold),
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
    ),
                        ],
                      )):
                      Expanded(child: Container(
                        width: screenWidth,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("There was no matching results.",style: TextStyle(fontWeight: FontWeight.w300,fontSize: fontSize*0.8),),
                            Text("Please adjust your filters.",style: TextStyle(fontWeight: FontWeight.w300,fontSize: fontSize*0.8),),


    ],
                        ),
                      )),

                      if(order)
                        Positioned(
                          top: 0,
                          child:Container(
                            color: Colors.white,

                            width: screenWidth,
                            child: Padding(
                              padding:  EdgeInsets.all(marginValue),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Sort by",style: TextStyle(fontSize: fontSize*0.8,fontWeight: FontWeight.bold),),
                                  SizedBox(height: screenHeight*0.02,),
                                  Padding(
                                    padding:  EdgeInsets.all(marginValue),
                                    child: Wrap(
                                      spacing: screenWidth*0.02,
                                      runSpacing: screenHeight*0.01,
                                      children: List.generate(listorderby.length, (index){

                                        return  InkWell(
                                          onTap: () {
                                            setState(() {
                                              orderby=listorderby[index];
                                              _search();
                                            });
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                                border: Border.all(color: Colors.black.withOpacity(0.5))
                                                ,
                                                color: orderby==listorderby[index]?Colors.blue:Colors.white,
                                                borderRadius: BorderRadius.all(Radius.circular(5))
                                            ),
                                            child:
                                            Padding(
                                              padding:  EdgeInsets.all(marginValue),
                                              child: Text(listorderby[index],style:TextStyle(fontSize: fontSize*0.7,color:orderby==listorderby[index]? Colors.white:Colors.black.withOpacity(0.7)),),

                                            ),
                                          ),
                                        );
                                      })

                                      ,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),




              ],
            ),

        ));
  }

  previousSearchsItem(int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: InkWell(
        onTap: () {
          setState(() {
            searchController.text=previousSearchs[index];
          });
        },
        child: Dismissible(
          key: GlobalKey(),
          onDismissed: (DismissDirection dir) {
            setState(() {});
            previousSearchs.removeAt(index);
          },
          child: Row(
            children: [
              const Icon(
                Icons.history,
                color: Colors.grey,


              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                previousSearchs[index],
              ),
              const Spacer(),
              const Icon(
                Icons.call_made_outlined,
                color: Colors.grey,
              )
            ],
          ),
        ),
      ),
    );
  }



}

