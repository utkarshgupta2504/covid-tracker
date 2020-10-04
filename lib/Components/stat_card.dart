import 'package:flutter/material.dart';

class StatCard extends StatelessWidget {
  StatCard({this.title, this.value, this.increment, this.textColor});

  final String title;
  final String value;
  final String increment;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color(0x00202022),
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            Text(
              title,
              style: TextStyle(
                color: textColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              increment[0] == '-' ? increment : '+' + increment,
              style: TextStyle(
                color: Color(textColor.value - 0x55000000),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              value,
              style: TextStyle(
                color: textColor,
                fontWeight: FontWeight.w900,
                fontSize: 25.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
