// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travelamigos/controllers/auth_controller.dart';
import 'package:travelamigos/controllers/user_controller.dart';
import 'package:travelamigos/main.dart';
import 'package:travelamigos/views/screens/profile/edit_profile.dart';
import 'package:travelamigos/views/widgets/widgets.dart';

class MyProfileScreen extends GetWidget<AuthController> {
  final String uid;
  MyProfileScreen({super.key, required this.uid,});
  // final name = "Ashu";
  final username = "ashug.io";
  final connections = 999;
  final age = 20;
  final uploads = 50;
  final referances = 24;
  final location = "Chandigarh, India";
  var about =
      'Hey, I am Ashu Garg an engineer by profession and a traveller by passion. I am travelling since last 3 years and explored lots of different states and their culture and tradition';

  @override
  Widget build(BuildContext context) {
    Get.put<UserController>(UserController());
    return DefaultTabController(
        length: 3,
        child: Scaffold(
            body: Column(children: [
          Container(
              color: Colors.white,
              child: Stack(children: [
                Container(
                  width: Get.width,
                  height: 350,
                  decoration: BoxDecoration(
                      color: Palette.kToDark,
                      borderRadius: BorderRadius.circular(45.0)),
                  // child: ClipRRect(
                  //     borderRadius: BorderRadius.circular(38.0),
                  //     child: Image.asset('assets/images/banner1.png',
                  //         fit: BoxFit.fitHeight))
                ),
                Container(
                    height: 400.0,
                    color: Colors.transparent,
                    child: Column(children: [
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
                                    blurRadius: 12)
                              ]),
                          child: Column(children: <Widget>[
                            Spacer(),
                            CircleAvatar(
                                radius: 50.0,
                                backgroundImage:
                                    AssetImage('assets/image/2.jpg')),
                            SizedBox(height: 20),
                            GetX<UserController>(
                              builder: (_) {
                                return Text(
                                    "${_.user.name} " " ${age.toString()}",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 32,
                                        fontWeight: FontWeight.w700));
                              },
                            ),
                            SizedBox(height: 10),
                            Text(username,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500)),
                            SizedBox(height: 30),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset('assets/icons/location.png',
                                      height: 13, color: Colors.white),
                                  SizedBox(width: 5),
                                  Text(location,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500))
                                ]),
                            Spacer()
                          ]))
                    ])),
                Column(children: [
                  SizedBox(height: 320),
                  Container(
                      height: 60.0,
                      margin: const EdgeInsets.symmetric(horizontal: 120.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50.0),
                          color: Colors.white,
                          boxShadow: const [
                            BoxShadow(
                                color: Colors.black12,
                                offset: Offset(0, 6),
                                blurRadius: 12)
                          ]),
                      child: GestureDetector(
                          onTap: (() {
                            Get.to(EditProfilePage());
                          }),
                          child: Container(
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                Text('Edit Profile',
                                    style: TextStyle(fontSize: 16)),
                                SizedBox(width: 12),
                                Image.asset('assets/icons/editprofile.png',
                                    height: 20)
                              ]))))
                ])
              ])),
          ExpandableNotifier(
              child: Expandable(
                  collapsed: ExpandableButton(
                      child: Container(
                          // margin: EdgeInsets.symmetric(horizontal: 20),
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.symmetric(vertical: 15),
                          color: Colors.white,
                          child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 40),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                        height: 20,
                                        child: Image.asset(
                                          'assets/icons/about.png',
                                        )),
                                    Text('User Info',
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold)),
                                    Container(
                                        height: 20,
                                        child: Image.asset(
                                            'assets/icons/down-arrow.png',
                                            color: Colors.black87))
                                  ])))),
                  expanded: Column(children: [
                    SizedBox(height: 15),
                    Text('About',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 28, vertical: 14),
                        child: Text(about,
                            style: TextStyle(
                                fontSize: 15, color: Colors.grey[500]))),
                    ExpandableButton(
                        child: Container(
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.symmetric(vertical: 15),
                            color: Colors.white,
                            child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 30),
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                          height: 20,
                                          child: Image.asset(
                                              'assets/icons/about.png',
                                              color: Colors.white)),
                                      Text('Back',
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.white)),
                                      Container(
                                          height: 20,
                                          child: Image.asset(
                                              'assets/icons/up-arrow.png',
                                              color: Colors.black87))
                                    ]))))
                  ]))),
          SizedBox(height: 20),
          TabBar(tabs: [
            Tab(
              child: MyBox(text1: connections.toString(), text2: 'Connections'),
            ),
            Tab(
              child: MyBox(text1: uploads.toString(), text2: 'Uploads'),
            ),
            Tab(child: MyBox(text1: referances.toString(), text2: 'Referances'))
          ]),
        ])));
  }
}
