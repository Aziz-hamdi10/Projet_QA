
import 'package:bridgewearaa/services/data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomCategoriesList extends StatefulWidget {
  final Function change;

   CustomCategoriesList({Key? key,required this.change}) : super(key: key);

  @override
  State<CustomCategoriesList> createState() => _CustomCategoriesListState();
}

class _CustomCategoriesListState extends State<CustomCategoriesList> {
  int _index = 0;
  @override
  Widget build(BuildContext context) {

    MediaQueryData mediaQueryData = MediaQuery.of(context);
    double screenWidth = mediaQueryData.size.width;
    double screenHeight = mediaQueryData.size.height;
    double fontSize = MediaQuery.of(context).size.shortestSide * 0.05;
    double marginValue = MediaQuery.of(context).size.width * 0.02;
    List<String>listcategorie=['All','Men','Women','Kids'];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("Categorie",style: TextStyle(fontSize: fontSize,fontWeight: FontWeight.bold),),

        ),
        Row(
          children: [
            Wrap(
              children: List.generate(listcategorie.length, (index) {
                return        menuButton(

                    onTap: () {
                      setState(() {
                        _index = index;
                        this.widget.change(listcategorie[index]);
                      });
                    },
                    color: context.read<DataService>().Categorie.toLowerCase()==listcategorie[index].toLowerCase()? Colors.blueAccent : Colors.grey.withOpacity(0.5),
                    text: listcategorie[index],
                    textColor: Colors.white,
                    width:    context.read<DataService>().Categorie.toLowerCase()==listcategorie[index].toLowerCase()? screenWidth*0.2 : screenWidth*0.15
                );

              })

              ,
            )



          ],
        ),
      ],
    );
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
}