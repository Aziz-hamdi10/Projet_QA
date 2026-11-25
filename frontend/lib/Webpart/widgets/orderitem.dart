import 'package:bridgewearaa/Webpart/model.dart';
import 'package:bridgewearaa/config.dart';
import 'package:bridgewearaa/const/colors.dart';
import 'package:bridgewearaa/controlleur/commandcontrolleur.dart';
import 'package:bridgewearaa/controlleur/usercontrolleur.dart';
import 'package:bridgewearaa/models/commande.dart';
import 'package:bridgewearaa/models/user.dart';
import 'package:bridgewearaa/screens/order%20detail.dart';
import 'package:bridgewearaa/services/data.dart';
import 'package:bridgewearaa/widget/CustomConfirmation.dart';
import 'package:bridgewearaa/widget/CustomErormsg.dart';
import 'package:bridgewearaa/widget/commanditem.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class orderitem extends StatefulWidget {
  final commande data;
  final bool? liv;
  const orderitem(this.data, this.liv);

  @override
  _OrderItemState createState() => _OrderItemState();
}

class _OrderItemState extends State<orderitem> {
    User user=User(id: "id", firstname: "firstname", secondname: "secondname", email: "email", phone: "phone", picture: "picture", password: "password",role: "");
  void initState() {
    super.initState();
  
    getuserbyid(widget.data.idbuyer, (x)=>{
      setState(() {
        user=x;
      })
    }


    );

 



  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        if(widget.liv==true )
          Navigator.push(context, MaterialPageRoute(builder:(context) => orderdetails(widget.data), ));

      },
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16),
            margin: EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
              color: Colors.blueAccent.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Container(
                  width: 80,
                  height: 100,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: primary,
                      image: DecorationImage(
            image: NetworkImage(url + "/getimage/" + widget.data.prd.imgaenames[0]),
            fit: BoxFit.cover, // or any other BoxFit option you prefer
          ),
  ),

                                  ),

                SizedBox(
                  width: 14,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.data.prd.name,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          Text(
                            widget.data.prixtotal.toStringAsFixed(0)+" DT",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          
                        ],
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        widget.data.prd.name,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                       "Ordered On " + DateFormat('dd MMM yyyy HH:mm').format(widget.data.dateadd),
                        style: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontStyle: FontStyle.italic,
                            fontSize: 12),
                      )
                      ,
                 
                          if(widget.data.dateconfirm!=null)
                          SizedBox(
                        height: 4,
                      ),
                                          if(widget.data.dateconfirm!=null)

                      Text(
                       "Confirmed  On " + DateFormat('dd MMM yyyy HH:mm').format(widget.data.dateconfirm!),
                        style: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontStyle: FontStyle.italic,
                            fontSize: 12),
                      ),
    if(widget.data.datetaked!=null)
                          SizedBox(
                        height: 4,
                      ),
                                          if(widget.data.datetaked!=null)

                      Text(
                       "Taked  On " + DateFormat('dd MMM yyyy HH:mm').format(widget.data.datetaked!),
                        style: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontStyle: FontStyle.italic,
                            fontSize: 12),
                      ),
                      if(widget.data.datedelievry!=null)
                          SizedBox(
                        height: 4,
                      ),
                                          if(widget.data.datedelievry!=null)

                      Text(
                       "Delievred  On " + DateFormat('dd MMM yyyy HH:mm').format(widget.data.datedelievry!),
                        style: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontStyle: FontStyle.italic,
                            fontSize: 12),
                      ),
 if(widget.data.datefinished!=null)
                          SizedBox(
                        height: 4,
                      ),
                                          if(widget.data.datefinished!=null)

                      Text(
                       "Finished  On " + DateFormat('dd MMM yyyy HH:mm').format(widget.data.datefinished!),
                        style: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontStyle: FontStyle.italic,
                            fontSize: 12),
                      ),
                      
                      
                      
                           if(widget.data.datecancel!=null)
                          SizedBox(
                        height: 4,
                      ),
                                          if(widget.data.datecancel!=null)

                      Text(
                       "Canceled On " + DateFormat('dd MMM yyyy HH:mm').format(widget.data.datecancel!),
                        style: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontStyle: FontStyle.italic,
                            fontSize: 12),
                      ),



                      SizedBox(
                        height: 6,
                      ),
                        Container(
                                    decoration: BoxDecoration(
                                      color: getColorForCmdEtat(widget.data.etat).withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    child: Center(
                                      child: Padding(
                                        padding: EdgeInsets.all(5),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: [
                                            Icon(Icons.circle, size: 16, color: getColorForCmdEtat(widget.data.etat)),
                                            FittedBox(
                                              fit: BoxFit.scaleDown,
                                              child: Text(
                                                widget.data.etat,
                                                style: TextStyle(fontSize: 15,color: getColorForCmdEtat(widget.data.etat),fontWeight: FontWeight.bold),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                    if(widget.data.etat.toLowerCase()!="finished"&&widget.data.etat.toLowerCase()!="canceled")
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  if(widget.data.etat.toLowerCase()!="confirmed")
                  Expanded(
                    child: Container(
                    child: ElevatedButton(
                        onPressed: () {
                          customconfimation(context, 'Canceled', 'Are you sure you want to Cancel this order ?', () {
                       Navigator.pop(context);
                  
                             modifyorderstate(context.read<DataService>().token!,widget.data.id, "Canceled", (msg, cl, icon) => {
                                setState(() {
                        widget.data.etat="Canceled";
                        widget.data.datecancel=DateTime.now();
                      }),
                                 ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                      backgroundColor: cl,
                      content: Customerrormsg(icon: icon,
                        message: msg,bgcolor: cl,)
                                  ))
                  
                          });
                  
                  
                          },Colors.red);
                            },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                          overlayColor: MaterialStateProperty.all<Color>(Colors.transparent),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0), // Adjust border radius as needed
                            ),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(0),
                          child: FittedBox(
                  
                            child: Text(
                              "Cancel",
                              style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                    ),
                  ),
                  )
       ,
       SizedBox(width: 10,),
       if(widget.data.etat.toLowerCase()=="waiting confirmation"&&(context.read<DataService>().user!.role.toLowerCase()=="moderator"||context.read<DataService>().user!.role.toLowerCase()=="admin"))
          Expanded(
            child: Container(
            child: ElevatedButton(
                onPressed: () {
            customconfimation(context, 'Confirmation', 'Are you sure you want to Valid this order ?', () {
                       Navigator.pop(context);
          
             modifyorderstate(context.read<DataService>().token!,widget.data.id, "Confirmed", (msg, cl, icon) => {
                setState(() {
                        widget.data.etat="Confirmed";
                                            widget.data.dateconfirm=DateTime.now();
          
                      }),
                 ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      backgroundColor: cl,
                      content: Customerrormsg(icon: icon,
                        message: msg,bgcolor: cl,)
                  ))
          
                  });
          
          
                  },Colors.green);
          
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                  overlayColor: MaterialStateProperty.all<Color>(Colors.transparent),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0), // Adjust border radius as needed
            ),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.all(0),
                  child: FittedBox(
          
            child: Text(
              "Valid",
              style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 12),
            ),
                  ),
                ),
            ),
          ),
          )
       ,if(widget.data.etat.toLowerCase()=="confirmed"&&context.read<DataService>().user!.role.toLowerCase()=="delievry")
          Expanded(
         child: Container(
         child: ElevatedButton(
             onPressed: () {
            customconfimation(context, 'Confirmation', 'Are you sure you want to Take this order ?', () {
                       Navigator.pop(context);
       
             modifyorderstate(context.read<DataService>().token!,widget.data.id, "Taked", (msg, cl, icon) => {
                setState(() {
                        widget.data.etat="Taked";
                                            widget.data.dateconfirm=DateTime.now();
       
                      }),
                 ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      backgroundColor: cl,
                      content: Customerrormsg(icon: icon,
                        message: msg,bgcolor: cl,)
                  ))
       
          });
       
       
          },Colors.blueAccent);
       
             },
             style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
          overlayColor: MaterialStateProperty.all<Color>(Colors.transparent),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0), 
            ),
          ),
             ),
             child: Padding(
          padding: EdgeInsets.all(0),
          child: FittedBox(
       
            child: Text(
              "Take it",
              style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 12),
            ),
          ),
             ),
         ),
       ),
       )
           ,if(widget.data.etat.toLowerCase()=="taked"&&context.read<DataService>().user!.role.toLowerCase()=="delievry")
          Expanded(
     child: Container(
     child: ElevatedButton(
        onPressed: () {
            customconfimation(context, 'Confirmation', 'Are you will Delievred this order ?', () {
                       Navigator.pop(context);
   
             modifyorderstate(context.read<DataService>().token!,widget.data.id, "On delievry", (msg, cl, icon) => {
                setState(() {
                        widget.data.etat="On delievry";
                                            widget.data.dateconfirm=DateTime.now();
   
                      }),
                 ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      backgroundColor: cl,
                      content: Customerrormsg(icon: icon,
                        message: msg,bgcolor: cl,)
                  ))
   
          });
   
   
          },Colors.blueAccent);
   
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
          overlayColor: MaterialStateProperty.all<Color>(Colors.transparent),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0), // Adjust border radius as needed
            ),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(0),
          child: FittedBox(
   
            child: Text(
              "Delievry it",
              style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 12),
            ),
          ),
        ),
     ),
   ),
   )
            ,if(widget.data.etat.toLowerCase()=="on delievry"&&context.read<DataService>().user!.role.toLowerCase()=="delievry")
          Expanded(
     child: Container(
     child: ElevatedButton(
        onPressed: () {
            customconfimation(context, 'Confirmation', 'Is this order Finished ?', () {
                       Navigator.pop(context);
   
             modifyorderstate(context.read<DataService>().token!,widget.data.id, "Finished", (msg, cl, icon) => {
                setState(() {
                        widget.data.etat="Finished";
                                            widget.data.dateconfirm=DateTime.now();
   
                      }),
                 ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      backgroundColor: cl,
                      content: Customerrormsg(icon: icon,
                        message: msg,bgcolor: cl,)
                  ))
   
          });
   
   
          },Colors.blueAccent);
   
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
          overlayColor: MaterialStateProperty.all<Color>(Colors.transparent),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0), // Adjust border radius as needed
            ),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(0),
          child: FittedBox(
   
            child: Text(
              "Finish it",
              style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 12),
            ),
          ),
        ),
     ),
   ),
   )
         
                                ],
                              ),
                      ),
                    )
                    ],
                  ),
                )
              ],
            ),
          ),
        if(widget.liv==false )
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
             Container(
            padding: EdgeInsets.all(16),
            margin: EdgeInsets.only(bottom: 24),
             decoration: BoxDecoration(
              color: Colors.blueAccent.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text("The Seller",style: TextStyle(fontWeight: FontWeight.bold),),
                ),
                Container(
child: ClipRRect(
  borderRadius: BorderRadius.circular(50),
                                                          child: widget.data.prd.iduser!.picture.toLowerCase().endsWith('.svg+xml')?
                                                           SvgPicture.network(
                                url + "/getimage/" +widget.data.prd.iduser!.picture,
                                height: 50,
                                fit:BoxFit.cover,


                                // Placeholder widget while loading, if needed
                                placeholderBuilder: (BuildContext context) => CircularProgressIndicator(),

                              ):
 Image.network(
                                url + "/getimage/" + widget.data.prd.iduser!.picture,
                                                              height: 50,

                              ),
                            ),
                ),
                SizedBox(height: 10,),
                Text(widget.data.prd.iduser!.firstname+" "+widget.data.prd.iduser!.secondname ),
                              SizedBox(height: 5,),
                Container(
                  child: Text("Phone : "+widget.data.prd.iduser!.phone,style: TextStyle(fontSize: 12),))
              ],
            ),
            ),
               Container(
            padding: EdgeInsets.all(16),
            margin: EdgeInsets.only(bottom: 24),
             decoration: BoxDecoration(
              color: Colors.blueAccent.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                 Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text("The buyer",style: TextStyle(fontWeight: FontWeight.bold),),
                ),
                Container(
child: ClipRRect(
      borderRadius: BorderRadius.circular(50.0),

                                                          child: user!.picture.toLowerCase().endsWith('.svg+xml')?
                                                           SvgPicture.network(
                                url + "/getimage/" +user!.picture,
                                height: 50,
                                fit:BoxFit.cover,


                                placeholderBuilder: (BuildContext context) => CircularProgressIndicator(),

                              ):
 Image.network(
                                url + "/getimage/" + user!.picture,
                                                              height: 50,

                              ),
                            ),
                ),
                SizedBox(height: 10,),
                Text(user!.firstname+" "+user!.secondname ),
                              SizedBox(height: 5,),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text("Phone : "+user!.phone,style: TextStyle(fontSize: 12),))
              ],
            ),
            ),
         ],
        )
        ],
      ),
    );
  }
}
