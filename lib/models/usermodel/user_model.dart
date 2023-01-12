import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? uid;
  String? name;
  String? username;
  String? profilephoto;
  String? email;
  String? age;
  String? location;
  String? about;
  int? connections;
  int? uploads;
  int? referances;

  UserModel(
      {this.uid,
      this.name,
      this.username,
      this.profilephoto,
      this.email,
      this.age,
      this.location,
      this.about,
      this.connections,
      this.uploads,
      this.referances});

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "name": name,
        "username": username,
        "profilephoto": profilephoto,
        "email": email,
        "age": age,
        "location": location,
        "about": about,
        "connections": connections,
        "uploads": uploads,
        "referances": referances
      };

  static UserModel fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return UserModel(
        uid: snapshot['uid'],
        name: snapshot['name'],
        username: snapshot['username'],
        profilephoto: snapshot['profilephoto'],
        email: snapshot['email'],
        age: snapshot['age'],
        location: snapshot['location'],
        about: snapshot['about'],
        connections: snapshot['connections'],
        uploads: snapshot['uploads'],
        referances: snapshot["referances"]
        );
  }
}
