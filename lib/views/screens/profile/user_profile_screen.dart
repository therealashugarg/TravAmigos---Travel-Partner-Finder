// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travelamigos/main.dart';
import 'package:travelamigos/views/screens/profile/edit_profile.dart';
import 'package:travelamigos/views/widgets/widgets.dart';

class UserProfileScreen extends StatefulWidget {
  final String uid;
  const UserProfileScreen({super.key, required this.uid});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  var userData = {};
  var uploads = 0;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    try {
      var userSnap = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.uid)
          .get();

      // get post length
      var postSnap = await FirebaseFirestore.instance
          .collection('posts')
          .where('uid',
              isEqualTo: FirebaseFirestore.instance
                  .collection('users')
                  .doc(widget.uid))
          .get();
      // get plan length
      var planSnap = await FirebaseFirestore.instance
          .collection('plans')
          .where('uid', isEqualTo: userSnap.data()!['uid']).get(),
      uploads = postSnap.docs.length + planSnap.docs.length;
      userData = userSnap.data()!;
      setState(() {});
    } catch (e) {
      Get.snackbar(
        '',
        e.toString(),
      );
    }
  }

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
                      color: Palette.kToDark,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(45),
                          bottomRight: Radius.circular(45))),
                  // child: ClipRRect(
                  //     borderRadius: BorderRadius.circular(38.0),
                  //     child: Image.asset('assets/images/banner1.png',
                  //         fit: BoxFit.fitHeight))
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
                                  NetworkImage(userData['profilephoto']),
                            ),
                            SizedBox(height: 20),
                            Text(
                              userData['name'] + ", " + userData['age'],
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 32,
                                  fontWeight: FontWeight.w700),
                            ),
                            SizedBox(height: 10),
                            Text(
                              userData['username'],
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
                                  userData['location'],
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
                            child: Row(
                              children: [
                                Text(
                                  'Message',
                                  style: TextStyle(fontSize: 16),
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Image.asset('assets/icons/chat.png', height: 20)
                              ],
                            ),
                          ),
                          Row(
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
              MyBox(
                  text1: userData['connections'].toString(),
                  text2: 'Connections'),
              MyBox(text1: uploads.toString(), text2: 'Uploads'),
              MyBox(
                  text1: userData['referances'].toString(), text2: 'Referances')
            ],
          )
        ],
      ),
    );
  }
}
