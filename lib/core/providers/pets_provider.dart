import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
          "date": DateFormat.yMMMMd("en_US").format(DateTime.now()),
        });
      }
    } on FirebaseException catch (e) {
      print(e.message);
    }
    return Animal(
        name: name,
        type: type,
        age: age,
        gender: gender,
        imageUrl: imageUrl,
        description: description);
  }

  // brew list from snapshot
  List<Animal> _animalListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      //print(doc.data);
      return Animal(
          name: doc['name'],
          type: doc['type'],
          age: doc['age'],
          description: doc['description'],
          gender: doc['gender'],
          imageUrl: doc['imageUrl'],
          date: doc['date']);
    }).toList();
  }

  Stream<List<Animal>> get animals {
    return petsCollections
        .doc(currentUser!.uid)
        .collection('pets_list')
        .snapshots()
        .map(_animalListFromSnapshot);
  }
}
