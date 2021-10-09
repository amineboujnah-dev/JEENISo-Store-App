import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pets_app/core/constants/drawer_configuration.dart';
import 'package:pets_app/core/models/product_model.dart';
import 'package:pets_app/ui/screens/menu/widgets/menu_icon_widget.dart';
import 'package:pets_app/ui/ui_utils/config_setup/size_config.dart';
import 'package:provider/provider.dart';

import 'pet_card.dart';

class AnimalList extends StatefulWidget {
  final List<Product> products;
  AnimalList({required this.products});
  @override
  _BrewListState createState() => _BrewListState();
}

class _BrewListState extends State<AnimalList> {
  @override
  Widget build(BuildContext context) {
    final animals = Provider.of<List<Product>>(context);
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
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.max,
              children: [
                MenuIconWidget(),
                SizedBox(
                  width: sizeConfig.getProportionateScreenWidth(100),
                ),
                Row(
                  children: [
                    Icon(
                      FontAwesomeIcons.home,
                      color: primaryGreen,
                    ),
                    SizedBox(
                      width: sizeConfig.getProportionateScreenWidth(5),
                    ),
                    Text(
                      'Home',
                      style: TextStyle(fontSize: 17),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            margin: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
          ),
          ListView.builder(
            physics: ScrollPhysics(),
            shrinkWrap: true,
            itemCount: animals.length,
            itemBuilder: (context, index) {
              return AnimalCard(product: animals[index]);
            },
          ),
        ],
      ),
    );
  }
}
