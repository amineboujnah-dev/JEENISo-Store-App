import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pets_app/core/models/animal_model.dart';
import 'package:pets_app/core/models/user_model.dart';
import 'package:pets_app/core/services/user_service.dart';
import 'package:pets_app/ui/screens/Pets/Pet%20Details/widgets/pet_details_widget.dart';
import 'package:provider/provider.dart';

class PetDetailsView extends StatefulWidget {
  final Animal animal;
  PetDetailsView({required this.animal});

  @override
  _PetDetailsViewState createState() => _PetDetailsViewState();
}

class _PetDetailsViewState extends State<PetDetailsView> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserData>.value(
      value: UserService(uid: widget.animal.userID).userData,
      initialData: UserData("", "", "", "", ""),
      child: PetDetailsWidget(animal: widget.animal),
    );
  }
}
