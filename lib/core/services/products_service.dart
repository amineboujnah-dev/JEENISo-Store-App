import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:pets_app/core/models/product_model.dart';
import 'package:pets_app/core/models/user_model.dart';

class PetsService with ChangeNotifier {
  var currentUser = FirebaseAuth.instance.currentUser;
  CollectionReference petsCollections =
      FirebaseFirestore.instance.collection("pets");
  CollectionReference allpetsCollection =
      FirebaseFirestore.instance.collection("all pets");

  Future<Product> addProduct(String userID, String name, String age,
      String gender, String type, String imageUrl, String description) async {
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
    return Product(
      userID: userID,
      name: name,
      price: type,
      imageUrl: imageUrl,
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

  List<Product> _animalListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Product(
          id: doc['id'],
          userID: doc['userID'],
          name: doc['name'],
          price: doc['type'],
          imageUrl: doc['imageUrl'],
          date: doc['date'],
          myFavorites: doc['myFavorites']);
    }).toList();
  }

  Stream<List<Product>> get products {
    return allpetsCollection.snapshots().map(_animalListFromSnapshot);
  }

  Stream<List<Product>> get myAnimals {
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

  Product _userFromFirebaseUser(DocumentSnapshot snapshot) {
    return Product(
        userID: snapshot.get('userID'),
        name: snapshot.get('name'),
        price: snapshot.get('type'),
        imageUrl: snapshot.get('imageUrl'));
  }

  Stream<Product> getAnimal(String userID, String? docID) {
    return petsCollections
        .doc(userID)
        .collection('my_pets')
        .doc(docID)
        .snapshots()
        .map(_userFromFirebaseUser);
  }

  Future<Product> updatePetData(
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
    return Product(
      userID: userID,
      name: name,
      price: type,
      imageUrl: imageUrl,
    );
  }
}
