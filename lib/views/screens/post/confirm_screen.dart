// ignore_for_file: must_be_immutable

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travelamigos/controllers/upload_post_controller.dart';
import 'package:travelamigos/views/screens/home/home_page.dart';

class ConfirmScreen extends StatelessWidget {
  FocusNode myFocusNode = FocusNode();
  TextEditingController captionController = TextEditingController();
  final File imageFile;
  final String imagePath;

  UploadPostController uploadPostController = Get.put(UploadPostController());

  ConfirmScreen({
    Key? key,
    required this.imageFile,
    required this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Align(
                  alignment: Alignment.topLeft,
                  child: GestureDetector(
                      onTap: () => Get.back(),
                      child: const Icon(Icons.arrow_back,
                          size: 32, color: Colors.black54))),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Column(children: [
                const SizedBox(height: 20),
                ClipRRect(
                  borderRadius: BorderRadius.circular(28),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.width - 36,
                    child: Image.file(
                      File(imagePath),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                buildTextFieldForCaption(),
                const SizedBox(height: 30),
                Row(children: [
                  InkWell(
                    highlightColor: Colors.white,
                    splashColor: Colors.white,
                    onTap: () {
                      Get.to(HomePage());
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 3, right: 12),
                      child: Container(
                        width: MediaQuery.of(context).size.width / 2 - 33,
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Colors.grey[300]),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Padding(
                              padding: EdgeInsets.only(top: 2),
                              child: Text(
                                'Clear',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black54,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ), 
                    ),
                  ),
                  InkWell(
                    highlightColor: Colors.white,
                    splashColor: Colors.white,
                    onTap: () => uploadPostController.uploadPost(
                        captionController.text, imagePath),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 12, right: 3),
                      child: Container(
                        width: MediaQuery.of(context).size.width / 2 - 33,
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: const Color(0XFFA56FF8)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Padding(
                              padding: EdgeInsets.only(top: 2),
                              child: Text(
                                'Publish',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ]),
                const SizedBox(
                  height: 20,
                ),
              ]),
            ),
          ],
        ),
      ),
    ));
  }

  Widget buildTextFieldForCaption() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: Container(
        color: Colors.grey[200],
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15, 5, 15, 15),
          child: TextField(
            controller: captionController,
            maxLines: 5,
            keyboardType: TextInputType.multiline,
            textInputAction: TextInputAction.newline,
            style: const TextStyle(fontSize: 16),
            decoration: InputDecoration(
                labelText: "Caption",
                focusColor: Colors.black54,
                labelStyle: TextStyle(
                    color:
                        myFocusNode.hasFocus ? Colors.black54 : Colors.black54),
                floatingLabelBehavior: FloatingLabelBehavior.always,
                border: InputBorder.none),
          ),
        ),
      ),
    );
  }
}
