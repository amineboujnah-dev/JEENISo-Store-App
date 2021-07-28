import 'package:flutter/material.dart';
import 'package:pets_app/core/models/user_model.dart';
import 'package:pets_app/ui/screens/Authentication/view/authentication_view.dart';

import 'package:pets_app/ui/screens/menu/view/menu_view.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel?>(context);
    if (user == null) {
      return Authentication();
    } else {
      return MenuView();
    }
  }
}
