import 'package:cloud_firestore/cloud_firestore.dart';

class Plan {
  String username;
  String uid;
  String id;
  String plan;
  String place;
  final date;
  List likes;
  List commentCount;
  List shareCount;
  List interestedCount;
  String profilePhoto;

  Plan({
    required this.username,
    required this.uid,
    required this.id,
    required this.plan,
    required this.place,
    required this.date,
    required this.likes,
    required this.commentCount,
    required this.shareCount,
    required this.interestedCount,
    required this.profilePhoto,
  });

  Map<String, dynamic> toJson() => {
        "username": username,
        "uid": uid,
        "id": id,
        "plan": plan,
        "location": place,
        "date": date,
        "likes": likes,
        "commentCount": commentCount,
        "shareCount": shareCount,
        "interestedCount": interestedCount,
        "profilePhoto": profilePhoto,
      };

  static Plan fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Plan(
        username: snapshot['username'],
        uid: snapshot['uid'],
        id: snapshot['id'],
        plan: snapshot['plan'],
        place: snapshot['location'],
        date: snapshot['date'],
        likes: snapshot['likes'],
        commentCount: snapshot['commentCount'],
        shareCount: snapshot['shareCount'],
        interestedCount: snapshot['interestedCount'],
        profilePhoto: snapshot['profilePhoto']
        );
  }
}



/*
class Plan {
  String? plan;
  String? location;
  String? date;

  Plan({this.plan, this.location, this.date});

  Plan.fromJson(Map<String, dynamic> json) {
    plan = json['plan'];
    location = json['location'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['plan'] = plan;
    data['location'] = location;
    data['date'] = date;
    return data;
  }
}
*/