import 'package:flutter/material.dart';
import 'package:pets_app/core/models/animal_model.dart';
import 'package:pets_app/core/providers/pets_provider.dart';
import 'package:pets_app/ui/screens/Pets/My%20pets/widgets/pets_list.dart';
import 'package:provider/provider.dart';

class MyPets extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<MyPets> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Animal>>.value(
      value: PetsProvider().animals,
      initialData: [],
      child: Scaffold(body: AnimalList()),
    );
  }
}
