import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pets_app/core/models/user_model.dart';
import 'package:pets_app/ui/screens/Authentication/view/authentication_view.dart';
import 'package:pets_app/ui/screens/Profile/Edit%20Profile/view/edit_profile_view.dart';
import 'package:pets_app/ui/screens/Profile/Profile%20Details/view/profile_details_view.dart';
import 'package:pets_app/ui/screens/home/widget/home_widget.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel?>(context);
    if (user != null) {
      return HomeScreen();
    } else {
      return Authentication();
    }
  }
}
