import 'package:bridgewearaa/Webpart/model.dart';
import 'package:bridgewearaa/Webpart/widgets/status_card.dart';
import 'package:bridgewearaa/controlleur/commandcontrolleur.dart';
import 'package:bridgewearaa/controlleur/usercontrolleur.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../constaints.dart';



class StatusList extends StatefulWidget {
  @override
  _StatusListState createState() => _StatusListState();
}

class _StatusListState extends State<StatusList> {
  double totalselling=0;
    double totalprofit=0;
    int numberorder=0;
        int numberorderfinished=0;
    int numberorderw=0;
    int numberorderond=0;
    int numberordercancel=0;

    int numbercustomer=0;
    int numbermoderator=0;
    int numberlivreur=0;
    int numberusers=0;
  int index=0;
     List<BussinessStatus> total = [

];
List<BussinessStatus> Users = [

];
List<BussinessStatus> Orders = [

];
bool loading=false;
  getdata(Function fn)async{
              totalselling=await gettotalselling("token")??0;
                            totalprofit=await gettottalprofit("token")??0;
                            numberorder=await getnmuberorders("all")??0;
                            numberusers=await getnmbruserbyrole("all");
                            numbercustomer=await getnmbruserbyrole("client");
                            numberlivreur=await getnmbruserbyrole("Livreur");
                            numbermoderator=await getnmbruserbyrole("Moderator");
                                  numberorderfinished=await getnmuberorders("Finished");
                            numberorderond=await getnmuberorders("On delievry");
                            numberorderw=await getnmuberorders("Waiting Confirmation");

                            numberordercancel=await getnmuberorders("Canceled");
                            fn();

    setState(() {

      total=[
    BussinessStatus('Total Sales',totalselling.toString()+ ' \DT', Icons.show_chart_outlined),
  BussinessStatus('Total Profit', totalprofit.toString()+' \DT', Icons.money),
  BussinessStatus('Orders', numberorder.toString(), Icons.shopping_cart_outlined),


];
Users=[
    BussinessStatus('Users', numberusers.toString(), Icons.people_outline_outlined),
        BussinessStatus('Customers', numbercustomer.toString(), Icons.account_circle),

    BussinessStatus('Moderator', numbermoderator.toString(), Icons.emoji_people_outlined),
  BussinessStatus('Delievry', numberlivreur.toString(), Icons.delivery_dining_sharp),
];
Orders=[
    BussinessStatus('total Orders', numberorder.toString(), Icons.shopping_cart_outlined),
    BussinessStatus(' Finished', numberorderfinished.toString(), Icons.check_box),
    BussinessStatus(' Waithing Confirmation', numberorderw.toString(), Icons.published_with_changes_rounded),
    BussinessStatus(' On Delievry', numberorderond.toString(), Icons.delivery_dining),
    BussinessStatus(' Cancelled ', numberordercancel.toString(), Icons.remove_shopping_cart_outlined),

];
    });

  }

 @override
  void initState() {
    super.initState();
getdata((){
  setState(() {
    loading=true;
  });
});
  }
  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    return Column(
      children: [
        Row( 
          children: [
            InkWell(
              onTap: (){
                setState(() {
                                  index=0;

                });
              },
              child: Text(
                'Total',
                style: TextStyle(
                  fontSize: 16,
                                    fontWeight: index==0?FontWeight.bold:null,
            
                ),
              ),
            ),
            SizedBox(width: 14),
    InkWell(
              onTap: (){
   setState(() {
                                  index=1;

                });              },              child: Text('Users',
                  style: TextStyle(
                    fontSize: 16,
                                                        fontWeight: index==1?FontWeight.bold:null,

                  )),
            ),
            SizedBox(
              width: 14,
            ),
    InkWell(
              onTap: (){
   setState(() {
                                  index=2;

                });              },              child: Text('Orders',
                  style: TextStyle(
                    fontSize: 16,
                                                        fontWeight: index==2?FontWeight.bold:null,

                  )),
            ),
          ],
        ),
        SizedBox(
          height: componentPadding,
        ),
        index==0?
        StaggeredGridView.countBuilder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            crossAxisCount: 3,
            mainAxisSpacing: componentPadding,
            crossAxisSpacing: componentPadding,
            itemCount: total.length,
            itemBuilder: (context, index) => StatusCard(total[index]),
            staggeredTileBuilder: (index) {
              if (_size.width > screenXxl) return StaggeredTile.fit(1);
              if (_size.width > screenSm) return StaggeredTile.fit(2);
              return StaggeredTile.fit(4);
            }):index==1?
                  StaggeredGridView.countBuilder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            crossAxisCount: 3,
            mainAxisSpacing: componentPadding,
            crossAxisSpacing: componentPadding,
            itemCount: Users.length,
            itemBuilder: (context, index) => StatusCard(Users[index]),
            staggeredTileBuilder: (index) {
              if (_size.width > screenXxl) return StaggeredTile.fit(1);
              if (_size.width > screenSm) return StaggeredTile.fit(2);
              return StaggeredTile.fit(4);
            }) :
                  StaggeredGridView.countBuilder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            crossAxisCount: 3,
            mainAxisSpacing: componentPadding,
            crossAxisSpacing: componentPadding,
            itemCount: Orders.length,
            itemBuilder: (context, index) => StatusCard(Orders[index]),
            staggeredTileBuilder: (index) {
              if (_size.width > screenXxl) return StaggeredTile.fit(1);
              if (_size.width > screenSm) return StaggeredTile.fit(2);
              return StaggeredTile.fit(4);
            }) 
            ,


            CircularProgressIndicator()
            ],
    );
  }
}
