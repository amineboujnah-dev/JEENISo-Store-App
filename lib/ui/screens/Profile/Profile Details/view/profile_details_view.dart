import 'package:flutter/material.dart';
import 'package:pets_app/ui/screens/Profile/Profile%20Details/widgets/profile_details_widget.dart';
import 'package:pets_app/ui/screens/home/widgets/drawer_widget.dart';

class ProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          DrawerScreen(),
          ProfileWidget(),
        ],
      ),
    );
  }
}
