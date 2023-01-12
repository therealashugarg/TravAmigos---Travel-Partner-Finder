import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:travelamigos/models/usermodel/user_model.dart';

class Database {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<bool> createNewUser(UserModel user) async {
    try {
      await firestore.collection("users").doc(user.uid).set({
        'uid': user.uid,
        'email': user.email,
        'username': user.username,
        'profilephoto': null,
        'age': null,
        'name': null,
        'location': null,
        'about': null
      });
      return true;
    } catch (e) {
      // print(e);
      return false;
    }
  }

  Future<UserModel> getUser(String uid) async {
    try {
      DocumentSnapshot doc =
          await firestore.collection("users").doc(uid).get();

      return UserModel.fromSnap(doc);
    } catch (e) {
      // print(e);
      rethrow;
    }
  }
}
