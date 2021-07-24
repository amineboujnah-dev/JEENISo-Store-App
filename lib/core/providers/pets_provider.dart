import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pets_app/core/models/animal_model.dart';

class PetsProvider with ChangeNotifier {
  final currentUser = FirebaseAuth.instance.currentUser;
  CollectionReference petsCollections =
      FirebaseFirestore.instance.collection("users");

  Future<Animal> addPet(String name, String age, String gender, String type,
      String imageUrl, String description) async {
    try {
      if (currentUser != null) {
        petsCollections.doc(currentUser!.uid).collection('pets_list').add({
          "name": name,
          "age": age,
          "gender": gender,
          "type": type,
          "imageUrl": imageUrl,
          "description": description,
        });
      }
    } on FirebaseException catch (e) {
      print(e.message);
    }
    return new Animal(
        name, type, age, description, gender, imageUrl, Colors.green);
  }
}
