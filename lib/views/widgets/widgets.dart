import 'package:flutter/material.dart';

class MyBox extends StatelessWidget {
  String text1;
  String text2;

  MyBox({super.key, required this.text1, required this.text2});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: 70,
      width: 100,
      child: Column(
        children: [
          Text(
            text1,
            style: const TextStyle(color: Color(0XFF8F909F), fontSize: 15),
          ),
          const SizedBox(height: 5),
          Text(
            text2,
            style: const TextStyle(color: Color(0XFF0C1739), fontSize: 10),
          ),
        ],
      ),
    );
  }
}
