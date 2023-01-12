// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, must_be_immutable

import 'package:expandable/expandable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travelamigos/main.dart';
import 'package:travelamigos/views/screens/profile/edit_profile.dart';
import 'package:travelamigos/views/widgets/widgets.dart';

class MyProfileScreen extends StatelessWidget {
  String name = '';
  String username = '';
  int connections = 0;
  String age = '';
  int uploads = 0;
  int referances = 0;
  String location = '';
  String about = '';
  String profilephoto = '';

  @override
  Widget build(BuildContext context) {
    // Get.put<UserController>(UserController());
    return DefaultTabController(
        length: 3,
        child: Scaffold(
            body: FutureBuilder(
          future: _fetchUserData(),
          builder: ((context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return Center(child: CircularProgressIndicator());
            }
            return Column(children: [
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
                                        NetworkImage(profilephoto)),
                                SizedBox(height: 20),
                                Text("$name," " ${age.toString()}",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 32,
                                        fontWeight: FontWeight.w700)),
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
                    Column(
                      children: [
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
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Edit Profile',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  SizedBox(width: 12),
                                  Image.asset('assets/icons/editprofile.png',
                                      height: 20)
                                ]),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              ExpandableNotifier(
                  child: Expandable(
                      collapsed: ExpandableButton(
                          child: Container(
                              // margin: EdgeInsets.symmetric(horizontal: 20),
                              width: MediaQuery.of(context).size.width,
                              padding: EdgeInsets.symmetric(vertical: 15),
                              color: Colors.white,
                              child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 40),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                            height: 20,
                                            child: Image.asset(
                                              'assets/icons/about.png',
                                            )),
                                        Text('User Info',
                                            style: TextStyle(
                                                fontSize: 17,
                                                fontWeight: FontWeight.bold)),
                                        SizedBox(
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
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 30),
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(
                                              height: 20,
                                              child: Image.asset(
                                                  'assets/icons/about.png',
                                                  color: Colors.white)),
                                          Text('Back',
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.white)),
                                          SizedBox(
                                              height: 20,
                                              child: Image.asset(
                                                  'assets/icons/up-arrow.png',
                                                  color: Colors.black87))
                                        ]))))
                      ]))),
              SizedBox(height: 20),
              TabBar(tabs: [
                Tab(
                  child: MyBox(
                      text1: connections.toString(), text2: 'Connections'),
                ),
                Tab(
                  child: MyBox(text1: uploads.toString(), text2: 'Uploads'),
                ),
                Tab(
                    child: MyBox(
                        text1: referances.toString(), text2: 'Referances'))
              ]),
            ]);
          }),
        )));
  }

  _fetchUserData() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser!.uid)
        .get()
        .then((ds) {
      if (ds.get('name') != null) {
        name = ds.get('name');
      }
      if (ds.get('age') != null) {
        age = ds.get('age');
      }
      if (ds.get('username') != null) {
        username = ds.get('username');
      }
      if (ds.get('about') != null) {
        about = ds.get('about');
      }
      if (ds.get('location') != null) {
        location = ds.get('location');
      }
      if (ds.get('connections') != null) {
        connections = ds.get('connections');
      }
      if (ds.get('uploads') != null) {
        uploads = ds.get('uploads');
      }
      if (ds.get('referances') != null) {
        referances = ds.get('referances');
      }
      if (ds.get('profilephoto') != null) {
        profilephoto = ds.get('profilephoto');
      }
      if (ds.get('uploads') != null) {
        uploads = ds.get('uploads');
      }
      if (ds.get('referances') != null) {
        referances = ds.get('referances');
      }
    });
  }
}
