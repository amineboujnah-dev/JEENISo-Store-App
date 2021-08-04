import 'package:flutter/material.dart';
import 'package:pets_app/core/models/animal_model.dart';
import 'package:pets_app/core/services/pets_service.dart';
import 'package:pets_app/ui/screens/Pets/My%20pets/widgets/pets_list.dart';
import 'package:provider/provider.dart';

class MyPetsWidget extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<MyPetsWidget> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Animal>>.value(
      value: PetsService().myAnimals,
      initialData: [],
      child: Scaffold(body: AnimalList()),
    );
  }
}
