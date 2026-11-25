import 'package:bridgewearaa/Webpart/constaints.dart';
import 'package:bridgewearaa/Webpart/widgets/bar_chart.dart';
import 'package:bridgewearaa/Webpart/widgets/pie_chart.dart';
import 'package:bridgewearaa/controlleur/commandcontrolleur.dart';
import 'package:flutter/material.dart';
List<Color> predefinedColors = [
  Colors.green,
  Colors.blue,
  Colors.yellow,
  Colors.orange,
  Colors.purple,
  Colors.teal,
  Colors.pink,
  Colors.cyan,
  Colors.indigo,
  Colors.brown,
  Colors.amber,
  Colors.lime,
  Colors.deepOrange,
  Colors.lightBlue,
  Colors.deepPurple,
  Colors.lightGreen,
  Colors.blueGrey,
  Colors.grey,
    Colors.red,

];
class Charts extends StatefulWidget {
   final List<double> data; 
  final List<String> labels; 
  final List<String> titles; 

  const Charts({
    Key? key,
    required this.data,
    required this.labels,
    required this.titles,
  }) : super(key: key);

  @override
  _ChartsState createState() => _ChartsState();
}

class _ChartsState extends State<Charts> {
  
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    if (_size.width >= screenLg) {
      return Row(
        children: [
          Flexible(
            flex: 1,
            child: BarChartSample(
         titles: widget.titles,
labels: widget.labels,
data: widget.data,            ),
          ),
          SizedBox(
            width: componentPadding,
          ),
          Flexible(
            flex: 1,
            child: Column(
              children: [
                MyPieChart(  titles: widget.titles,
labels: widget.labels,
data: widget.data,     ),
  Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(

          child: Padding(
            padding: const EdgeInsets.all(0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children:  List.generate(widget.data.length-1, (index) {
                              return       Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                    width: 22,
                                    height: 22,
                                    decoration: BoxDecoration(
                                        color: predefinedColors[index],
                                        borderRadius: BorderRadius.circular(50))),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  widget.data[index+1].toString(),
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w600,
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              widget.labels[index+1],
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        )
                    ;
                             }),
                             ),
    )),
  )
              ],
            ),
          ),
        ],
      );
    }

    return Column(
      children: [
        BarChartSample(
         titles: widget.titles,
labels: widget.labels,
data: widget.data,          ),
        SizedBox(
          height: componentPadding,
        ),
  Flexible(
            flex: 1,
            child: MyPieChart(  titles: widget.titles,
labels: widget.labels,
data: widget.data,     ),
          ),      ],
    );
  }
}
