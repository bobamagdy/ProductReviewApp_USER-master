import 'package:cloud_firestore/cloud_firestore.dart';

class UserClass {
  String email;
  String uid;
  String username;
  String image;
  String phone;
  String password;
  String state;

  UserClass(
      {String email,
      String uid,
      String username,
      String image,
      String phone,
      String password,
      String state}) {
    this.email = email;
    this.username = username;
    this.image = image;
    this.phone = phone;
    this.password = password;
    this.state = state;
  }
  Map<String, String> toJson() => {
        'username': username,
        'email': email,
        'password': password,
        'phone': phone,
        'image': image,
        'state': state,
      };
  factory UserClass.fromDatabase(DocumentSnapshot document) {
    return UserClass(
      email: document["email"] as String,
      username: document["username"] as String,
      password: document["password"] as String,
      phone: document["phone"] as String,
      image: document["image"] as String,
      state: document["state"] as String,
    );
  }
}
