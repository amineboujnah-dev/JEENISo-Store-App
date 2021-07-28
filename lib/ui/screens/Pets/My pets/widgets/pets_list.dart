import 'package:flutter/material.dart';
import 'package:pets_app/core/constants/drawer_configuration.dart';
import 'package:pets_app/core/models/animal_model.dart';
import 'package:pets_app/ui/screens/menu/widgets/menu_icon_widget.dart';
import 'package:pets_app/ui/ui_utils/config_setup/size_config.dart';
import 'package:provider/provider.dart';

import 'pet_card.dart';

class AnimalList extends StatefulWidget {
  @override
  _BrewListState createState() => _BrewListState();
}

class _BrewListState extends State<AnimalList> {
  @override
  Widget build(BuildContext context) {
    final animals = Provider.of<List<Animal>>(context);
    final sizeConfig = SizeConfig();
    sizeConfig.init(context);

    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: sizeConfig.getProportionateScreenHeight(50),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.max,
              children: [
                MenuIconWidget(),
                Column(
                  children: [
                    Text('Address'),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          color: primaryGreen,
                        ),
                        Text('Tunisia'),
                      ],
                    ),
                  ],
                ),
                CircleAvatar(
                  radius: 24.0,
                  backgroundImage:
                      AssetImage('assets/images/adopt_me_logo.png'),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            margin: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(20)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(Icons.search),
                Text('Search pet'),
                Icon(Icons.settings)
              ],
            ),
          ),
          ListView.builder(
            physics: ScrollPhysics(),
            shrinkWrap: true,
            itemCount: animals.length,
            itemBuilder: (context, index) {
              return AnimalCard(animal: animals[index]);
            },
          ),
        ],
      ),
    );
  }
}
