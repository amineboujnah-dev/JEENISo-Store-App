import 'package:flutter/material.dart';
import 'package:pets_app/core/models/user_model.dart';
import 'package:pets_app/ui/screens/Authentication/view/authentication_view.dart';
import 'package:pets_app/ui/screens/home/widgets/drawer_widget.dart';
import 'package:pets_app/ui/screens/home/widgets/homeScreen.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel?>(context);
    if (user != null) {
      return Scaffold(
        body: Stack(
          children: [
            DrawerScreen(),
            HomeScreen(),
          ],
        ),
      );
    } else {
      return Authentication();
    }
  }
}
