import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:travelamigos/models/planmodel/plan_model.dart';
import 'package:travelamigos/views/screens/home/home_page.dart';

class UploadPlanController extends GetxController {
  // upload plan
  uploadPlan(DateTime dateTime, String place, String planText) async {
    try {
      String uid = FirebaseAuth.instance.currentUser!.uid;
      DocumentSnapshot userDoc =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();
      // get id
      var allDocs = await FirebaseFirestore.instance.collection('plans').get();
      int len = allDocs.docs.length;

      Plan plan = Plan(
        username: (userDoc.data()! as Map<String, dynamic>)['username'],
        uid: uid,
        id: "Plan $len",
        plan: planText,
        place: place,
        date: dateTime,
        likes: [],
        commentCount: [],
        shareCount: [],
        interestedCount: [],
        profilePhoto: (userDoc.data()! as Map<String, dynamic>)['profilephoto'],
      );

      await FirebaseFirestore.instance
          .collection('plans')
          .doc('Plan $len')
          .set(plan.toJson())
          .then((value) {
        FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .update({'uploads': FieldValue.increment(1)});
        Get.snackbar(
          '',
          "Your plan is successfully uploaded".toString(),
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
