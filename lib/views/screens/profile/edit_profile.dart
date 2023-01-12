// library_private_types_in_public_api, use_key_in_widget_constructors

// ignore_for_file: must_be_immutable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travelamigos/views/screens/home/home_page.dart';

class EditProfilePage extends StatelessWidget {
  String name = '';
  String username = '';
  String age = '';
  String location = '';
  String about = '';
  String profilephoto = '';

  TextEditingController nameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController aboutController = TextEditingController();

  EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
            onPressed: () {
              Get.back();
            },
          ),
          elevation: 0,
          backgroundColor: Colors.white,
        ),
        body: FutureBuilder(
          future: _fetchUserData(),
          builder: ((context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return Center(child: CircularProgressIndicator());
            }
            nameController.text = name.toString();
            usernameController.text = username.toString();
            locationController.text = location.toString();
            ageController.text = age.toString();
            aboutController.text = about.toString();
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
                },
                child: ListView(
                  children: [
                    const Center(
                      child: Text(
                        "Edit Profile",
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.w500),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Center(
                      child: Stack(
                        children: [
                          Container(
                            width: 130,
                            height: 130,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 4,
                                    color: Theme.of(context)
                                        .scaffoldBackgroundColor),
                                boxShadow: [
                                  BoxShadow(
                                      spreadRadius: 2,
                                      blurRadius: 10,
                                      color: Colors.black.withOpacity(0.1),
                                      offset: const Offset(0, 10))
                                ],
                                shape: BoxShape.circle,
                                image: const DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage('assets/image/2.jpg'))),
                          ),
                          Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      width: 4,
                                      color: Theme.of(context)
                                          .scaffoldBackgroundColor,
                                    ),
                                    color: Colors.grey[500]),
                                child: const Icon(
                                  Icons.edit,
                                  color: Colors.white,
                                ),
                              )),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 35,
                    ),
                    buildTextField("Full Name", nameController),
                    buildTextField("Username", usernameController),
                    buildTextField("Location", locationController),
                    buildTextField("Age", ageController),
                    buildTextFieldForAbout("About", aboutController),
                    const SizedBox(
                      height: 35,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Get.back();
                          },
                          child: const Text("CANCEL",
                              style: TextStyle(
                                  fontSize: 14,
                                  letterSpacing: 2.2,
                                  color: Colors.white)),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            _editUserProfile(
                                nameController.text,
                                usernameController.text.trim(),
                                locationController.text,
                                ageController.text.trim(),
                                aboutController.text);
                            Get.to(HomePage());
                          },
                          child: const Text(
                            "SAVE",
                            style: TextStyle(
                                fontSize: 14,
                                letterSpacing: 2.2,
                                color: Colors.white),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            );
          }),
        ));
  }

  Widget buildTextField(
      String labelText, TextEditingController editController) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 35.0),
      child: TextField(
        controller: editController,
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.only(bottom: 3),
            labelText: labelText,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            )),
      ),
    );
  }

  Widget buildTextFieldForAbout(
      String labelText, TextEditingController aboutController) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 35.0),
      child: TextField(
        controller: aboutController,
        maxLines: 5,
        keyboardType: TextInputType.multiline,
        textInputAction: TextInputAction.newline,
        style: const TextStyle(fontSize: 16),
        decoration: InputDecoration(
          labelText: labelText,
          floatingLabelBehavior: FloatingLabelBehavior.always,
        ),
      ),
    );
  }

  _editUserProfile(String name, String username, String location, String age,
      String about) async {
    final currentUser = FirebaseAuth.instance.currentUser;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser!.uid)
        .update({
      'name': name,
      'username': username,
      'location': location,
      'age': age,
      'about': about
    }).then((value) {
      Get.snackbar("Edit Profile", "Profile edited successfully!");
    });
  }

  _fetchUserData() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser!.uid)
        .get()
        .then((ds) {
      if (ds.get('profilephoto') != null) {
        profilephoto = ds.get('profilephoto');
      }
      if (ds.get('name') != null) {
        name = ds.get('name');
      }
      if (ds.get('username') != null) {
        username = ds.get('username');
      }
      if (ds.get('location') != null) {
        location = ds.get('location');
      }
      if (ds.get('age') != null) {
        age = ds.get('age');
      }
      if (ds.get('about') != null) {
        about = ds.get('about');
      }
    });
  }
}
