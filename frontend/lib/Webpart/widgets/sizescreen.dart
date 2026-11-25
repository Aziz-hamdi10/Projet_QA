import 'dart:typed_data';
import 'package:bridgewearaa/controlleur/sizecontrolleur.dart';
import 'package:bridgewearaa/models/size.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import 'package:bridgewearaa/Webpart/constaints.dart';
import 'package:bridgewearaa/config.dart';
import 'package:bridgewearaa/controlleur/brandcontrolleur.dart';
import 'package:bridgewearaa/controlleur/colorcontrolleur.dart';
import 'package:bridgewearaa/models/brand.dart';
import 'package:bridgewearaa/models/color.dart';
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

class SizeScreen extends StatefulWidget {
  const SizeScreen({Key? key}) : super(key: key);

  @override
  _SizeScreenState createState() => _SizeScreenState();
}

class _SizeScreenState extends State<SizeScreen> {
  @override
  void initState() {
    super.initState();
   
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
      title: "Sizes",
        onPressedSeeAll: ()  {
                showDialog(
  context: context,
  builder: (BuildContext context) {
    return 
       AlertDialog(
        title: Text("Add Size",style: TextStyle(fontSize: fontSize*0.7,fontWeight: FontWeight.bold),),
        content: addsizewidget(changed: (){
    
        }),
       
      
    );
  },
);
;  },
        child: StaggeredGridView.countBuilder(
          crossAxisCount: 2,
          itemCount: context.read<DataService>().listsize2.length,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Padding( 
              padding: const EdgeInsets.all(0.0),
              child: Sizecard(delete: (){
                setState(() {
                                   context.read<DataService>().listsize.remove(context.read<DataService>().listsize[index]);
                                                                           context.read<DataService>().listsize2.remove(context.read<DataService>().listsize2[index]);

                });
              },data: context.read<DataService>().listsize2[index],change: (size){
                  context.read<DataService>().listsize[index]=size.name;
                                  context.read<DataService>().listsize2[index]=size;

              
                
              }),
            );
          },
          staggeredTileBuilder: (int index) =>
              StaggeredTile.fit(1),
        ),
      )
    : ActiveProjectCard(
      title: "Sizes",
        onPressedSeeAll: ()  {
            showDialog(
  context: context,
  builder: (BuildContext context) {
    return Dialog(
      child: Material(
        child: addsizewidget(changed:(){
         
        } ),
      ),
    );
  },
);
                  },
        child: StaggeredGridView.countBuilder(
          crossAxisCount: 2,
          itemCount: context.read<DataService>().listsize2.length,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Padding( 
              padding: const EdgeInsets.all(0.0),
              child: Sizecard(delete:(){
                setState(() {
                                   context.read<DataService>().listsize.remove(context.read<DataService>().listsize[index]);
                                   context.read<DataService>().listsize2.remove(context.read<DataService>().listsize2[index]);

                });
              } ,data:  context.read<DataService>().listsize2[index],change: (newsize){
                   context.read<DataService>().listsize[index]=newsize.name;
                                               context.read<DataService>().listsize2[index]=newsize;

              }),
            );
          },
          staggeredTileBuilder: (int index) =>
              StaggeredTile.fit(2),
        ),
      )
    ;}
}


class addsizewidget extends StatefulWidget {
  final String? S;
  final Function changed;
  const addsizewidget({
     required this.changed,
    this.S,
    Key? key,
 
  }) : super(key: key);

  @override
  _addsizewidgetState createState() => _addsizewidgetState();
}

class _addsizewidgetState extends State<addsizewidget> {
  @override
  void initState() {
    super.initState();
    if(widget.S!=null){

    _nameinputcontroller.text=widget.S!;
    

    }
   
  }
  String texterror="";
      TextEditingController name=TextEditingController();
final _colornotifier= ValueNotifier(Colors.green);

    TextEditingController _nameinputcontroller = TextEditingController();

     String _isnamevalid="";

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

    return  Padding(
      padding:  EdgeInsets.all(0),
      child: Container(
        height: screenHeight*0.3,
            child:Column(
  mainAxisAlignment: MainAxisAlignment.center,
  crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 20),
        Padding(
          padding:  EdgeInsets.all(marginValue),
          child: Expanded(
            child: TextField(
              controller: _nameinputcontroller,
              onChanged: (value) {
                if (value.isNotEmpty ) {
                  setState(() {
                    _isnamevalid = "";
                    if(searchSizeByName(value, context.read<DataService>().listsize2)==true){
                      _isnamevalid = "name already Exist";
                    }
                    else{
                                      _isnamevalid = "";
                  
                    }
                  });
                } else {
                  setState(() {
                                        _isnamevalid = "Enter Size !";

                  });
                }
              },
              decoration: InputDecoration(
                labelText: 'Enter Size',
                labelStyle: TextStyle(fontSize: fontSize*0.7),
                hintText: 'Size',
                errorText: _isnamevalid=="" ? null : _isnamevalid
              ),
            ),
          ),
        ), SizedBox(height: screenHeight*0.02,),
          
                      Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close',style: TextStyle(color: Colors.red,fontSize: fontSize*0.5),),
            ),
              TextButton(
          onPressed: () {
        if(_nameinputcontroller.text.isNotEmpty&&_isnamevalid==""){
  addsize(_nameinputcontroller.text, (msg, color1) =>{
             
               context.read<DataService>().listsize2.add(size(id: "id", name: _nameinputcontroller.text,dateadd: DateTime.now())),
                              context.read<DataService>().listsize.add( _nameinputcontroller.text),

              
              Navigator.pop(context),
          
                ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            backgroundColor: color1,
            content:                               Customerrormsg(icon: Icons.done,message: msg,bgcolor: color1,)

        ))
             });
        }
       },
          child: Text(widget.S!=null?'Modif':'Add',style: TextStyle(fontSize: fontSize*0.5),),
        ),
          ],
        ),
                         
               
      ],
    )

      
      
          ),
    )
      ;
  }
    Color hexToColor(String hexColor) {
    return Color(int.parse(hexColor.substring(1, 7), radix: 16) + 0xFF000000);
  }

  String colorToHex(Color color) {
    return '#${color.value.toRadixString(16).substring(2)}';
  }

  bool isValidHexColor(String hexColor) {
    if (hexColor.isEmpty || hexColor.length != 7 || !hexColor.startsWith('#')) {
      return false;
    }
    try {
      Color(int.parse(hexColor.substring(1, 7), radix: 16) + 0xFF000000);
      return true;
    } catch (e) {
      return false;
    }
  }

}

