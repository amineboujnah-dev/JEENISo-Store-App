import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:pets_app/core/models/animal_model.dart';
import 'package:pets_app/core/models/user_model.dart';

class PetsService {
  var currentUser = FirebaseAuth.instance.currentUser;
  CollectionReference petsCollections =
      FirebaseFirestore.instance.collection("pets");
  CollectionReference allpetsCollection =
      FirebaseFirestore.instance.collection("all pets");

  Future<Animal> addPet(String userID, String name, String age, String gender,
      String type, String imageUrl, String description) async {
    try {
      if (currentUser != null) {
        final docRef1 =
            await petsCollections.doc(userID).collection("my_pets").add({
          "userID": userID,
          "name": name,
          "age": age,
          "gender": gender,
          "type": type,
          "imageUrl": imageUrl,
          "description": description,
          "date": DateFormat.yMMMMd("en_US").format(DateTime.now()),
          "myFavorites": [],
        });
        docRef1.update(({
          "id": docRef1.id,
        }));
        final docRef2 = await allpetsCollection.add({
          "userID": userID,
          "name": name,
          "age": age,
          "gender": gender,
          "type": type,
          "imageUrl": imageUrl,
          "description": description,
          "date": DateFormat.yMMMMd("en_US").format(DateTime.now()),
          "myFavorites": [],
        });
        docRef2.update(({
          "id": docRef2.id,
        }));
      }
    } on FirebaseException catch (e) {
      print(e.message);
    }
    return Animal(
      userID: userID,
      name: name,
      type: type,
      age: age,
      gender: gender,
      imageUrl: imageUrl,
      description: description,
    );
  }

  Future addPetToFavorites(
      UserModel? user, String id, List? myFavorites) async {
    try {
      if (user != null) {
        allpetsCollection.doc(id).update(({
              "myFavorites": myFavorites,
            }));
      }
    } on FirebaseException catch (e) {
      print(e.message);
    }
  }

  List<Animal> _animalListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Animal(
          id: doc['id'],
          userID: doc['userID'],
          name: doc['name'],
          type: doc['type'],
          age: doc['age'],
          description: doc['description'],
          gender: doc['gender'],
          imageUrl: doc['imageUrl'],
          date: doc['date'],
          myFavorites: doc['myFavorites']);
    }).toList();
  }

  Stream<List<Animal>> get animals {
    return allpetsCollection.snapshots().map(_animalListFromSnapshot);
  }

  Stream<List<Animal>> get myAnimals {
    return petsCollections
        .doc(currentUser!.uid)
        .collection('my_pets')
        .snapshots()
        .map(_animalListFromSnapshot);
  }
}
