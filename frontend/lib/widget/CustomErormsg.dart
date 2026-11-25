import 'package:flutter/material.dart';

class Customerrormsg extends StatelessWidget {
  final Color bgcolor;
  final String message;
  final IconData icon;

  Customerrormsg({required this.icon,required this.message,required this.bgcolor});

  @override
  Widget build(BuildContext context) {
    return

      Container(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        height: 48.0,
        decoration: BoxDecoration(
          color: bgcolor,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: Colors.white,
            ),
            SizedBox(width: 8.0),
            Flexible(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  message,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      );

  }
}
