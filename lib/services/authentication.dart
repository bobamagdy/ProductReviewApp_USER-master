import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path/path.dart' as path;

// Signout() async {
//   return await FirebaseAuth.instance.signOut();
// }

Future<String> UploadImageToFirebaseStorage(_image, uid) async {
  Reference storageref =
      FirebaseStorage.instance.ref().child('${path.basename(_image.path)}');
  UploadTask uploadTask =
      storageref.child("${uid}_profilePic_$_image}.jpg").putFile(_image);
  String downlaodUrl = await (await uploadTask).ref.getDownloadURL();
  return downlaodUrl;
}

//GET UID
GetCurrentUID() async {
  return (await FirebaseAuth.instance.currentUser).uid;
}

retrieveUserData() async {
  String userId;
  userId = (await FirebaseAuth.instance.currentUser).uid;
  print("first step in a function" + userId);
  var d = FirebaseFirestore.instance.collection('User').doc(userId).get();
  print(d);
  print('hereeeeeeeeeeeeeeeeeeeeeeeeee');
  return d;

  //     .then((DocumentSnapshot documentSnapshot) {
  //   if (documentSnapshot.exists) {
  //     print("create instanceeeeeeeeeeeeeeee");
  //     print('Document data: ${documentSnapshot.data()}');
  //     print('Document data: ${documentSnapshot}');
  //     print(documentSnapshot.data());
  //     return documentSnapshot.data();
  //   } else {
  //     print('Document does not exist on the database');
  //     return documentSnapshot.exists;
  //   }
  // });
}

changePhoto(File _image) async {
  await Firebase.initializeApp();
  FirebaseAuth auth = FirebaseAuth.instance;
  DocumentReference userref;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  User firebaseUser;
  if (firebaseUser != null) {
    String mediaUrl =
        await UploadImageToFirebaseStorage(_image, firebaseUser.uid);
    userref = firestore.collection('User').doc(firebaseUser.uid);
    userref.update({'ImageUrl': mediaUrl});
  }
}

Future<void> userSetup(String email, String password, String phone,
    String username, File _image) async {
  await Firebase.initializeApp();
  FirebaseAuth auth = FirebaseAuth.instance;
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  DocumentReference userref;
  // SharedPreferences.setMockInitialValues({});
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  User firebaseUser;
  UserCredential userCredential = await FirebaseAuth.instance
      .createUserWithEmailAndPassword(email: email, password: password)
      .then((auth) {
    firebaseUser = auth.user;
  });
  print("user created");
  if (firebaseUser != null) {
    FirebaseFirestore.instance.collection('User').doc(firebaseUser.uid).set({
      'Username': username,
      'Email': firebaseUser.email,
      'uid': firebaseUser.uid,
      'Phone': phone,
      'ImageUrl': ''
    });
    String mediaUrl =
        await UploadImageToFirebaseStorage(_image, firebaseUser.uid);
    userref = firestore.collection('User').doc(firebaseUser.uid);
    userref.update({'ImageUrl': mediaUrl});

    await sharedPreferences.setString(username, firebaseUser.displayName);
    await sharedPreferences.setString(email, firebaseUser.email);
    await sharedPreferences.setString(mediaUrl, firebaseUser.photoURL);
    await sharedPreferences.setString(phone, firebaseUser.phoneNumber);
    await sharedPreferences.setString(firebaseUser.uid, firebaseUser.uid);
  }
  print("every thing created");
}

Future<void> login(String email, String password) async {
  FirebaseAuth auth = FirebaseAuth.instance;
  User currentUser;
  await auth
      .signInWithEmailAndPassword(email: email, password: password)
      .then((authUser) => currentUser = authUser.user);
  // if (currentUser != null) read(currentUser);
}

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:flutter/cupertino.dart';
// import 'exeptions.dart';
// import 'dart:convert';

//with ChangeNotifier
// Register with realtime database
// Future<void> register(String email, String password) async {
//   Uri url = Uri.parse(
//       'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyDbc6OBM47X44uPT2FBlvwtpcrcYEu8lsc'); //change
//   try {
//     final response = await http.post(url,
//         body: json.encode({
//           'email': email,
//           'password': password,
//           'returnSecureToken': true
//         }));
//     final responseData = json.decode(response.body);
//     print(responseData);
//     if (responseData['error'] != null) {
//       throw HttpExeption(responseData['error']['message']);
//     }
//   } catch (error) {
//     throw error;
//   }
// }

////////////////////////////////////////////////////////////////////////////////////
// login with realtime database
// Future<void> login(String email, String password) async {
//   Uri url = Uri.parse(
//       'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyDbc6OBM47X44uPT2FBlvwtpcrcYEu8lsc');
//   try {
//     final response = await http.post(url,
//         body: json.encode({
//           'email': email,
//           'password': password,
//           'returnSecureToken': true
//         }));
//     final responseData = json.decode(response.body);
//     print(responseData);
//     if (responseData['error'] != null) {
//       throw HttpExeption(responseData['error']['message']);
//     }
//   } catch (error) {
//     throw error;
//   }
// }
//
//
//
// await Provider.of<Authntication>(context, listen: false)
//     .login(_authData['email'], _authData['password']);
// Navigator.of(context).pushReplacementNamed(ProfileScreen.roteName);
