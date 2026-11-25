import 'package:bridgewearaa/Webpart/pages/userscreen.dart';
import 'package:bridgewearaa/Webpart/pages/usersscreen.dart';
import 'package:bridgewearaa/config.dart';
import 'package:bridgewearaa/controlleur/usercontrolleur.dart';
import 'package:bridgewearaa/models/user.dart';
import 'package:bridgewearaa/widget/CustomConfirmation.dart';
import 'package:bridgewearaa/widget/CustomErormsg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class tableau extends StatefulWidget {
  final String role;
  final List<User> listuser;
  const tableau({Key? key,required this.listuser,required this.role}) : super(key: key);

  @override
  State<tableau> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<tableau> {
     List<User> listfiltred=[];
     TextEditingController searchController=TextEditingController();
List<User> fitreruser(List<User> listuser,String name) {
  if(name.isNotEmpty)
    {
      return listuser.where((user) {
        return user.firstname.toLowerCase().contains(name.toLowerCase())||user.secondname.toLowerCase().contains(name.toLowerCase())||user.email.toLowerCase().contains(name.toLowerCase());
      }).toList();
    }
  else{
    return listuser;
  }

}
    void _search(){
    setState(() {
      listfiltred=widget.listuser;
      listfiltred=fitreruser(listfiltred,searchController.text);


 
      }

    );

  }

  bool isExpanded = false;
  @override
  void initState() {
    super.initState();
  
    _search();
  }
  @override
  Widget build(BuildContext context) {
        MediaQueryData mediaQueryData = MediaQuery.of(context);
    double screenWidth = mediaQueryData.size.width;
    double screenHeight = mediaQueryData.size.height;
   
 if(screenHeight<screenWidth){
           screenWidth = mediaQueryData.size.height;
     screenHeight = mediaQueryData.size.width;

    }
      double fontSize = MediaQuery.of(context).size.shortestSide * 0.05;
    double marginValue = screenWidth * 0.02;
     
    return Scaffold(
      body: Row(
        children: [
     Expanded(
            child: Padding(
              padding: EdgeInsets.all(marginValue),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
             
               
              
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text(
                              widget.listuser.length.toString()+" "+widget.role,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 28.0,
                              ),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                        ],
                        ),
                     
                      ],
                    ),
                   

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if(widget.role.toLowerCase()!="customer")
                    FloatingActionButton(
        onPressed: () {
                  showDialog(
  context: context,
  builder: (BuildContext context) {
    return AlertDialog(
      title: Text("Add " + widget.role,style: TextStyle(fontSize:fontSize ,fontWeight: FontWeight.bold),),
      content: adduserwidget(changed: (u){
setState(() {
  listfiltred.add(u);
});

      },role: widget.role)
     
    );
  },
);
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.deepPurple.shade400,

      ),
             Row(
                          children: [
                               Container(
                          width: screenWidth*0.3,
                          child: TextField(
                            controller: searchController,
                                       onChanged: (value) {
                              setState(() {
_search();
                              });
                            },
                            decoration: InputDecoration(
                              hintText: "Search",
                              prefixIcon: Icon(Icons.search),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black26,
                                ),
                              ),
                            ),
                          ),
                        ),
                 
                      ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height:screenHeight*0.01,
                    ),
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
                    DataColumn(label: Text("Picture")),
                    DataColumn(label: Text("Email")),
                    DataColumn(label: Text("First Name")),
                    DataColumn(label: Text("Last Name")),
                    DataColumn(label: Text("role")),
                    DataColumn(label: Text("State")),
                    DataColumn(label: Text("")),

                  ],
                  rows: List<DataRow>.generate(
                    listfiltred.length,
                    (index) => DataRow(
                      cells: [
                        DataCell(
                          InkWell(
                            onTap: (){
                                     showDialog(
               context: context,
  builder: (BuildContext context) {
    return AlertDialog(
      content: Container(
      width: screenWidth*0.9,
        child: userscren(user: listfiltred[index].id)),
     
    );
  },
);
                            },
                            child: Container(
                              width: screenWidth * 0.05,
                              height: screenWidth * 0.05,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: ClipOval(
                                child: listfiltred[index]
                                        .picture
                                        .toLowerCase()
                                        .endsWith('.svg+xml')
                                    ? SvgPicture.network(
                                        url+'/getimage/${listfiltred[index].picture}',
                                        fit: BoxFit.cover,
                                        placeholderBuilder: (BuildContext context) =>
                                            CircularProgressIndicator(),
                                      )
                                    : Image.network(
                                        url+'/getimage/${listfiltred[index].picture}',
                                        fit: BoxFit.cover,
                                      ),
                              ),
                            ),
                          ),
                        ),
                        DataCell(Text(listfiltred[index].email)),
                        DataCell(Text(listfiltred[index].firstname)),
                        DataCell(Text(listfiltred[index].secondname)),
                        DataCell(Text(listfiltred[index].role)),
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
                                                DataCell(Row(
                                                  children: [
                                                    InkWell(child: Icon(Icons.delete,color: Colors.red,),
                                                    onTap: (){
                                                   
                            customconfimation(context, 'Delete Product ?', 'Are you sure you want to delete this User?', () {
                                   deleteuser((msg, Color,icon) => {
 setState(() {
                      widget.listuser.remove(widget.listuser[index]);
                    }),
                    Navigator.pop(context),
                ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  backgroundColor: Color,
                  content: Customerrormsg(icon: icon,
                    message: msg,bgcolor: Color,)
              ))
            }, widget.listuser[index].id);
                                      }
                                       ,Colors.red);
                   
                  
                                                    },
                                                    ),
                                                    if(widget.listuser[index].etat.toLowerCase()!="active")
                                                    InkWell(
                                                        onTap: (){
                                                           customconfimation(context, 'Active User ?', 'Are you sure you want to Active this User?', () {
   modifyuserid(listfiltred[index].id, "Active", (msg, cl, icon) => {
              setState(() {
                      listfiltred[index].etat="Active";
                    }),
                    Navigator.pop(context),
               ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    backgroundColor: cl,
                    content: Customerrormsg(icon: icon,
                      message: msg,bgcolor: cl,)
                ))

        });

                                                           },Colors.green);
                                                      },
                                                      child: Icon(Icons.arrow_upward,color: Colors.green,)),
                                                     if(widget.listuser[index].etat.toLowerCase()!="blocked")

                                                    InkWell(
                                                      onTap: (){
                                                           customconfimation(context, 'Block User ?', 'Are you sure you want to Block this User?', (
                                                           ){
 modifyuserid(listfiltred[index].id, "Blocked", (msg, cl, icon) => {
              setState(() {
                      listfiltred[index].etat="Blocked";
                    }),
                    Navigator.pop(context),
               ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    backgroundColor: cl,
                    content: Customerrormsg(icon: icon,
                      message: msg,bgcolor: cl,)
                ))

        });

                                                           },Colors.red);
                                                      },
                                                      child: Icon(Icons.block,color: Colors.grey,)),
   if(widget.listuser[index].etat.toLowerCase()!="notactive")

                                                    InkWell(
                                                      onTap: (){
                                                           customconfimation(context, 'disable User ?', 'Are you sure you want to disable this User?', () {
 modifyuserid(listfiltred[index].id, "notactive", (msg, cl, icon) => {
              setState(() {
                      listfiltred[index].etat="notactive";
                    }),
                    Navigator.pop(context),
               ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    backgroundColor: cl,
                    content: Customerrormsg(icon: icon,
                      message: msg,bgcolor: cl,)
                ))

        });

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
                ),
              ),
            ),
          ),
        ],
      ),
   
    );
  }
}
Color getcolor(String etat) {
  switch (etat.toLowerCase()) {
    case 'notactive':
      return Colors.grey;
    case 'not valide':
      return Colors.grey;
    case 'blocked':
      return Colors.red;
    case 'No livreur':
      return Color.fromRGBO(254, 186, 11, 1);
    case 'traitement':
      return Color.fromRGBO(254, 186, 11, 1);
    case 'Tocken':
      return Color.fromRGBO(204, 221, 8, 1);
    default:
      return Colors.green;
  }
}