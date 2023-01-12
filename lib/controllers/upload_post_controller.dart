import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:travelamigos/models/postmodel/post_model.dart';
import 'package:travelamigos/views/screens/home/home_page.dart';

class UploadPostController extends GetxController {
  // upload to storage
  Future<String> _uploadPostToStorage(String id, String imagePath) async {
    Reference ref = FirebaseStorage.instance.ref().child('posts').child(id);

    UploadTask uploadTask = ref.putFile(File(imagePath));
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  // upload post
  uploadPost(String caption, String imagePath) async {
    try {
      String uid = FirebaseAuth.instance.currentUser!.uid;
      DocumentSnapshot userDoc =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();
      // get id
      var allDocs = await FirebaseFirestore.instance.collection('posts').get();
      int len = allDocs.docs.length;
      String imageUrl = await _uploadPostToStorage("Post $len", imagePath);

      Post post = Post(
        username: (userDoc.data()! as Map<String, dynamic>)['username'],
        uid: uid,
        id: "Post $len",
        datePublished: DateTime.now(),
        likes: [],
        commentCount: [],
        shareCount: [],
        caption: caption,
        imageUrl: imageUrl,
        profilePhoto: (userDoc.data()! as Map<String, dynamic>)['profilephoto'],
      );

      await FirebaseFirestore.instance
          .collection('posts')
          .doc('Post $len')
          .set(post.toJson())
          .then((value) {
        FirebaseFirestore.instance
            .collection('users')
            .doc(uid)
            .update({'uploads': FieldValue.increment(1)});
        Get.snackbar(
          '',
          "Your post is successfully uploaded".toString(),
        );
      });
      Get.to(HomePage());
    } catch (e) {
      Get.snackbar(
        'Error Uploading Post',
        e.toString(),
      );
    }
  }
}
