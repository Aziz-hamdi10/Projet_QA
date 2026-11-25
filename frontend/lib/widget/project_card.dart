import 'package:bridgewearaa/Webpart/constaints.dart';
import 'package:bridgewearaa/Webpart/widgets/brandscreen.dart';
import 'package:bridgewearaa/Webpart/widgets/categoriescreen.dart';
import 'package:bridgewearaa/Webpart/widgets/colorsscreen.dart';
import 'package:bridgewearaa/Webpart/widgets/sizescreen.dart';
import 'package:bridgewearaa/config.dart';
import 'package:bridgewearaa/controlleur/brandcontrolleur.dart';
import 'package:bridgewearaa/controlleur/categoriecontroller.dart';
import 'package:bridgewearaa/controlleur/colorcontrolleur.dart';
import 'package:bridgewearaa/controlleur/promotioncontrolleur.dart';
import 'package:bridgewearaa/controlleur/sizecontrolleur.dart';
import 'package:bridgewearaa/models/brand.dart';
import 'package:bridgewearaa/models/categorie.dart';
import 'package:bridgewearaa/models/color.dart';
import 'package:bridgewearaa/models/promotion.dart';
import 'package:bridgewearaa/models/size.dart';
import 'package:bridgewearaa/models/user.dart';
import 'package:bridgewearaa/services/data.dart';
import 'package:bridgewearaa/widget/CustomConfirmation.dart';
import 'package:bridgewearaa/widget/CustomErormsg.dart';
import 'package:bridgewearaa/widget/tableau.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProjectCardData {
  final double percent;
  final ImageProvider projectImage;
  final String projectName;
  final DateTime releaseTime;

  const ProjectCardData({
    required this.projectImage,
    required this.projectName,
    required this.releaseTime,
    required this.percent,
  });
}

class brandcard extends StatefulWidget {
  final Function change;
    final Function delete;

  final brand data;

  const brandcard({
    required this.change,
    required this.data,
    required  this.delete,
    Key? key,
  }) : super(key: key);

  @override
  _BrandCardState createState() => _BrandCardState();
}

class _BrandCardState extends State<brandcard> {
  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    double screenWidth = mediaQueryData.size.width;
    double screenHeight = mediaQueryData.size.height;
    final Size _size = MediaQuery.of(context).size;
    final bool _isDesktop = _size.width >= 600;
    if (screenHeight < screenWidth) {
      screenWidth = mediaQueryData.size.height;
      screenHeight = mediaQueryData.size.width;
    }
    double fontSize = MediaQuery.of(context).size.shortestSide * 0.05;

    if (!_isDesktop) {
      fontSize = MediaQuery.of(context).size.shortestSide * 0.06;
    }
    double marginValue = MediaQuery.of(context).size.width * 0.02;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _ProgressIndicator(
          center: _ProfilImage(image: widget.data.image),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.topLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _TitleText(widget.data.title),
                const SizedBox(height: 5),
                Row(
                  children: [
                    const _SubtitleText("Release time : "),
                    _ReleaseTimeText(widget.data.datedadd)
                  ],
                )
              ],
            ),
          ),
        ),
        InkWell(
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return Dialog(
                  child: Material(
                    child: addbrandwidget(
                      br: widget.data,
                      change: () {
                        widget.change();
                      },
                    ),
                  ),
                );
              },
            );
          },
          child: Icon(Icons.change_circle, color: Colors.grey, size: fontSize),
        ),
        InkWell(
          onTap: () {
     customconfimation(context, 'Confirmation', 'Are you sure you want to delete '+widget.data.title+'?', () {
                Navigator.pop(context);

        deletbrand((msg, Color,icon) => {
                widget.delete(),

                ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  backgroundColor: Color,
                  content: Customerrormsg(icon: icon,
                    message: msg,bgcolor: Color,)
              ))
            }, widget.data.id);

      },Colors.red);
           
          },
          child: Icon(Icons.delete, color: Colors.red, size: fontSize),
        )
      ],
    );
  }
}

class categoryCard extends StatefulWidget {
  final Function change;
    final Function delete;

  final categorie data;

  const categoryCard({
    required this.change,
    required this.data,
    required  this.delete,
    Key? key,
  }) : super(key: key);

  @override
  _categoryCardState createState() => _categoryCardState();
}

class _categoryCardState extends State<categoryCard> {
  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    double screenWidth = mediaQueryData.size.width;
    double screenHeight = mediaQueryData.size.height;
    final Size _size = MediaQuery.of(context).size;
    final bool _isDesktop = _size.width >= 600;
    if (screenHeight < screenWidth) {
      screenWidth = mediaQueryData.size.height;
      screenHeight = mediaQueryData.size.width;
    }
    double fontSize = MediaQuery.of(context).size.shortestSide * 0.05;

    if (!_isDesktop) {
      fontSize = MediaQuery.of(context).size.shortestSide * 0.06;
    }
    double marginValue = MediaQuery.of(context).size.width * 0.02;

    return InkWell(
       onTap: (){
         showDialog(
  context: context,
  builder: (BuildContext context) {
    return AlertDialog(
      title: Text("Promotion",style: TextStyle(fontSize: fontSize*0.7,fontWeight: FontWeight.bold),),
      content: PromotionCard(data: widget.data,delete: (){

      },change: (){
        
      }),
     
    );
  },
);
       },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _ProgressIndicator(
            center: _ProfilImage(image: widget.data.image),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.topLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _TitleText(widget.data.name),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      const _SubtitleText("Release time : "),
                      _ReleaseTimeText(widget.data.dateadd)
                    ],
                  )
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return Dialog(
                    child: Material(
                      child: addcategoriewidget(
                        cr: widget.data,
                        change: () {
                          widget.change();
                        },
                      ),
                    ),
                  );
                },
              );
            },
            child: Icon(Icons.change_circle, color: Colors.grey, size: fontSize),
          ),
          InkWell(
            onTap: () {
       customconfimation(context, 'Confirmation', 'Are you sure you want to delete '+widget.data.name+'?', () {
                  Navigator.pop(context);
    
          deletecategory((msg, Color,icon) => {
                  widget.delete(),
    
                  ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    backgroundColor: Color,
                    content: Customerrormsg(icon: icon,
                      message: msg,bgcolor: Color,)
                ))
              }, widget.data.id);
    
        },Colors.red);
             
            },
            child: Icon(Icons.delete, color: Colors.red, size: fontSize),
          )
        ],
      ),
    );
  }
}



class PromotionCard extends StatefulWidget {
  final Function change;
    final Function delete;

  final categorie data;

  const PromotionCard({
    required this.change,
    required this.data,
    required  this.delete,
    Key? key,
  }) : super(key: key);

  @override
  _PromotionCardtate createState() => _PromotionCardtate();
}

class _PromotionCardtate extends State<PromotionCard> {
  List<promotion>listfiltred=[];
  getdata(Function fn)async{
    await getpromotion((p0) => {
      
      fn(p0)
    },widget.data.id);
  }
  @override
  void initState() {
    super.initState();
    getdata((p0){
setState(() {
              listfiltred=p0;

      }); 
    }
      
    );

  }
  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    double screenWidth = mediaQueryData.size.width;
    double screenHeight = mediaQueryData.size.height;
    final Size _size = MediaQuery.of(context).size;
    final bool _isDesktop = _size.width >= 600;
    if (screenHeight < screenWidth) {
      screenWidth = mediaQueryData.size.height;
      screenHeight = mediaQueryData.size.width;
    }
    double fontSize = MediaQuery.of(context).size.shortestSide * 0.05;

    if (!_isDesktop) {
      fontSize = MediaQuery.of(context).size.shortestSide * 0.06;
    }
    double marginValue = MediaQuery.of(context).size.width * 0.02;

    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _ProgressIndicator(
              center: _ProfilImage(image: widget.data.image),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.topLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _TitleText(widget.data.name),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        const _SubtitleText("Release time : "),
                        _ReleaseTimeText(widget.data.dateadd)
                      ],
                    )
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return Dialog(
                      child: Material(
                        child: addcategoriewidget(
                          cr: widget.data,
                          change: () {
                            widget.change();
                          },
                        ),
                      ),
                    );
                  },
                );
              },
              child: Icon(Icons.change_circle, color: Colors.grey, size: fontSize),
            ),
            InkWell(
              onTap: () {
         customconfimation(context, 'Confirmation', 'Are you sure you want to delete '+widget.data.name+'?', () {
                    Navigator.pop(context);

            deletecategory((msg, Color,icon) => {
                    widget.delete(),

                    ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      backgroundColor: Color,
                      content: Customerrormsg(icon: icon,
                        message: msg,bgcolor: Color,)
                  ))
                }, widget.data.id);

          },Colors.red);
               
              },
              child: Icon(Icons.delete, color: Colors.red, size: fontSize),
            )
          ],
        ),
         SizedBox(height: screenHeight*0.005,),
         SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: DataTable(
                  headingRowColor: MaterialStateProperty.resolveWith(
                      (states) => Colors.grey.shade200),
                      columnSpacing: 30, 
                  dataRowHeight: 40, 
                  headingRowHeight: 50,
                  columns: [
                    DataColumn(label: Text("Promotion")),
                    DataColumn(label: Text("Date Start")),
                    DataColumn(label: Text("Date End")),
          
                    DataColumn(label: Text("state")),
                                        DataColumn(label: Text("percentage")),

                                        DataColumn(label: InkWell(
                                          onTap: (){

                                          },
                                          child: Icon(Icons.add))),


                  ],
                  rows: List<DataRow>.generate(
                    listfiltred.length,
                    (index) => DataRow(
                      cells: [
                                                DataCell(Text(listfiltred[index].title)),

                     DataCell(Text(listfiltred[index].datestart.toString())),
                        DataCell(Text(listfiltred[index].dateend.toString())),
DataCell(        Expanded(
                          child: Container(
                           
                                child: Padding(
                                  padding:  EdgeInsets.all(10),
                                  child: Row(
                                        children: [
                                          Icon(Icons.circle, color: getcolor(listfiltred[index].etat)),
                                          SizedBox(width: screenWidth * 0.005),
                                          FittedBox(
                                            fit: BoxFit.scaleDown,
                                            child: Text(
                                              listfiltred[index].etat,
                                              style: TextStyle(color: getcolor(listfiltred[index].etat)),
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
                                                                      DataCell(Text(listfiltred[index].percentage.toString()+" %",style: TextStyle(fontWeight: FontWeight.bold),)),

 DataCell(Row(
                                                  children: [
                                                    InkWell(child: Icon(Icons.delete,color: Colors.red,),
                                                    onTap: (){
                                                   
                            customconfimation(context, 'Delete Promotion ?', 'Are you sure you want to delete this Promotion?', () {
                           
                              deletepromotion((msg, Color,icon) => {
                                Navigator.pop(context),
                                setState(() {
                                                  listfiltred.remove(listfiltred[index]);

                                })

            
            }, listfiltred[index].id);
                                      }
                                       ,Colors.red);
                   
                  
                                                    },
                                                    ),
                                                    if(listfiltred[index].etat.toLowerCase()!="active")
                                                    InkWell(
                                                        onTap: (){


                                                          
                                                        
                                                      },
                                                      child: Icon(Icons.arrow_upward,color: Colors.green,)),
                                               
   if(listfiltred[index].etat.toLowerCase()!="notactive")

                                                    InkWell(
                                                      onTap: (){
                                                           customconfimation(context, 'disable Promotion ?', 'Are you sure you want to disable this Promotion?', () {
                                                              promotion p =promotion(code:listfiltred[index].code ,iddepartement: listfiltred[index].iddepartement,id:  listfiltred[index].id, etat:  (DateTime.now().isBefore(DateTime.now())&&DateTime.now().isAfter(DateTime.now()))?"active":"notactive", title:  listfiltred[index].title, datestart: DateTime.now(), dateend:DateTime.now(), percentage: listfiltred[index].percentage );
                modifpromo(p, (p0, p1) =>{
                          setState(() {
                                   listfiltred[index]=p;
                          })
                 });
                  Navigator.pop(context);
                                                      },Colors.red);

                                                           },

                                                    
                                                      child: Icon(Icons.arrow_circle_down_outlined,color: Colors.grey,)),

                                                  ],
                                                )),

                 ],
                    ),
                  ),
                ),
              ),
            ),
      
      
      ],
    );
  }
}


class Colorcard extends StatefulWidget {
  final Function change;
    final Function delete;

  final color data;

  const Colorcard({
    required this.change,
    required this.data,
    required  this.delete,
    Key? key,
  }) : super(key: key);

  @override
  _colorcardstate createState() => _colorcardstate();
}

class _colorcardstate extends State<Colorcard> {
  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    double screenWidth = mediaQueryData.size.width;
    double screenHeight = mediaQueryData.size.height;
    final Size _size = MediaQuery.of(context).size;
    final bool _isDesktop = _size.width >= 600;
    if (screenHeight < screenWidth) {
      screenWidth = mediaQueryData.size.height;
      screenHeight = mediaQueryData.size.width;
    }
    double fontSize = MediaQuery.of(context).size.shortestSide * 0.05;

    if (!_isDesktop) {
      fontSize = MediaQuery.of(context).size.shortestSide * 0.06;
    }
    double marginValue = MediaQuery.of(context).size.width * 0.02;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
       Container(
            decoration: BoxDecoration(

                shape: BoxShape.circle,
                color: Colors.grey.withOpacity(0.3),
            ),
            child: CircleAvatar(
              radius: screenWidth*0.05,
              backgroundColor: this.widget.data.coleur,

            ),
          ),
        const SizedBox(width: 10),
        Expanded(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.topLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _TitleText(widget.data.name),
                const SizedBox(height: 5),
                Row(
                  children: [
                    const _SubtitleText("Release time : "),
                    _ReleaseTimeText(widget.data!.dateadd)
                  ],
                )
              ],
            ),
          ),
        ),
        InkWell(
          onTap: () {
                   showDialog(
  context: context,
  builder: (BuildContext context) {
    return Dialog(
      child: Material(
        child: Container(
          height: screenHeight,
          width: screenWidth,
          child: addcolorwidget(changed:(cl){
            setState(() {
                          widget.change(cl);
            });

           
          } ,cl: widget.data),
        ),
      ),
    );
  },
);
          },
          child: Icon(Icons.change_circle, color: Colors.grey, size: fontSize),
        ),
        InkWell(
          onTap: () {
     customconfimation(context, 'Confirmation', 'Are you sure you want to delete '+widget.data.name+'?', () {
                Navigator.pop(context);

        deletecolor((msg, Color,icon) => {
                widget.delete(),

                ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  backgroundColor: Color,
                  content: Customerrormsg(icon: icon,
                    message: msg,bgcolor: Color,)
              ))
            }, widget.data.id);

      },Colors.red);
           
          },
          child: Icon(Icons.delete, color: Colors.red, size: fontSize),
        )
      ],
    );
  }
}


class Sizecard extends StatefulWidget {
  final Function change;
    final Function delete;

  final size data;

  const Sizecard({
    required this.change,
    required this.data,
    required  this.delete,
    Key? key,
  }) : super(key: key);

  @override
  _Sizecardstate createState() => _Sizecardstate();
}

class _Sizecardstate extends State<Sizecard> {
  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    double screenWidth = mediaQueryData.size.width;
    double screenHeight = mediaQueryData.size.height;
    final Size _size = MediaQuery.of(context).size;
    final bool _isDesktop = _size.width >= 600;
    if (screenHeight < screenWidth) {
      screenWidth = mediaQueryData.size.height;
      screenHeight = mediaQueryData.size.width;
    }
    double fontSize = MediaQuery.of(context).size.shortestSide * 0.05;

    if (!_isDesktop) {
      fontSize = MediaQuery.of(context).size.shortestSide * 0.06;
    }
    double marginValue = MediaQuery.of(context).size.width * 0.02;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
                              decoration: BoxDecoration(

                                  shape: BoxShape.circle,
                                  color: Colors.grey.withOpacity(0.3),
                              ),
                              child: CircleAvatar(
                                radius: screenWidth*0.05,
                                backgroundColor: Colors.transparent,
                                child: Text(widget.data.name.toUpperCase(),textAlign: TextAlign.center,style: TextStyle(color: Colors.black,fontSize: fontSize,fontWeight: FontWeight.bold),),

                              ),
                            ),
    const SizedBox(width: 10),
        Expanded(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.topLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _TitleText(widget.data.name),
                const SizedBox(height: 5),
                Row(
                  children: [
                    const _SubtitleText("Release time : "),
                    _ReleaseTimeText(widget.data.dateadd)
                  ],
                )
              ],
            ),
          ),
        ),
    
        InkWell(
          onTap: () {
     customconfimation(context, 'Confirmation', 'Are you sure you want to delete '+widget.data.name+'?', () {
                Navigator.pop(context);
                  deletesize((msg, Color,icon) => {
                widget.delete(),

                ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  backgroundColor: Color,
                  content: Customerrormsg(icon: icon,
                    message: msg,bgcolor: Color,)
              ))
            }, widget.data.id);

  

      },Colors.red);
           
          },
          child: Icon(Icons.delete, color: Colors.red, size: fontSize),
        )
      ],
    );
  }
}

class _ProgressIndicator extends StatelessWidget {
  const _ProgressIndicator({
    required this.center,
    Key? key,
  }) : super(key: key);

  final Widget center;

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
     
  
    return CircularPercentIndicator(
      radius: screenWidth*0.1,
      lineWidth: 2.0,
      center: center,
      circularStrokeCap: CircularStrokeCap.round,
      backgroundColor: Colors.blueGrey,
      progressColor: Colors.grey,
    );
  }
}

class _ProfilImage extends StatelessWidget {
  const _ProfilImage({required this.image, Key? key}) : super(key: key);

  final String image;

  @override
  Widget build(BuildContext context) {
    return ClipOval(

                            child:
                            image.toLowerCase().endsWith('.svg+xml')?
                            SvgPicture.network(
                              url + "/getimage/" +image,
                              // Placeholder widget while loading, if needed
                              placeholderBuilder: (BuildContext context) => CircularProgressIndicator(),

                            ):
                            Image.network(
                              url+"/getimage/"+image, // Assuming you want to display the first image

                            ),
                          );
                       
  }
}

class _TitleText extends StatelessWidget {
  const _TitleText(this.data, {Key? key}) : super(key: key);

  final String data;

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        color: Colors.black,
        letterSpacing: 0.8,
      ),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}

class _SubtitleText extends StatelessWidget {
  const _SubtitleText(this.data, {Key? key}) : super(key: key);

  final String data;
  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: TextStyle(fontSize: 11, color:Colors.black),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}

class _ReleaseTimeText extends StatelessWidget {
  const _ReleaseTimeText(this.date, {Key? key}) : super(key: key);

  final DateTime date;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2.5),
      child: Text(
        DateFormat.yMMMd().format(date),
        style: const TextStyle(fontSize: 9, color: Colors.white),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}



