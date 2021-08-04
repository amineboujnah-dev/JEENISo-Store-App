import 'package:flutter/material.dart';
import 'package:pets_app/core/models/animal_model.dart';

import 'package:pets_app/ui/screens/Home/widgets/pets_list.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final animals = Provider.of<List<Animal>>(context);
    return AnimalList(animals: animals);
  }
}
