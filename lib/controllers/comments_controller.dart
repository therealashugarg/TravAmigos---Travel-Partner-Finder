import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:travelamigos/controllers/auth_controller.dart';
import 'package:travelamigos/models/commentmodel/comment_model.dart';

class CommentController extends GetxController {
  final Rx<List<Comment>> _comments = Rx<List<Comment>>([]);
  List<Comment> get comments => _comments.value;

  String _postId = "";

  updatePostId(String id) {
    _postId = id;
    getComment();
  }

  getComment() async {
    _comments.bindStream(
      FirebaseFirestore.instance
          .collection('posts')
          .doc(_postId)
          .collection('comments')
          .snapshots()
          .map(
        (QuerySnapshot query) {
          List<Comment> retVal = [];
          for (var elements in query.docs) {
            retVal.add(Comment.fromSnap(elements));
          }
          return retVal;
        },
      ),
    );
  }

  postComment(String commentText) async {
    try {
      if (commentText.isNotEmpty) {
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(AuthController.instance.user.uid)
            .get();
        var allDocs = await FirebaseFirestore.instance
            .collection('posts')
            .doc(_postId)
            .collection('comments')
            .get();
        int len = allDocs.docs.length;

        Comment comment = Comment(
            username: (userDoc.data()! as dynamic)['username'],
            comment: commentText.trim(),
            datePublished: DateTime.now(),
            likes: [],
            profilePhoto: (userDoc.data()! as dynamic)['profilephoto'],
            uid: AuthController.instance.user.uid,
            id: 'Comment $len');
        await FirebaseFirestore.instance
            .collection('posts')
            .doc(_postId)
            .collection('comments')
            .doc('Comment $len')
            .set(comment.toJson());
        DocumentSnapshot doc = await FirebaseFirestore.instance
            .collection('posts')
            .doc(_postId)
            .get();
        var uid = AuthController.instance.user.uid;
        FirebaseFirestore.instance.collection('posts').doc(_postId).update({
          'commentCount': FieldValue.arrayUnion([uid]),
        });
      }
    } catch (e) {
      Get.snackbar('Error While Commenting', e.toString());
    }
  }
}
