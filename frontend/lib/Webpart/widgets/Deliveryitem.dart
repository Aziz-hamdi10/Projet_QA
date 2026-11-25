import 'package:bridgewearaa/Webpart/model.dart';
import 'package:bridgewearaa/config.dart';
import 'package:bridgewearaa/const/colors.dart';
import 'package:bridgewearaa/controlleur/commandcontrolleur.dart';
import 'package:bridgewearaa/controlleur/usercontrolleur.dart';
import 'package:bridgewearaa/models/commande.dart';
import 'package:bridgewearaa/models/user.dart';
import 'package:bridgewearaa/screens/order%20detail.dart';
import 'package:bridgewearaa/widget/CustomConfirmation.dart';
import 'package:bridgewearaa/widget/CustomErormsg.dart';
import 'package:bridgewearaa/widget/commanditem.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_svg/flutter_svg.dart';

class deleivryitem extends StatefulWidget {
  final commande data;
  const deleivryitem(this.data);

  @override
  _deleivryitemState createState() => _deleivryitemState();
}

class _deleivryitemState extends State<deleivryitem> {
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
            fit: BoxFit.cover,
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
                      Text(
                        widget.data.prd.name,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
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

                  ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
