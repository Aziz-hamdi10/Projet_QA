import 'package:flutter/material.dart';
import 'package:bridgewearaa/Webpart/components/orders_list.dart';

class NewsPage extends StatelessWidget {
  final String iduser;
  const NewsPage({Key? key,required this.iduser}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: orderList(iduser: iduser),
    );
  }
}
