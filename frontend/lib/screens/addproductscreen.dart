import 'dart:io';
import 'dart:typed_data';
import 'package:bridgewearaa/config.dart';
import 'package:bridgewearaa/controlleur/productcontrolleur.dart';
import 'package:bridgewearaa/models/brand.dart';
import 'package:bridgewearaa/models/categorie.dart';
import 'package:bridgewearaa/models/color.dart';
import 'package:bridgewearaa/models/product.dart';
import 'package:bridgewearaa/models/size.dart';
import 'package:bridgewearaa/widget/CustomConfirmation.dart';
import 'package:bridgewearaa/widget/CustomErormsg.dart';
import 'package:bridgewearaa/widget/couleursfiltred.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';

import 'package:bridgewearaa/screens/buttons.dart';
import 'package:bridgewearaa/services/data.dart';
import 'package:bridgewearaa/services/imagecompress.dart';
import 'package:bridgewearaa/widget/brandsflitrer.dart';
import 'package:bridgewearaa/widget/customcategorie.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../models/color.dart';

class ImagePickerHelper {
  Future<XFile?> pickCropImage({
    required CropAspectRatio cropAspectRatio,
    required ImageSource imageSource,
  }) async {
    XFile? pickImage = await ImagePicker().pickImage(source: imageSource);
    if (pickImage == null) return null;
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: pickImage.path,
      aspectRatio: cropAspectRatio,
      compressQuality: 90,
      compressFormat: ImageCompressFormat.jpg,
    );
    if (croppedFile == null) return null;

    return XFile(croppedFile.path);
  }
}
class addproductappbar extends StatelessWidget implements PreferredSizeWidget {
  @override
  static const IconData shopping_bag_outlined = IconData(0xf37d, fontFamily: 'MaterialIcons');

  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    double screenWidth = mediaQueryData.size.width;
    double screenHeight = mediaQueryData.size.height;
    double fontSize = MediaQuery.of(context).size.shortestSide * 0.05;
    double marginValue = MediaQuery.of(context).size.width * 0.02;
    return  AppBar(
      automaticallyImplyLeading: false,

      title: Text("New Product",style: TextStyle(color: Colors.black),),
      elevation: 0,
      backgroundColor: Colors.white,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
class addproductscreen extends StatefulWidget {
  final Function done;
  const addproductscreen({super.key,required this.done});

  @override
  State<addproductscreen> createState() => _addproductState();
}

class _addproductState extends State<addproductscreen> {
  List<XFile?> imageFiles = [
  ];
  XFile? imageFile;
  categorie category=categorie(dateadd: DateTime.now(), id: "id", image: "image", name: "Category");
  brand Brand=brand(datedadd: DateTime.now(), id: "id", title: "Brand", image: "image");
  color Color=  color(id:"0",name:"Color", coleur:  Colors.red,dateadd: DateTime.now());

  size Size=size(id: "id", name: "Size", dateadd: DateTime.now());
  String Erortitle="";
  String Erordesc="";
  String Erorcateg="";
  String Erorbrand="";
  String Erorsize="";
  String Erorcolor="";
  String Erorprice1="";
  String Erorprice2="";
  TextEditingController title=TextEditingController();
  TextEditingController Description=TextEditingController();
  TextEditingController Priceseeling=TextEditingController();
  TextEditingController PriceOriginal=TextEditingController();
  validateTitle(TextEditingController controller) {
    String value = controller.text.trim();

    setState(() {
      if (value.isEmpty) {
        Erortitle = 'Title is required';
      }
      else{
        Erortitle = '';

      }

    });

  }

  void validateDescription(TextEditingController controller) {
    String value = controller.text.trim();

    setState(() {
      if (value.isEmpty) {
        Erordesc = 'Description is required';
      } else {
        Erordesc = '';
      }
    });
  }
  void validatecategory( ) {

    setState(() {
      if (category.name=="Category") {
        Erorcateg = 'Category is required';
      } else {
        Erorcateg = '';
      }
    });
  }
  void validatesize( ) {

    setState(() {
      if (Size.name=="Size") {
        Erorsize = 'Size is required';
      } else {
        Erorsize = '';
      }
    });
  }
  void validatecolor( ) {

    setState(() {
      if (Color.name=="Color") {
        Erorcolor = 'Color is required';
      } else {
        Erorcolor = '';
      }
    });
  }
  void validatebrand( ) {

    setState(() {
      if (Brand.title=="Brand") {
        Erorbrand = 'Brand is required';
      } else {
        Erorbrand = '';
      }
    });
  }
  void validatePriceseeling(TextEditingController controller) {
    String value = controller.text.trim();

    setState(() {
      if (value.isEmpty) {
        Erorprice1 = 'Seeling Price is required';
      } else {
        Erorprice1 = '';
      }
      print(Erorprice1);
    });
  }

  void validatepriceOriginal(TextEditingController controller) {
    String value = controller.text.trim();

    setState(() {
      if (value.isEmpty) {
        Erorprice2 = 'Original Price is required';
      } else {
        Erorprice2 = '';
      }
    });
  }

  addproducttolist(Product p){
    addProductWithImages(p);
    //addProduct(p);
    this.widget.done();
    Navigator.pop(context);

    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            backgroundColor: Colors.green,
            content: Customerrormsg(icon: Icons.done,message: "Product added with success",bgcolor: Colors.green,)

        ))
    ;
  }
  _verifadd(){
    validatePriceseeling(Priceseeling);
    validateDescription(Description);
    validatepriceOriginal(PriceOriginal);
    validateTitle(title);
    validatebrand();
    validatecategory();
    validatecolor();
    validatesize();
    if(Erorsize.isNotEmpty||Erorbrand.isNotEmpty||Erorcateg.isNotEmpty||Erorprice1.isNotEmpty||Erorprice2.isNotEmpty||Erortitle.isNotEmpty||Erordesc.isNotEmpty||Erorcolor.isNotEmpty){
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              backgroundColor: Colors.red,
              content: Customerrormsg(icon: Icons.cancel,
                message: "Data required ! Make Sure you remplir all the data",bgcolor: Colors.red,)
          ))
      ;}
    else{
      Product p =Product(commentaires: [],iduser: context.read<DataService>().user!,imgaenames:[],state: "Available", cl:Color, Brand:Brand, department: "Men", Categorie: category!, Size:  Size, numberlikes: 0, id: "1", name:title.text , description: Description.text,Originalprice: double.parse(PriceOriginal.text), SeelingPrice:double.parse(Priceseeling.text), imageUrl:imageFiles);
      customconfimation(context, 'Confirmation', 'Are you sure you want to proceed?', () {
        addproducttolist(p);
      },Colors.blueAccent);

    }


  }
  @override
  void initState() {
    super.initState();
    context.read<DataService>().coleurajouter=null;
    context.read<DataService>().Sizeajouter="";
    context.read<DataService>().brandajouter="";
    context.read<DataService>().categajouter="";
  }


  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    double screenWidth = mediaQueryData.size.width;
    double screenHeight = mediaQueryData.size.height;
    double fontSize = MediaQuery.of(context).size.shortestSide * 0.05;
    double marginValue = MediaQuery.of(context).size.width * 0.02;
    List<brand> listbrands=context.read<DataService>().brands;
    List<String> listsize=context.read<DataService>().listsize;
    List<color> listcolors=    context.read<DataService>().listcolors;

    void _pickImage(ImageSource source,XFile? imageFile) async {
      final ImagePicker _picker = ImagePicker();
    imageFile = await _picker.pickImage(source: source);



      if (imageFile != null) {
        setState(() {
          imageFiles.add(imageFile);

        });
      }
    }
    void _onClick(XFile? imageFile) async {
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
                    _pickImage(ImageSource.camera,imageFile);
                  },
                  child: Text("Camera"),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    _pickImage(ImageSource.gallery,imageFile);
                  },
                  child: Text("Gallery"),
                ),
              ],
            ),
          );
        },
      );
    }



    return  SingleChildScrollView(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              imageFiles.isEmpty?
              GestureDetector(
                onTap: () {
                  _onClick(imageFile);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  height: screenHeight * 0.4,
                  width: screenHeight * 0.35,
                  child: Center(
                    child: Icon(
                      Icons.add,
                      size: 40,
                      color: Colors.white,
                    ),
                  ),
                ),
              )

                  :
              Container(
                width: screenWidth,

                child:

                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding:  EdgeInsets.all(marginValue),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [

                        Wrap(
                          spacing: 10,
                          children: List.generate(imageFiles.length+1, (index) {
                            return      index!=imageFiles.length?

                            Stack(
                              alignment: Alignment.topRight,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                  ),
                                  height: screenHeight * 0.4,
                                  width: screenHeight * 0.35,
                                  child: imageFiles[index] != null
                                      ? ClipRRect(  // Use ClipRRect to apply border radius to the image
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                    child: Image(
                                      image: FileImage(File(imageFiles[index]!.path)),
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                      : Text("no image"),
                                ),
                                Padding(
                                  padding:  EdgeInsets.all(marginValue),
                                  child: InkWell(
                                      onTap: (){
                                        setState(() {
                                          imageFiles.remove(imageFiles[index]);

                                        });
                                      }
                                      ,
                                      child: Icon(size:fontSize*2,Icons.cancel_outlined,color: Colors.black,)),
                                )
                              ],
                            ):
                            GestureDetector(
                              onTap: () {
                                _onClick(imageFile);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                ),
                                height: screenHeight * 0.4,
                                width: screenHeight * 0.4,
                                child: Center(
                                  child: Icon(
                                    Icons.add,
                                    size: 40,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            );



                          }),                     ),

                      ],
                    ),
                  ),
                ),
              ),


            ],

          ),
          SizedBox(height: screenHeight*0.02,),
          Container(
            width: screenWidth,

            decoration: BoxDecoration(
              color: Colors.white,

              borderRadius: BorderRadius.all(Radius.circular(10)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5), // Change the shadow color as needed
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3),
                  // Change the offset as needed
                ),

              ],
            ),
            child: Padding(
              padding:  EdgeInsets.all(marginValue),
              child:   Column(

                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [

                  Container(
                    width: screenWidth,


                    child: Padding(
                      padding:  EdgeInsets.all(marginValue),
                      child:                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Title :" ,style: TextStyle(fontSize: fontSize*0.8,fontWeight: FontWeight.bold,),),

                          TextField(
                            textAlign: TextAlign.left,
                            controller: title,
                            onChanged: (value) => validateTitle(title),                             style: TextStyle(
                            color: Colors.black,
                            fontSize: fontSize * 0.7,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                          ),

                            decoration: InputDecoration(
                              hintText: 'Ex: Manteau, Hoodie, Cargo',
                              hintStyle: TextStyle(
                                fontSize: fontSize*0.7,
                              ),
                              focusedBorder: InputBorder.none,
                              errorStyle: TextStyle(
                                fontSize: fontSize*0.5,
                                fontWeight: FontWeight.w600,
                              ),
                              errorText: Erortitle.isEmpty||Erortitle=="ok"?null:Erortitle,
                              errorBorder: UnderlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                borderSide: BorderSide(
                                  width: screenWidth * 0.003,
                                  color: Colors.red,
                                ),
                              ),
                            ),


                          ),
                          SizedBox(height: screenHeight*0.05,),
                          Text("Description :" ,style: TextStyle(fontSize: fontSize*0.8,fontWeight: FontWeight.bold),),

                          TextField(
                            controller: Description,
                            textAlign: TextAlign.left,
                            onChanged: (value) => validateDescription(Description),
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: fontSize * 0.7,
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
                              errorText: Erordesc.isEmpty||Erordesc=="ok"?null:Erordesc,

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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    showModalBottomSheet(
                                      context: context,

                                      builder: (context) =>ListcatSheet(marginValue: marginValue, screenHeight: screenHeight, screenWidth: screenWidth, fontSize: fontSize,change:(ch){
                                        setState(() {
                                          category=ch;
                                          Navigator.pop(context);

                                        });
                                      }),

                                      // Without invoking the function

                                    );
                                  });
                                },
                                child:
                                Container(
                                  width: screenWidth*0.45,
                                  decoration: BoxDecoration(
                                      border: Border.all(color:Erorcateg.isEmpty?Colors.black.withOpacity(0.5):Colors.red
                                      ),
                                      borderRadius: BorderRadius.all(Radius.circular(10))
                                  ),
                                  child: Padding(
                                    padding:  EdgeInsets.all(marginValue),
                                    child:Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                      SvgPicture.asset("assets/icons/Category.svg",height: fontSize*1.3,),

                                        Text(categorie==null?"Category":category!.name, style: TextStyle(fontSize: fontSize * 0.8, fontWeight: FontWeight.bold)),
                                        Icon(Icons.arrow_right, size: fontSize * 1.5),
                                      ],
                                    ),

                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {

                                    showModalBottomSheet(
                                      context: context,

                                      builder: (context) =>ListBrandSheet(marginValue: marginValue, screenHeight: screenHeight, screenWidth: screenWidth, fontSize: fontSize,change:(ch){
                                        setState(() {
                                          Brand=ch;
                                          Navigator.pop(context);

                                        });
                                      }),

                                      // Without invoking the function

                                    );
                                  });

                                },
                                child:
                                Container(
                                  width: screenWidth*0.45,
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Erorbrand.isEmpty||Erorbrand=="ok"?Colors.black.withOpacity(0.5):Colors.red
                                      ),
                                      borderRadius: BorderRadius.all(Radius.circular(10))
                                  ),
                                  child: Padding(
                                    padding:  EdgeInsets.all(marginValue),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        SvgPicture.asset("assets/icons/marque.svg",height: fontSize*1.3,color: Colors.black,)                                         ,
                                        Text(Brand.title,style: TextStyle(fontSize: fontSize*0.8,fontWeight: FontWeight.bold),)
                                        ,
                                        Icon(Icons.arrow_right,size: fontSize*1.5,)

                                      ],
                                    ),
                                  ),
                                ),
                              )
                              ,
                            ],
                          ),
                          SizedBox(height: screenHeight*0.02,),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    showModalBottomSheet(
                                      context: context,

                                      builder: (context) =>ListColorsSheet(marginValue: marginValue, screenWidth: screenWidth, listColors: listcolors,change:(ch){
                                        setState(() {
                                          Color=ch;
                                          context.read<DataService>().coleurajouter=ch;
                                          Navigator.pop(context);


                                        });
                                      }),
                                      // Without invoking the function

                                    );
                                  });
                                },
                                child:
                                Container(
                                  width: screenWidth*0.45,
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Erorcolor.isEmpty||Erorcolor=="ok"?Colors.black.withOpacity(0.5):Colors.red
                                      ),
                                      borderRadius: BorderRadius.all(Radius.circular(10))
                                  ),
                                  child: Padding(
                                    padding:  EdgeInsets.all(marginValue),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Icon(Icons.color_lens_outlined,size: fontSize*1.5,)
                                        ,
                                        Text(Color.name,style: TextStyle(fontSize: fontSize*0.8,fontWeight: FontWeight.bold),)
                                        ,
                                        Icon(Icons.arrow_right,size: fontSize*1.5,)

                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    showModalBottomSheet(
                                      context: context,

                                      builder: (context) =>ListSizeSheet(marginValue: marginValue, screenWidth: screenWidth, fontSize: fontSize,change:(newsize){
                                        setState(() {
                                          Size=newsize;
                                          Navigator.pop(context);


                                        });
                                      }),
                                      // Without invoking the function

                                    );
                                  });

                                },
                                child:
                                Container(
                                  width: screenWidth*0.45,
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Erorsize.isEmpty||Erorsize=="ok"?Colors.black.withOpacity(0.5):Colors.red
                                      ),
                                      borderRadius: BorderRadius.all(Radius.circular(10))
                                  ),
                                  child: Padding(
                                    padding:  EdgeInsets.all(marginValue),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Icon(Icons.height,size: fontSize*1.5,)
                                        ,
                                        Text(Size.name.toUpperCase(),style: TextStyle(fontSize: fontSize*0.8,fontWeight: FontWeight.bold),)
                                        ,
                                        Icon(Icons.arrow_right,size: fontSize*1.5,)

                                      ],
                                    ),
                                  ),
                                ),
                              )
                              ,
                            ],
                          ),
                          SizedBox(height: screenHeight*0.02,),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: screenWidth*0.45,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Erorprice1.isEmpty?Colors.black.withOpacity(0.5):Colors.red
                                    ),
                                    borderRadius: BorderRadius.all(Radius.circular(10))
                                ),
                                child: Padding(
                                  padding:  EdgeInsets.all(marginValue),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,

                                    children: [
                                      Text("Seeling Price",style: TextStyle(fontWeight: FontWeight.bold,fontSize: fontSize*0.7),)
                                      ,
                                      TextField(
                                        controller: Priceseeling,
                                        textAlign: TextAlign.left,
                                        onChanged: (value) => validatePriceseeling(Priceseeling),
                                        keyboardType: TextInputType.numberWithOptions(decimal: true),

                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: fontSize * 0.7,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w400,
                                        ),

                                        decoration: InputDecoration(
                                          hintText: 'Ex: 35.000 DT',
                                          hintStyle: TextStyle(

                                            fontSize: fontSize*0.8,
                                          ),
                                          border: InputBorder.none,
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

                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                width: screenWidth*0.45,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Erorprice2.isEmpty||Erorprice2=="ok"?Colors.black.withOpacity(0.5):Colors.red
                                    ),
                                    borderRadius: BorderRadius.all(Radius.circular(10))
                                ),
                                child: Padding(
                                  padding:  EdgeInsets.all(marginValue),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Original Price",style: TextStyle(fontWeight: FontWeight.bold,fontSize: fontSize*0.7),)
                                      ,
                                      TextField(
                                        controller: PriceOriginal,
                                        keyboardType: TextInputType.numberWithOptions(decimal: true),

                                        textAlign: TextAlign.left,
                                        onChanged: (value) => validatepriceOriginal(PriceOriginal),

                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: fontSize * 0.7,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w400,
                                        ),

                                        decoration: InputDecoration(
                                          hintText: 'Pushace Prix',
                                          hintStyle: TextStyle(

                                            fontSize: fontSize*0.8,
                                          ),
                                          border: InputBorder.none,
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

                                    ],
                                  ),
                                ),
                              ),

                            ],
                          ),
                          SizedBox(height: screenHeight*0.02,),
                          button(onclick:(){
                            _verifadd();
                          }, color: Colors.blueAccent.withOpacity(0.7), width: screenWidth*0.7, label: "Add Now", height: screenHeight*0.07)


                        ],
                      ),

                    ),

                  ),


                ],

              ),
            ),

          ),




        ],
      ),
    )
    ;
  }

  Future<dynamic> error(BuildContext context,String title,String Description) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(Description),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}

class ListSizeSheet extends StatefulWidget {
  const ListSizeSheet({
    Key? key,
    required this.change,
    required this.marginValue,
    required this.screenWidth,
    required this.fontSize,
  }) : super(key: key);
  final Function change;
  final double marginValue;
  final double screenWidth;
  final double fontSize;

  @override
  _ListSizeSheetState createState() => _ListSizeSheetState();
}

class _ListSizeSheetState extends State<ListSizeSheet> {
  @override
  Widget build(BuildContext context) {
    String sizeajouter=context.read<DataService>().Sizeajouter;
    return Container(

      child: Wrap(
        children: List.generate(
          context.read<DataService>().listsize.length,
              (index) {
            List<String> listSize = context.read<DataService>().listsize;
            return Padding(
              padding: EdgeInsets.all(widget.marginValue),
              child: Stack(
                alignment: Alignment.topRight,
                children: [
                  InkWell(
                    onTap: () {
                      this.widget.change( context.read<DataService>().listsize2[index]);
                      setState(() {
                        context.read<DataService>().Sizeajouter=listSize[index];
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey.withOpacity(0.3),
                        border: sizeajouter == listSize[index] ? Border.all(color: Colors.blueAccent, width: widget.fontSize * 0.1) : null,

                      ),
                      child: CircleAvatar(
                        radius: widget.screenWidth * 0.1,
                        backgroundColor: Colors.transparent,
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            listSize[index].toUpperCase(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: widget.fontSize,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  if(sizeajouter==listSize[index])
                    CircleAvatar(
                      radius: widget.fontSize * 0.5,
                      backgroundColor: Colors.blueAccent,
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Icon(Icons.check, color: Colors.white),
                      ),
                    )
                ],
              ),
            );
          },
        ),
      ),

    );
  }
}

class ListColorsSheet extends StatefulWidget {
  const ListColorsSheet({
    Key? key,
    required this.marginValue,
    required this.change,
    required this.screenWidth,
    required this.listColors,
  }) : super(key: key);
  final Function change;
  final double marginValue;
  final double screenWidth;
  final List<color> listColors;

  @override
  _ListColorsSheetState createState() => _ListColorsSheetState();
}

class _ListColorsSheetState extends State<ListColorsSheet> {
  @override
  Widget build(BuildContext context) {
    color? cl=context.read<DataService>().coleurajouter;

    return Container(
      child: Padding(
        padding: EdgeInsets.all(widget.marginValue),
        child: Wrap(
          spacing: widget.screenWidth * 0.02,
          children: List.generate(widget.listColors.length, (index) {
            return colorcontainer(
              c: widget.listColors[index],
              change: () {
                setState(() {
                  cl?.name=widget.listColors[index].name;
                });
                this.widget.change(widget.listColors[index]);
              },
              exist: cl==this.widget.listColors[index],
            );
          }),
        ),
      ),
    );
  }
}

class ListBrandSheet extends StatefulWidget {
  final Function change;
  final double marginValue;
  final double screenHeight;
  final double screenWidth;
  final double fontSize;

  const ListBrandSheet({
    Key? key,
    required this.change,
    required this.marginValue,
    required this.screenHeight,
    required this.screenWidth,
    required this.fontSize,
  }) : super(key: key);

  @override
  _ListBrandSheetState createState() => _ListBrandSheetState();
}

class _ListBrandSheetState extends State<ListBrandSheet> {

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    double screenWidth = mediaQueryData.size.width;
    double screenHeight = mediaQueryData.size.height;
    double fontSize = MediaQuery.of(context).size.shortestSide * 0.05;
    double marginValue = MediaQuery.of(context).size.width * 0.02;
    String pos = context.read<DataService>().brandajouter;

    return Container(
      child: Padding(
        padding: EdgeInsets.all(widget.marginValue),
        child: Wrap(
          runSpacing: widget.screenHeight * 0.01,
          spacing: widget.screenWidth*0.02,
          children: context.read<DataService>().brands.map((brand) {
            return  Stack(
              alignment: Alignment.topRight,
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      pos = brand.title;

                      widget.change(brand);
                      context.read<DataService>().brandajouter=brand.title;
                    });
                  },
                  child:  Container(
                    height: screenHeight * 0.1,
                    width: screenHeight * 0.1,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey.withOpacity(0.3),
                      border: Border.all(color: brand.title== pos ? Colors.blueAccent : Colors.transparent, width: screenWidth * 0.005),
                    ),
                    child: ClipOval(

                      child:
                      brand.image.toLowerCase().endsWith('.svg+xml')?
                      SvgPicture.network(
                        url + "/getimage/" + brand.image,
                        // Placeholder widget while loading, if needed
                        placeholderBuilder: (BuildContext context) => CircularProgressIndicator(),

                      ):
                      Image.network(
                        url+"/getimage/"+brand.image, // Assuming you want to display the first image

                      ),
                    ),
                  ),
                ),
                if (pos == brand.title)
                  CircleAvatar(
                    radius: widget.fontSize * 0.5,
                    backgroundColor: Colors.blueAccent,
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Icon(Icons.check, color: Colors.white),
                    ),
                  )
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}

class ListcatSheet extends StatefulWidget {
  final Function change;
  final double marginValue;
  final double screenHeight;
  final double screenWidth;
  final double fontSize;

  const ListcatSheet({
    Key? key,
    required this.change,
    required this.marginValue,
    required this.screenHeight,
    required this.screenWidth,
    required this.fontSize,
  }) : super(key: key);

  @override
  _ListcatSheetState createState() => _ListcatSheetState();
}

class _ListcatSheetState extends State<ListcatSheet> {

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    double screenWidth = mediaQueryData.size.width;
    double screenHeight = mediaQueryData.size.height;
    double fontSize = MediaQuery.of(context).size.shortestSide * 0.05;
    double marginValue = MediaQuery.of(context).size.width * 0.02;
    String pos = context.read<DataService>().brandajouter;

    return Container(
      child: Padding(
        padding: EdgeInsets.all(widget.marginValue),
        child: Wrap(
          runSpacing: widget.screenHeight * 0.01,
          spacing: widget.screenWidth*0.02,
          children: context.read<DataService>().categories.map((categ) {
            return  Stack(
              alignment: Alignment.topRight,
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      pos = categ.name;

                      widget.change(categ);
                      context.read<DataService>().categajouter=categ.name;
                    });
                  },
                  child:  Container(
                    height: screenHeight * 0.1,
                    width: screenHeight * 0.1,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey.withOpacity(0.3),
                      border: Border.all(color: categ.name== pos ? Colors.blueAccent : Colors.transparent, width: screenWidth * 0.005),
                    ),
                    child: ClipOval(

                      child:
                      categ.image.toLowerCase().endsWith('.svg+xml')?
                      SvgPicture.network(
                        url + "/getimage/" + categ.image,
                        // Placeholder widget while loading, if needed
                        placeholderBuilder: (BuildContext context) => CircularProgressIndicator(),

                      ):
                      Image.network(
                        url+"/getimage/"+categ.image, // Assuming you want to display the first image

                      ),
                    ),
                  ),
                ),
                if (pos == categ.name)
                  CircleAvatar(
                    radius: widget.fontSize * 0.5,
                    backgroundColor: Colors.blueAccent,
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Icon(Icons.check, color: Colors.white),
                    ),
                  )
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}


class categorysheet extends StatefulWidget {
  final  Function change;
  categorysheet({super.key,required this.change});

  @override
  State<categorysheet> createState() => _categorysheetState();
}

class _categorysheetState extends State<categorysheet> {

  int _index = 0;

  @override
  Widget build(BuildContext context) {MediaQueryData mediaQueryData = MediaQuery.of(context);
  double screenWidth = mediaQueryData.size.width;
  double screenHeight = mediaQueryData.size.height;
  double fontSize = MediaQuery.of(context).size.shortestSide * 0.05;
  double marginValue = MediaQuery.of(context).size.width * 0.02;
  List<String>listcategorie=['All','Men','Women','Kids'];

  return  Container(
      height:screenHeight*0.15 ,
      child:  Wrap(
        children: List.generate(listcategorie.length, (index) {
          return menuButton(

              onTap: () {
                setState(() {
                  _index = index;
                  this.widget.change(listcategorie[index]);
                  context.read<DataService>().Categorie=listcategorie[index];
                });
              },
              color: context.read<DataService>().Categorie.toLowerCase()==listcategorie[index].toLowerCase()? Colors.blueAccent : Colors.grey.withOpacity(0.5),
              text: listcategorie[index],
              textColor: Colors.white,
              width:    context.read<DataService>().Categorie.toLowerCase()==listcategorie[index].toLowerCase()? screenWidth*0.2 : screenWidth*0.15
          );

        })

        ,
      ))
  ;
  }
}


menuButton(
    {required String text,
      required Color color,
      required Color textColor,
      required double width,
      IconData? icon,
      required VoidCallback onTap}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        width: width,
        height: 45,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(30),
        ),
        child: icon!=null?
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              text,

            ),
            Icon(icon)
          ],
        ):Text(
          text,

        ),
      ),
    ),
  );
}

Widget getCategoryIcon(String category, double fontSize) {
  if (category == "Category"||category=="") {
    return SvgPicture.asset("assets/icons/Category.svg",height: fontSize*1.3,);
  } else if (category == "2") {
    return SvgPicture.asset("assets/icons/icon2.svg", height: fontSize * 1.3);
  }

  else {

    if(category=="kids"){
      return SvgPicture.asset("assets/icons/icon2.svg", height: fontSize * 1.3);

    }
    else{
      return SvgPicture.asset("assets/icons/defaultIcon.svg", height: fontSize * 1.3);

    }
  }
}

