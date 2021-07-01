import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'ui/screens/Authentication/login.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Future<FirebaseApp> _init = Firebase.initializeApp();
    return FutureBuilder(
        future: _init,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return ErrorWidget();
          } else if (snapshot.hasData) {
            return MaterialApp(
              theme: ThemeData(
                primarySwatch: Colors.green,
              ),
              debugShowCheckedModeBanner: false,
              home: Login(),
            );
          } else {
            return Loading();
          }
        });
  }
}

class ErrorWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Icon(Icons.error),
            Text('Something went wrong !'),
          ],
        ),
      ),
    );
  }
}

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: CircularProgressIndicator(),
    ));
  }
}
