import 'package:flutter/material.dart';

class MyBox extends StatelessWidget {
  String text1;
  String text2;

  MyBox({required this.text1, required this.text2});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        // height: 70,
        width: 100,
        child: Column(
          children: [
            Text(
              text1,
              style: TextStyle(color: Color(0XFF8F909F), fontSize: 10),
            ),
            SizedBox(height: 5),
            Text(
              text2,
              style: TextStyle(color: Color(0XFF0C1739), fontSize: 7),
            ),
          ],
        ),
      ),
    );
  }
}
