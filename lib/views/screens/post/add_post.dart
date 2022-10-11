// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';
import 'package:travelamigos/controllers/value_controller.dart';
import 'package:travelamigos/views/screens/post/confirm_screen.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({Key? key}) : super(key: key);
  @override
  _AddPostScreenState createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  File? pickedImage;

  Future pickImage() async {
    final image = await ImagePicker().getImage(source: ImageSource.gallery);
    if (image == null) return;
    setState(() {
      pickedImage = File(image.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Align(
                  alignment: Alignment.topLeft,
                  child: GestureDetector(
                      onTap: () => Get.back(),
                      child: Icon(Icons.arrow_back,
                          size: 32, color: Colors.black54))),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 82),
              child: Container(
                height: 45,
                decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(25.0)),
                child: TabBar(
                  indicator: BoxDecoration(
                      color: Color(0XFFA56FF8),
                      borderRadius: BorderRadius.circular(25.0)),
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.black,
                  tabs: const [
                    Tab(
                      text: 'Plan',
                    ),
                    Tab(
                      text: 'Post',
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
                child: TabBarView(children: [
              Column(children: [
                SizedBox(height: 30),
                Container(
                    width: 200,
                    height: 200,
                    color: Colors.deepPurple.shade200,
                    child: Center(
                        child: Text("Plan Pages",
                            style: TextStyle(color: Colors.white))))
              ]),
              Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                SizedBox(height: 35),
                if (pickedImage != null)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(28),
                    child: Container(
                      width: 380,
                      height: 380,
                      child: Image.file(
                        File(pickedImage!.path),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                Spacer(),
                InkWell(
                  onTap: pickImage,
                  child: Container(
                    width: 190,
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.grey[300]),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          width: 5,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 2),
                          child: Text(
                            'Upload',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black54,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                            height: 24,
                            child:
                                Image.asset('assets/icons/cloud-upload.png', color: Colors.black54,)),
                        SizedBox(
                          width: 5,
                        ),
                      ],
                    ),
                  ),
                ),
                Spacer(),
                InkWell(
                  onTap: () {
                    if (pickedImage != null)
                      Get.to(ConfirmScreen(
                        imageFile: File(pickedImage!.path),
                        imagePath: pickedImage!.path,
                      ));
                    else
                      return;
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 82),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: pickedImage == null
                              ? Colors.grey[300]
                              : Color(0XFFA56FF8)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 2),
                            child: Text(
                              'Next',
                              style: TextStyle(
                                fontSize: 14,
                                color: pickedImage == null
                              ? Colors.black54
                              : Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20)
              ])
            ]))
          ],
        ),
      )),
    );
  }
}
