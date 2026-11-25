import 'package:bridgewearaa/controlleur/commandcontrolleur.dart';
import 'package:bridgewearaa/models/commande.dart';
import 'package:bridgewearaa/screens/buttons.dart';
import 'package:bridgewearaa/screens/productdetails.dart';
import 'package:bridgewearaa/screens/searchscreen.dart';
import 'package:bridgewearaa/services/data.dart';
import 'package:bridgewearaa/widget/commanditem.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';

class bag extends StatefulWidget {
  const bag({super.key});

  @override
  State<bag> createState() => _bagState();
}

class _bagState extends State<bag> {
  bool loading=false;
  List<commande> listsales=[];
  getdata(Function add)async{
    getcommand((list) => {
      setState(() {
        context.read<DataService>().listcommandes=list;
      })
    },context.read<DataService>().user!.id).then((value) => {
      add()
    });
    getsalles((list) => {
      setState(() {
        listsales=list;
      })
    },context.read<DataService>().user!.id).then((value) => {
      add()
    });
  }
  void initState() {
    super.initState();
    if(context.read<DataService>().user!=null)

getdata((){
  setState(() {
    loading=true;
  });
});





  }
  int index=0;
  @override
  Widget build(BuildContext context) {
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
    return Scaffold(
appBar: AppBar(




  title: Text("My Bag",style: TextStyle(color: Colors.black),),
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
      body: SingleChildScrollView(
        child:Column(

          children: [
            Padding(padding: EdgeInsets.all(marginValue),
              child: Row(
                children: [
                  Expanded(child:  InkWell(
                    onTap: () {
                      setState(() {
                        index=0;
                      });
                    },
                    child: Container(
                      child: Column(
                        children: [
                          Center(child: InkWell(
                            onTap: () {
                              setState(() {
                                index=0;
                                loading=false;
                                getdata((){

                                  loading=true;

                                });
                              });
                            },
                            child: Text("Purchase",style:
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
                    ),
                  )
                  ),
                  Expanded(child:  InkWell(
                    onTap: () {
                      setState(() {
                        index=1;
                        loading=false;
                        getdata((){

                          loading=true;

                        });
                      });

                    },
                    child: Container(
                      child: Column(
                        children: [
                          Center(child: InkWell(
                              onTap: () {
                                setState(() {
                                  index=1;
                                  loading=false;
                                  getdata((){

                                    loading=true;

                                  });
                                });
                              },
                              child: Text("Sales",style:
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
                    ),
                  )
                  ),
                ],
              ),

            ),

            Column(

              children: [

                loading?
                index==0?
                listcommande.isEmpty?
                Center(
                  child: Container(

                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [

                        SvgPicture.asset(
                          "assets/icons/Paper Bag.svg",
                          width: screenWidth * 0.4,
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        Text(
                          "Your Bag is Empty !",
                          style: TextStyle(
                            fontSize: fontSize * 1.5,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                          softWrap: true, // Allow text to wrap to the next line
                          textAlign: TextAlign.center, // Center-align the text
                        ),
                        SizedBox(height: screenHeight * 0.02),

                        Container(
                          width: screenWidth * 0.9, // Set your desired maximum width
                          child:  Text(
                            "Tap on the heart on your favorite items to add them to your wishlist",
                            style: TextStyle(
                              fontSize: fontSize*0.8,
                              color: Colors.black.withOpacity(0.7),
                            ),
                            softWrap: true,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.02),

                        button(onclick:(){
                          Navigator.push(context, MaterialPageRoute(builder:(context) => SearchScreen(dp: [],br: context.read<DataService>().brands,list:context.read<DataService>().listproduct), ));
                        },color: Colors.blueAccent.withOpacity(0.7), width: screenWidth*0.8, label:"Start shopping", height:screenHeight*0.07)
                      ],
                    ),
                  ),
                ):
                SingleChildScrollView(
                  child: Center(
                    child: Padding(
                      padding:  EdgeInsets.all(marginValue),
                      child: Wrap(
                          runSpacing: marginValue*2,

                          children:
                          List.generate(listcommande.length, (index){
                            return commandeitem(c: listcommande[index],);
                          })
                      ),
                    ),
                  ),
                ):
                listsales.isEmpty?
                Center(
                  child: Container(

                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [

                        SvgPicture.asset(
                          "assets/icons/Paper Bag.svg",
                          width: screenWidth * 0.4,
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        Text(
                          "Your Bag is Empty !",
                          style: TextStyle(
                            fontSize: fontSize * 1.5,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                          softWrap: true, // Allow text to wrap to the next line
                          textAlign: TextAlign.center, // Center-align the text
                        ),
                        SizedBox(height: screenHeight * 0.02),

                        Container(
                          width: screenWidth * 0.9, // Set your desired maximum width
                          child:  Text(
                            "Tap on the heart on your favorite items to add them to your wishlist",
                            style: TextStyle(
                              fontSize: fontSize*0.8,
                              color: Colors.black.withOpacity(0.7),
                            ),
                            softWrap: true,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.02),

                        button(onclick:(){
                          Navigator.push(context, MaterialPageRoute(builder:(context) => SearchScreen(dp: [],br: context.read<DataService>().brands,list:context.read<DataService>().listproduct), ));
                        },color: Colors.blueAccent.withOpacity(0.7), width: screenWidth*0.8, label:"Start shopping", height:screenHeight*0.07)
                      ],
                    ),
                  ),
                ):
                SingleChildScrollView(
                  child: Center(
                    child: Padding(
                      padding:  EdgeInsets.all(marginValue),
                      child: Wrap(
                          runSpacing: marginValue*2,

                          children:
                          List.generate(listsales.length, (index){
                            return commandeitem(c: listsales[index],sales: "no avis",);
                          })
                      ),
                    ),
                  ),
                ):
                Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircularProgressIndicator(),
                      ),
                    )
              ],
            ),
          ],
        )
        //no commandes







      ),
    );

  }
}
