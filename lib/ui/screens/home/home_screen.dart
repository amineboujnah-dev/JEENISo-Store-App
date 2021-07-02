import 'package:flutter/material.dart';
import 'package:pets_app/core/services/authentication_service.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<AuthService>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        actions: [
          IconButton(
            onPressed: () async => await loginProvider.logout(),
            icon: Icon(Icons.exit_to_app),
          ),
        ],
      ),
    );
  }
}