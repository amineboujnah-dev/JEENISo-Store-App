import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:pets_app/core/models/animal_model.dart';
import 'package:pets_app/core/models/user_model.dart';

class PetsService with ChangeNotifier {
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
        final docRef2 = await allpetsCollection.doc(docRef1.id).set({
          "id": docRef1.id,
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

  Future<void> deletePet(String? userID, String docID) {
    allpetsCollection.doc(docID).delete();
    return petsCollections
        .doc(userID)
        .collection('my_pets')
        .doc(docID)
        .delete()
        .then((value) => print("Pet Deleted"))
        .catchError((error) => print("Failed to delete pet: $error"));
  }

  Animal _userFromFirebaseUser(DocumentSnapshot snapshot) {
    return Animal(
        userID: snapshot.get('userID'),
        name: snapshot.get('name'),
        type: snapshot.get('type'),
        age: snapshot.get('age'),
        description: snapshot.get('description'),
        gender: snapshot.get('gender'),
        imageUrl: snapshot.get('imageUrl'));
  }

  Stream<Animal> getAnimal(String userID, String? docID) {
    return petsCollections
        .doc(userID)
        .collection('my_pets')
        .doc(docID)
        .snapshots()
        .map(_userFromFirebaseUser);
  }

  Future<Animal> updatePetData(
      String userID,
      String? id,
      String name,
      String age,
      String gender,
      String type,
      String imageUrl,
      String description) async {
    await petsCollections.doc(userID).collection('my_pets').doc(id).update({
      "name": name,
      "age": age,
      "gender": gender,
      "type": type,
      "imageUrl": imageUrl,
      "description": description,
      "date": DateFormat.yMMMMd("en_US").format(DateTime.now()),
    });
    /* await allpetsCollection.doc(id).update({
      "name": name,
      "age": age,
      "gender": gender,
      "type": type,
      "imageUrl": imageUrl,
      "description": description,
      "date": DateFormat.yMMMMd("en_US").format(DateTime.now()),
    });*/
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
}
