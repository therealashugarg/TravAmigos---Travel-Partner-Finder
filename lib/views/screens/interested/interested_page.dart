// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:travelamigos/controllers/auth_controller.dart';

class InterestedPage extends StatelessWidget {
  const InterestedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Interested Page',
              style: TextStyle(fontSize: 30),
            ),
            SizedBox(height: 30),
            Center(
                child: ElevatedButton(
              onPressed: () {
                AuthController.instance.logOut();
              },
              child: Text("Logout"),
            )),
          ],
        )
    );
  }
}