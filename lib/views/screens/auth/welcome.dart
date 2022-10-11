// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travelamigos/main.dart';
import 'package:travelamigos/views/screens/auth/login.dart';
import 'package:travelamigos/views/screens/auth/register.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: SafeArea(
            child: Padding(
                padding: EdgeInsets.symmetric(vertical: 24, horizontal: 32),
                child: Column(children: [
                  Image.asset('assets/images/welcome.png', width: 360),
                  SizedBox(height: 28),
                  Text("TravAmigo",
                      style:
                          TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                  SizedBox(height: 38),
                  SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () {
                            Get.to(Register());
                          },
                          style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Color(0XFFA56FF8)),
                              elevation:
                                  MaterialStateProperty.resolveWith<double>(
                                (Set<MaterialState> states) {
                                  if (states.contains(MaterialState.disabled)) {
                                    return 0;
                                  }
                                  return 0;
                                },
                              ),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      side: BorderSide(
                                          width: 2, color: Color(0XFFA56FF8)),
                                      borderRadius:
                                          BorderRadius.circular(40.0)))),
                          child: Padding(
                              padding: EdgeInsets.all(22.0),
                              child: Text('Create Account',
                                  style: TextStyle(fontSize: 18))))),
                  SizedBox(height: 22),
                  SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () {
                            Get.to(LoginPage());
                          },
                          style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  Color(0XFFA56FF8)),
                              elevation:
                                  MaterialStateProperty.resolveWith<double>(
                                (Set<MaterialState> states) {
                                  if (states.contains(MaterialState.disabled)) {
                                    return 0;
                                  }
                                  return 0;
                                },
                              ),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      side: BorderSide(
                                          width: 2, color: Color(0XFFA56FF8)),
                                      borderRadius:
                                          BorderRadius.circular(40.0)))),
                          child: Padding(
                              padding: EdgeInsets.all(24.0),
                              child: Text('Login',
                                  style: TextStyle(
                                      color: Color(0XFFA56FF8),
                                      fontSize: 18))))),
                  Spacer(),
                  Container(
                    width: 280,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'By Signing up, you agree to the ',
                              style: TextStyle(fontSize: 12),
                            ),
                            GestureDetector(
                                onTap: (() {}),
                                child: Text('Terms of use &',
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Color(0XFFA56FF8))))
                          ],
                        ),
                        SizedBox(height: 5),
                        GestureDetector(
                          onTap: (() {
                            
                          }),
                          child: Text('privacy policy',
                              style: TextStyle(
                                  fontSize: 12, color: Color(0XFFA56FF8))),
                        )
                      ],
                    ),
                  )
                ]))));
  }
}
