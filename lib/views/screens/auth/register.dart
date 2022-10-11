// ignore_for_file: prefer_const_constructors

import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travelamigos/constants.dart';
import 'package:travelamigos/controllers/auth_controller.dart';
import 'package:travelamigos/main.dart';
import 'package:travelamigos/views/screens/auth/login.dart';

class Register extends StatelessWidget {
  const Register({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController usernameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    final registerController = Get.put(AuthController());

    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: whiteColor,
        body: SafeArea(
            child: Padding(
          padding: EdgeInsets.symmetric(vertical: 24, horizontal: 32),
          child: Column(
            children: [
              Align(
                  alignment: Alignment.topLeft,
                  child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Icon(Icons.arrow_back,
                          size: 32, color: Colors.black54))),
              SizedBox(height: 18),
              Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                      color: Palette.kToDark.shade200, shape: BoxShape.circle),
                  child: Image.asset('assets/images/illustration-2.png')),
              SizedBox(height: 68),
              Text("Register",
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
              SizedBox(height: 28),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12)),
                child: Column(
                  children: [
                    // username field start
                    TextFormField(
                        controller: usernameController,
                        decoration: InputDecoration(
                            // prefix person icon
                            prefixIcon: Icon(Icons.account_circle_outlined),
                            // field editing
                            hintText: "Username",
                            hintStyle: TextStyle(color: Colors.grey[400]),
                            labelText: "Username",
                            contentPadding: EdgeInsets.only(left: 10),
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20)))),
                    // username field end
                    SizedBox(height: 25),
                    // email field start
                    TextFormField(
                        controller: emailController,
                        decoration: InputDecoration(
                            // prefix email icon
                            prefixIcon: Icon(Icons.alternate_email),
                            // field editing
                            hintText: "Email",
                            hintStyle: TextStyle(color: Colors.grey[400]),
                            labelText: "Email",
                            contentPadding: EdgeInsets.only(left: 10),
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20))),
                        // some keyboard settings
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.done,
                        autofillHints: [AutofillHints.email]),
                    // email field end
                    SizedBox(height: 25),
                    // password field start
                    Obx(() => TextField(
                        controller: passwordController,
                        decoration: InputDecoration(
                            // prefix lock icon
                            prefixIcon: Icon(Icons.https_outlined),
                            // suffix visibility icon
                            suffixIcon: IconButton(
                                icon: registerController.isPasswordHidden.value
                                    ? Icon(Icons.visibility_off)
                                    : Icon(Icons.visibility),
                                onPressed: () {
                                  registerController.isPasswordHidden.value =
                                      !registerController
                                          .isPasswordHidden.value;
                                }),

                            // field editing
                            hintText: "Password",
                            hintStyle: TextStyle(color: Colors.grey[400]),
                            labelText: "Password",
                            contentPadding: EdgeInsets.only(left: 10),
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20))),
                        // password visibility on or off
                        obscureText:
                            registerController.isPasswordHidden.value)),
                    // password field end
                    SizedBox(height: 40),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (usernameController.text.isEmpty  ) {
                            Get.snackbar("About Register", "Register message",
                                backgroundColor: darkPurple.withOpacity(0.4),
                                snackPosition: SnackPosition.BOTTOM,
                                titleText: Text("Register failed",
                                    style: TextStyle(color: whiteColor)),
                                messageText: Text(
                                  "Please enter username",
                                  style: TextStyle(color: whiteColor),
                                ));
                          } else if (emailController.text.trim().isEmpty) {
                            Get.snackbar("About Register", "Register message",
                                backgroundColor: darkPurple.withOpacity(0.4),
                                snackPosition: SnackPosition.BOTTOM,
                                titleText: Text("Register failed",
                                    style: TextStyle(color: whiteColor)),
                                messageText: Text(
                                  "Please enter your email",
                                  style: TextStyle(color: whiteColor),
                                ));
                          } else if (passwordController.text.trim().isEmpty) {
                            Get.snackbar("About Register", "Register message",
                                backgroundColor: darkPurple.withOpacity(0.4),
                                snackPosition: SnackPosition.BOTTOM,
                                titleText: Text("Register failed",
                                    style: TextStyle(color: whiteColor)),
                                messageText: Text(
                                  "Please enter your password",
                                  style: TextStyle(color: whiteColor),
                                ));
                          } else {
                            try {
                              QuerySnapshot snap = await FirebaseFirestore
                                  .instance
                                  .collection("users")
                                  .where("username",
                                      isEqualTo: usernameController.text.trim())
                                  .get();
                            } catch (e) {}
                            AuthController.instance.register(
                                emailController.text.trim(),
                                passwordController.text.trim(),
                                usernameController.text.trim());
                          }
                        },
                        style: ButtonStyle(
                            foregroundColor: MaterialStateProperty.all<Color>(
                                Colors.white),
                            elevation:
                                MaterialStateProperty.resolveWith<double>(
                              (Set<MaterialState> states) {
                                if (states.contains(MaterialState.disabled)) {
                                  return 0;
                                }
                                return 0;
                              },
                            ),
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Color(0XFFA56FF8)),
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    side: BorderSide(
                                        width: 2, color: Color(0XFFA56FF8)),
                                    borderRadius:
                                        BorderRadius.circular(40.0)))),
                        child: Padding(
                          padding: EdgeInsets.all(24.0),
                          child: Text(
                            'Submit',
                             style: TextStyle(fontSize: 18)
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => LoginPage()));
                        },
                        child: Center(
                            child: Text('Already a member? Log In.',
                                style: TextStyle(
                                    color: Colors.grey[500],
                                    fontWeight: FontWeight.w500))))
                  ],
                ),
              ),
            ],
          ),
        )));
  }

  Otp() {}
}
