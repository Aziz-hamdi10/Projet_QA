import 'package:flutter/material.dart';
class loading extends StatelessWidget {
  const loading({super.key});

  @override
  Widget build(BuildContext context) {
    LinearGradient gradient = LinearGradient(
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
      colors: [Color.fromRGBO(4, 204,217, 1.0), Color.fromRGBO(4, 97, 103, 0.89)],
    );
    return Scaffold(

      body:  Container(
        decoration: BoxDecoration(
        gradient: gradient,
          // Apply the linear gradient to the background
    ),
        child: Center(
          child: Image(
            image: AssetImage('images/BridgeWear5.png'),
          ),
        ),
    )
    );
  }
}
