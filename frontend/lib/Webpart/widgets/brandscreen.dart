import 'dart:typed_data';

import 'package:bridgewearaa/Webpart/constaints.dart';
import 'package:bridgewearaa/config.dart';
import 'package:bridgewearaa/controlleur/brandcontrolleur.dart';
import 'package:bridgewearaa/models/brand.dart';
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

class brandscreen extends StatefulWidget {
  const brandscreen({Key? key}) : super(key: key);

  @override
  _brandscreenstate createState() => _brandscreenstate();
}

class _brandscreenstate extends State<brandscreen> {
  @override
  void initState() {
    super.initState();
       getbrands( (list) =>{

      context.read<DataService>().brands=list
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
      title: "brands",
        onPressedSeeAll: ()  {
                showDialog(
  context: context,
  builder: (BuildContext context) {
    return AlertDialog(
      title: Text("Add brand",style: TextStyle(fontSize: fontSize*0.7,fontWeight: FontWeight.bold),),
      content: addbrandwidget(change: (){
        
      }),
     
    );
  },
);
;  },
        child: StaggeredGridView.countBuilder(
          crossAxisCount: 2,
          itemCount: context.read<DataService>().brands.length,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Padding( 
              padding: const EdgeInsets.all(0.0),
              child: brandcard(delete: (){
                setState(() {
                                   context.read<DataService>().brands.remove(context.read<DataService>().brands[index]);

                });
              },data: context.read<DataService>().brands[index],change: (brand){
                  context.read<DataService>().brands[index]=brand;
                
              }),
            );
          },
          staggeredTileBuilder: (int index) =>
              StaggeredTile.fit(1),
        ),
      )
    : ActiveProjectCard(
      title: "brands",
        onPressedSeeAll: ()  {
            showDialog(
  context: context,
  builder: (BuildContext context) {
    return Dialog(
      child: Material(
        child: addbrandwidget(change:(){
         
        } ),
      ),
    );
  },
);
                  },
        child: StaggeredGridView.countBuilder(
          crossAxisCount: 2,
          itemCount: context.read<DataService>().brands.length,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Padding( 
              padding: const EdgeInsets.all(0.0),
              child: brandcard(delete:(){
                setState(() {
                                   context.read<DataService>().brands.remove(context.read<DataService>().brands[index]);

                });
              } ,data: context.read<DataService>().brands[index],change: (newbrand){
                   context.read<DataService>().brands[index]=newbrand;
             
              }),
            );;
          },
          staggeredTileBuilder: (int index) =>
              StaggeredTile.fit(2),
        ),
      )
    ;}
}


class addbrandwidget extends StatefulWidget {
  final brand? br;
  final Function change;
  const addbrandwidget({
     required this.change,
    this.br,
    Key? key,
 
  }) : super(key: key);

  @override
  _AddBrandWidgetState createState() => _AddBrandWidgetState();
}

class _AddBrandWidgetState extends State<addbrandwidget> {
  String? errmsg;
  
   void updateVerification(String value) async {
      if ( value.isEmpty) {
        setState(() {
              errmsg= 'Name is required';

        });
  } else {
setState(() {
              errmsg= null;

        });
        if(widget.br!=null)
 {   if(widget.br!.title!=name.text)
    {
       bool result = await checkbrandAvailability(value);
    setState(() {
      if(result==false){
        errmsg="Name Used";
      }else{
        errmsg=null;
      }
    });
    }}
    else{
      bool result = await checkbrandAvailability(value);
    setState(() {
      if(result==false){
        errmsg="Name Used";
      }else{
        errmsg=null;
      }
    });
    }

      
     
 
  
  }

  
  }

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
  addcheck(){
    updateVerification(name.text);
if(errmsg!=null)   {   
  setState(() {
              texterror= errmsg!;

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
             addbrand(name.text, (msg, color,br) =>{
               context.read<DataService>().brands.add(br!),
            
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
             modifbrand(widget.br!.id,name.text,imageFile, (msg, color,icon) =>{
              
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
                  : widget.br != null
                      ?widget.br!.image.toLowerCase().endsWith('.svg+xml')?
                            SvgPicture.network(
                              url + "/getimage/" + widget.br!.image,
                          height: screenWidth * 0.25,
                          width: screenWidth * 0.25,
                            )
                      
                      :Image.network(
                          url + "/getimage/" + widget.br!.image,
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
              widget.br != null || imageFile != null
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
                            padding: const EdgeInsets.all(20.0),
                            child: TextField(
                              controller: name,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: fontSize * 0.4,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w400,
                              ),
                          onChanged: (value){
                            updateVerification(value);
                          },
                              decoration: InputDecoration(
                                errorText: errmsg,
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
            widget.br!=null?updatecheck():addcheck();
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
String getimagename(XFile? x){
      String imageName = path.basename(x!.path);
      List<String> parts = imageName.split('_');
      String desiredName = parts.last;
      return desiredName;
}