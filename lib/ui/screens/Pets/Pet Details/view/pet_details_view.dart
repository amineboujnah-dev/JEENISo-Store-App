import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pets_app/core/models/animal_model.dart';
import 'package:pets_app/core/models/user_model.dart';
import 'package:pets_app/core/services/user_service.dart';
import 'package:pets_app/ui/screens/Pets/Pet%20Details/widgets/pet_details_widget.dart';
import 'package:provider/provider.dart';

class PetDetailsView extends StatelessWidget {
  final Animal animal;
  PetDetailsView({required this.animal});

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;
    return StreamProvider<UserData>.value(
      value: UserService(uid: currentUser!.uid).userData,
      initialData: UserData("", "", "", "", ""),
      child: PetDetailsWidget(animal: animal),
    );
  }
}
