import 'dart:typed_data';

import 'package:bridgewearaa/Webpart/constaints.dart';
import 'package:bridgewearaa/config.dart';
import 'package:bridgewearaa/controlleur/brandcontrolleur.dart';
import 'package:bridgewearaa/controlleur/categoriecontroller.dart';
import 'package:bridgewearaa/models/brand.dart';
import 'package:bridgewearaa/models/categorie.dart';
import 'package:bridgewearaa/services/data.dart';
import 'package:bridgewearaa/widget/CustomConfirmation.dart';
import 'package:bridgewearaa/widget/CustomErormsg.dart';
import 'package:bridgewearaa/widget/active_project_card.dart';
import 'package:bridgewearaa/widget/project_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:flutter_svg/flutter_svg.dart';

class categoriescreen extends StatefulWidget {
  const categoriescreen({Key? key}) : super(key: key);

  @override
  _categoriescreenstate createState() => _categoriescreenstate();
}

class _categoriescreenstate extends State<categoriescreen> {
  @override
  void initState() {
    super.initState();
       getcategories( (list) =>{

      context.read<DataService>().categories=list
    });
  }

  @override
  Widget build(BuildContext context) {
     MediaQueryData mediaQueryData = MediaQuery.of(context);
    double screenWidth = mediaQueryData.size.width;
    double screenHeight = mediaQueryData.size.height;
        final Size _size = MediaQuery.of(context).size;
    final bool _isDesktop = _size.width >= 600;
   if(screenHeight<screenWidth){
           screenWidth = mediaQueryData.size.height;
     screenHeight = mediaQueryData.size.width;

    }
    double fontSize = MediaQuery.of(context).size.shortestSide * 0.05;
    double marginValue = MediaQuery.of(context).size.width * 0.02;
     
  
      
  
    return _isDesktop? ActiveProjectCard(
      title: "categories",
        onPressedSeeAll: ()  {
                showDialog(
  context: context,
  builder: (BuildContext context) {
    return AlertDialog(
      title: Text("Add category",style: TextStyle(fontSize: fontSize*0.7,fontWeight: FontWeight.bold),),
      content: addcategoriewidget(change: (){
        
      }),
     
    );
  },
);
;  },
        child: StaggeredGridView.countBuilder(
          crossAxisCount: 2,
          itemCount: context.read<DataService>().categories.length,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Padding( 
              padding: const EdgeInsets.all(0.0),
              child: categoryCard(delete: (){
                setState(() {
                                   context.read<DataService>().categories.remove(context.read<DataService>().categories[index]);

                });
              },data: context.read<DataService>().categories[index],change: (categorie){
                  context.read<DataService>().categories[index]=categorie;
                
              }),
            );
          },
          staggeredTileBuilder: (int index) =>
              StaggeredTile.fit(1),
        ),
      )
    : ActiveProjectCard(
      title: "Categorie",
        onPressedSeeAll: ()  {
            showDialog(
  context: context,
  builder: (BuildContext context) {
    return Dialog(
      child: Material(
        child: addcategoriewidget(change:(){
         
        } ),
      ),
    );
  },
);
                  },
        child: StaggeredGridView.countBuilder(
          crossAxisCount: 2,
          itemCount: context.read<DataService>().categories.length,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Padding( 
              padding: const EdgeInsets.all(0.0),
              child: categoryCard(delete:(){
                setState(() {
                                   context.read<DataService>().categories.remove(context.read<DataService>().categories[index]);

                });
              } ,data: context.read<DataService>().categories[index],change: (newcat){
                   context.read<DataService>().categories[index]=newcat;
             
              }),
            );;
          },
          staggeredTileBuilder: (int index) =>
              StaggeredTile.fit(2),
        ),
      )
    ;}
}


class addcategoriewidget extends StatefulWidget {
  final categorie? cr;
  final Function change;
  const addcategoriewidget({
     required this.change,
    this.cr,
    Key? key,
 
  }) : super(key: key);

  @override
  _AddCategorieWidgetState createState() => _AddCategorieWidgetState();
}

class _AddCategorieWidgetState extends State<addcategoriewidget> {
  @override
  void initState() {
    super.initState();
    if(widget.cr!=null)
    name.text=widget.cr!.name;
  }
  XFile? imageFile;
  String texterror="";
  Uint8List webimage=Uint8List(8);
      TextEditingController name=TextEditingController();
categorie? newcat;
  addcheck(){
if(name.text.isEmpty)   {   
  setState(() {
              texterror= "Name required !";

  });
          }
      else{
        if(imageFile==null){       
          setState(() {
             texterror= "Picture required !";
          });  

        }
        else{
 setState(() {
             texterror= "";
             addcategory(name.text, (msg, color) =>{
               newcat=categorie( dateadd:DateTime.now(),id: "id", name: name.text, image: getimagename(imageFile)),
               if(newcat!=null)
               context.read<DataService>().categories.add(newcat!)
              ,
              Navigator.pop(context),
          
                ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            backgroundColor: color,
            content:                               Customerrormsg(icon: Icons.done,message: msg,bgcolor: color,)

        ))
             }, imageFile);
          });  
        }
      }
    }
   
   updatecheck(){
if(name.text.isEmpty&&imageFile==null)   {   
  setState(() {
              texterror= "Name required !";

  });
          }
      else{
       
 setState(() {
             texterror= "";
             modifycategorie(widget.cr!.id,name.text,imageFile, (msg, color,icon) =>{
              
              Navigator.pop(context),
          
                ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            backgroundColor: color,
            content:                               Customerrormsg(icon: Icons.done,message: msg,bgcolor: color,)

        ))
             });
          });  
        
      }
    }
   
 void pickImage(ImageSource source) async {
  final ImagePicker picker = ImagePicker();
   imageFile = await picker.pickImage(source: ImageSource.gallery);

  if (ImagePicker != null) {
    var f=await imageFile!.readAsBytes();
    setState(() {
    
      webimage=f;
    });
  }
}

String _nameisvalid="";
 
  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    double screenWidth = mediaQueryData.size.width;
    double screenHeight = mediaQueryData.size.height;
    double fontSize = MediaQuery.of(context).size.shortestSide * 0.05;
    double marginValue = MediaQuery.of(context).size.width * 0.02;
  if(screenWidth>screenHeight){
           screenWidth = mediaQueryData.size.height;
       screenHeight = mediaQueryData.size.width;
      }
        final Size _size = MediaQuery.of(context).size;

        final bool _isDesktop = _size.width >= screenLg;

    return  Container(
          width: screenWidth * 0.7,
          height: _isDesktop?screenHeight * 0.45: screenHeight*0.7 ,

          color: Colors.white,
          child:
      Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
        SizedBox(
          height: screenHeight*0.02,
        ),
          ClipOval(
            child: Container(
              child: imageFile != null
                  ? Image.memory(
                      webimage,
                      width: screenWidth * 0.25,
                      height: screenWidth * 0.25,
                    )
                  : widget.cr != null
                      ?widget.cr!.image.toLowerCase().endsWith('.svg+xml')?
                            SvgPicture.network(
                              url + "/getimage/" + widget.cr!.image,
                          height: screenWidth * 0.25,
                          width: screenWidth * 0.25,
                            )
                      
                      :Image.network(
                          url + "/getimage/" + widget.cr!.image,
                          height: screenWidth * 0.25,
                          width: screenWidth * 0.25,
                        )
                      : Container(
                          height: screenWidth * 0.25,
                          width: screenWidth * 0.25,
                          color: Colors.grey[100],
                          child: Icon(Icons.add),
                        ),
            ),
          ),
          TextButton(
            onPressed: () {
              pickImage(ImageSource.gallery);
            },
            style: TextButton.styleFrom(
              foregroundColor: Colors.lightBlueAccent,
            ),
            child: Text(
              widget.cr != null || imageFile != null
                  ? "Upload Image"
                  : "Add Image",
            ),
          ),
           SizedBox(
          height: screenHeight*0.01,
        ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                 Padding(
                   padding:  EdgeInsets.all(marginValue),
                   child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                     children: [
                       Text("Name :" ,style: TextStyle(fontSize: fontSize*0.4,fontWeight: FontWeight.bold),),
                     ],
                   ),
                 ),

                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: TextField(
                              controller: name,
                               onChanged: (value) {
                if (value.isNotEmpty ) {
                  setState(() {
                    _nameisvalid = "";
                    if(searchcatByName(value, context.read<DataService>().categories)==true){
                      _nameisvalid = "name already Exist";
                    }
                    else{
                                      _nameisvalid = "";
                  
                    }
                  });
                } else {
                  setState(() {
                                        _nameisvalid = "Enter Category name !";

                  });
                }
              },
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: fontSize * 0.4,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w400,
                              ),
                          
                              decoration: InputDecoration(
                                hintText: '',
                                                errorText: _nameisvalid=="" ? null : _nameisvalid,

                                hintStyle: TextStyle(
                                  fontSize: fontSize*0.7,
                                ),
                                focusedBorder: InputBorder.none,
                                errorStyle: TextStyle(
                                  fontSize: fontSize*0.5,
                                  fontWeight: FontWeight.w600,
                                ),
                          
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                  borderSide: BorderSide(
                                    width: screenWidth * 0.003,
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                          
                          
                            ),
                          ),
                                                  SizedBox(height: screenHeight*0.02,),

                          Center(child: Text(texterror,style: TextStyle(fontSize: fontSize*0.35,color: Colors.red),)),
                          SizedBox(height: screenHeight*0.02,),

                             Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close',style: TextStyle(color: Colors.red),),
            ),
              TextButton(
          onPressed: () {
            widget.cr!=null?updatecheck():addcheck();
       },
          child: Text(widget.cr!=null?'Modif':'Add'),
        ),
          ],
        ),
                         
            ],)
        ],
      ),
      
    
    
        )
      ;
  }
}
String getimagename(XFile? x){
      String imageName = path.basename(x!.path);
      List<String> parts = imageName.split('_');
      String desiredName = parts.last;
      return desiredName;
}
class PromotionWidget extends StatefulWidget {
  final brand? br;
  final Function change;
  const PromotionWidget({
     required this.change,
    this.br,
    Key? key,
 
  }) : super(key: key);

  @override
  _PromotionWidgetState createState() => _PromotionWidgetState();
}

class _PromotionWidgetState extends State<PromotionWidget> {
  @override
  void initState() {
    super.initState();
    if(widget.br!=null)
    name.text=widget.br!.title;
  }
  XFile? imageFile;
  String texterror="";
  Uint8List webimage=Uint8List(8);
      TextEditingController name=TextEditingController();
brand? newbrand;




 
  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    double screenWidth = mediaQueryData.size.width;
    double screenHeight = mediaQueryData.size.height;
    double fontSize = MediaQuery.of(context).size.shortestSide * 0.05;
    double marginValue = MediaQuery.of(context).size.width * 0.02;
  if(screenWidth>screenHeight){
           screenWidth = mediaQueryData.size.height;
       screenHeight = mediaQueryData.size.width;
      }
        final Size _size = MediaQuery.of(context).size;

        final bool _isDesktop = _size.width >= screenLg;

    return  Container(
          width: screenWidth * 0.7,
          height: _isDesktop?screenHeight * 0.45: screenHeight*0.7 ,

          color: Colors.white,
          child:
      Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
      
 
           SizedBox(
          height: screenHeight*0.01,
        ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                 Padding(
                   padding:  EdgeInsets.all(marginValue),
                   child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                     children: [
                       Text("Name :" ,style: TextStyle(fontSize: fontSize*0.4,fontWeight: FontWeight.bold),),
                     ],
                   ),
                 ),

                          TextField(
                            controller: name,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: fontSize * 0.4,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                            ),

                            decoration: InputDecoration(
                              hintText: '',
                              hintStyle: TextStyle(
                                fontSize: fontSize*0.7,
                              ),
                              focusedBorder: InputBorder.none,
                              errorStyle: TextStyle(
                                fontSize: fontSize*0.5,
                                fontWeight: FontWeight.w600,
                              ),

                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                borderSide: BorderSide(
                                  width: screenWidth * 0.003,
                                  color: Colors.red,
                                ),
                              ),
                            ),


                          ),
                                                  SizedBox(height: screenHeight*0.02,),

                          Center(child: Text(texterror,style: TextStyle(fontSize: fontSize*0.35,color: Colors.red),)),
                          SizedBox(height: screenHeight*0.02,),

                             Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close',style: TextStyle(color: Colors.red),),
            ),
              TextButton(
          onPressed: () {
       },
          child: Text(widget.br!=null?'Modif':'Add'),
        ),
          ],
        ),
                         
            ],)
        ],
      ),
      
    
    
        )
      ;
  }
}
