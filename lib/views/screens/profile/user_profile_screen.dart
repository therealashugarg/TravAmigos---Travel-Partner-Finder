// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travelamigos/views/screens/profile/edit_profile.dart';
import 'package:travelamigos/views/widgets/widgets.dart';

class UserProfileScreen extends StatelessWidget {
  UserProfileScreen({super.key});
  final name = "Ashu";
  final username = "ashug.io";
  final connections = 999;
  final age = 20;
  final uploads = 50;
  final referances = 24;
  final location = "Chandigarh, India";
  var top = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            color: Colors.white,
            child: Stack(
              children: [
                Container(
                  width: Get.width,
                  height: 350,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(38.0)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(38.0),
                    child: Image.asset(
                      'assets/images/banner1.png',
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
                Container(
                  height: 400.0,
                  color: Colors.transparent,
                  child: Column(
                    children: [
                      Container(
                        width: Get.width,
                        height: 350.0,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(38.0),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black12,
                              offset: Offset(0, 6),
                              blurRadius: 12,
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Spacer(),
                            CircleAvatar(
                              radius: 50.0,
                              backgroundImage:
                                  AssetImage('assets/images/profile.png'),
                            ),
                            SizedBox(height: 20),
                            Text(
                              name + ", " + age.toString(),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 32,
                                  fontWeight: FontWeight.w700),
                            ),
                            SizedBox(height: 10),
                            Text(
                              username,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500),
                            ),
                            SizedBox(height: 30),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/icons/location.png',
                                  height: 13,
                                  color: Colors.white,
                                ),
                                SizedBox(width: 5),
                                Text(
                                  location,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                            Spacer(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    SizedBox(
                      height: 320,
                    ),
                    Container(
                      height: 60.0,
                      margin: const EdgeInsets.symmetric(
                        horizontal: 60.0,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50.0),
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            offset: Offset(0, 6),
                            blurRadius: 12,
                          )
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            onTap: (() {
                              Get.to(EditProfilePage());
                            }),
                            child: Container(
                              child: Row(
                                children: [
                                  Text(
                                    'Message',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Image.asset('assets/icons/chat.png',
                                      height: 20)
                                ],
                              ),
                            ),
                          ),
                          Container(
                            child: Row(
                              children: [
                                Text(
                                  'Connect',
                                  style: TextStyle(fontSize: 16),
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Image.asset('assets/icons/add.png', height: 20)
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              MyBox(text1: connections.toString(), text2: 'Connections'),
              MyBox(text1: uploads.toString(), text2: 'Uploads'),
              MyBox(text1: referances.toString(), text2: 'Referances')
            ],
          )
        ],
      ),
    );
  }
}
