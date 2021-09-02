import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterdemoapp/screens/login_screen.dart';

Future<User?> createAccount(String name, String email,String phone, String password) async {
  FirebaseAuth _auth = FirebaseAuth.instance;

  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  try {
    User? user = (await _auth.createUserWithEmailAndPassword(
        email: email, password: password))
        .user;

    if (user != null) {
      print("Account created Succesfull");

      // ignore: deprecated_member_use
      user.updateProfile(displayName: name);

      await _firestore.collection('users').doc(_auth.currentUser!.uid).set({
        "name": name,
        "email": email,
        "phone": phone,
        "status": "Unavalible",
        "uid": _auth.currentUser!.uid,
      });

      return user;
    } else {
      print("Account creation failed");
      return user;
    }
  } catch (e) {
    print(e);
    return null;
  }
}

Future<User?> logIn(String email, String password) async {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  try {
    User? user = (await _auth.signInWithEmailAndPassword(
        email: email, password: password))
        .user;

    if (user != null) {
      print("Login Successful");
      _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .get()
      // ignore: deprecated_member_use
          .then((value) => user.updateProfile(displayName: value['name']));

      return user;
    } else {
      print("Login Failed");
      return user;
    }
  } catch (e) {
    print(e);
    return null;
  }
}

Future logOut(BuildContext context) async {
  FirebaseAuth _auth = FirebaseAuth.instance;

  try {
    await _auth.signOut().then((value) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => LoginScreen()));
    });
  } catch (e) {
    print("error");
  }
}
Future<void> addUser(String word, String meaning,String description) {
  // Call the user's CollectionReference to add a new user
  CollectionReference users = FirebaseFirestore.instance.collection('Vocabulary');

  return users
      .add({
    'Word': word, // John Doe
    'Meaning': meaning, // Stokes and Sons
    'Description': description // 42
  })
      .then((value) => print("User Added"))
      .catchError((error) => print("Failed to add user: $error"));
}
