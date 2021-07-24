import 'package:flutter/material.dart';
import 'package:pets_app/ui/screens/Home/widgets/drawer_widget.dart';
import 'package:pets_app/ui/screens/Pets/Add%20Pet/widget/add_pet_widget.dart';

class AddPetView extends StatelessWidget {
  const AddPetView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          //DrawerScreen(),
          AddPetWidget(),
        ],
      ),
    );
  }
}
