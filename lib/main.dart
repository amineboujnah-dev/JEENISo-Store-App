import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pets_app/core/services/authentication_service.dart';
import 'package:pets_app/ui/screens/home/view/home_view.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Future<FirebaseApp> _init = Firebase.initializeApp();
    return FutureBuilder(
        future: _init,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Column(
                children: [
                  Icon(Icons.error),
                  Text('Something went wrong !'),
                ],
              ),
            );
          } else if (snapshot.hasData) {
            return MultiProvider(
              providers: [
                ChangeNotifierProvider<AuthService>.value(value: AuthService()),
                StreamProvider<User?>.value(
                    value: AuthService().user, initialData: null),
              ],
              child: MaterialApp(
                theme: ThemeData(
                  primarySwatch: Colors.green,
                ),
                debugShowCheckedModeBanner: false,
                home: Wrapper(),
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
