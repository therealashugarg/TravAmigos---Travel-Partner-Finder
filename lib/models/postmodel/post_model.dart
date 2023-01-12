import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  String username;
  String uid;
  String id;
  final datePublished;
  List likes;
  List commentCount;
  List shareCount;
  String caption;
  String imageUrl;
  String profilePhoto;

  Post({
    required this.username,
    required this.uid,
    required this.id,
    required this.datePublished, 
    required this.likes,
    required this.commentCount,
    required this.shareCount,
    required this.caption,
    required this.imageUrl,
    required this.profilePhoto,
  });

  Map<String, dynamic> toJson() => {
        "username": username,
        "uid": uid,
        "profilePhoto": profilePhoto,
        "datePublished": datePublished,
        "id": id,
        "likes": likes,
        "commentCount": commentCount,
        "shareCount": shareCount,
        "caption": caption,
        "imageUrl": imageUrl,
      };

  static Post fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Post(
      username: snapshot['username'],
      uid: snapshot['uid'],
      id: snapshot['id'],
      datePublished: snapshot['datePublished'],
      likes: snapshot['likes'],
      commentCount: snapshot['commentCount'],
      shareCount: snapshot['shareCount'],
      caption: snapshot['caption'],
      imageUrl: snapshot['imageUrl'],
      profilePhoto: snapshot['profilePhoto'],
    );
  }
}
