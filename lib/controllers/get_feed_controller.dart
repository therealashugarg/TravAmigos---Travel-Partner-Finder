import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:travelamigos/controllers/auth_controller.dart';
import 'package:travelamigos/models/planmodel/plan_model.dart';
import 'package:travelamigos/models/postmodel/post_model.dart';

class GetFeedController extends GetxController {
  final Rx<List<Post>> _postList = Rx<List<Post>>([]);
  final Rx<List<Plan>> _planList = Rx<List<Plan>>([]);
  final Rx<List<dynamic>> _postplan = Rx<List<dynamic>>([]);

  List<Post> get postList => _postList.value;
  List<Plan> get planList => _planList.value;
  List get postPlan => _postplan.value;

  @override
  void onInit() {
    super.onInit();
    _postList.bindStream(
        FirebaseFirestore.instance.collection('posts').snapshots().map(
      (QuerySnapshot query) {
        List<Post> retVal = [];
        for (var element in query.docs) {
          retVal.add(Post.fromSnap(element));
        }
        return retVal;
      },
    ));
    _planList.bindStream(
        FirebaseFirestore.instance.collection('plans').snapshots().map(
      (QuerySnapshot query) {
        List<Plan> retVal = [];
        for (var element in query.docs) {
          retVal.add(Plan.fromSnap(element));
        }
        return retVal;
      },
    ));
  }

  likePost(String id) async { 
    DocumentSnapshot doc =
        await FirebaseFirestore.instance.collection('posts').doc(id).get();
    var uid = AuthController.instance.user.uid;
    if ((doc.data()! as dynamic)['likes'].contains(uid)) {
      await FirebaseFirestore.instance.collection('posts').doc(id).update({
        'likes': FieldValue.arrayRemove([uid]),
      });
    } else {
      await FirebaseFirestore.instance.collection('posts').doc(id).update({
        'likes': FieldValue.arrayUnion([uid]),
      });
    }
  }

  likePlan(String id) async {
    DocumentSnapshot doc =
        await FirebaseFirestore.instance.collection('plans').doc(id).get();
    var uid = AuthController.instance.user.uid;
    if ((doc.data()! as dynamic)['likes'].contains(uid)) {
      await FirebaseFirestore.instance.collection('plans').doc(id).update({
        'likes': FieldValue.arrayRemove([uid]),
      });
    } else {
      await FirebaseFirestore.instance.collection('plans').doc(id).update({
        'likes': FieldValue.arrayUnion([uid]),
      });
    }
  }

  interestedPeople(String id) async {
    DocumentSnapshot doc =
        await FirebaseFirestore.instance.collection('plans').doc(id).get();
    var uid = AuthController.instance.user.uid;
    if ((doc.data()! as dynamic)['interestedCount'].contains(uid)) {
      await FirebaseFirestore.instance.collection('plans').doc(id).update({
        'interestedCount': FieldValue.arrayRemove([uid]),
      });
    } else {
      await FirebaseFirestore.instance.collection('plans').doc(id).update({
        'interestedCount': FieldValue.arrayUnion([uid]),
      });
    }
  }

}
