import 'dart:io';
import 'dart:typed_data';
import 'package:bridgewearaa/Webpart/constaints.dart';
import 'package:bridgewearaa/config.dart';
import 'package:bridgewearaa/screens/modifpasswordscreen.dart';
import 'package:bridgewearaa/services/data.dart';
import 'package:bridgewearaa/widget/CustomConfirmation.dart';
import 'package:bridgewearaa/widget/CustomErormsg.dart';
import 'package:provider/provider.dart';

import 'package:bridgewearaa/controlleur/usercontrolleur.dart';
import 'package:bridgewearaa/screens/addproductscreen.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_svg/flutter_svg.dart';
class EditAccountScreen extends StatefulWidget {
  const EditAccountScreen({super.key});

  @override
  State<EditAccountScreen> createState() => _EditAccountScreenState();
}

class _EditAccountScreenState extends State<EditAccountScreen> {
  XFile? imageFile;
    Uint8List webimage=Uint8List(8);

   void pickImage2(ImageSource source) async {
  final ImagePicker picker = ImagePicker();
   imageFile = await picker.pickImage(source: ImageSource.gallery);

  if (ImagePicker != null) {
    var f=await imageFile!.readAsBytes();
    setState(() {
    
      webimage=f;
    });
  }
  }
  void pickImage(ImageSource source) async {
    XFile? pickedImage = await ImagePickerHelper().pickCropImage(
      cropAspectRatio: CropAspectRatio(ratioX: 16, ratioY: 16),
      imageSource: source,
    );

    if (pickedImage != null) {
      setState(() {
        imageFile = pickedImage;
        print(imageFile!.path);
      });
    }
  }

  void onClick() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Choose Image Source"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  pickImage(ImageSource.camera);
                },
                child: Text("Camera"),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  pickImage(ImageSource.gallery);
                },
                child: Text("Gallery"),
              ),
            ],
          ),
        );
      },
    );
  }

  TextEditingController FirstName=TextEditingController();
  TextEditingController Secondname=TextEditingController();
  TextEditingController Email=TextEditingController();
  TextEditingController phone=TextEditingController();
  TextEditingController Password=TextEditingController();
  String errorfirstname="";
  String errorSecondname="";
  String erroremail="";
  String errorphone="";

  validatefirstname(TextEditingController controller,String erortitle) {
    String value = controller.text.trim();

    setState(() {
      if (value.isEmpty) {
        errorfirstname = erortitle;
      }
      else{
        errorfirstname = "";

      }

    });

  }
  validatesecondename(TextEditingController controller,String erortitle) {
    String value = controller.text.trim();

    setState(() {
      if (value.isEmpty) {
        errorSecondname = erortitle;
      }
      else{
        errorSecondname = "";

      }

    });

  }
  validatephone(TextEditingController controller,String erortitle) {
    String value = controller.text.trim();

    setState(() {
      if (value.isEmpty) {
        errorphone = erortitle;
      }
      else{
        errorphone = "";

      }

    });

  }
  void validateEmail(TextEditingController controller, String errorTitle) {
    String value = controller.text.trim();

    setState(() {
      if (value.isEmpty) {
        erroremail = errorTitle;
      } else {
        if (!RegExp(r"^[a-zA-Z0-9+._-]+@[a-zA-Z0-9.-]+$").hasMatch(value)) {
          erroremail = "Invalid email format";
        } else {
          erroremail = "";
        }
      }
    });
  }
  @override
  void initState() {
    super.initState();
    FirstName.text=context.read<DataService>().user!.firstname;
    Secondname.text=context.read<DataService>().user!.secondname;
    Email.text=context.read<DataService>().user!.email;
    phone.text=context.read<DataService>().user!.phone;



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

    final _showDesktop = _size.width >= screenXxl;
    final user = context.read<DataService>().user;


    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_rounded,color: Colors.blueAccent,),

        ),
        leadingWidth: 80,
        actions: [
          if (
              (Email.text != user?.email ||
                  FirstName.text != user?.firstname ||
                  Secondname.text != user?.secondname ||
                  phone.text != user?.phone ||
                  (imageFile!=null&&user?.picture!=imageFile!.path))
          )
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: IconButton(
                onPressed: () {
                  customconfimation(context, 'Confirmation', 'Are you sure you want to Modify your profile ?', () {
                    modifyUserProfile(
                        user!.id,
                        Email.text,
                        FirstName.text,
                        Secondname.text,
                        phone.text,
                        Password.text,
                        imageFile,
                            (u){
                            Navigator.pop(context);
                          setState(() {

                            context.read<DataService>().user=u;
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    backgroundColor: Colors.green,
                                    content:                               Customerrormsg(icon: Icons.done,message: "Profile modified successfully",bgcolor: Colors.green,)

                                ))
                            ;
                          });
                        }

                    );
                  },Colors.blueAccent);

                },
                icon: Icon(Icons.check, color: Colors.blueAccent),
              ),
            ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.all(marginValue*2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              SizedBox(height: screenHeight*0.03),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ClipOval(
                      child:Container(
                        child:_isDesktop&&imageFile != null?
                        Image.memory(
                      webimage,
                      width: screenWidth * 0.35,
                      height: screenWidth * 0.35,
                    )
                         
                        : imageFile != null ?
                        Image(
                          image: FileImage(File(imageFile!.path)),
                          fit: BoxFit.cover,
                          height: screenWidth * 0.35,
                          width: screenWidth * 0.35,
                        ) :
                        Image.network(
                          url+"/getimage/"+context.read<DataService>().user!.picture,
                          height: screenWidth * 0.35,
                          width: screenWidth * 0.35,
                        ),
                      )

                    ),
                    TextButton(
                      onPressed: () {
                        _isDesktop?
                                          pickImage2(ImageSource.gallery)

                        :
                        onClick();
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.lightBlueAccent,
                      ),
                      child: const Text("Upload Image"),
                    ),

                  ],
                ),
              ),
              Text("First Name :" ,style: TextStyle(color: Colors.grey,fontSize: fontSize*0.75,fontWeight: FontWeight.bold,),),
              TextField(
                textAlign: TextAlign.left,
                controller: FirstName,
                onChanged: (value) =>  validatefirstname(FirstName, "First Name must be only from caractére"),
                style: TextStyle(
                color: Colors.black,
                fontSize: fontSize * 0.7,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
              ),

                decoration: InputDecoration(
                  hintStyle: TextStyle(
                    fontSize: fontSize*0.7,
                  ),
                  focusedBorder: InputBorder.none,
                  errorStyle: TextStyle(
                    fontSize: fontSize*0.5,
                    fontWeight: FontWeight.w600,
                  ),
                  errorText: errorfirstname.isEmpty||errorfirstname=="ok"?null:errorfirstname,
                  errorBorder: UnderlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(
                      width: screenWidth * 0.003,
                      color: Colors.red,
                    ),
                  ),
                ),


              ),



              SizedBox(height: screenHeight*0.03),
              Text("Second Name :" ,style: TextStyle(color: Colors.grey,fontSize: fontSize*0.75,fontWeight: FontWeight.bold,),),

              TextField(
                textAlign: TextAlign.left,
                controller: Secondname,
                onChanged: (value) =>  validatesecondename(Secondname, "Second Name must be only from caractére"),
                style: TextStyle(
                  color: Colors.black,
                  fontSize: fontSize * 0.7,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                ),

                decoration: InputDecoration(
                  hintStyle: TextStyle(
                    fontSize: fontSize*0.7,
                  ),
                  focusedBorder: InputBorder.none,
                  errorStyle: TextStyle(
                    fontSize: fontSize*0.5,
                    fontWeight: FontWeight.w600,
                  ),
                  errorText: errorSecondname.isEmpty||errorSecondname=="ok"?null:errorSecondname,
                  errorBorder: UnderlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(
                      width: screenWidth * 0.003,
                      color: Colors.red,
                    ),
                  ),
                ),


              ),



              SizedBox(height: screenHeight*0.03),
              Text("Phone :" ,style: TextStyle(color: Colors.grey,fontSize: fontSize*0.75,fontWeight: FontWeight.bold,),),

              TextField(
                textAlign: TextAlign.left,
                controller: phone,
                onChanged: (value) =>  validatephone(phone, "Phone must be from 8 Number"),
                style: TextStyle(
                  color: Colors.black,
                  fontSize: fontSize * 0.7,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                ),

                decoration: InputDecoration(
                  hintStyle: TextStyle(
                    fontSize: fontSize*0.7,
                  ),
                  focusedBorder: InputBorder.none,
                  errorStyle: TextStyle(
                    fontSize: fontSize*0.5,
                    fontWeight: FontWeight.w600,
                  ),
                  errorText: errorphone.isEmpty||errorphone=="ok"?null:errorphone,
                  errorBorder: UnderlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(
                      width: screenWidth * 0.003,
                      color: Colors.red,
                    ),
                  ),
                ),


              ),
              SizedBox(height: screenHeight*0.03),

          InkWell(
            onTap: (){
              showModalBottomSheet(
                  context: context,

                  builder: (context) =>modifpasswordscreen(email: Email.text,oldpassword: true,)

                // Without invoking the function

              );
            },
            child: Container(
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

              child: Padding(
                      padding:  EdgeInsets.all(marginValue*2),
                      child: Row(
                        children: [
                          Icon(Icons.key),
                          SizedBox(width: screenWidth*0.02,),

                          Expanded(
                            child: Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Change password",style: TextStyle(fontWeight: FontWeight.bold),),
                                  Text("It's a good idea to use a strong password that you're not using elsewhere",style: TextStyle(),overflow: TextOverflow.clip,),

                                ],
                              ),
                            ),
                          ),
                          SizedBox(width: screenWidth*0.02,),
                          Icon(Icons.arrow_forward_ios)
                        ],
                      ),
                    )
                    ,
                  ),
          ),

            ],
          ),
        ),
      ),
    );
  }
}

class inputaddproduct extends StatelessWidget {
  const inputaddproduct({
    super.key,
    required this.fontSize,
    required this.screenWidth,
    required this.title,
    required this.error,
    required this.validateTitle
  });

  final double fontSize;
  final double screenWidth;
  final TextEditingController title;
  final Function validateTitle;
  final String error;

  @override
  Widget build(BuildContext context) {
    return TextField(
      textAlign: TextAlign.left,
      controller: title,
      onChanged: (value) => validateTitle(title,error),
      style: TextStyle(
      color: Colors.black,
      fontSize: fontSize * 0.6,
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w400,
    ),

      decoration: InputDecoration(
        hintText: title.text,
        hintStyle: TextStyle(
          fontSize: fontSize*0.7,
        ),
        focusedBorder: InputBorder.none,
        errorStyle: TextStyle(
          fontSize: fontSize*0.5,
          fontWeight: FontWeight.w600,
        ),
        errorText: error.isEmpty||error=="ok"?null:error,
        errorBorder: UnderlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(
            width: screenWidth * 0.003,
            color: Colors.red,
          ),
        ),
      ),


    );
  }
}
