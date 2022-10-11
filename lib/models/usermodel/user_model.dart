import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class UserModel {
  String? uid;
  String? name;
  String? username;
  String? profilephoto;
  String? email;
  String? age;
  String? location;
  String? about;

  UserModel(
      {this.uid,
      this.name,
      this.username,
      this.profilephoto,
      this.email,
      this.age,
      this.location,
      this.about});

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "name": name,
        "username": username,
        "profilephoto": profilephoto,
        "email": email,
        "age": age,
        "location": location,
        "about": about
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
        about: snapshot['about']);
  }

  // UserModel.fromDocumentSnapshot(DocumentSnapshot data) {
  //   uid = data.id;
  //   name = data["name"];
  //   username = data["username"];
  //   email = data["email"];
  //   age = data["age"];
  //   location = data["location"];
  //   about = data["about"];
  // }
}
