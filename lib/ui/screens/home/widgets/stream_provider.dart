import 'package:flutter/material.dart';
import 'package:pets_app/core/models/animal_model.dart';
import 'package:pets_app/core/services/pets_service.dart';
import 'pets_list.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Animal>>.value(
      value: PetsService().animals,
      initialData: [],
      child: Scaffold(body: AnimalList()),
    );
  }
}
