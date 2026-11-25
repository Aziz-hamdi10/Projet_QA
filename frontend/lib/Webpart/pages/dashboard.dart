import 'package:bridgewearaa/Webpart/pages/usersscreen.dart';
import 'package:bridgewearaa/Webpart/widgets/brandscreen.dart';
import 'package:bridgewearaa/Webpart/widgets/categoriescreen.dart';
import 'package:bridgewearaa/Webpart/widgets/colorsscreen.dart';
import 'package:bridgewearaa/Webpart/widgets/sizescreen.dart';
import 'package:bridgewearaa/controlleur/brandcontrolleur.dart';
import 'package:bridgewearaa/controlleur/colorcontrolleur.dart';
import 'package:bridgewearaa/controlleur/sizecontrolleur.dart';
import 'package:bridgewearaa/controlleur/usercontrolleur.dart';
import 'package:bridgewearaa/models/user.dart';
import 'package:bridgewearaa/screens/Seeting.dart';
import 'package:bridgewearaa/services/data.dart';

import 'package:flutter/material.dart';
import 'package:bridgewearaa/Webpart/components/charts.dart';
import 'package:bridgewearaa/Webpart/components/status_list.dart';
import 'package:bridgewearaa/Webpart/constaints.dart';
import 'package:bridgewearaa/Webpart/layout/main_layout.dart';
import '../components/order_table.dart';

import 'package:provider/provider.dart';



class Dashboard extends StatefulWidget {
  final String iduser;
  
  Dashboard({Key? key, required this.iduser}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List<User>listdelievry=[];
    List<User>listmoderateur=[];
  List<User>listclients=[];

   @override
  void initState() {
    super.initState();
    getcolors( (list) =>{

      context.read<DataService>().listcolors=list
    });

        getsizes2( (list) =>{

       context.read<DataService>().listsize2=list
    });
       getsizes( (list) =>{

       context.read<DataService>().listsize=list
    });
    getUsersByToken(widget.iduser, (p0) =>{
      listdelievry=p0
    });
    getusers(widget.iduser, (p0) => {
listclients=p0
    });
    getmoderateurs(widget.iduser, (p0) =>{
listmoderateur=p0
    });
  }
  
  String index="Dashboard";

  @override
  Widget build(BuildContext context) {
 
    return MainLayout(
      fn: (newindex){
setState(() {
  index=newindex;
});
      },
      index: index,

      iduser: widget.iduser,
child: index == "Dashboard" 
    ? DashboardWidgets() 
    : index.toLowerCase() == "brands" 
        ? brandscreen():index.toLowerCase() == "settings"?Seetingbody():index.toLowerCase() == "delievry"?livreurwidget( listuser: listdelievry,role: "delievry",):index.toLowerCase() == "moderators"?modwidget( listuser: listmoderateur,role: "Moderator",):index.toLowerCase() == "colors"?ColorsScreen():index.toLowerCase() == "category"?categoriescreen():index.toLowerCase() == "sizes"?SizeScreen(): Clientwidget(listuser: listclients,role: "Customer"),    );
  }
}
class DashboardWidgets extends StatefulWidget {
  
  DashboardWidgets({Key? key}) : super(key: key);

  @override
  _DashboardWidgetsState createState() => _DashboardWidgetsState();
}

class _DashboardWidgetsState extends State<DashboardWidgets> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        StatusList(),
          
        SizedBox(
          height: componentPadding,
        ),
        OrderTable(),
      ],
    );
  }
}
