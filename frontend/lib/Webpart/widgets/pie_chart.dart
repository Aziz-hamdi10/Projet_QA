import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:bridgewearaa/Webpart/constaints.dart';
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
class MyPieChart extends StatelessWidget {
     final List<double> data; 
  final List<String> labels; 
  final List<String> titles; 

  const MyPieChart({
    Key? key,
    required this.data,
    required this.labels,
    required this.titles,
  }) : super(key: key);


List<PieChartSectionData> getChartSections(BuildContext context, double radius) {
    return List.generate(data.length-1, (index) {
      double value = data[index+1];
      int percentage = (value * 100 / data[0]).round();   

      return PieChartSectionData(
        color: predefinedColors[index],
        value: value,
                title: '$percentage%', 

        radius: radius,
        titleStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        showTitle: true,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    return AspectRatio(
      aspectRatio: 1.5,
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: primary),
            borderRadius: BorderRadius.circular(18)),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Stack(
            children: [
              PieChart(
                PieChartData(
                    sections: getChartSections(
                        context, _size.width >= screenMd ? 40 : 20),
                    startDegreeOffset: 360),
              ),
           
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                                width: 22,
                                height: 22,
                                decoration: BoxDecoration(
                                    color: Color(0xffCCECDF),
                                    borderRadius: BorderRadius.circular(50))),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              data[0].toString(),
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
                          'Total',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                        
                       
                ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
