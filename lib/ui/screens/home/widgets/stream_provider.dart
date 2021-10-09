import 'package:flutter/material.dart';
import 'package:pets_app/core/constants/drawer_configuration.dart';
import 'package:pets_app/core/models/product_model.dart';
import 'package:pets_app/core/services/products_service.dart';
import 'package:pets_app/ui/screens/Home/widgets/home.dart';
import 'pets_list.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Product>>.value(
      value: PetsService().products,
      initialData: [],
      child: Scaffold(
        body: Home(),
      ),
    );
  }
}
