import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pets_app/core/models/user.dart';

class AuthService with ChangeNotifier {
  bool _isLoading = false;
  late String _errorMessage;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final gooleSignIn = GoogleSignIn();
  DatabaseReference usersRef =
      FirebaseDatabase.instance.reference().child("users");

  Future register(
      String name, String email, String phoneNumber, String password) async {
    setLoading(true);
    try {
      UserCredential authResult = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      User? user = authResult.user;
      if (user != null) {
        /*Map userDataMap = {
          "name": name,
          "phoneNumber": phoneNumber,
          "email": email,
          "password": password,
        };*/
        FirebaseFirestore.instance.collection("users").add({
          "id": user.uid,
          "name": name,
          "phoneNumber": phoneNumber,
          "email": email,
          "password": password,
        });
        //save user info in the database
        //usersRef.child(user.uid).set(userDataMap);
      }
      setLoading(false);
      return user;
    } on SocketException {
      setLoading(false);
      setMessage("No internet, please connect to the internet");
    } catch (e) {
      setLoading(false);
      print(e);
      setMessage(e.toString());
    }
    notifyListeners();
  }

  Future login(String email, String password) async {
    try {
      setLoading(true);
      UserCredential authResult = await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = authResult.user;
      setLoading(false);
      return user;
    } on SocketException {
      setLoading(false);
      setMessage("No internet, please connect to the internet");
    } catch (e) {
      setLoading(false);
      print(e);
      setMessage(e.toString());
    }
    notifyListeners();
  }

  Future logout() async {
    await firebaseAuth.signOut();
  }

  void setLoading(val) {
    _isLoading = val;
    notifyListeners();
  }

  void setMessage(message) {
    _errorMessage = message;
    notifyListeners();
  }

  Stream<User?> get user =>
      firebaseAuth.authStateChanges().map((event) => event);
}
