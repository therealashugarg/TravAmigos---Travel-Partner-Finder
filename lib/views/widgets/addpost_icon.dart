import 'package:flutter/material.dart';

class AddPost extends StatelessWidget {
  const AddPost({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 30,
      height: 26,
      child: Stack(
        children: [
          
          Center(
            child: Container(
              height: double.infinity,
              width: 38,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(7),
                border: Border.all(width: 2)
              ),
              child: const Icon(
                Icons.add,
                color: Colors.black,
                size: 20,
              ),
            ),
          )
        ],
      ),
    );
  }
}