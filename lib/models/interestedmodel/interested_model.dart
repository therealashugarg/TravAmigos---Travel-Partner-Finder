import 'package:cloud_firestore/cloud_firestore.dart';

class Interested {
  String username;
  final datePublished;
  String profilePhoto;
  String uid;
  String id;

  Interested({
    required this.username,
    required this.datePublished,
    required this.profilePhoto,
    required this.uid,
    required this.id,
  });

  Map<String, dynamic> toJson() => {
        'username': username,
        'datePublished': datePublished,
        'profilePhoto': profilePhoto,
        'uid': uid,
        'id': id,
      };

  static Interested fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return Interested(
        username: snapshot['username'],
        datePublished: snapshot['datePublished'],
        profilePhoto: snapshot['profilePhoto'],
        uid: snapshot['uid'],
        id: snapshot['id']);
  }
}
