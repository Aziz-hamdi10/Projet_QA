import 'dart:typed_data';
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

class ColorsScreen extends StatefulWidget {
  const ColorsScreen({Key? key}) : super(key: key);

  @override
  _ColorsScreenState createState() => _ColorsScreenState();
}

class _ColorsScreenState extends State<ColorsScreen> {
  @override
  void initState() {
    super.initState();
       getcolors( (list) =>{

      context.read<DataService>().listcolors=list
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
      title: "Colors",
        onPressedSeeAll: ()  {
                showDialog(
  context: context,
  builder: (BuildContext context) {
    return AlertDialog(
      title: Text("Add Color",style: TextStyle(fontSize: fontSize*0.7,fontWeight: FontWeight.bold),),
      content: addcolorwidget(changed: (){

      }),
     
    );
  },
);
;  },
        child: StaggeredGridView.countBuilder(
          crossAxisCount: 2,
          itemCount: context.read<DataService>().listcolors.length,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Padding( 
              padding: const EdgeInsets.all(0.0),
              child: Colorcard(delete: (){
                setState(() {
                                   context.read<DataService>().listcolors.remove(context.read<DataService>().listcolors[index]);

                });
              },data: context.read<DataService>().listcolors[index],change: (brand){
                  context.read<DataService>().listcolors[index]=brand;
                
              
                
              }),
            );
          },
          staggeredTileBuilder: (int index) =>
              StaggeredTile.fit(1),
        ),
      )
    : ActiveProjectCard(
      title: "Colors",
        onPressedSeeAll: ()  {
            showDialog(
  context: context,
  builder: (BuildContext context) {
    return Dialog(
      child: Material(
        child: addcolorwidget(changed:(){
         
        } ),
      ),
    );
  },
);
                  },
        child: StaggeredGridView.countBuilder(
          crossAxisCount: 2,
          itemCount: context.read<DataService>().listcolors.length,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Padding( 
              padding: const EdgeInsets.all(0.0),
              child: Colorcard(delete:(){
                setState(() {
                                   context.read<DataService>().listcolors.remove(context.read<DataService>().listcolors[index]);

                });
              } ,data: context.read<DataService>().listcolors[index],change: (newcolor){
                   context.read<DataService>().listcolors[index]=newcolor;
             
              }),
            );
          },
          staggeredTileBuilder: (int index) =>
              StaggeredTile.fit(2),
        ),
      )
    ;}
}


class addcolorwidget extends StatefulWidget {
  final color? cl;
  final Function changed;
  const addcolorwidget({
     required this.changed,
    this.cl,
    Key? key,
 
  }) : super(key: key);

  @override
  _addcolorwidgetState createState() => _addcolorwidgetState();
}

class _addcolorwidgetState extends State<addcolorwidget> {
  @override
  void initState() {
    super.initState();
    if(widget.cl!=null){
    _hexInputController.text=colorToHex(widget.cl!.coleur);
  _selectedColor=widget.cl!.coleur;
    _nameinputcontroller.text=widget.cl!.name;
    

    }
   
  }
  String texterror="";
      TextEditingController name=TextEditingController();
final _colornotifier= ValueNotifier(Colors.green);
 Color _selectedColor = Colors.blue;

  TextEditingController _hexInputController = TextEditingController();
    TextEditingController _nameinputcontroller = TextEditingController();

    String _isValidHex="";
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

    return  SingleChildScrollView(
      child: Padding(
        padding:  EdgeInsets.all(0),
        child: Container(
             
              color: Colors.white,
              child:ValueListenableBuilder<Color>(
    valueListenable:_colornotifier ,
    builder: (_,color1,__) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ColorPicker(
            pickerColor: _selectedColor,
            onColorChanged: (color1) {
              setState(() {
                _selectedColor = color1;
                _hexInputController.text = colorToHex(color1);
              });
            },
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextField(
              controller: _hexInputController,
              onChanged: (value) {
                if (value.isNotEmpty && value.length == 7 && value.startsWith('#')) {
                  setState(() {
                    _selectedColor = hexToColor(value);
                    _isValidHex = "";
                    if(searchColorByHex(value,context.read<DataService>().listcolors)==true){
                      _isValidHex = "Hex Code already Exist";
                    }
                    else{
                                      _isValidHex = "";
              
                    }
                  });
                } else {
                  setState(() {
                    _isValidHex = "Wrong Hex code";
                  });
                }
              },
              decoration: InputDecoration(
                labelText: 'Enter Hex Color Code',
                hintText: '#RRGGBB',
                errorText: _isValidHex=="" ? null : _isValidHex
              ),
            ),
          ), SizedBox(height: screenHeight*0.02,),
                  SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextField(
              controller: _nameinputcontroller,
              onChanged: (value) {
                if (value.isNotEmpty ) {
                  setState(() {
                    _isnamevalid = "";
                    if(searchColorByName(value, context.read<DataService>().listcolors)==true&&widget.cl!.name.toLowerCase()!=value.toLowerCase()){
                      _isnamevalid = "name already Exist";
                    }
                    else{
                                      _isnamevalid = "";
              
                    }
                  });
                } else {
                  setState(() {
                    _isValidHex = "WrongHexcode";
                  });
                }
              },
              decoration: InputDecoration(
                labelText: 'Enter Color Name',
                hintText: 'Name',
                errorText: _isnamevalid=="" ? null : _isnamevalid
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
                child: Text('Close',style: TextStyle(color: Colors.red),),
              ),
                TextButton(
            onPressed: () {
              if(widget.cl==null)
            {  if(_isnamevalid==""&&_isValidHex==""&&_nameinputcontroller.text.isNotEmpty&&_hexInputController.text.isNotEmpty){
                addcolor(_nameinputcontroller.text, _hexInputController.text, (msg, color1) =>{
               
                 context.read<DataService>().listcolors.add(color(id: "id", name: _nameinputcontroller.text, coleur: hexToColor(_hexInputController.text),dateadd: DateTime.now()))
                ,
                Navigator.pop(context),
            
                  ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              backgroundColor: color1,
              content:                               Customerrormsg(icon: Icons.done,message: msg,bgcolor: color1,)
    
          ))
               });
              }}
              else{ 
                            if((_isnamevalid==""||widget.cl!.name==_nameinputcontroller.text)&&_isValidHex==""&&_nameinputcontroller.text.isNotEmpty&&_hexInputController.text.isNotEmpty){
                          setState(() {
                                                    widget.changed(color(dateadd: DateTime.now(),id: widget.cl!.id, name: _nameinputcontroller.text, coleur:hexToColor( _hexInputController.text)));
    
                          });
                           Navigator.pop(context);
                            updatecolor(widget.cl!.id, _nameinputcontroller.text, _hexInputController.text, (msg, color1) => {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              backgroundColor: color1,
              content:                               Customerrormsg(icon: Icons.done,message: msg,bgcolor: color1,)
    
          ))
                            });
                            }
    
              }
         },
            child: Text(widget.cl!=null?'Modif':'Add'),
          ),
            ],
          ),
                           
             
        ],
      );
    },
    
              )
        
        
            ),
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

